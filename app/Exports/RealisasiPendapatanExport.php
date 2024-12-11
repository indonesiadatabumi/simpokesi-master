<?php

namespace App\Exports;

use App\Models\Hotel;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class RealisasiPendapatanExport implements FromView
{
    public function __construct($input = null)
    {
        // $this->hotel_klasifikasi_id = @$input['hotel_klasifikasi_id'];
        // $this->tahun = @$input['tahun'];
        // $this->kecamatan = @$input['kecamatan'];
        $this->startYear = @$input['startYear'];
        $this->endYear = @$input['endYear'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $data = [];

        $data['jenisPajak'] = $this->jenisPajak();
        $data['realisasi'] = $this->executeCurlRealisasi();
        $data['target'] = $this->target();
        $data['startYear'] = $this->startYear;
        $data['endYear'] = $this->endYear;

        return view('backend.exports.realisasiPendapatan', $data);
    }

    public function jenisPajak()
    {
        return jenisPajak();
        $jenisPajak = [
            ['id' => 1, 'code' => '4.1.01.06', 'name' => 'Pajak Hotel'],
            ['id' => 2, 'code' => '4.1.01.07', 'name' => 'Pajak Restoran'],
            ['id' => 3, 'code' => '4.1.01.08', 'name' => 'Pajak Hiburan'],
            ['id' => 4, 'code' => '4.1.01.09', 'name' => 'Pajak Reklame'],
            ['id' => 6, 'code' => '4.1.01.10', 'name' => 'Pajak Penerangan Jalan'],
            ['id' => 7, 'code' => '4.1.01.11', 'name' => 'Pajak Parkir'],
            ['id' => 8, 'code' => '4.1.01.12', 'name' => 'Pajak Air Tanah'],
        ];
        return $jenisPajak;
    }

    public function executeCurlRealisasi($value='')
    {
        $jenisPajak = $this->jenisPajak();

        foreach ($jenisPajak as &$r) {
            $idPajak = $r['id'];
            $curl = curl_init();

            $postData = json_encode([
                "jenis_pajak" => $idPajak,
                "periode" => ""
            ]);

            curl_setopt_array($curl, array(
              CURLOPT_URL => 'http://sipdah.bekasikota.go.id/api/simpokesi/data_realisasi_jenis_pajak',
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS => $postData,
              CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
              ),
            ));

            $response = curl_exec($curl);

            curl_close($curl);
            $r['realisasi'] = $response;
        }

        return $jenisPajak;
    }

    public function target($value='')
    {
        /*hotel*/
        $hotel = DB::table('hotels_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $hiburan = DB::table('hiburans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $restorans = DB::table('restorans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $reklames = DB::table('reklames_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $penerangans = DB::table('penerangans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $parkirs = DB::table('parkirs_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $airs = DB::table('airs_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();

        $a =[];
        foreach ($hotel as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[1] = $a;

        $a =[];
        foreach ($restorans as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[2] = $a;

        $a =[];
        foreach ($hiburan as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[3] = $a;

        $a =[];
        foreach ($reklames as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[4] = $a;

        $a =[];
        foreach ($penerangans as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[6] = $a;

        $a =[];
        foreach ($parkirs as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[7] = $a;

        $a =[];
        foreach ($airs as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[8] = $a;

        return $jenisPajak;

    }
}
