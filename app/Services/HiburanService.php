<?php

namespace App\Services;

use App\Imports\HiburanImport;
use App\Imports\HiburanJenisRuanganImport;
use App\Models\HiburanJenisRuangan;
use App\Models\HiburanJenis;
use App\Models\HiburanKategori;
use App\Models\HiburanTarif;
use App\Models\HiburanTarifValue;
use App\Models\HiburanKunjunganValue;
use App\Models\HiburanTingkatKunjunganAvg;
use App\Models\Kelurahan;
use App\Models\Hiburan;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class HiburanService
{
    private $jenis_hiburan;

    public function getHiburanList()
    {
        return DB::table('hiburans')->select([
            DB::raw('*'),
            DB::raw('hiburans.id as id'),
            DB::raw('hiburans.created_at as created_at'),
            DB::raw('hiburans.updated_at as updated_at'),
        ])->whereNull('hiburans.deleted_at')
            ->leftJoin('hiburan_kategoris', 'hiburan_kategoris.id', 'hiburans.hiburan_kategori_id');
    }

    public function store(Request $request)
    {
        $input = $request->all();

        // get jenis hiburan
        $jenisHiburan = $this->checkHiburanExist($request);
        $this->jenis_hiburan = $jenisHiburan;

        // Create kategori if not exist
        if (@$input['hiburan']['hiburan_kategori_id']) {
            $kategori = HiburanKategori::find($input['hiburan']['hiburan_kategori_id']);
            if (empty($kategori)) {
                $kategori = HiburanKategori::create([
                    'hiburan_jenis_id' => $input['hiburan']['hiburan_jenis_id'],
                    'hiburan_kategori_deskripsi' => toUpper($input['hiburan']['hiburan_kategori_id'])
                ]);
                $input['hiburan']['hiburan_kategori_id'] = $kategori->id;
            }
        }

        // Create Hiburan
        $input['hiburan']['hiburan_alamat'] = toUpper($input['hiburan']['hiburan_alamat']);
        $input['hiburan']['hiburan_kelurahan'] = toUpper(@$input['hiburan']['hiburan_kelurahan']);
        $input['hiburan']['hiburan_kecamatan'] = Kelurahan::where('kelurahan', $input['hiburan']['hiburan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['hiburan']['created_by'] = auth()->user()->id;
        $input['hiburan']['status_aktif_id'] = @$input['hiburan']['status_aktif_id'] ? $input['hiburan']['status_aktif_id'] : 4;
        $input['hiburan']['hiburan_potensi_pajak'] = $jenisHiburan->hiburan_jenis_have_ruangan ? 
            $this->getPotensiHiburanHaveRuangan($input, false, true) : 
            $this->getPotensiHiburanHaventRuangan($input);

        // Set temp file
        if (@$input['hiburan']['hiburan_foto']) {
            $tempFile = $input['hiburan']['hiburan_foto'];
            unset($input['hiburan']['hiburan_foto']);
        }

        $hiburan = Hiburan::create($input['hiburan']);
        $this->jenis_hiburan = $hiburan->jenis;

        // Upload File
        if (@$tempFile) {
            $no = $this->getNomorUrut($hiburan->id);
            $year = date('Y', strtotime($hiburan->created_at));
            $date = date('mdY');
            $slug = strtoupper($jenisHiburan->hiburan_jenis_slug);

            $imageName = $year.'_'.$slug.'_' . $no . $date . '.' . $tempFile->getClientOriginalExtension();
            $tempFile->storeAs('hiburan', $imageName, 'public_uploads');
            $input['hiburan']['hiburan_foto'] = $imageName;

            $hiburan->update(['hiburan_foto' => $input['hiburan']['hiburan_foto']]);
        }

        // Create tingkat kunjungan
        if (@$input['tingkat_kunjungan']) {
            $input['tingkat_kunjungan']['hiburan_id'] = $hiburan->id;
            HiburanTingkatKunjunganAvg::create($input['tingkat_kunjungan']);
        }

        // Create jenis ruangan
        if ($jenisHiburan->hiburan_jenis_have_ruangan) {
            foreach ($input['jenis_ruangan'] as $key => $row) {
                $input['jenis_ruangan'][$key]['hiburan_jenis_ruangan_potensi_pajak'] = $this->getPotensiRuangan($row, null, false, $input);
                $input['jenis_ruangan'][$key]['hiburan_id'] = $hiburan->id;
            }

            HiburanJenisRuangan::insert($input['jenis_ruangan']);
        }

        // update or create multiple tarif
        if ($jenisHiburan->hiburan_jenis_have_multiple_tarif) {
            foreach ($input['hiburan_tarif_value'] as $key => $row) {
                $input['hiburan_tarif_value'][$key]['hiburan_id'] = $hiburan->id;
            }

            HiburanTarifValue::upsert($input['hiburan_tarif_value'], ['hiburan_id', 'hiburan_tarif_id'], ['hiburan_tarif_value']);
        }

        // update or create multiple kunjungan
        if ($jenisHiburan->hiburan_jenis_have_multiple_kunjungan) {
            foreach ($input['hiburan_kunjungan_value'] as $key => $row) {
                $input['hiburan_kunjungan_value'][$key]['hiburan_id'] = $hiburan->id;
            }

            HiburanKunjunganValue::upsert($input['hiburan_kunjungan_value'], ['hiburan_id', 'hiburan_kunjungan_id'], ['hiburan_kunjungan_weekends_value', 'hiburan_kunjungan_weekdays_value']);
        }
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        // get jenis hiburan
        $jenisHiburan = $this->checkHiburanExist($request);
        $this->jenis_hiburan = $jenisHiburan;

        // Create kategori if not exist
        if (@$input['hiburan']['hiburan_kategori_id']) {
            $kategori = HiburanKategori::find($input['hiburan']['hiburan_kategori_id']);
            if (empty($kategori)) {
                $kategori = HiburanKategori::create([
                    'hiburan_jenis_id' => $input['hiburan']['hiburan_jenis_id'],
                    'hiburan_kategori_deskripsi' => toUpper($input['hiburan']['hiburan_kategori_id'])
                ]);
                $input['hiburan']['hiburan_kategori_id'] = $kategori->id;
            }
        }

        // Find Hiburan
        $hiburan = Hiburan::findOrFail($id);

        // Update Hiburan
        $input['hiburan']['hiburan_alamat'] = toUpper($input['hiburan']['hiburan_alamat']);
        $input['hiburan']['hiburan_kelurahan'] = toUpper(@$input['hiburan']['hiburan_kelurahan']);
        $input['hiburan']['hiburan_kecamatan'] = Kelurahan::where('kelurahan', $input['hiburan']['hiburan_kelurahan'])->first()->kecamatan->kecamatan;
        $input['hiburan']['updated_at'] = Carbon::now();
        $input['hiburan']['hiburan_potensi_pajak'] = $jenisHiburan->hiburan_jenis_have_ruangan ? 
            $this->getPotensiHiburanHaveRuangan($input, false, true) : 
            $this->getPotensiHiburanHaventRuangan($input);

        // Upload File
        if (@$input['hiburan']['hiburan_foto']) {
            Storage::disk('public_uploads')->delete('hiburan/' . $hiburan->hiburan_foto);

            $no = $this->getNomorUrut($hiburan->id);
            $year = date('Y', strtotime($hiburan->created_at));
            $date = date('mdY');
            $slug = strtoupper($jenisHiburan->hiburan_jenis_slug);

            $imageName = $year.'_'.$slug.'_' . $no . $date . '.' . $input['hiburan']['hiburan_foto']->getClientOriginalExtension();
            $input['hiburan']['hiburan_foto']->storeAs('hiburan', $imageName, 'public_uploads');
            $input['hiburan']['hiburan_foto'] = $imageName;
        }

        $hiburan->update($input['hiburan']);

        // Create or Update tingkat kunjungan
        if (@$input['tingkat_kunjungan']) {
            $hiburan->tingkat_kunjungan()->updateOrCreate(['id' => @$hiburan->tingkat_kunjungan->id], $input['tingkat_kunjungan']);
        }

        // If have jenis ruangan
        if ($jenisHiburan->hiburan_jenis_have_ruangan) {
            // Create or Update jenis ruangan
            foreach ($input['jenis_ruangan'] as $key => $row) {
                $input['jenis_ruangan'][$key]['hiburan_id'] = $id;
                $input['jenis_ruangan'][$key]['hiburan_jenis_ruangan_potensi_pajak'] = $this->getPotensiRuangan($row, null, false, $input);
                $input['jenis_ruangan'][$key]['id'] = @$input['jenis_ruangan'][$key]['id'] ?? null;
            }

            HiburanJenisRuangan::upsert($input['jenis_ruangan'], ['id']);

            // Delete jenis ruangan
            $deletedIpr = HiburanJenisRuangan::whereIn('id', explode(';', $input['deleted_jenis_ruangan']));
            if ($deletedIpr->count() > 0) {
                $deletedIpr->delete();
            }
        }

        // update or create multiple tarif
        if ($jenisHiburan->hiburan_jenis_have_multiple_tarif) {
            foreach ($input['hiburan_tarif_value'] as $key => $row) {
                $input['hiburan_tarif_value'][$key]['hiburan_id'] = $hiburan->id;
            }

            HiburanTarifValue::upsert($input['hiburan_tarif_value'], ['hiburan_id', 'hiburan_tarif_id'], ['hiburan_tarif_value']);
        }

        // update or create multiple kunjungan
        if ($jenisHiburan->hiburan_jenis_have_multiple_kunjungan) {
            foreach ($input['hiburan_kunjungan_value'] as $key => $row) {
                $input['hiburan_kunjungan_value'][$key]['hiburan_id'] = $hiburan->id;
            }

            HiburanKunjunganValue::upsert($input['hiburan_kunjungan_value'], ['hiburan_id', 'hiburan_kunjungan_id'], ['hiburan_kunjungan_weekends_value', 'hiburan_kunjungan_weekdays_value']);
        }
    }

    public function destroy($id)
    {
        $hiburan = Hiburan::findOrFail($id);
        $jenisHiburanId = @$hiburan->hiburan_jenis_id;

        $hiburan->delete();

        return $jenisHiburanId;
    }

    public function settingPersentase(Request $request)
    {
        $input = $request->all();

        foreach ($input['hiburan'] as $hiburanId => $persentase) {
            $hiburan = HiburanJenis::findOrFail($hiburanId);
            $hiburan->update([
                'hiburan_jenis_persentase' => $persentase['hiburan_jenis_persentase']
            ]);
        }

        foreach ($input['kategori'] as $kategoriId => $persentase) {
            $hiburan = HiburanKategori::findOrFail($kategoriId);
            $hiburan->update([
                'hiburan_kategori_persentase' => $persentase['hiburan_kategori_persentase']
            ]);
        }
    }

    public function import(Request $request)
    {
        $input = $request->all();
        $file = request()->file('file');

        if ($input['import_tipe'] === 'Hiburan') {
            $import = new HiburanImport();
        } else {
            $import = new HiburanJenisRuanganImport();
        }

        $import->import($file);

        return $import;
    }

    public function print(Request $request) {
        $hiburan = new Hiburan();

        if (@$request->tahun && ($request->tahun != '')) {
            $hiburan = $hiburan->whereYear('created_at', $request->tahun);
        }

        if (@$request->hiburan_jenis_id && ($request->hiburan_jenis_id != '')) {
            $hiburan = $hiburan->where('hiburan_jenis_id', $request->hiburan_jenis_id);
        }

        if(@$request->kecamatan && @$request->kecamatan != ''){
            $hiburan = $hiburan->where(DB::raw('LOWER(hiburan_kecamatan)'), strtolower($request->kecamatan));
        }
        
        if(@$request->status_aktif_id && @$request->status_aktif_id != ''){
            $hiburan = $hiburan->where('status_aktif_id', $request->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $hiburan = $hiburan->where(DB::raw('LOWER(hiburan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        return $hiburan->get();
    }

    public function ignoreStripe($str)
    {
        return $str != '-' ? $str : null;
    }

    public function getPotensiHiburanHaventRuangan($input)
    {
        $sk_weekdays = $input['tingkat_kunjungan']['situasi_kunjungan_weekdays'] ?? 0;
        $sk_weekends = $input['tingkat_kunjungan']['situasi_kunjungan_weekends'] ?? 0;

        // Check if jenis hiburan have multiple kunjungan
        if ($this->jenis_hiburan->hiburan_jenis_have_multiple_kunjungan) {
            $tk_weekdays = 0;
            $tk_weekends = 0;
            foreach ($input['hiburan_kunjungan_value'] as $key => $row) {
                $tk_weekdays += (@$row['hiburan_kunjungan_weekdays_value'] * 1 ?? 0);
                $tk_weekends += (@$row['hiburan_kunjungan_weekends_value'] * 1 ?? 0);
            }
        } else {    
            $tk_weekdays = $input['tingkat_kunjungan']['tingkat_kunjungan_weekdays'] ?? 0;
            $tk_weekends = $input['tingkat_kunjungan']['tingkat_kunjungan_weekends'] ?? 0;
        }

        // Check if jenis hiburan have duration
        $durasi = 1;
        if ($this->jenis_hiburan->hiburan_jenis_durasi_label && @$input['hiburan']['hiburan_durasi']) {
            $durasi = $input['hiburan']['hiburan_durasi'];
        }

        $persentase = $input['hiburan']['hiburan_persentase_pajak'] ?? 10;
        $jumlah = @$input['hiburan']['hiburan_jumlah'] ?? 1;

        // Check if jenis hiburan have multiple tarif
        // If jenis hiburan multiple tarif not weekends & weekdays
        if ($this->jenis_hiburan->hiburan_jenis_have_multiple_tarif && ($this->jenis_hiburan->tarif->whereNotNull('hiburan_tarif_type')->count() == 0)) {
            // Check if jenis hiburan have multiple kunjungan
            if ($this->jenis_hiburan->hiburan_jenis_have_multiple_kunjungan) {
                $hiburan_kunjungans = collect($input['hiburan_kunjungan_value']);
            }

            $potensi = 0;
            foreach ($input['hiburan_tarif_value'] as $key => $row) {
                $tarif = (@$row['hiburan_tarif_value'] * 1 ?? 0);
                // Check if jenis hiburan have multiple kunjungan
                if ($this->jenis_hiburan->hiburan_jenis_have_multiple_kunjungan) {
                    $tk_weekdays = @$hiburan_kunjungans->where('hiburan_kunjungan_id', @$row['hiburan_tarif_id'])->first()['hiburan_kunjungan_weekdays_value'] ?? 0;
                    $tk_weekends = @$hiburan_kunjungans->where('hiburan_kunjungan_id', @$row['hiburan_tarif_id'])->first()['hiburan_kunjungan_weekends_value'] ?? 0;
                }
                
                $potensi_weekdays = $durasi * $sk_weekdays * $tk_weekdays * $tarif * ($persentase / 100);
                $potensi_weekends = $durasi * $sk_weekends * $tk_weekends * $tarif * ($persentase / 100);
                
                if (@$this->jenis_hiburan->hiburan_jenis_jumlah_label && @$this->jenis_hiburan->hiburan_jenis_jumlah_is_count == 1) {
                    $potensi_weekdays *= $jumlah;
                    $potensi_weekends *= $jumlah;
                }

                $potensi += $potensi_weekdays + $potensi_weekends;
            }
        // If jenis hiburan multiple tarif weekends & weekdays
        } else if ($this->jenis_hiburan->hiburan_jenis_have_multiple_tarif && ($this->jenis_hiburan->tarif->whereNotNull('hiburan_tarif_type')->count() > 0)) {
            $potensi = 0;
            foreach ($input['hiburan_tarif_value'] as $key => $row) {
                $tarif = (@$row['hiburan_tarif_value'] * 1 ?? 0);
                $hiburanTarif = HiburanTarif::findOrFail($row['hiburan_tarif_id']);
                if ($hiburanTarif->hiburan_tarif_type === 'weekends') {
                    $potensi_weekends = $durasi * $sk_weekends * $tk_weekends * $tarif * ($persentase / 100);
                } else {
                    $potensi_weekdays = $durasi * $sk_weekdays * $tk_weekdays * $tarif * ($persentase / 100);
                }
            }

            if (@$this->jenis_hiburan->hiburan_jenis_jumlah_label && @$this->jenis_hiburan->hiburan_jenis_jumlah_is_count == 1) {
                $potensi_weekdays *= $jumlah;
                $potensi_weekends *= $jumlah;
            }

            $potensi = $potensi_weekdays + $potensi_weekends;
        } else {
            $tarif = @$input['hiburan']['hiburan_tarif'] ?? 0;

            $potensi_weekdays = $durasi * $sk_weekdays * $tk_weekdays * $tarif * ($persentase / 100);
            $potensi_weekends = $durasi * $sk_weekends * $tk_weekends * $tarif * ($persentase / 100);
                
            if (@$this->jenis_hiburan->hiburan_jenis_jumlah_label && @$this->jenis_hiburan->hiburan_jenis_jumlah_is_count == 1) {
                $potensi_weekdays *= $jumlah;
                $potensi_weekends *= $jumlah;
            }

            $potensi = $potensi_weekdays + $potensi_weekends;
        }

        return $potensi;
    }

    public function getPotensiHiburanHaveRuangan($hiburan, $formatted = true, $inputMode = false)
    {
        $jumlah_potensi = 0;
        if ($inputMode == true) {
            foreach ($hiburan['jenis_ruangan'] as $jenis_ruangan) {
                $jumlah_potensi += $this->getPotensiRuangan($jenis_ruangan, null, false, $hiburan);
            }
        } else {
            foreach ($hiburan->jenis_ruangan as $jenis_ruangan) {
                $jumlah_potensi += $this->getPotensiRuangan($jenis_ruangan, $hiburan, false);
            }
        }

        return $formatted == true ? generateRupiah($jumlah_potensi) : $jumlah_potensi;
    }

    public function getPotensiRuangan($jenis_ruangan, $hiburan = null, $formatted = true, $input = null)
    {
        if (@$input) {
            $jumlah_fjh_weekends = (@$input['tingkat_kunjungan']['situasi_kunjungan_weekends'] ?? 0);
            $jumlah_fjh_weekdays = (@$input['tingkat_kunjungan']['situasi_kunjungan_weekdays'] ?? 0);

            $tingkat_kunjungan_weekends = @$jenis_ruangan['hiburan_jenis_ruangan_avg_weekends'] ?? 0;
            $tingkat_kunjungan_weekdays = @$jenis_ruangan['hiburan_jenis_ruangan_avg_weekdays'] ?? 0;

            $jumlah = @$input['hiburan']['hiburan_jumlah'] ?? 1;
            $tarif = @$jenis_ruangan['hiburan_jenis_ruangan_tarif'] ?? 0;
            $persentase = @$input['hiburan']['hiburan_persentase_pajak'] ?? 10;
    
            if (@$jenis_ruangan['hiburan_jenis_jumlah_label'] && @$jenis_ruangan['hiburan_jenis_jumlah_is_count'] == 1) {
                $potensi = ($jumlah_fjh_weekends * $tingkat_kunjungan_weekends * $jumlah * $tarif * ($persentase / 100)) + 
                    ($jumlah_fjh_weekdays * $tingkat_kunjungan_weekdays * $jumlah * $tarif * ($persentase / 100));
            } else {
                $potensi = $jumlah_fjh_weekends * $tingkat_kunjungan_weekends * $tarif * ($persentase / 100) + 
                    ($jumlah_fjh_weekdays * $tingkat_kunjungan_weekdays * $tarif * ($persentase / 100));
            }
        } else {
            if (empty($hiburan)) {
                $hiburan = Hiburan::find($jenis_ruangan->hiburan_id);
            }

            $jumlah_fjh_weekends = (@$hiburan->situasi_kunjungan_weekends ?? 0);
            $jumlah_fjh_weekdays = (@$hiburan->situasi_kunjungan_weekdays ?? 0);

            $tingkat_kunjungan_weekends = $jenis_ruangan->hiburan_jenis_ruangan_avg_weekends;
            $tingkat_kunjungan_weekdays = $jenis_ruangan->hiburan_jenis_ruangan_avg_weekdays;

            $jumlah = $hiburan->hiburan_jumlah ?? 1;
            $tarif = $jenis_ruangan->hiburan_jenis_ruangan_tarif;
            $persentase = $hiburan->hiburan_persentase_pajak ?? 10;
    
            if (@$jenis_ruangan->hiburan_jenis_jumlah_label && @$jenis_ruangan->hiburan_jenis_jumlah_is_count == 1) {
                $potensi = ($jumlah_fjh_weekends * $tingkat_kunjungan_weekends * $jumlah * $tarif * ($persentase / 100)) + 
                    ($jumlah_fjh_weekdays * $tingkat_kunjungan_weekdays * $jumlah * $tarif * ($persentase / 100));
            } else {
                $potensi = $jumlah_fjh_weekends * $tingkat_kunjungan_weekends * $tarif * ($persentase / 100) + 
                    ($jumlah_fjh_weekdays * $tingkat_kunjungan_weekdays * $tarif * ($persentase / 100));
            }
        }
        
        return $formatted == true ? generateRupiah($potensi) : $potensi;
    }

    public function getBobotFJH($fjh, $tingkat_kunjungan, $rounded = true) {
        $sumFJH = (@$tingkat_kunjungan->kunjungan_weekends ?? 0) + (@$tingkat_kunjungan->kunjungan_weekdays ?? 0);

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

    public function checkHiburanExist(Request $request)
    {
        $input = $request->all();
        $jenisHiburan = HiburanJenis::all();

        if (empty($input['hiburan']['hiburan_jenis_id'])) {
            return redirect()->back()->with('error', 'Jenis hiburan tidak ditemukan!');
        }

        if ($jenisHiburan->where('id', $input['hiburan']['hiburan_jenis_id'])->count() == 0) {
            return redirect()->back()->with('error', 'Jenis hiburan tidak ditemukan!');
        }

        return $jenisHiburan->find($input['hiburan']['hiburan_jenis_id']);
    }
}
