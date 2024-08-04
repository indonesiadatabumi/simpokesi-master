<?php

namespace App\Imports;

use App\Models\HotelJenisKamar;
use App\Models\HotelKlasifikasi;
use App\Models\Kelurahan;
use App\Models\Hotel;
use App\Services\HotelService;
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

class HotelJenisKamarImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $hotels;
    public $rowNum = 0;

    public function __construct()
    {
        $this->hotels = Hotel::get(['hotel_npwpd'])->pluck('hotel_npwpd')->toArray();
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

        if ($this->checkEmpty(@$row['hotel_npwpd'])
            && $this->checkEmpty(@$row['hotel_jenis_kamar_deskripsi'])) {
            return null;
        }

        // Check if not found
        if (!in_array($this->ignoreStripe(@$row['hotel_npwpd'], false), $this->hotels)) {
            $error = ['hotel_npwpd' => 'Hotel dengan NPWPD : '.$row['hotel_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'hotel_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        // Select Hotel
        $hotel = Hotel::where('hotel_npwpd', $this->ignoreStripe(@$row['hotel_npwpd'], false));
        $hotelCollection = $hotel->with('tingkat_hunian')->first();

        if (empty($hotelCollection)) {
            $error = ['hotel_npwpd' => 'Hotel dengan NPWPD : '.$row['hotel_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'hotel_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        //Create or update jenis kamar
        $row['jenis_kamar'] = [
            'hotel_id' => $hotelCollection->id,
            'hotel_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['hotel_jenis_kamar_deskripsi']),
            'hotel_jenis_kamar_jumlah' => $this->formatNumber(@$row['hotel_jenis_kamar_jumlah']),
            'hotel_jenis_kamar_tarif' => $this->formatNumber(@$row['hotel_jenis_kamar_tarif']),
            'hotel_jenis_kamar_avg_penuh' => $this->formatNumber(@$row['hotel_jenis_kamar_avg_penuh']),
            'hotel_jenis_kamar_avg_akhir_pekan' => $this->formatNumber(@$row['hotel_jenis_kamar_avg_akhir_pekan']),
            'hotel_jenis_kamar_avg_normal' => $this->formatNumber(@$row['hotel_jenis_kamar_avg_normal']),
            'hotel_jenis_kamar_avg_sepi' => $this->formatNumber(@$row['hotel_jenis_kamar_avg_sepi'])
        ];

        $row['jenis_kamar']['hotel_jenis_kamar_potensi_pajak'] = (new HotelService())->getPotensiKamar($row['jenis_kamar'], null, false, $hotelCollection->toArray());

        HotelJenisKamar::updateOrCreate([
            'hotel_id' => $hotelCollection->id,
            'hotel_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['hotel_jenis_kamar_deskripsi'])
        ], $row['jenis_kamar']);

        $hotelCollection = $hotel->with(['tingkat_hunian', 'jenis_kamar'])->first();
        $hotel->update([
            'hotel_potensi_pajak' => (new HotelService())->getPotensiHotel($hotelCollection->toArray(), false, true)
        ]);
    }

    public function rules(): array
    {
        return [
            '*.hotel_jenis_kamar_jumlah' => 'nullable|numeric',
            '*.hotel_jenis_kamar_tarif' => 'nullable|numeric',
            '*.hotel_jenis_kamar_avg_penuh' => 'nullable|numeric',
            '*.hotel_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            '*.hotel_jenis_kamar_avg_normal' => 'nullable|numeric',
            '*.hotel_jenis_kamar_avg_sepi' => 'nullable|numeric',
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
