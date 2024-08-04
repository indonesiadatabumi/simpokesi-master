<?php

namespace App\Services;

use App\Imports\RestoranImport;
use App\Models\RestoranKlasifikasi;
use App\Models\RestoranTingkatKunjunganAvg;
use App\Models\Kelurahan;
use App\Models\Restoran;
use App\Models\CwpLog;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class RestoranCwpService
{
    public function getRestoranList()
    {
        return DB::table('restorans')->select([
            DB::raw('*'),
            DB::raw('restorans.id as id')
        ])->where('restoran_is_cwp', true)
        ->whereNull('restorans.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create Restoran
        $input['restoran']['restoran_alamat'] = toUpper($input['restoran']['restoran_alamat']);
        $input['restoran']['restoran_kelurahan'] = toUpper(@$input['restoran']['restoran_kelurahan']);
        $input['restoran']['restoran_kecamatan'] = Kelurahan::where('kelurahan', $input['restoran']['restoran_kelurahan'])->first()->kecamatan->kecamatan;
        $input['restoran']['restoran_potensi_pajak'] = $this->getPotensiRestoran($input);
        $input['restoran']['created_by'] = auth()->user()->id;
        $input['restoran']['status_aktif_id'] = @$input['restoran']['status_aktif_id'] ? $input['restoran']['status_aktif_id'] : 4;
        $input['restoran']['restoran_is_cwp'] = true;

        // Set temp file
        if (@$input['restoran']['restoran_foto']) {
            $tempFile = $input['restoran']['restoran_foto'];
            unset($input['restoran']['restoran_foto']);
        }

        $restoran = Restoran::create($input['restoran']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($restoran->id);
            $year = date('Y', strtotime($restoran->created_at));
            $date = date('mdY');

            $imageName = $year.'_RESTORAN_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('restoran', $imageName, 'public_uploads');
            $input['restoran']['restoran_foto'] = $imageName;

            $restoran->update(['restoran_foto' => $input['restoran']['restoran_foto']]);
        }

        // Create tingkat kunjungan
        $input['tingkat_kunjungan']['restoran_id'] = $restoran->id;
        RestoranTingkatKunjunganAvg::create($input['tingkat_kunjungan']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Find Restoran
        $restoran = Restoran::findOrFail($id);

        // Update Restoran
        $input['restoran']['restoran_alamat'] = toUpper($input['restoran']['restoran_alamat']);
        $input['restoran']['restoran_kelurahan'] = toUpper(@$input['restoran']['restoran_kelurahan']);
        $input['restoran']['restoran_kecamatan'] = Kelurahan::where('kelurahan', $input['restoran']['restoran_kelurahan'])->first()->kecamatan->kecamatan;
        $input['restoran']['restoran_potensi_pajak'] = $this->getPotensiRestoran($input);
        $input['restoran']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['restoran']['restoran_foto']) {
            Storage::disk('public_uploads')->delete('restoran/' . $restoran->restoran_foto);

            $no = $this->getNomorUrut($restoran->id);
            $year = date('Y', strtotime($restoran->created_at));
            $date = date('mdY');

            $imageName = $year.'_RESTORAN_' . $no . $date . '.' . $input['restoran']['restoran_foto']->getClientOriginalExtension();
            $input['restoran']['restoran_foto']->storeAs('restoran', $imageName, 'public_uploads');
            $input['restoran']['restoran_foto'] = $imageName;
        }

        $restoran->update($input['restoran']);

        // Create or Update tingkat kunjungan
        $restoran->tingkat_kunjungan()->updateOrCreate(['id' => @$restoran->tingkat_kunjungan->id], $input['tingkat_kunjungan']);
    }

    public function destroy($id)
    {
        $restoran = Restoran::findOrFail($id);

        $restoran->delete();
    }

    public function convert(Request $request, $id)
    {
        $restoran = Restoran::findOrFail($id);

        $restoran->update([
            'restoran_is_cwp' => false
        ]);

        CwpLog::create([
            'cwp_id' => $id,
            'cwp_type' => 'restoran',
            'cwp_name' => @$restoran->restoran_nama,
            'cwp_status' => 'Status calon wajib pajak restoran '.@$request->restoran_tipe.' telah berubah menjadi wajib pajak.',
            'created_by' => auth()->user()->id
        ]);
    }

    public function import(Request $request)
    {
        $file = request()->file('file');

        $import = new RestoranImport();
        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $restoran = Restoran::where('restoran_is_cwp', true)
            ->whereNull('restorans.deleted_at');

        if (@$request->tahun && ($request->tahun != '')) {
            $restoran = $restoran->whereYear('created_at', $request->tahun);
        }

        if (@$request->restoran_klasifikasi_id && ($request->restoran_klasifikasi_id != '')) {
            $restoran = $restoran->where('restoran_klasifikasi_id', $request->restoran_klasifikasi_id);
        }

        if (@$request->tipe && ($request->tipe != '')) {
            $restoran = $restoran->where('restoran_tipe', str_replace('_', '/', $request->tipe));
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $restoran = $restoran->where(DB::raw('LOWER(restoran_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $restoran = $restoran->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $restoran = $restoran->where(DB::raw('LOWER(restoran_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $restoran->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiRestoran($input)
    {
        $sk_ramai = $input['tingkat_kunjungan']['situasi_kunjungan_ramai'] ?? 0;
        $sk_normal = $input['tingkat_kunjungan']['situasi_kunjungan_normal'] ?? 0;
        $sk_sepi = $input['tingkat_kunjungan']['situasi_kunjungan_sepi'] ?? 0;

        $tk_ramai = $input['tingkat_kunjungan']['avg_kunjungan_ramai'] ?? 0;
        $tk_normal = $input['tingkat_kunjungan']['avg_kunjungan_normal'] ?? 0;
        $tk_sepi = $input['tingkat_kunjungan']['avg_kunjungan_sepi'] ?? 0;

        $pengeluaran_avg = $input['restoran']['restoran_pengeluaran_avg'] ?? 0;
        $persentase = $input['restoran']['restoran_persentase_pajak'] ?? 10;

        $potensi_ramai = $sk_ramai * $tk_ramai * $pengeluaran_avg * ($persentase / 100);
        $potensi_normal = $sk_normal * $tk_normal * $pengeluaran_avg * ($persentase / 100);
        $potensi_sepi = $sk_sepi * $tk_sepi * $pengeluaran_avg * ($persentase / 100);

        $potensi = $potensi_ramai + $potensi_normal + $potensi_sepi;

        return $potensi;
    }

    public function getPotensiSituasiKunjungan($restoran, $situasi)
    {
        $arr = $restoran->tingkat_kunjungan;
        $sk = $arr['situasi_kunjungan_'.$situasi];
        $tk = $arr['avg_kunjungan_'.$situasi];
        $pengeluaran_avg = $restoran->restoran_pengeluaran_avg;
        $persentase = $restoran->restoran_persentase_pajak ?? 10;

        return generateRupiah($sk * $tk * $pengeluaran_avg * ($persentase / 100), false);
    }

    public function getNomorUrut($id)
    {
        if ($id < 10000) {
            $id = '0'.$id;
        } else if ($id < 1000) {
            $id = '00'.$id;
        } else if ($id < 100) {
            $id = '000'.$id;
        } else if ($id < 10) {
            $id = '0000'.$id;
        }

        return $id;
    }
}
