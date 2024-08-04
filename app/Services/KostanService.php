<?php

namespace App\Services;

use App\Imports\KostanImport;
use App\Imports\KostanJenisKamarImport;
use App\Models\KostanJenisKamar;
use App\Models\Kelurahan;
use App\Models\Kostan;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class KostanService
{
    public function getKostanList()
    {
        return DB::table('kostans')->select([
            DB::raw('*'),
            DB::raw('kostans.id as id')
        ])->whereNull('kostans.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create Kostan
        $input['kostan']['kostan_alamat'] = toUpper($input['kostan']['kostan_alamat']);
        $input['kostan']['kostan_kelurahan'] = toUpper(@$input['kostan']['kostan_kelurahan']);
        $input['kostan']['kostan_potensi_pajak'] = $this->getPotensiKostan($input);
        $input['kostan']['kostan_kecamatan'] = Kelurahan::where('kelurahan', $input['kostan']['kostan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['kostan']['created_by'] = auth()->user()->id;
        $input['kostan']['status_aktif_id'] = @$input['kostan']['status_aktif_id'] ? $input['kostan']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['kostan']['kostan_foto']) {
            $tempFile = $input['kostan']['kostan_foto'];
            unset($input['kostan']['kostan_foto']);
        }

        $kostan = Kostan::create($input['kostan']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($kostan->id);
            $year = date('Y', strtotime($kostan->created_at));
            $date = date('mdY');

            $imageName = $year.'_KOSTAN_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('kostan', $imageName, 'public_uploads');
            $input['kostan']['kostan_foto'] = $imageName;

            $kostan->update(['kostan_foto' => $input['kostan']['kostan_foto']]);
        }


        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['kostan_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row);
            $input['jenis_kamar'][$key]['kostan_id'] = $kostan->id;
        }

        KostanJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Find Kostan
        $kostan = Kostan::findOrFail($id);

        // Update Kostan
        $input['kostan']['kostan_alamat'] = toUpper($input['kostan']['kostan_alamat']);
        $input['kostan']['kostan_kelurahan'] = toUpper(@$input['kostan']['kostan_kelurahan']);
        $input['kostan']['kostan_potensi_pajak'] = $this->getPotensiKostan($input);
        $input['kostan']['kostan_kecamatan'] = Kelurahan::where('kelurahan', $input['kostan']['kostan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['kostan']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['kostan']['kostan_foto']) {
            Storage::disk('public_uploads')->delete('kostan/' . $kostan->kostan_foto);

            $no = $this->getNomorUrut($kostan->id);
            $year = date('Y', strtotime($kostan->created_at));
            $date = date('mdY');

            $imageName = $year.'_KOSTAN_' . $no . $date . '.' . $input['kostan']['kostan_foto']->getClientOriginalExtension();
            $input['kostan']['kostan_foto']->storeAs('kostan', $imageName, 'public_uploads');
            $input['kostan']['kostan_foto'] = $imageName;
        }

        $kostan->update($input['kostan']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['kostan_id'] = $id;
            $input['jenis_kamar'][$key]['kostan_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

        KostanJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = KostanJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }
    }

    public function destroy($id)
    {
        $kostan = Kostan::findOrFail($id);

        $kostan->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Kostan') {
            $import = new KostanImport();
        } else {
            $import = new KostanJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $kostan = new Kostan();

        if (@$request->tahun && ($request->tahun != '')) {
            $kostan = $kostan->whereYear('created_at', $request->tahun);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $kostan = $kostan->where(DB::raw('LOWER(kostan_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $kostan = $kostan->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $kostan = $kostan->where(DB::raw('LOWER(kostan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $kostan->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiKostan($kostan)
    {
        $jumlah_potensi = 0;
        foreach ($kostan['jenis_kamar'] as $jenis_kamar) {
            $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, ($kostan['kostan']['kostan_persentase_pajak'] ?? 10));
        }

        return $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar, $persentase = 10)
    {
        $tarif = $jenis_kamar['kostan_jenis_kamar_tarif'] ?? 0;
        $avg = $jenis_kamar['kostan_jenis_kamar_hunian_avg'] ?? 0;

        $potensi = $tarif * $avg * 12 * ($persentase / 100);

        return $potensi;
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
