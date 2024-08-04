<?php

namespace App\Imports;

use App\Models\HotelKlasifikasi;
use App\Models\Kelurahan;
use App\Models\Hotel;
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

class HotelImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $hotel_klasifikasis;
    public $user;
    public $hotels;
    public $kelurahans;
    public $rowNum = 0;

    public function __construct()
    {
        $this->hotel_klasifikasis = HotelKlasifikasi::all();
        $this->user = auth()->user();
        $this->hotels = Hotel::get(['hotel_npwpd'])->pluck('hotel_npwpd')->toArray();
        $this->kelurahans = Kelurahan::all();
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

        if ($this->checkEmpty(@$row['hotel_pemilik'])
            && $this->checkEmpty(@$row['hotel_nama'])
            && $this->checkEmpty(@$row['hotel_npwpd'])) {
            return null;
        }

        // Check if added
        if (in_array($this->ignoreStripe(@$row['hotel_npwpd'], false), $this->hotels)) {
            $error = ['hotel_npwpd' => 'Hotel NPWPD telah terpakai'];
            $failures[] = new Failure($this->rowNum, 'hotel_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        } else {
            $this->hotels[] = $this->ignoreStripe(@$row['hotel_npwpd'], false);
        }

        // Create Hotel Klasifikasi
        $input_klasifikasi = $this->ignoreStripe(strtolower(@$row['hotel_klasifikasi']));
        $hotel_klasifikasi = $this->hotel_klasifikasis->filter(function ($item) use ($input_klasifikasi) {
            return strtolower($item['hotel_klasifikasi_deskripsi']) == strtolower($input_klasifikasi);
        });

        if (($hotel_klasifikasi->count() > 0)) {
            $row['hotel_klasifikasi'] = $hotel_klasifikasi->first()->id;
        } else {
            $hotel_klasifikasi = HotelKlasifikasi::create([
                'hotel_klasifikasi_deskripsi' => $this->ignoreStripe(strtoupper($row['hotel_klasifikasi']))
            ]);
            $this->hotel_klasifikasis = HotelKlasifikasi::all();

            $row['hotel_klasifikasi'] = $hotel_klasifikasi->id;
        }

        // Set Default latitude & longitude if empty
        $latitude = $this->ignoreStripe(@$row['hotel_latitude']);
        $longitude = $this->ignoreStripe(@$row['hotel_longitude']);
        if ((empty($latitude) || $latitude == '') && (empty($longitude) || $longitude == '') && @$row['hotel_kelurahan']) {
            $input_kelurahan = $this->removeKecKel($this->ignoreStripe(@$row['hotel_kelurahan']));
            $kelurahan = $this->kelurahans->filter(function ($item) use ($input_kelurahan) {
                return $item['kelurahan'] == strtoupper($input_kelurahan);
            });

            if ($kelurahan->count() > 0) {
                $row['hotel_latitude'] = $kelurahan->first()->default_latitude;
                $row['hotel_longitude'] = $kelurahan->first()->default_longitude;
            }
        }

        //Create Hotel
        $row['hotel'] = [
            'hotel_nama' => $this->ignoreStripe(@$row['hotel_nama']),
            'hotel_pemilik' => $this->ignoreStripe(@$row['hotel_pemilik']),
            'hotel_telepon' => $this->ignoreStripe(@$row['hotel_telepon']),
            'hotel_npwpd' => $this->ignoreStripe(@$row['hotel_npwpd']),
            'hotel_klasifikasi_id' => @$row['hotel_klasifikasi'],
            'hotel_alamat' => $this->ignoreStripe(@$row['hotel_alamat']),
            'hotel_kecamatan' => $this->removeKecKel($this->ignoreStripe(@$row['hotel_kecamatan'])),
            'hotel_kelurahan' => $this->removeKecKel($this->ignoreStripe(@$row['hotel_kelurahan'])),
            'hotel_rt' => $this->ignoreStripe(@$row['hotel_rt']),
            'hotel_rw' => $this->ignoreStripe(@$row['hotel_rw']),
            'hotel_jumlah_pegawai' => $this->formatNumber(@$row['hotel_jumlah_pegawai']),
            'hotel_status_tapping_box' => $this->formatNumber(@$row['hotel_status_tapping_box']),
            'hotel_persentase_pajak' => $this->formatNumber(@$row['hotel_persentase_pajak']),
            'status_aktif_id' => $this->user->role_id == 1 ? 1 : 4,
            'hotel_foto' => @$row['hotel_foto'],
            'hotel_latitude' => $this->ignoreStripe(@$row['hotel_latitude']),
            'hotel_longitude' => $this->ignoreStripe(@$row['hotel_longitude']),
            'created_by' => $this->user->id,
        ];
        $hotel = Hotel::create($row['hotel']);

        // Create FJH
        $row['tingkat_hunian'] = [
            'kunjungan_penuh' => $this->formatNumber(@$row['kunjungan_penuh']),
            'kunjungan_akhir_pekan' => $this->formatNumber(@$row['kunjungan_akhir_pekan']),
            'kunjungan_normal' => $this->formatNumber(@$row['kunjungan_normal']),
            'kunjungan_sepi' => $this->formatNumber(@$row['kunjungan_sepi']),
            'hotel_id' => $hotel->id,
        ];
        $hotel->tingkat_hunian()->create($row['tingkat_hunian']);
    }

    public function rules(): array
    {
        return [
            '*.hotel_jumlah_pegawai' => 'nullable|numeric',
            '*.hotel_status_tapping_box' => 'nullable|numeric',
            '*.hotel_persentase_pajak' => 'nullable|numeric',
            '*.kunjungan_penuh' => 'nullable|numeric',
            '*.kunjungan_akhir_pekan' => 'nullable|numeric',
            '*.kunjungan_normal' => 'nullable|numeric',
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
