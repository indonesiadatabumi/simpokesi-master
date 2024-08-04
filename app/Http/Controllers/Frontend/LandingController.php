<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Kostan;
use App\Models\Restoran;
use App\Models\Rusun;
use Illuminate\Http\Request;

class LandingController extends Controller
{
    public function index()
    {
        $data['countHotel'] = Hotel::count();
        $data['countRestoran'] = Restoran::count();
        $data['countRusun'] = Rusun::count();
        $data['countKostan'] = Kostan::count();
        return view('frontend.landing.index', $data);
    }
}
