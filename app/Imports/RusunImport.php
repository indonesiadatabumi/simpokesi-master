<?php

namespace App\Imports;

use App\Models\Kelurahan;
use App\Models\Rusun;
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

class RusunImport implements OnEachRow, WithHeadingRow, WithChunkReading, WithBatchInserts, WithValidation, SkipsOnFailure
{
    use Importable, SkipsErrors, SkipsFailures;

    public $user;
    public $rusuns;
    public $kelurahans;
    public $rowNum = 0;

    public function __construct()
    {
        $this->user = auth()->user();
        $this->rusuns = Rusun::get(['rusun_npwpd'])->pluck('rusun_npwpd')->toArray();
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

        if ($this->checkEmpty(@$row['rusun_pemilik'])
            && $this->checkEmpty(@$row['rusun_nama'])
            && $this->checkEmpty(@$row['rusun_npwpd'])) {
            return null;
        }

        // Check if added
        if (in_array($this->ignoreStripe(@$row['rusun_npwpd'], false), $this->rusuns)) {
            $error = ['rusun_npwpd' => 'Rusun NPWPD telah terpakai'];
            $failures[] = new Failure($this->rowNum, 'rusun_npwpd', $error);
            throw new ValidationException(
                \Illuminate\Validation\ValidationException::withMessages($error),
                $failures
            );
        } else {
            $this->rusuns[] = $this->ignoreStripe(@$row['rusun_npwpd'], false);
        }

        // Set Default latitude & longitude if empty
        $latitude = $this->ignoreStripe(@$row['rusun_latitude']);
        $longitude = $this->ignoreStripe(@$row['rusun_longitude']);
        if ((empty($latitude) || $latitude == '') && (empty($longitude) || $longitude == '') && @$row['rusun_kelurahan']) {
            $input_kelurahan = $this->removeKecKel($this->ignoreStripe(@$row['rusun_kelurahan']));
            $kelurahan = $this->kelurahans->filter(function ($item) use ($input_kelurahan) {
                return $item['kelurahan'] == strtoupper($input_kelurahan);
            });

            if ($kelurahan->count() > 0) {
                $row['rusun_latitude'] = $kelurahan->first()->default_latitude;
                $row['rusun_longitude'] = $kelurahan->first()->default_longitude;
            }
        }

        //Create Rusun
        $row['rusun'] = [
            'rusun_nama' => $this->ignoreStripe(@$row['rusun_nama']),
            'rusun_pemilik' => $this->ignoreStripe(@$row['rusun_pemilik']),
            'rusun_telepon' => $this->ignoreStripe(@$row['rusun_telepon']),
            'rusun_npwpd' => $this->ignoreStripe(@$row['rusun_npwpd']),
            'rusun_alamat' => $this->ignoreStripe(@$row['rusun_alamat']),
            'rusun_kecamatan' => $this->removeKecKel($this->ignoreStripe(@$row['rusun_kecamatan'])),
            'rusun_kelurahan' => $this->removeKecKel($this->ignoreStripe(@$row['rusun_kelurahan'])),
            'rusun_rt' => $this->ignoreStripe(@$row['rusun_rt']),
            'rusun_rw' => $this->ignoreStripe(@$row['rusun_rw']),
            'rusun_jumlah_pegawai' => $this->formatNumber(@$row['rusun_jumlah_pegawai']),
            'status_aktif_id' => $this->user->role_id == 1 ? 1 : 4,
            'rusun_foto' => $this->ignoreStripe(@$row['rusun_foto'], false),
            'rusun_latitude' => $this->ignoreStripe(@$row['rusun_latitude']),
            'rusun_longitude' => $this->ignoreStripe(@$row['rusun_longitude']),
            'created_by' => $this->user->id,
        ];
        Rusun::create($row['rusun']);
    }

    public function rules(): array
    {
        return [
            '*.rusun_jumlah_pegawai' => 'nullable|numeric',
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
