<?php

namespace App\Http\Controllers\Backend;

use App\Exports\RekapitulasiDokumenLainTabularExport;
use App\Exports\RekapitulasiTabularExport;
use App\Http\Controllers\Controller;
use App\Models\JenisDokumen;
use App\Models\Kecamatan;
use App\Services\RekapitulasiDokumenLainService;
use App\Services\RekapitulasiTabularService;
use Maatwebsite\Excel\Facades\Excel;

class RekapitulasiDokumenLainController extends Controller
{
    // Tabular
    public function tabular($jenis = null)
    {
        $data['jenis_dokumens'] = JenisDokumen::orderBy('jenis_dokumen_deskripsi', 'asc')->get();

        if (empty($jenis)){
            $id = $data['jenis_dokumens']->first()->id;
            return redirect('/rekapitulasi-dokumen-lain/tabular/'.$id);
        }

        $data['jenis_dokumen'] = JenisDokumen::findOrFail($jenis);
        $data['recapitulations'] = (new RekapitulasiDokumenLainService())->getRecapitulation($jenis);

        return view('backend.rekapitulasi-tabular-dokumen-lain.index', $data);
    }

    public function export($jenis)
    {
        $jenis_dokumen = JenisDokumen::findOrFail($jenis);

        $dokumen = new RekapitulasiDokumenLainTabularExport($jenis);

        return Excel::download($dokumen, 'Rekapitulasi Tabular Dokumen '.$jenis_dokumen->jenis_dokumen_deskripsi.'.xls');
    }

    // Grafik
    public function grafik()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.rekapitulasi-grafik-dokumen-lain.index', $data);
    }

    // Peta

    public function peta()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();
        $data['jenis_dokumens'] = JenisDokumen::orderBy('id', 'asc')->get();

        return view('backend.rekapitulasi-peta-dokumen-lain.index', $data);
    }
}
