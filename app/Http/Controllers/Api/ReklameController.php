<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Reklame;
use App\Services\ReklameService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class ReklameController extends Controller
{
    public function show($id)
    {
        $data = Reklame::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'reklame' => @$data ?? null
        ]); 
    }

    public function jsonDatatable()
    {
        $data = (new ReklameService())->getReklameList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('reklames.created_at', $tahun);
        }
        

        if(@request()->reklame_klasifikasi_id && @request()->reklame_klasifikasi_id != ''){
            $reklameKlasifikasiId = request()->reklame_klasifikasi_id;
            $data = $data->where('klasifikasi_id', $reklameKlasifikasiId);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(reklame_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('npwpd', function($reklame) {
                return $reklame->npwpd ?? '-';
            })
            ->editColumn('nama_objek', function($reklame) {
                return $reklame->nama_objek ?? '-';
            })
            ->editColumn('rekening_objek', function($reklame) {
                return $reklame->rekening_objek ?? '-';
            })
            ->editColumn('nama', function($reklame) {
                return $reklame->nama ?? '-';
            })
            ->editColumn('alamat', function($reklame) {
                return $reklame->alamat_objek ?? '-';
            })
            ->addColumn('action', function($reklame) {
                $content['reklame'] = $reklame;
                return view('datatables.reklame.action', $content);
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

        $tags = (new ReklameService())->getReklameList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(reklame_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'reklames.pemohon_id')
            ->orderBy('reklame_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->reklame_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
    */
}
