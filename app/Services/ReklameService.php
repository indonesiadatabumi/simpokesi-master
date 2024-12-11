<?php

namespace App\Services;

use App\Imports\ReklameImport;
/*use App\Imports\ReklameJenisKamarImport;
use App\Models\ReklameJenisKamar;
use App\Models\ReklameKlasifikasi;
use App\Models\ReklameTingkatHunianAvg;*/
use App\Models\Kelurahan;
use App\Models\Reklame;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ReklameService
{
    public function getReklameList()
    {
        return DB::table('reklames')->select([
            DB::raw('*'),
            DB::raw('reklames.id as id')
        ])->whereNull('reklames.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
/*        $klasifikasi = ReklameKlasifikasi::find($input['reklame']['reklame_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = ReklameKlasifikasi::create([
                'reklame_klasifikasi_deskripsi' => toUpper($input['reklame']['reklame_klasifikasi_id'])
            ]);
            $input['reklame']['reklame_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Create Reklame
        $input['reklame']['reklame_alamat'] = toUpper($input['reklame']['reklame_alamat']);
        $input['reklame']['reklame_kelurahan'] = toUpper(@$input['reklame']['reklame_kelurahan']);
        $input['reklame']['reklame_potensi_pajak'] = $this->getPotensiReklame($input, false, true);
        $input['reklame']['reklame_kecamatan'] = Kelurahan::where('kelurahan', $input['reklame']['reklame_kelurahan'])->first()->kecamatan->kecamatan;
        $input['reklame']['created_by'] = auth()->user()->id;
        $input['reklame']['status_aktif_id'] = @$input['reklame']['status_aktif_id'] ? $input['reklame']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['reklame']['reklame_foto']) {
            $tempFile = $input['reklame']['reklame_foto'];
            unset($input['reklame']['reklame_foto']);
        }

        $reklame = Reklame::create($input['reklame']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($reklame->id);
            $year = date('Y', strtotime($reklame->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('reklame', $imageName, 'public_uploads');
            $input['reklame']['reklame_foto'] = $imageName;

            $reklame->update(['reklame_foto' => $input['reklame']['reklame_foto']]);
        }

        // Create tingkat hunian
        $input['tingkat_hunian']['reklame_id'] = $reklame->id;
   //     ReklameTingkatHunianAvg::create($input['tingkat_hunian']);

        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['reklame_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['reklame_id'] = $reklame->id;
        }

      ///  ReklameJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
  /*      $klasifikasi = ReklameKlasifikasi::find($input['reklame']['reklame_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = ReklameKlasifikasi::create([
                'reklame_klasifikasi_deskripsi' => toUpper($input['reklame']['reklame_klasifikasi_id'])
            ]);
            $input['reklame']['reklame_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Find Reklame
        $reklame = Reklame::findOrFail($id);

        // Update Reklame
        $input['reklame']['reklame_alamat'] = toUpper($input['reklame']['reklame_alamat']);
        $input['reklame']['reklame_kelurahan'] = toUpper(@$input['reklame']['reklame_kelurahan']);
        $input['reklame']['reklame_potensi_pajak'] = $this->getPotensiReklame($input, false, true);
        $input['reklame']['reklame_kecamatan'] = Kelurahan::where('kelurahan', $input['reklame']['reklame_kelurahan'])->first()->kecamatan->kecamatan;
        $input['reklame']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['reklame']['reklame_foto']) {
            Storage::disk('public_uploads')->delete('reklame/' . $reklame->reklame_foto);

            $no = $this->getNomorUrut($reklame->id);
            $year = date('Y', strtotime($reklame->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $input['reklame']['reklame_foto']->getClientOriginalExtension();
            $input['reklame']['reklame_foto']->storeAs('reklame', $imageName, 'public_uploads');
            $input['reklame']['reklame_foto'] = $imageName;
        }

        $reklame->update($input['reklame']);

        // Create or Update tingkat hunian
        $reklame->tingkat_hunian()->updateOrCreate(['id' => @$reklame->tingkat_hunian->id], $input['tingkat_hunian']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['reklame_id'] = $id;
            $input['jenis_kamar'][$key]['reklame_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

    /*    ReklameJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = ReklameJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }*/
    }

    public function destroy($id)
    {
        $reklame = Reklame::findOrFail($id);

        $reklame->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Reklame') {
            $import = new ReklameImport();
 //       } else {
   //         $import = new ReklameJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $reklame = new Reklame();

        if (@$request->tahun && ($request->tahun != '')) {
            $reklame = $reklame->whereYear('created_at', $request->tahun);
        }

        if (@$request->reklame_klasifikasi_id && ($request->reklame_klasifikasi_id != '')) {
            $reklame = $reklame->where('reklame_klasifikasi_id', $request->reklame_klasifikasi_id);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $reklame = $reklame->where(DB::raw('LOWER(reklame_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $reklame = $reklame->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $reklame = $reklame->where(DB::raw('LOWER(reklame_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $reklame->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiReklame($reklame, $formatted = true, $inputMode = false)
    {
        $jumlah_potensi = 0;
        if ($inputMode == true) {
            foreach ($reklame['jenis_kamar'] as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, null, false, $reklame);
            }
        } else {
            foreach ($reklame->jenis_kamar as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, $reklame, false);
            }
        }

        return $formatted == true ? generateRupiah($jumlah_potensi) : $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar, $reklame = null, $formatted = true, $input = null)
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

            $tingkat_hunian_penuh = $bobot_fjh_penuh * ($jenis_kamar['reklame_jenis_kamar_avg_penuh'] ?? 0);
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * ($jenis_kamar['reklame_jenis_kamar_avg_akhir_pekan'] ?? 0);
            $tingkat_hunian_normal = $bobot_fjh_normal * ($jenis_kamar['reklame_jenis_kamar_avg_normal'] ?? 0);
            $tingkat_hunian_sepi = $bobot_fjh_sepi * ($jenis_kamar['reklame_jenis_kamar_avg_sepi'] ?? 0);

            $tarif = $jenis_kamar['reklame_jenis_kamar_tarif'] ?? 0;
            $persentase = $input['reklame']['reklame_persentase_pajak'] ?? 10;
        } else {
            if (empty($reklame)) {
                $reklame = Reklame::find($jenis_kamar->reklame_id);
            }

            $jumlah_fjh = $reklame->tingkat_hunian->kunjungan_penuh +
                $reklame->tingkat_hunian->kunjungan_akhir_pekan +
                $reklame->tingkat_hunian->kunjungan_normal +
                $reklame->tingkat_hunian->kunjungan_sepi;

            $bobot_fjh_penuh = $reklame->tingkat_hunian->kunjungan_penuh / $jumlah_fjh;
            $bobot_fjh_akhir_pekan = $reklame->tingkat_hunian->kunjungan_akhir_pekan / $jumlah_fjh;
            $bobot_fjh_normal = $reklame->tingkat_hunian->kunjungan_normal / $jumlah_fjh;
            $bobot_fjh_sepi = $reklame->tingkat_hunian->kunjungan_sepi / $jumlah_fjh;

            $tingkat_hunian_penuh = $bobot_fjh_penuh * $jenis_kamar->reklame_jenis_kamar_avg_penuh;
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * $jenis_kamar->reklame_jenis_kamar_avg_akhir_pekan;
            $tingkat_hunian_normal = $bobot_fjh_normal * $jenis_kamar->reklame_jenis_kamar_avg_normal;
            $tingkat_hunian_sepi = $bobot_fjh_sepi * $jenis_kamar->reklame_jenis_kamar_avg_sepi;

            $tarif = $jenis_kamar->reklame_jenis_kamar_tarif;
            $persentase = $reklame->reklame_persentase_pajak ?? 10;
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
