<?php

namespace App\Imports;

use App\Models\RusunJenisKamar;
use App\Models\RusunKlasifikasi;
use App\Models\Kelurahan;
use App\Models\Rusun;
use App\Services\RusunService;
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

class RusunJenisKamarImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $rusuns;
    public $rowNum = 0;

    public function __construct()
    {
        $this->rusuns = Rusun::get(['rusun_npwpd'])->pluck('rusun_npwpd')->toArray();
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

        if ($this->checkEmpty(@$row['rusun_npwpd'])
            && $this->checkEmpty(@$row['rusun_jenis_kamar_deskripsi'])) {
            return null;
        }

        // Check if not found
        if (!in_array($this->ignoreStripe(@$row['rusun_npwpd'], false), $this->rusuns)) {
            $error = ['rusun_npwpd' => 'Rusun dengan NPWPD : '.$row['rusun_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'rusun_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        // Select Rusun
        $rusun = Rusun::where('rusun_npwpd', $this->ignoreStripe(@$row['rusun_npwpd'], false));
        $rusunCollection = $rusun->first();

        if (empty($rusunCollection)) {
            $error = ['rusun_npwpd' => 'Rusun dengan NPWPD : '.$row['rusun_npwpd'].' tidak ditemukan'];
            $failures[] = new Failure($this->rowNum, 'rusun_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        }

        //Create or update jenis kamar
        $row['jenis_kamar'] = [
            'rusun_id' => $rusunCollection->id,
            'rusun_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['rusun_jenis_kamar_deskripsi']),
            'rusun_jenis_kamar_jumlah' => $this->formatNumber(@$row['rusun_jenis_kamar_jumlah']),
            'rusun_jenis_kamar_tarif' => $this->formatNumber(@$row['rusun_jenis_kamar_tarif']),
            'rusun_jenis_kamar_hunian_avg' => $this->formatNumber(@$row['rusun_jenis_kamar_hunian_avg']),
        ];

        $row['jenis_kamar']['rusun_jenis_kamar_potensi_pajak'] = (new RusunService())->getPotensiKamar($row['jenis_kamar']);

        RusunJenisKamar::updateOrCreate([
            'rusun_id' => $rusunCollection->id,
            'rusun_jenis_kamar_deskripsi' => $this->ignoreStripe(@$row['rusun_jenis_kamar_deskripsi'])
        ], $row['jenis_kamar']);

        $rusunCollection = $rusun->with('jenis_kamar')->first();
        $rusun->update([
            'rusun_potensi_pajak' => (new RusunService())->getPotensiRusun($rusunCollection->toArray())
        ]);
    }

    public function rules(): array
    {
        return [
            '*.rusun_jenis_kamar_jumlah' => 'nullable|numeric',
            '*.rusun_jenis_kamar_tarif' => 'nullable|numeric',
            '*.rusun_jenis_kamar_hunian_avg' => 'nullable|numeric',
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
