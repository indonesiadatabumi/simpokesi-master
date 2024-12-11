<?php

namespace App\Http\Controllers\Backend;

use App\Exports\RekapitulasiTabularExport;
use App\Http\Controllers\Controller;
use App\Models\Kecamatan;
use App\Services\RekapitulasiTabularService;
use Maatwebsite\Excel\Facades\Excel;

class RekapitulasiTabularController extends Controller
{
    public function show($jenis)
    {
        $data['potensi_pajak'] = [
            'hotel' => ['Hotel', 'hotel',1],
            'restoran_notcwp' => ['Restoran', 'restoran_notcwp',2],
            'restoran_cwp' => ['Calon Wajib Pajak Restoran', 'restoran_cwp',4],
            'kostan' => ['Kosan', 'kostan',8],
            'rusun' => ['Rusun', 'rusun',9],
            'hiburan' => ['Hiburan', 'hiburan',3],
            'parkir' => ['Parkir', 'parkir',7],
        ];

        
        if (empty($data['potensi_pajak'][$jenis])) {
            return abort(404);
        }

        $data['recapitulations'] = (new RekapitulasiTabularService())->getRecapitulation($data['potensi_pajak'][$jenis]);
        $data['jenis'] = $jenis;
        $data['jenis_id']=$data['potensi_pajak'][$jenis][2];

        return view('backend.rekapitulasi-tabular.index', $data);
    }

    public function export($jenis)
    {
        $data['potensi_pajak'] = [
            'hotel' => ['Hotel', 'hotel'],
            'restoran_notcwp' => ['Restoran', 'restoran_notcwp'],
            'restoran_cwp' => ['Calon Wajib Pajak Restoran', 'restoran_cwp'],
            'kostan' => ['Kostan', 'kostan'],
            'rusun' => ['Rusun', 'rusun'],
            'hiburan' => ['Hiburan', 'hiburan'],
            'parkir' => ['Parkir', 'parkir'],
        ];

        if (empty($data['potensi_pajak'][$jenis])) {
            return abort(404);
        }

        $dokumen = new RekapitulasiTabularExport($data['potensi_pajak'][$jenis]);

        return Excel::download($dokumen, 'Rekapitulasi Tabular Potensi Pajak '.$data['potensi_pajak'][$jenis][0].'.xls');
    }
}
