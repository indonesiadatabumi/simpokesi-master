<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Air;
use App\Services\AirService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class AirController extends Controller
{
    public function show($id)
    {
        $data = Air::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'air' => @$data ?? null
        ]); 
    }

    public function jsonDatatable()
    {
        $data = (new AirService())->getAirList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('airs.created_at', $tahun);
        }
        

        if(@request()->air_klasifikasi_id && @request()->air_klasifikasi_id != ''){
            $airKlasifikasiId = request()->air_klasifikasi_id;
            $data = $data->where('klasifikasi_id', $airKlasifikasiId);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(air_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('npwpd', function($air) {
                return $air->npwpd ?? '-';
            })
            ->editColumn('nama_objek', function($air) {
                return $air->nama_objek ?? '-';
            })
            ->editColumn('rekening_objek', function($air) {
                return $air->rekening_objek ?? '-';
            })
            ->editColumn('nama', function($air) {
                return $air->nama ?? '-';
            })
            ->editColumn('alamat', function($air) {
                return $air->alamat_objek ?? '-';
            })
            ->addColumn('action', function($air) {
                $content['air'] = $air;
                return view('datatables.air.action', $content);
            })
            ->rawColumns(['action'])
            ->toJson();
    }
/*
    public function jsonSelect2(Request $request)
    {
        if (@$request->q) {
            $keyword = trim($request->q);
        }else{
            $keyword = '';
        }

        $tags = (new AirService())->getAirList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(air_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'airs.pemohon_id')
            ->orderBy('air_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->air_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
    */
}
