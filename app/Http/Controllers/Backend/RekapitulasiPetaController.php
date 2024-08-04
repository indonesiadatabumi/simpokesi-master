<?php

namespace App\Http\Controllers\Backend;

use App\Exports\RekapitulasiTabularExport;
use App\Http\Controllers\Controller;
use App\Models\Kecamatan;
use App\Services\RekapitulasiGrafikService;
use Maatwebsite\Excel\Facades\Excel;

class RekapitulasiPetaController extends Controller
{
    public function index()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.rekapitulasi-peta.index', $data);
    }
}
