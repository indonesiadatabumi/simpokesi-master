<?php

namespace App\Exports;

use App\Models\Krk;
use App\Services\RekapitulasiDokumenLainService;
use App\Services\RekapitulasiTabularService;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class RekapitulasiDokumenLainTabularExport implements FromView
{
    public $jenis;

    public function __construct($jenis)
    {
        $this->jenis = $jenis;
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $data['recapitulations'] = (new RekapitulasiDokumenLainService())->getRecapitulation($this->jenis);

        return view('backend.exports.rekapitulasi-tabular', $data);
    }
}
