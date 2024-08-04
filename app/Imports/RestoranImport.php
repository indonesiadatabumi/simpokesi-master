<?php

namespace App\Imports;

use App\Models\RestoranKlasifikasi;
use App\Models\Kelurahan;
use App\Models\Restoran;
use App\Services\RestoranService;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\OnEachRow;
use Maatwebsite\Excel\Concerns\SkipsErrors;
use Maatwebsite\Excel\Concerns\SkipsFailures;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Concerns\WithBatchInserts;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Row;
use Maatwebsite\Excel\Validators\Failure;
use Maatwebsite\Excel\Validators\ValidationException;
use Illuminate\Http\Request;

class RestoranImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $restoran_klasifikasis;
    public $user;
    public $restorans;
    public $kelurahans;
    public $tipe;
    public $rowNum = 0;

    public function __construct(Request $request)
    {
        $this->restoran_klasifikasis = RestoranKlasifikasi::all();
        $this->user = auth()->user();
        $this->restorans = Restoran::get(['restoran_npwpd'])->pluck('restoran_npwpd')->toArray();
        $this->kelurahans = Kelurahan::all();
        $this->tipe = @$request->restoran_tipe;
    }

    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function onRow(Row $row)
    {
        $row = $row->toArray();
        $this->rowNum ++;

        if ($this->checkEmpty(@$row['restoran_pemilik'])
            && $this->checkEmpty(@$row['restoran_nama'])
            && $this->checkEmpty(@$row['restoran_npwpd'])) {
            return null;
        }

        // Check if added
        if (in_array($this->ignoreStripe(@$row['restoran_npwpd'], false), $this->restorans)) {
            $error = ['restoran_npwpd' => 'Restoran NPWPD telah terpakai'];
            $failures[] = new Failure($this->rowNum, 'restoran_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        } else {
            $this->restorans[] = $this->ignoreStripe(@$row['restoran_npwpd'], false);
        }

        // Create Restoran Klasifikasi
        $input_klasifikasi = $this->ignoreStripe(strtolower(@$row['restoran_klasifikasi']));
        $restoran_klasifikasi = $this->restoran_klasifikasis->filter(function ($item) use ($input_klasifikasi) {
            return strtolower($item['restoran_klasifikasi_deskripsi']) == strtolower($input_klasifikasi);
        });

        if (($restoran_klasifikasi->count() > 0)) {
            $row['restoran_klasifikasi'] = $restoran_klasifikasi->first()->id;
        } else {
            $restoran_klasifikasi = RestoranKlasifikasi::create([
                'restoran_klasifikasi_deskripsi' => $this->ignoreStripe(strtoupper($row['restoran_klasifikasi']))
            ]);
            $this->restoran_klasifikasis = RestoranKlasifikasi::all();

            $row['restoran_klasifikasi'] = $restoran_klasifikasi->id;
        }

        // Set Default latitude & longitude if empty
        $latitude = $this->ignoreStripe(@$row['restoran_latitude']);
        $longitude = $this->ignoreStripe(@$row['restoran_longitude']);
        if ((empty($latitude) || $latitude == '') && (empty($longitude) || $longitude == '') && @$row['restoran_kelurahan']) {
            $input_kelurahan = $this->removeKecKel($this->ignoreStripe(@$row['restoran_kelurahan']));
            $kelurahan = $this->kelurahans->filter(function ($item) use ($input_kelurahan) {
                return $item['kelurahan'] == strtoupper($input_kelurahan);
            });

            if ($kelurahan->count() > 0) {
                $row['restoran_latitude'] = $kelurahan->first()->default_latitude;
                $row['restoran_longitude'] = $kelurahan->first()->default_longitude;
            }
        }

        //Create Restoran
        $row['restoran'] = [
            'restoran_tipe' => $this->tipe,
            'restoran_nama' => $this->ignoreStripe(@$row['restoran_nama']),
            'restoran_pemilik' => $this->ignoreStripe(@$row['restoran_pemilik']),
            'restoran_telepon' => $this->ignoreStripe(@$row['restoran_telepon']),
            'restoran_npwpd' => $this->ignoreStripe(@$row['restoran_npwpd']),
            'restoran_klasifikasi_id' => @$row['restoran_klasifikasi'],
            'restoran_alamat' => $this->ignoreStripe(@$row['restoran_alamat']),
            'restoran_kecamatan' => $this->removeKecKel($this->ignoreStripe(@$row['restoran_kecamatan'])),
            'restoran_kelurahan' => $this->removeKecKel($this->ignoreStripe(@$row['restoran_kelurahan'])),
            'restoran_rt' => $this->ignoreStripe(@$row['restoran_rt']),
            'restoran_rw' => $this->ignoreStripe(@$row['restoran_rw']),
            'restoran_jumlah_pegawai' => $this->formatNumber(@$row['restoran_jumlah_pegawai']),
            'restoran_pengeluaran_avg' => $this->formatNumber(@$row['restoran_pengeluaran_avg']),
            'restoran_kapasitas_kursi' => $this->formatNumber(@$row['restoran_kapasitas_kursi']),
            'restoran_status_tapping_box' => $this->formatNumber(@$row['restoran_status_tapping_box']),
            'restoran_persentase_pajak' => $this->formatNumber(@$row['restoran_persentase_pajak']),
            'status_aktif_id' => $this->user->role_id == 1 ? 1 : 4,
            'restoran_is_cwp' => false,
            'restoran_foto' => @$row['restoran_foto'],
            'restoran_latitude' => $this->ignoreStripe(@$row['restoran_latitude']),
            'restoran_longitude' => $this->ignoreStripe(@$row['restoran_longitude']),
            'created_by' => $this->user->id,
        ];

        // Create FJH
        $row['tingkat_kunjungan'] = [
            'situasi_kunjungan_ramai' => $this->formatNumber(@$row['situasi_kunjungan_ramai']),
            'situasi_kunjungan_normal' => $this->formatNumber(@$row['situasi_kunjungan_normal']),
            'situasi_kunjungan_sepi' => $this->formatNumber(@$row['situasi_kunjungan_sepi']),
            'avg_kunjungan_ramai' => $this->formatNumber(@$row['avg_kunjungan_ramai']),
            'avg_kunjungan_normal' => $this->formatNumber(@$row['avg_kunjungan_normal']),
            'avg_kunjungan_sepi' => $this->formatNumber(@$row['avg_kunjungan_sepi']),
        ];

        // Set Potensi Pajak
        $row['restoran']['restoran_potensi_pajak'] = (new RestoranService())->getPotensiRestoran($row);

        $restoran = Restoran::create($row['restoran']);

        // Set Restoran Id
        $row['tingkat_kunjungan']['restoran_id'] = $restoran->id;

        $restoran->tingkat_kunjungan()->create($row['tingkat_kunjungan']);
    }

    public function rules(): array
    {
        return [
            '*.restoran_jumlah_pegawai' => 'nullable|numeric',
            '*.restoran_pengeluaran_avg' => 'nullable|numeric',
            '*.restoran_kapasitas_kursi' => 'nullable|numeric',
            '*.restoran_status_tapping_box' => 'nullable|numeric',
            '*.restoran_persentase_pajak' => 'nullable|numeric',
            '*.situasi_kunjungan_ramai' => 'nullable|numeric',
            '*.situasi_kunjungan_normal' => 'nullable|numeric',
            '*.situasi_kunjungan_sepi' => 'nullable|numeric',
            '*.avg_kunjungan_ramai' => 'nullable|numeric',
            '*.avg_kunjungan_normal' => 'nullable|numeric',
            '*.avg_kunjungan_sepi' => 'nullable|numeric',
        ];
    }

    public function onError(\Throwable $error)
    {

    }

    public function batchSize(): int
    {
        return 1000;
    }

    public function chunkSize(): int
    {
        return 1000;
    }

    public function headingRow(): int
    {
        return 3;
    }

    public function ignoreStripe($str, $upper = true)
    {
        $str = trim($str);

        if ($str == '-' || $str == '-;-' || $str == '') {
            $str = null;
        } else {
            if ($upper === true) {
                $str = strtoupper($str);
            }
        }

        return $str;
    }

    public function formatNumber($str)
    {
        $str = @$this->ignoreStripe($str) ?? '0';
        return str_replace(',', '.', $str);
    }

    public function checkEmpty($str)
    {
        $str = trim($str);
        return empty($str) || $str == '';
    }

    public function removeKecKel($str)
    {
        if (!empty($str)) {
            $str = str_replace('KEC.', '', $str);
            $str = str_replace('KEL.', '', $str);
            $str = trim($str);
        } else {
            return $str;
        }

        return $str;
    }
}
