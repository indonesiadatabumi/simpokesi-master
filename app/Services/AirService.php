<?php

namespace App\Services;

use App\Imports\AirImport;
/*use App\Imports\AirJenisKamarImport;
use App\Models\AirJenisKamar;
use App\Models\AirKlasifikasi;
use App\Models\AirTingkatHunianAvg;*/
use App\Models\Kelurahan;
use App\Models\Air;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class AirService
{
    public function getAirList()
    {
        return DB::table('airs')->select([
            DB::raw('*'),
            DB::raw('airs.id as id')
        ])->whereNull('airs.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
/*        $klasifikasi = AirKlasifikasi::find($input['air']['air_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = AirKlasifikasi::create([
                'air_klasifikasi_deskripsi' => toUpper($input['air']['air_klasifikasi_id'])
            ]);
            $input['air']['air_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Create Air
        $input['air']['air_alamat'] = toUpper($input['air']['air_alamat']);
        $input['air']['air_kelurahan'] = toUpper(@$input['air']['air_kelurahan']);
        $input['air']['air_potensi_pajak'] = $this->getPotensiAir($input, false, true);
        $input['air']['air_kecamatan'] = Kelurahan::where('kelurahan', $input['air']['air_kelurahan'])->first()->kecamatan->kecamatan;
        $input['air']['created_by'] = auth()->user()->id;
        $input['air']['status_aktif_id'] = @$input['air']['status_aktif_id'] ? $input['air']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['air']['air_foto']) {
            $tempFile = $input['air']['air_foto'];
            unset($input['air']['air_foto']);
        }

        $air = Air::create($input['air']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($air->id);
            $year = date('Y', strtotime($air->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('air', $imageName, 'public_uploads');
            $input['air']['air_foto'] = $imageName;

            $air->update(['air_foto' => $input['air']['air_foto']]);
        }

        // Create tingkat hunian
        $input['tingkat_hunian']['air_id'] = $air->id;
   //     AirTingkatHunianAvg::create($input['tingkat_hunian']);

        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['air_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['air_id'] = $air->id;
        }

      ///  AirJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
  /*      $klasifikasi = AirKlasifikasi::find($input['air']['air_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = AirKlasifikasi::create([
                'air_klasifikasi_deskripsi' => toUpper($input['air']['air_klasifikasi_id'])
            ]);
            $input['air']['air_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Find Air
        $air = Air::findOrFail($id);

        // Update Air
        $input['air']['air_alamat'] = toUpper($input['air']['air_alamat']);
        $input['air']['air_kelurahan'] = toUpper(@$input['air']['air_kelurahan']);
        $input['air']['air_potensi_pajak'] = $this->getPotensiAir($input, false, true);
        $input['air']['air_kecamatan'] = Kelurahan::where('kelurahan', $input['air']['air_kelurahan'])->first()->kecamatan->kecamatan;
        $input['air']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['air']['air_foto']) {
            Storage::disk('public_uploads')->delete('air/' . $air->air_foto);

            $no = $this->getNomorUrut($air->id);
            $year = date('Y', strtotime($air->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $input['air']['air_foto']->getClientOriginalExtension();
            $input['air']['air_foto']->storeAs('air', $imageName, 'public_uploads');
            $input['air']['air_foto'] = $imageName;
        }

        $air->update($input['air']);

        // Create or Update tingkat hunian
        $air->tingkat_hunian()->updateOrCreate(['id' => @$air->tingkat_hunian->id], $input['tingkat_hunian']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['air_id'] = $id;
            $input['jenis_kamar'][$key]['air_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

    /*    AirJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = AirJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }*/
    }

    public function destroy($id)
    {
        $air = Air::findOrFail($id);

        $air->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Air') {
            $import = new AirImport();
 //       } else {
   //         $import = new AirJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $air = new Air();

        if (@$request->tahun && ($request->tahun != '')) {
            $air = $air->whereYear('created_at', $request->tahun);
        }

        if (@$request->air_klasifikasi_id && ($request->air_klasifikasi_id != '')) {
            $air = $air->where('air_klasifikasi_id', $request->air_klasifikasi_id);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $air = $air->where(DB::raw('LOWER(air_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $air = $air->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $air = $air->where(DB::raw('LOWER(air_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $air->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiAir($air, $formatted = true, $inputMode = false)
    {
        $jumlah_potensi = 0;
        if ($inputMode == true) {
            foreach ($air['jenis_kamar'] as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, null, false, $air);
            }
        } else {
            foreach ($air->jenis_kamar as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, $air, false);
            }
        }

        return $formatted == true ? generateRupiah($jumlah_potensi) : $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar, $air = null, $formatted = true, $input = null)
    {
        if (@$input) {
            $jumlah_fjh = ($input['tingkat_hunian']['kunjungan_penuh'] ?? 0) +
                ($input['tingkat_hunian']['kunjungan_akhir_pekan'] ?? 0) +
                ($input['tingkat_hunian']['kunjungan_normal'] ?? 0) +
                ($input['tingkat_hunian']['kunjungan_sepi'] ?? 0);

            $bobot_fjh_penuh = ($input['tingkat_hunian']['kunjungan_penuh'] ?? 0) / $jumlah_fjh;
            $bobot_fjh_akhir_pekan = ($input['tingkat_hunian']['kunjungan_akhir_pekan'] ?? 0) / $jumlah_fjh;
            $bobot_fjh_normal = ($input['tingkat_hunian']['kunjungan_normal'] ?? 0) / $jumlah_fjh;
            $bobot_fjh_sepi = ($input['tingkat_hunian']['kunjungan_sepi'] ?? 0) / $jumlah_fjh;

            $tingkat_hunian_penuh = $bobot_fjh_penuh * ($jenis_kamar['air_jenis_kamar_avg_penuh'] ?? 0);
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * ($jenis_kamar['air_jenis_kamar_avg_akhir_pekan'] ?? 0);
            $tingkat_hunian_normal = $bobot_fjh_normal * ($jenis_kamar['air_jenis_kamar_avg_normal'] ?? 0);
            $tingkat_hunian_sepi = $bobot_fjh_sepi * ($jenis_kamar['air_jenis_kamar_avg_sepi'] ?? 0);

            $tarif = $jenis_kamar['air_jenis_kamar_tarif'] ?? 0;
            $persentase = $input['air']['air_persentase_pajak'] ?? 10;
        } else {
            if (empty($air)) {
                $air = Air::find($jenis_kamar->air_id);
            }

            $jumlah_fjh = $air->tingkat_hunian->kunjungan_penuh +
                $air->tingkat_hunian->kunjungan_akhir_pekan +
                $air->tingkat_hunian->kunjungan_normal +
                $air->tingkat_hunian->kunjungan_sepi;

            $bobot_fjh_penuh = $air->tingkat_hunian->kunjungan_penuh / $jumlah_fjh;
            $bobot_fjh_akhir_pekan = $air->tingkat_hunian->kunjungan_akhir_pekan / $jumlah_fjh;
            $bobot_fjh_normal = $air->tingkat_hunian->kunjungan_normal / $jumlah_fjh;
            $bobot_fjh_sepi = $air->tingkat_hunian->kunjungan_sepi / $jumlah_fjh;

            $tingkat_hunian_penuh = $bobot_fjh_penuh * $jenis_kamar->air_jenis_kamar_avg_penuh;
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * $jenis_kamar->air_jenis_kamar_avg_akhir_pekan;
            $tingkat_hunian_normal = $bobot_fjh_normal * $jenis_kamar->air_jenis_kamar_avg_normal;
            $tingkat_hunian_sepi = $bobot_fjh_sepi * $jenis_kamar->air_jenis_kamar_avg_sepi;

            $tarif = $jenis_kamar->air_jenis_kamar_tarif;
            $persentase = $air->air_persentase_pajak ?? 10;
        }

        $tingkat_hunian = $tingkat_hunian_penuh +
            $tingkat_hunian_akhir_pekan +
            $tingkat_hunian_normal +
            $tingkat_hunian_sepi;

        $potensi = $tingkat_hunian * $tarif * 365 * ($persentase / 100);

        return $formatted == true ? generateRupiah($potensi) : $potensi;
    }

    public function getBobotFJH($fjh, $tingkat_hunian, $rounded = true) {
        $sumFJH = (@$tingkat_hunian->kunjungan_penuh ?? 0)
            + (@$tingkat_hunian->kunjungan_akhir_pekan ?? 0)
            + (@$tingkat_hunian->kunjungan_normal ?? 0)
            + (@$tingkat_hunian->kunjungan_sepi ?? 0);

        return $rounded === true ? round($fjh / $sumFJH, 4) : $fjh / $sumFJH;
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
