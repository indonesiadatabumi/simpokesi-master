<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Services\HotelService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class HotelController extends Controller
{
    public function show($id)
    {
        $data = Hotel::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'hotel' => @$data ?? null
        ]);
    }

    public function jsonDatatable()
    {
        $data = (new HotelService())->getHotelList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('hotels.created_at', $tahun);
        }

        if(@request()->hotel_klasifikasi_id && @request()->hotel_klasifikasi_id != ''){
            $hotelKlasifikasiId = request()->hotel_klasifikasi_id;
            $data = $data->where('hotel_klasifikasi_id', $hotelKlasifikasiId);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(hotel_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('hotel_npwpd', function($hotel) {
                return $hotel->hotel_npwpd ?? '-';
            })
            ->editColumn('hotel_nama', function($hotel) {
                return $hotel->hotel_nama ?? '-';
            })
            ->editColumn('hotel_pemilik', function($hotel) {
                return $hotel->hotel_pemilik ?? '-';
            })
            ->addColumn('action', function($hotel) {
                $content['hotel'] = $hotel;
                return view('datatables.hotel.action', $content);
            })
            ->rawColumns(['action'])
            ->toJson();
    }

    public function jsonSelect2(Request $request)
    {
        if (@$request->q) {
            $keyword = trim($request->q);
        }else{
            $keyword = '';
        }

        $tags = (new HotelService())->getHotelList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(hotel_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'hotels.pemohon_id')
            ->orderBy('hotel_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->hotel_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
}
