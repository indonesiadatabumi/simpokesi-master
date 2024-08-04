<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Parkir;
use App\Services\ParkirService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class ParkirController extends Controller
{
    public function jsonDatatable()
    {
        $data = (new ParkirService())->getParkirList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('parkirs.created_at', $tahun);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(parkir_kecamatan)'), strtolower($kecamatan));
        }

        if(@request()->verifikasi && @request()->verifikasi != ''){
            $verifikasiId = @request()->verifikasi * 1;
            $data = $data->where('status_aktif_id', $verifikasiId);
        }

        if(auth()->user()->role_id == 2){
            $data = $data->where('created_by', auth()->user()->id);
        }

        return DataTables::query($data)
            ->addIndexColumn()
            ->editColumn('parkir_npwpd', function($parkir) {
                return $parkir->parkir_npwpd ?? '-';
            })
            ->editColumn('parkir_nama', function($parkir) {
                return $parkir->parkir_nama ?? '-';
            })
            ->editColumn('parkir_pemilik', function($parkir) {
                return $parkir->parkir_pemilik ?? '-';
            })
            ->addColumn('action', function($parkir) {
                $content['parkir'] = $parkir;
                return view('datatables.parkir.action', $content);
            })
            ->rawColumns(['action'])
            ->toJson();
    }
}
