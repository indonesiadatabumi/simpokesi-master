<?php

namespace App\Services;

use App\Imports\RusunImport;
use App\Imports\RusunJenisKamarImport;
use App\Models\RusunJenisKamar;
use App\Models\Kelurahan;
use App\Models\Rusun;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class RusunService
{
    public function getRusunList()
    {
        return DB::table('rusuns')->select([
            DB::raw('*'),
            DB::raw('rusuns.id as id')
        ])->whereNull('rusuns.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create Rusun
        $input['rusun']['rusun_alamat'] = toUpper($input['rusun']['rusun_alamat']);
        $input['rusun']['rusun_kelurahan'] = toUpper(@$input['rusun']['rusun_kelurahan']);
        $input['rusun']['rusun_potensi_pajak'] = $this->getPotensiRusun($input);
        $input['rusun']['rusun_kecamatan'] = Kelurahan::where('kelurahan', $input['rusun']['rusun_kelurahan'])->first()->kecamatan->kecamatan;
        $input['rusun']['created_by'] = auth()->user()->id;
        $input['rusun']['status_aktif_id'] = @$input['rusun']['status_aktif_id'] ? $input['rusun']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['rusun']['rusun_foto']) {
            $tempFile = $input['rusun']['rusun_foto'];
            unset($input['rusun']['rusun_foto']);
        }

        $rusun = Rusun::create($input['rusun']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($rusun->id);
            $year = date('Y', strtotime($rusun->created_at));
            $date = date('mdY');

            $imageName = $year.'_RUSUN_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('rusun', $imageName, 'public_uploads');
            $input['rusun']['rusun_foto'] = $imageName;

            $rusun->update(['rusun_foto' => $input['rusun']['rusun_foto']]);
        }


        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['rusun_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row);
            $input['jenis_kamar'][$key]['rusun_id'] = $rusun->id;
        }

        RusunJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Find Rusun
        $rusun = Rusun::findOrFail($id);

        // Update Rusun
        $input['rusun']['rusun_alamat'] = toUpper($input['rusun']['rusun_alamat']);
        $input['rusun']['rusun_kelurahan'] = toUpper(@$input['rusun']['rusun_kelurahan']);
        $input['rusun']['rusun_potensi_pajak'] = $this->getPotensiRusun($input);
        $input['rusun']['rusun_kecamatan'] = Kelurahan::where('kelurahan', $input['rusun']['rusun_kelurahan'])->first()->kecamatan->kecamatan;
        $input['rusun']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['rusun']['rusun_foto']) {
            Storage::disk('public_uploads')->delete('rusun/' . $rusun->rusun_foto);

            $no = $this->getNomorUrut($rusun->id);
            $year = date('Y', strtotime($rusun->created_at));
            $date = date('mdY');

            $imageName = $year.'_RUSUN_' . $no . $date . '.' . $input['rusun']['rusun_foto']->getClientOriginalExtension();
            $input['rusun']['rusun_foto']->storeAs('rusun', $imageName, 'public_uploads');
            $input['rusun']['rusun_foto'] = $imageName;
        }

        $rusun->update($input['rusun']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['rusun_id'] = $id;
            $input['jenis_kamar'][$key]['rusun_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

        RusunJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = RusunJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }
    }

    public function destroy($id)
    {
        $rusun = Rusun::findOrFail($id);

        $rusun->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Rusun') {
            $import = new RusunImport();
        } else {
            $import = new RusunJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $rusun = new Rusun();

        if (@$request->tahun && ($request->tahun != '')) {
            $rusun = $rusun->whereYear('created_at', $request->tahun);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $rusun = $rusun->where(DB::raw('LOWER(rusun_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $rusun = $rusun->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $rusun = $rusun->where(DB::raw('LOWER(rusun_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $rusun->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiRusun($rusun)
    {
        $jumlah_potensi = 0;
        foreach ($rusun['jenis_kamar'] as $jenis_kamar) {
            $jumlah_potensi += $this->getPotensiKamar($jenis_kamar);
        }

        return $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar)
    {
        $tarif = $jenis_kamar['rusun_jenis_kamar_tarif'] ?? 0;
        $avg = $jenis_kamar['rusun_jenis_kamar_hunian_avg'] ?? 0;

        $potensi = $tarif * $avg * 12;

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
