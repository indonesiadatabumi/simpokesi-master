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
    
    public function jsonHuniantable()
    {
        $data = (new HotelService())->getHunianList();
        
        if(@request()->id && @request()->id != ''){
            $id = request()->id;
            $data = $data->where('hotel_id', $id);
        }
        
        if(auth()->user()->role_id == 2){
            $data = $data->where('created_by', auth()->user()->id);
        }
        
        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('hotel_tingkat_hunian_avgs.created_at', $tahun);
        }
        
        return DataTables::query($data)
        ->addIndexColumn()
        ->editColumn('created_at', function($hotel) {
            return $hotel->created_at ?? '-';
        })
        ->editColumn('kunjungan_penuh', function($hotel) {
            return $hotel->kunjungan_penuh ?? '-';
        })
        ->editColumn('kunjungan_akhir_pekan', function($hotel) {
            return $hotel->kunjungan_akhir_pekan ?? '-';
        })
        ->editColumn('kunjungan_normal', function($hotel) {
            return $hotel->kunjungan_normal ?? '-';
        })
        ->editColumn('kunjungan_sepi', function($hotel) {
            return $hotel->kunjungan_sepi ?? '-';
        })
        ->addColumn('action', function($hotel) {
            $content['hotel'] = $hotel;
            return view('datatables.hotel.actionhunian', $content);
        })
        ->rawColumns(['action'])
        ->toJson();
    }
    
    public function jsonKamartable()
    {
        $data = (new HotelService())->getKamarList();
        
        if(@request()->id && @request()->id != ''){
            $id = request()->id;
            $data = $data->where('hotel_id', $id);
        }
        
        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('hotel_jenis_kamars.created_at', $tahun);
        }
        
        if(@request()->musim && @request()->musim != ''){
            $musim = request()->musim;
            $data = $data->where('musim', $musim);
        }
        
        if(@request()->category && @request()->category != ''){
            $category = request()->category;
            $data = $data->where('category_hari', $category);
        }
        
        if(auth()->user()->role_id == 2){
            $data = $data->where('created_by', auth()->user()->id);
        }
        
        return DataTables::query($data)
        ->addIndexColumn()
        ->editColumn('created_at', function($hotel) {
            return $hotel->created_at ?? '-';
        })
        ->editColumn('musim', function($hotel) {
            return $hotel->musim ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_deskripsi', function($hotel) {
            return $hotel->hotel_jenis_kamar_deskripsi ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_tarif', function($hotel) {
            return $hotel->hotel_jenis_kamar_tarif ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_jumlah', function($hotel) {
            return $hotel->hotel_jenis_kamar_jumlah ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_avg_penuh', function($hotel) {
            return $hotel->hotel_jenis_kamar_avg_penuh ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_avg_akhir_pekan', function($hotel) {
            return $hotel->hotel_jenis_kamar_avg_akhir_pekan ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_avg_normal', function($hotel) {
            return $hotel->hotel_jenis_kamar_avg_normal ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_avg_sepi', function($hotel) {
            return $hotel->hotel_jenis_kamar_avg_sepi ?? '-';
        })
        ->editColumn('hotel_jenis_kamar_potensi_pajak', function($hotel) {
            return $hotel->hotel_jenis_kamar_potensi_pajak ?? '-';
        })
        ->addColumn('action', function($hotel) {
            $content['hotel'] = $hotel;
            return view('datatables.hotel.actionkamar', $content);
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
