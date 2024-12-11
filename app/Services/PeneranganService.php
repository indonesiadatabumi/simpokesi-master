<?php

namespace App\Services;

use App\Imports\PeneranganImport;
/*use App\Imports\PeneranganJenisKamarImport;
use App\Models\PeneranganJenisKamar;
use App\Models\PeneranganKlasifikasi;
use App\Models\PeneranganTingkatHunianAvg;*/
use App\Models\Kelurahan;
use App\Models\Penerangan;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class PeneranganService
{
    public function getPeneranganList()
    {
        return DB::table('penerangans')->select([
            DB::raw('*'),
            DB::raw('penerangans.id as id')
        ])->whereNull('penerangans.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
/*        $klasifikasi = PeneranganKlasifikasi::find($input['penerangan']['penerangan_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = PeneranganKlasifikasi::create([
                'penerangan_klasifikasi_deskripsi' => toUpper($input['penerangan']['penerangan_klasifikasi_id'])
            ]);
            $input['penerangan']['penerangan_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Create Penerangan
        $input['penerangan']['penerangan_alamat'] = toUpper($input['penerangan']['penerangan_alamat']);
        $input['penerangan']['penerangan_kelurahan'] = toUpper(@$input['penerangan']['penerangan_kelurahan']);
        $input['penerangan']['penerangan_potensi_pajak'] = $this->getPotensiPenerangan($input, false, true);
        $input['penerangan']['penerangan_kecamatan'] = Kelurahan::where('kelurahan', $input['penerangan']['penerangan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['penerangan']['created_by'] = auth()->user()->id;
        $input['penerangan']['status_aktif_id'] = @$input['penerangan']['status_aktif_id'] ? $input['penerangan']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['penerangan']['penerangan_foto']) {
            $tempFile = $input['penerangan']['penerangan_foto'];
            unset($input['penerangan']['penerangan_foto']);
        }

        $penerangan = Penerangan::create($input['penerangan']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($penerangan->id);
            $year = date('Y', strtotime($penerangan->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('penerangan', $imageName, 'public_uploads');
            $input['penerangan']['penerangan_foto'] = $imageName;

            $penerangan->update(['penerangan_foto' => $input['penerangan']['penerangan_foto']]);
        }

        // Create tingkat hunian
        $input['tingkat_hunian']['penerangan_id'] = $penerangan->id;
   //     PeneranganTingkatHunianAvg::create($input['tingkat_hunian']);

        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['penerangan_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['penerangan_id'] = $penerangan->id;
        }

      ///  PeneranganJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
  /*      $klasifikasi = PeneranganKlasifikasi::find($input['penerangan']['penerangan_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = PeneranganKlasifikasi::create([
                'penerangan_klasifikasi_deskripsi' => toUpper($input['penerangan']['penerangan_klasifikasi_id'])
            ]);
            $input['penerangan']['penerangan_klasifikasi_id'] = $klasifikasi->id;
        }
*/
        // Find Penerangan
        $penerangan = Penerangan::findOrFail($id);

        // Update Penerangan
        $input['penerangan']['penerangan_alamat'] = toUpper($input['penerangan']['penerangan_alamat']);
        $input['penerangan']['penerangan_kelurahan'] = toUpper(@$input['penerangan']['penerangan_kelurahan']);
        $input['penerangan']['penerangan_potensi_pajak'] = $this->getPotensiPenerangan($input, false, true);
        $input['penerangan']['penerangan_kecamatan'] = Kelurahan::where('kelurahan', $input['penerangan']['penerangan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['penerangan']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['penerangan']['penerangan_foto']) {
            Storage::disk('public_uploads')->delete('penerangan/' . $penerangan->penerangan_foto);

            $no = $this->getNomorUrut($penerangan->id);
            $year = date('Y', strtotime($penerangan->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $input['penerangan']['penerangan_foto']->getClientOriginalExtension();
            $input['penerangan']['penerangan_foto']->storeAs('penerangan', $imageName, 'public_uploads');
            $input['penerangan']['penerangan_foto'] = $imageName;
        }

        $penerangan->update($input['penerangan']);

        // Create or Update tingkat hunian
        $penerangan->tingkat_hunian()->updateOrCreate(['id' => @$penerangan->tingkat_hunian->id], $input['tingkat_hunian']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['penerangan_id'] = $id;
            $input['jenis_kamar'][$key]['penerangan_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

    /*    PeneranganJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = PeneranganJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }*/
    }

    public function destroy($id)
    {
        $penerangan = Penerangan::findOrFail($id);

        $penerangan->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Penerangan') {
            $import = new PeneranganImport();
 //       } else {
   //         $import = new PeneranganJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $penerangan = new Penerangan();

        if (@$request->tahun && ($request->tahun != '')) {
            $penerangan = $penerangan->whereYear('created_at', $request->tahun);
        }

        if (@$request->penerangan_klasifikasi_id && ($request->penerangan_klasifikasi_id != '')) {
            $penerangan = $penerangan->where('penerangan_klasifikasi_id', $request->penerangan_klasifikasi_id);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $penerangan = $penerangan->where(DB::raw('LOWER(penerangan_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $penerangan = $penerangan->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $penerangan = $penerangan->where(DB::raw('LOWER(penerangan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $penerangan->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiPenerangan($penerangan, $formatted = true, $inputMode = false)
    {
        $jumlah_potensi = 0;
        if ($inputMode == true) {
            foreach ($penerangan['jenis_kamar'] as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, null, false, $penerangan);
            }
        } else {
            foreach ($penerangan->jenis_kamar as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, $penerangan, false);
            }
        }

        return $formatted == true ? generateRupiah($jumlah_potensi) : $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar, $penerangan = null, $formatted = true, $input = null)
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

            $tingkat_hunian_penuh = $bobot_fjh_penuh * ($jenis_kamar['penerangan_jenis_kamar_avg_penuh'] ?? 0);
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * ($jenis_kamar['penerangan_jenis_kamar_avg_akhir_pekan'] ?? 0);
            $tingkat_hunian_normal = $bobot_fjh_normal * ($jenis_kamar['penerangan_jenis_kamar_avg_normal'] ?? 0);
            $tingkat_hunian_sepi = $bobot_fjh_sepi * ($jenis_kamar['penerangan_jenis_kamar_avg_sepi'] ?? 0);

            $tarif = $jenis_kamar['penerangan_jenis_kamar_tarif'] ?? 0;
            $persentase = $input['penerangan']['penerangan_persentase_pajak'] ?? 10;
        } else {
            if (empty($penerangan)) {
                $penerangan = Penerangan::find($jenis_kamar->penerangan_id);
            }

            $jumlah_fjh = $penerangan->tingkat_hunian->kunjungan_penuh +
                $penerangan->tingkat_hunian->kunjungan_akhir_pekan +
                $penerangan->tingkat_hunian->kunjungan_normal +
                $penerangan->tingkat_hunian->kunjungan_sepi;

            $bobot_fjh_penuh = $penerangan->tingkat_hunian->kunjungan_penuh / $jumlah_fjh;
            $bobot_fjh_akhir_pekan = $penerangan->tingkat_hunian->kunjungan_akhir_pekan / $jumlah_fjh;
            $bobot_fjh_normal = $penerangan->tingkat_hunian->kunjungan_normal / $jumlah_fjh;
            $bobot_fjh_sepi = $penerangan->tingkat_hunian->kunjungan_sepi / $jumlah_fjh;

            $tingkat_hunian_penuh = $bobot_fjh_penuh * $jenis_kamar->penerangan_jenis_kamar_avg_penuh;
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * $jenis_kamar->penerangan_jenis_kamar_avg_akhir_pekan;
            $tingkat_hunian_normal = $bobot_fjh_normal * $jenis_kamar->penerangan_jenis_kamar_avg_normal;
            $tingkat_hunian_sepi = $bobot_fjh_sepi * $jenis_kamar->penerangan_jenis_kamar_avg_sepi;

            $tarif = $jenis_kamar->penerangan_jenis_kamar_tarif;
            $persentase = $penerangan->penerangan_persentase_pajak ?? 10;
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
