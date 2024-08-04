<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Kostan;
use App\Services\KostanService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class KostanController extends Controller
{
    public function show($id)
    {
        $data = Kostan::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'kostan' => @$data ?? null
        ]);
    }

    public function jsonDatatable()
    {
        $data = (new KostanService())->getKostanList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('kostans.created_at', $tahun);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(kostan_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('kostan_npwpd', function($kostan) {
                return $kostan->kostan_npwpd ?? '-';
            })
            ->editColumn('kostan_nama', function($kostan) {
                return $kostan->kostan_nama ?? '-';
            })
            ->editColumn('kostan_pemilik', function($kostan) {
                return $kostan->kostan_pemilik ?? '-';
            })
            ->addColumn('action', function($kostan) {
                $content['kostan'] = $kostan;
                return view('datatables.kostan.action', $content);
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

        $tags = (new KostanService())->getKostanList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(kostan_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'kostans.pemohon_id')
            ->orderBy('kostan_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->kostan_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
}
