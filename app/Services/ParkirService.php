<?php

namespace App\Services;

use App\Imports\ParkirImport;
use App\Models\ParkirTingkatKunjunganAvg;
use App\Models\Kelurahan;
use App\Models\Parkir;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ParkirService
{
    public function getParkirList()
    {
        return DB::table('parkirs')->select([
            DB::raw('*'),
            DB::raw('parkirs.id as id')
        ])->whereNull('parkirs.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create Parkir
        $input['parkir']['parkir_alamat'] = toUpper($input['parkir']['parkir_alamat']);
        $input['parkir']['parkir_kelurahan'] = toUpper(@$input['parkir']['parkir_kelurahan']);
        $input['parkir']['parkir_kecamatan'] = Kelurahan::where('kelurahan', $input['parkir']['parkir_kelurahan'])->first()->kecamatan->kecamatan;
        $input['parkir']['parkir_potensi_pajak_motor'] = $this->getPotensiParkir($input, 'motor');
        $input['parkir']['parkir_potensi_pajak_mobil'] = $this->getPotensiParkir($input, 'mobil');
        $input['parkir']['parkir_potensi_pajak'] = $this->getPotensiParkir($input, 'motor') + $this->getPotensiParkir($input, 'mobil');
        $input['parkir']['created_by'] = auth()->user()->id;
        $input['parkir']['status_aktif_id'] = @$input['parkir']['status_aktif_id'] ? $input['parkir']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['parkir']['parkir_foto']) {
            $tempFile = $input['parkir']['parkir_foto'];
            unset($input['parkir']['parkir_foto']);
        }

        $parkir = Parkir::create($input['parkir']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($parkir->id);
            $year = date('Y', strtotime($parkir->created_at));
            $date = date('mdY');

            $imageName = $year.'_PARKIR_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('parkir', $imageName, 'public_uploads');
            $input['parkir']['parkir_foto'] = $imageName;

            $parkir->update(['parkir_foto' => $input['parkir']['parkir_foto']]);
        }

        // Create tingkat kunjungan
        $input['tingkat_kunjungan']['parkir_id'] = $parkir->id;
        ParkirTingkatKunjunganAvg::create($input['tingkat_kunjungan']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Find Parkir
        $parkir = Parkir::findOrFail($id);

        // Update Parkir
        $input['parkir']['parkir_alamat'] = toUpper($input['parkir']['parkir_alamat']);
        $input['parkir']['parkir_kelurahan'] = toUpper(@$input['parkir']['parkir_kelurahan']);
        $input['parkir']['parkir_kecamatan'] = Kelurahan::where('kelurahan', $input['parkir']['parkir_kelurahan'])->first()->kecamatan->kecamatan;
        $input['parkir']['parkir_potensi_pajak_motor'] = $this->getPotensiParkir($input, 'motor');
        $input['parkir']['parkir_potensi_pajak_mobil'] = $this->getPotensiParkir($input, 'mobil');
        $input['parkir']['parkir_potensi_pajak'] = $this->getPotensiParkir($input, 'motor') + $this->getPotensiParkir($input, 'mobil');
        $input['parkir']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['parkir']['parkir_foto']) {
            Storage::disk('public_uploads')->delete('parkir/' . $parkir->parkir_foto);

            $no = $this->getNomorUrut($parkir->id);
            $year = date('Y', strtotime($parkir->created_at));
            $date = date('mdY');

            $imageName = $year.'_PARKIR_' . $no . $date . '.' . $input['parkir']['parkir_foto']->getClientOriginalExtension();
            $input['parkir']['parkir_foto']->storeAs('parkir', $imageName, 'public_uploads');
            $input['parkir']['parkir_foto'] = $imageName;
        }

        $parkir->update($input['parkir']);

        // Create or Update tingkat kunjungan
        $parkir->tingkat_kunjungan()->updateOrCreate(['id' => @$parkir->tingkat_kunjungan->id], $input['tingkat_kunjungan']);
    }

    public function destroy($id)
    {
        $parkir = Parkir::findOrFail($id);

        $parkir->delete();
    }

    public function import(Request $request)
    {
        $file = request()->file('file');

        $import = new ParkirImport();
        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $parkir = new Parkir();

        if (@$request->tahun && ($request->tahun != '')) {
            $parkir = $parkir->whereYear('created_at', $request->tahun);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $parkir = $parkir->where(DB::raw('LOWER(parkir_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $parkir = $parkir->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $parkir = $parkir->where(DB::raw('LOWER(parkir_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $parkir->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiParkir($input, $type = 'motor')
    {
        $sk_ramai = $input['tingkat_kunjungan'][$type . '_situasi_kunjungan_ramai'] ?? 0;
        $sk_normal = $input['tingkat_kunjungan'][$type . '_situasi_kunjungan_normal'] ?? 0;
        $sk_sepi = $input['tingkat_kunjungan'][$type . '_situasi_kunjungan_sepi'] ?? 0;

        $tk_ramai = $input['tingkat_kunjungan'][$type . '_avg_kunjungan_ramai'] ?? 0;
        $tk_normal = $input['tingkat_kunjungan'][$type . '_avg_kunjungan_normal'] ?? 0;
        $tk_sepi = $input['tingkat_kunjungan'][$type . '_avg_kunjungan_sepi'] ?? 0;

        $durasi_avg = $input['parkir']['parkir_durasi_avg'] ?? 0;
        $tarif = $input['parkir']['parkir_tarif_' . $type] ?? 0;
        $persentase = $input['parkir']['parkir_persentase_pajak'] ?? 10;

        $potensi_ramai = $sk_ramai * $tk_ramai * $tarif * $durasi_avg * ($persentase / 100);
        $potensi_normal = $sk_normal * $tk_normal * $tarif * $durasi_avg * ($persentase / 100);
        $potensi_sepi = $sk_sepi * $tk_sepi * $tarif * $durasi_avg * ($persentase / 100);

        $potensi = $potensi_ramai + $potensi_normal + $potensi_sepi;

        return $potensi;
    }

    public function getPotensiSituasiKunjungan($parkir, $situasi, $type = 'motor')
    {
        $arr = $parkir->tingkat_kunjungan;
        $sk = $arr[$type.'_situasi_kunjungan_'.$situasi];
        $tk = $arr[$type.'_avg_kunjungan_'.$situasi];
        $durasi_avg = $parkir->parkir_durasi_avg;
        $tarif = @$parkir['parkir_tarif_'.$type] ?? 0;
        $persentase = $parkir->parkir_persentase_pajak ?? 10;

        return generateRupiah($sk * $tk * $durasi_avg * $tarif * ($persentase / 100), false);
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
