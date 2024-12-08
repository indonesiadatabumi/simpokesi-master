<?php

namespace App\Http\Controllers\Backend;

use App\Exports\ParkirExport;
use App\Http\Controllers\Controller;
use App\Models\ParkirKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Parkir;
use App\Models\StatusAktif;
use App\Models\Hiburan;
use App\Models\Hotel;
use App\Models\Restoran;
use App\Models\Reklame;
use App\Models\Air;
use App\Models\Penerangan;
use App\Services\ParkirService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use ZanySoft\Zip\Zip;

class RealisasiPendapatanController extends Controller
{
    public function index()
    {
        $data = [];
        return view('backend.other.realisasi-pendapatan-index', $data);
    }

    public function forecastData(Request $request)
    {
        $input = $request->all();
        $jenisPajak = $input['jenisPajak'];
        $realisasiFiltered = realisasiFiltered($jenisPajak, $input['startYear'], $input['endYear']);
        // dd($realisasiFiltered);
        $foreCast = foreCast($realisasiFiltered);
        $realisasiFiltered[($input['endYear'] + 1)] = $foreCast;
        // $realisasiFiltered = realisasiTahunSort($jenisPajak);

        // return json_encode($realisasiFiltered);
        return response()->json(['data'=>$realisasiFiltered, 'foreCast'=>$foreCast]); 
    }
}
