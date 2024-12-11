<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Restoran;
use App\Services\RestoranCwpService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class RestoranCwpController extends Controller
{
    public function show($id)
    {
        $data = Restoran::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'restoran' => @$data ?? null
        ]);
    }

    public function jsonDatatable()
    {
        $data = (new RestoranCwpService())->getRestoranList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('restorans.created_at', $tahun);
        }
/*
        if(@request()->restoran_klasifikasi_id && @request()->restoran_klasifikasi_id != ''){
            $restoranKlasifikasiId = request()->restoran_klasifikasi_id;
            $data = $data->where('restoran_klasifikasi_id', $restoranKlasifikasiId);
        }
*/
        if(@request()->tipe && @request()->tipe != ''){
            $restoranTipe = request()->tipe;
            $data = $data->where('restoran_tipe','like','%'.$restoranTipe.'%');
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(restoran_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('restoran_npwpd', function($restoran) {
                return $restoran->restoran_npwpd ?? '-';
            })
            ->editColumn('restoran_nama', function($restoran) {
                return $restoran->restoran_nama ?? '-';
            })
            ->editColumn('restoran_pemilik', function($restoran) {
                return $restoran->restoran_pemilik ?? '-';
            })
            ->addColumn('action', function($restoran) {
                $content['restoran'] = $restoran;
                return view('datatables.restoran-cwp.action', $content);
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

        $tags = (new RestoranCwpService())->getRestoranList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(restoran_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'restorans.pemohon_id')
            ->orderBy('restoran_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->restoran_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
}
