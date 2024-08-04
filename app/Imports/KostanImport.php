<?php

namespace App\Imports;

use App\Models\Kelurahan;
use App\Models\Kostan;
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

class KostanImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $user;
    public $kostans;
    public $kelurahans;
    public $rowNum = 0;

    public function __construct()
    {
        $this->user = auth()->user();
        $this->kostans = Kostan::get(['kostan_npwpd'])->pluck('kostan_npwpd')->toArray();
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

        if ($this->checkEmpty(@$row['kostan_pemilik'])
            && $this->checkEmpty(@$row['kostan_nama'])
            && $this->checkEmpty(@$row['kostan_npwpd'])) {
            return null;
        }

        // Check if added
        if (in_array($this->ignoreStripe(@$row['kostan_npwpd'], false), $this->kostans)) {
            $error = ['kostan_npwpd' => 'Kostan NPWPD telah terpakai'];
            $failures[] = new Failure($this->rowNum, 'kostan_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        } else {
            $this->kostans[] = $this->ignoreStripe(@$row['kostan_npwpd'], false);
        }

        // Set Default latitude & longitude if empty
        $latitude = $this->ignoreStripe(@$row['kostan_latitude']);
        $longitude = $this->ignoreStripe(@$row['kostan_longitude']);
        if ((empty($latitude) || $latitude == '') && (empty($longitude) || $longitude == '') && @$row['kostan_kelurahan']) {
            $input_kelurahan = $this->removeKecKel($this->ignoreStripe(@$row['kostan_kelurahan']));
            $kelurahan = $this->kelurahans->filter(function ($item) use ($input_kelurahan) {
                return $item['kelurahan'] == strtoupper($input_kelurahan);
            });

            if ($kelurahan->count() > 0) {
                $row['kostan_latitude'] = $kelurahan->first()->default_latitude;
                $row['kostan_longitude'] = $kelurahan->first()->default_longitude;
            }
        }

        //Create Kostan
        $row['kostan'] = [
            'kostan_nama' => $this->ignoreStripe(@$row['kostan_nama']),
            'kostan_pemilik' => $this->ignoreStripe(@$row['kostan_pemilik']),
            'kostan_telepon' => $this->ignoreStripe(@$row['kostan_telepon']),
            'kostan_npwpd' => $this->ignoreStripe(@$row['kostan_npwpd']),
            'kostan_alamat' => $this->ignoreStripe(@$row['kostan_alamat']),
            'kostan_kecamatan' => $this->removeKecKel($this->ignoreStripe(@$row['kostan_kecamatan'])),
            'kostan_kelurahan' => $this->removeKecKel($this->ignoreStripe(@$row['kostan_kelurahan'])),
            'kostan_rt' => $this->ignoreStripe(@$row['kostan_rt']),
            'kostan_rw' => $this->ignoreStripe(@$row['kostan_rw']),
            'kostan_jumlah_pegawai' => $this->formatNumber(@$row['kostan_jumlah_pegawai']),
            'kostan_persentase_pajak' => $this->formatNumber(@$row['kostan_persentase_pajak']),
            'status_aktif_id' => $this->user->role_id == 1 ? 1 : 4,
            'kostan_foto' => $this->ignoreStripe(@$row['kostan_foto'], false),
            'kostan_latitude' => $this->ignoreStripe(@$row['kostan_latitude']),
            'kostan_longitude' => $this->ignoreStripe(@$row['kostan_longitude']),
            'created_by' => $this->user->id,
        ];
        Kostan::create($row['kostan']);
    }

    public function rules(): array
    {
        return [
            '*.kostan_jumlah_pegawai' => 'nullable|numeric',
            '*.kostan_persentase_pajak' => 'nullable|numeric',
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
