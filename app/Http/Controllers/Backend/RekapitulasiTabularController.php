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
            'hotel' => ['Hotel', 'hotel'],
            'restoran_notcwp' => ['Restoran', 'restoran_notcwp'],
            'restoran_cwp' => ['Calon Wajib Pajak Restoran', 'restoran_cwp'],
            'kostan' => ['Kosan', 'kostan'],
            'rusun' => ['Rusun', 'rusun'],
            'hiburan' => ['Hiburan', 'hiburan'],
            'parkir' => ['Parkir', 'parkir'],
        ];

        if (empty($data['potensi_pajak'][$jenis])) {
            return abort(404);
        }

        $data['recapitulations'] = (new RekapitulasiTabularService())->getRecapitulation($data['potensi_pajak'][$jenis]);
        $data['jenis'] = $jenis;

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
