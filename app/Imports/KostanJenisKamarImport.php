<?php

namespace App\Imports;

use App\Models\KostanJenisKamar;
use App\Models\KostanKlasifikasi;
use App\Models\Kelurahan;
use App\Models\Kostan;
use App\Services\KostanService;
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

class KostanJenisKamarImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $kostans;
    public $rowNum = 0;

    public function __construct()
    {
        $this->kostans = Kostan::get(['kostan_npwpd'])->pluck('kostan_npwpd')->toArray();
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

        if ($this->checkEmpty(@$row['kostan_npwpd'])
            && $this->checkEmpty(@$row['kostan_jenis_kamar_deskripsi'])) {
            return null;
        }

        // Check if not found
        if (!in_array($this->ignoreStripe(@$row['kostan_npwpd'], false), $this->kostans)) {
            $error = ['kostan_npwpd' => 'Kostan dengan NPWPD : '.$row['kostan_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'kostan_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        // Select Kostan
        $kostan = Kostan::where('kostan_npwpd', $this->ignoreStripe(@$row['kostan_npwpd'], false));
        $kostanCollection = $kostan->first();

        if (empty($kostanCollection)) {
            $error = ['kostan_npwpd' => 'Kostan dengan NPWPD : '.$row['kostan_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'kostan_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        //Create or update jenis kamar
        $row['jenis_kamar'] = [
            'kostan_id' => $kostanCollection->id,
            'kostan_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['kostan_jenis_kamar_deskripsi']),
            'kostan_jenis_kamar_jumlah' => $this->formatNumber(@$row['kostan_jenis_kamar_jumlah']),
            'kostan_jenis_kamar_tarif' => $this->formatNumber(@$row['kostan_jenis_kamar_tarif']),
            'kostan_jenis_kamar_hunian_avg' => $this->formatNumber(@$row['kostan_jenis_kamar_hunian_avg']),
        ];

        $row['jenis_kamar']['kostan_jenis_kamar_potensi_pajak'] = (new KostanService())->getPotensiKamar($row['jenis_kamar']);

        KostanJenisKamar::updateOrCreate([
            'kostan_id' => $kostanCollection->id,
            'kostan_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['kostan_jenis_kamar_deskripsi'])
        ], $row['jenis_kamar']);

        $kostanCollection = $kostan->with('jenis_kamar')->first();
        $kostan->update([
            'kostan_potensi_pajak' => (new KostanService())->getPotensiKostan($kostanCollection->toArray())
        ]);
    }

    public function rules(): array
    {
        return [
            '*.kostan_jenis_kamar_jumlah' => 'nullable|numeric',
            '*.kostan_jenis_kamar_tarif' => 'nullable|numeric',
            '*.kostan_jenis_kamar_hunian_avg' => 'nullable|numeric',
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
