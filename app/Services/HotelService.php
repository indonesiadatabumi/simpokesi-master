<?php

namespace App\Services;

use App\Imports\HotelImport;
use App\Imports\HotelJenisKamarImport;
use App\Models\HotelJenisKamar;
use App\Models\HotelKlasifikasi;
use App\Models\HotelTingkatHunianAvg;
use App\Models\Kelurahan;
use App\Models\Hotel;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class HotelService
{
    public function getHotelList()
    {
        return DB::table('hotels')->select([
            DB::raw('*'),
            DB::raw('hotels.id as id')
        ])->whereNull('hotels.deleted_at');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
        $klasifikasi = HotelKlasifikasi::find($input['hotel']['hotel_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = HotelKlasifikasi::create([
                'hotel_klasifikasi_deskripsi' => toUpper($input['hotel']['hotel_klasifikasi_id'])
            ]);
            $input['hotel']['hotel_klasifikasi_id'] = $klasifikasi->id;
        }

        // Create Hotel
        $input['hotel']['hotel_alamat'] = toUpper($input['hotel']['hotel_alamat']);
        $input['hotel']['hotel_kelurahan'] = toUpper(@$input['hotel']['hotel_kelurahan']);
        $input['hotel']['hotel_potensi_pajak'] = $this->getPotensiHotel($input, false, true);
        $input['hotel']['hotel_kecamatan'] = Kelurahan::where('kelurahan', $input['hotel']['hotel_kelurahan'])->first()->kecamatan->kecamatan;
        $input['hotel']['created_by'] = auth()->user()->id;
        $input['hotel']['status_aktif_id'] = @$input['hotel']['status_aktif_id'] ? $input['hotel']['status_aktif_id'] : 4;

        // Set temp file
        if (@$input['hotel']['hotel_foto']) {
            $tempFile = $input['hotel']['hotel_foto'];
            unset($input['hotel']['hotel_foto']);
        }

        $hotel = Hotel::create($input['hotel']);

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($hotel->id);
            $year = date('Y', strtotime($hotel->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('hotel', $imageName, 'public_uploads');
            $input['hotel']['hotel_foto'] = $imageName;

            $hotel->update(['hotel_foto' => $input['hotel']['hotel_foto']]);
        }

        // Create tingkat hunian
        $input['tingkat_hunian']['hotel_id'] = $hotel->id;
        HotelTingkatHunianAvg::create($input['tingkat_hunian']);

        // Create jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['hotel_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['hotel_id'] = $hotel->id;
        }

        HotelJenisKamar::insert($input['jenis_kamar']);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // Create klasifikasi if not exist
        $klasifikasi = HotelKlasifikasi::find($input['hotel']['hotel_klasifikasi_id']);
        if (empty($klasifikasi)) {
            $klasifikasi = HotelKlasifikasi::create([
                'hotel_klasifikasi_deskripsi' => toUpper($input['hotel']['hotel_klasifikasi_id'])
            ]);
            $input['hotel']['hotel_klasifikasi_id'] = $klasifikasi->id;
        }

        // Find Hotel
        $hotel = Hotel::findOrFail($id);

        // Update Hotel
        $input['hotel']['hotel_alamat'] = toUpper($input['hotel']['hotel_alamat']);
        $input['hotel']['hotel_kelurahan'] = toUpper(@$input['hotel']['hotel_kelurahan']);
        $input['hotel']['hotel_potensi_pajak'] = $this->getPotensiHotel($input, false, true);
        $input['hotel']['hotel_kecamatan'] = Kelurahan::where('kelurahan', $input['hotel']['hotel_kelurahan'])->first()->kecamatan->kecamatan;
        $input['hotel']['updated_at'] = Carbon::now();

        // Upload File
        if (@$input['hotel']['hotel_foto']) {
            Storage::disk('public_uploads')->delete('hotel/' . $hotel->hotel_foto);

            $no = $this->getNomorUrut($hotel->id);
            $year = date('Y', strtotime($hotel->created_at));
            $date = date('mdY');

            $imageName = $year.'_HOTEL_' . $no . $date . '.' . $input['hotel']['hotel_foto']->getClientOriginalExtension();
            $input['hotel']['hotel_foto']->storeAs('hotel', $imageName, 'public_uploads');
            $input['hotel']['hotel_foto'] = $imageName;
        }

        $hotel->update($input['hotel']);

        // Create or Update tingkat hunian
        $hotel->tingkat_hunian()->updateOrCreate(['id' => @$hotel->tingkat_hunian->id], $input['tingkat_hunian']);

        // Create or Update jenis kamar
        foreach ($input['jenis_kamar'] as $key => $row) {
            $input['jenis_kamar'][$key]['hotel_id'] = $id;
            $input['jenis_kamar'][$key]['hotel_jenis_kamar_potensi_pajak'] = $this->getPotensiKamar($row, null, false, $input);
            $input['jenis_kamar'][$key]['id'] = @$input['jenis_kamar'][$key]['id'] ?? null;
        }

        HotelJenisKamar::upsert($input['jenis_kamar'], ['id']);

        // Delete jenis kamar
        $deletedIpr = HotelJenisKamar::whereIn('id', explode(';', $input['deleted_jenis_kamar']));
        if ($deletedIpr->count() > 0) {
            $deletedIpr->delete();
        }
    }

    public function destroy($id)
    {
        $hotel = Hotel::findOrFail($id);

        $hotel->delete();
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Hotel') {
            $import = new HotelImport();
        } else {
            $import = new HotelJenisKamarImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $hotel = new Hotel();

        if (@$request->tahun && ($request->tahun != '')) {
            $hotel = $hotel->whereYear('created_at', $request->tahun);
        }

        if (@$request->hotel_klasifikasi_id && ($request->hotel_klasifikasi_id != '')) {
            $hotel = $hotel->where('hotel_klasifikasi_id', $request->hotel_klasifikasi_id);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $hotel = $hotel->where(DB::raw('LOWER(hotel_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $hotel = $hotel->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $hotel = $hotel->where(DB::raw('LOWER(hotel_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $hotel->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiHotel($hotel, $formatted = true, $inputMode = false)
    {
        $jumlah_potensi = 0;
        if ($inputMode == true) {
            foreach ($hotel['jenis_kamar'] as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, null, false, $hotel);
            }
        } else {
            foreach ($hotel->jenis_kamar as $jenis_kamar) {
                $jumlah_potensi += $this->getPotensiKamar($jenis_kamar, $hotel, false);
            }
        }

        return $formatted == true ? generateRupiah($jumlah_potensi) : $jumlah_potensi;
    }

    public function getPotensiKamar($jenis_kamar, $hotel = null, $formatted = true, $input = null)
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

            $tingkat_hunian_penuh = $bobot_fjh_penuh * ($jenis_kamar['hotel_jenis_kamar_avg_penuh'] ?? 0);
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * ($jenis_kamar['hotel_jenis_kamar_avg_akhir_pekan'] ?? 0);
            $tingkat_hunian_normal = $bobot_fjh_normal * ($jenis_kamar['hotel_jenis_kamar_avg_normal'] ?? 0);
            $tingkat_hunian_sepi = $bobot_fjh_sepi * ($jenis_kamar['hotel_jenis_kamar_avg_sepi'] ?? 0);

            $tarif = $jenis_kamar['hotel_jenis_kamar_tarif'] ?? 0;
            $persentase = $input['hotel']['hotel_persentase_pajak'] ?? 10;
        } else {
            if (empty($hotel)) {
                $hotel = Hotel::find($jenis_kamar->hotel_id);
            }

            $jumlah_fjh = $hotel->tingkat_hunian->kunjungan_penuh +
                $hotel->tingkat_hunian->kunjungan_akhir_pekan +
                $hotel->tingkat_hunian->kunjungan_normal +
                $hotel->tingkat_hunian->kunjungan_sepi;

            $bobot_fjh_penuh = $hotel->tingkat_hunian->kunjungan_penuh / $jumlah_fjh;
            $bobot_fjh_akhir_pekan = $hotel->tingkat_hunian->kunjungan_akhir_pekan / $jumlah_fjh;
            $bobot_fjh_normal = $hotel->tingkat_hunian->kunjungan_normal / $jumlah_fjh;
            $bobot_fjh_sepi = $hotel->tingkat_hunian->kunjungan_sepi / $jumlah_fjh;

            $tingkat_hunian_penuh = $bobot_fjh_penuh * $jenis_kamar->hotel_jenis_kamar_avg_penuh;
            $tingkat_hunian_akhir_pekan = $bobot_fjh_akhir_pekan * $jenis_kamar->hotel_jenis_kamar_avg_akhir_pekan;
            $tingkat_hunian_normal = $bobot_fjh_normal * $jenis_kamar->hotel_jenis_kamar_avg_normal;
            $tingkat_hunian_sepi = $bobot_fjh_sepi * $jenis_kamar->hotel_jenis_kamar_avg_sepi;

            $tarif = $jenis_kamar->hotel_jenis_kamar_tarif;
            $persentase = $hotel->hotel_persentase_pajak ?? 10;
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
