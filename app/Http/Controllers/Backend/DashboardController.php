<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Kostan;
use App\Models\Restoran;
use App\Models\Rusun;
use App\Models\Hiburan;
use App\Models\Parkir;
use Carbon\Carbon;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $year = $request->tahun ?? null;

        $data['sumHotel'] = Hotel::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->sum('hotel_potensi_pajak');

        $data['sumRestoranGroup'] = Restoran::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->where('restoran_is_cwp', 0)->get()->groupBy('restoran_tipe');

        $data['sumRestoran'] = Restoran::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->where('restoran_is_cwp', 0)->sum('restoran_potensi_pajak');

        $data['sumRestoranCwpGroup'] = Restoran::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->where('restoran_is_cwp', 1)->get()->groupBy('restoran_tipe');

        $data['sumRestoranCwp'] = Restoran::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->where('restoran_is_cwp', 1)->sum('restoran_potensi_pajak');

        $data['sumRusun'] = Rusun::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->sum('rusun_potensi_pajak');

        $data['sumKostan'] = Kostan::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->sum('kostan_potensi_pajak');

        $data['sumHiburan'] = Hiburan::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak');

        $data['sumParkir'] = Parkir::when(@$year, function($q) use($year){
            $q->whereYear('created_at', $year);
        })->where('status_aktif_id', 1)->sum('parkir_potensi_pajak');

        return view('backend.dashboard.index', $data);
    }
}
