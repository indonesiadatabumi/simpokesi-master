<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hiburan;
use App\Services\HiburanService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class HiburanController extends Controller
{
    public function show($id)
    {
        $data = Hiburan::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'hiburan' => @$data ?? null
        ]);
    }

    public function jsonDatatable()
    {
        $data = (new HiburanService())->getHiburanList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('hiburans.created_at', $tahun);
        }

        if(@request()->hiburan_jenis_id && @request()->hiburan_jenis_id != ''){
            $hiburanJenisId = request()->hiburan_jenis_id;
            $data = $data->where('hiburans.hiburan_jenis_id', $hiburanJenisId);
        }

        if(@request()->hiburan_kategori_id && @request()->hiburan_kategori_id != ''){
            $hiburanKategoriId = request()->hiburan_kategori_id;
            $data = $data->where('hiburans.hiburan_kategori_id', $hiburanKategoriId);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(hiburans.hiburan_kecamatan)'), strtolower($kecamatan));
        }

        if(@request()->verifikasi && @request()->verifikasi != ''){
            $verifikasiId = @request()->verifikasi * 1;
            $data = $data->where('hiburans.status_aktif_id', $verifikasiId);
        }

        if(auth()->user()->role_id == 2){
            $data = $data->where('hiburans.created_by', auth()->user()->id);
        }

        return DataTables::query($data)
            ->addIndexColumn()
            ->editColumn('hiburan_npwpd', function($hiburan) {
                return $hiburan->hiburan_npwpd ?? '-';
            })
            ->editColumn('hiburan_nama', function($hiburan) {
                return $hiburan->hiburan_nama ?? '-';
            })
            ->editColumn('hiburan_pemilik', function($hiburan) {
                return $hiburan->hiburan_pemilik ?? '-';
            })
            ->addColumn('hiburan_kategori', function($hiburan) {
                return @$hiburan->hiburan_kategori_deskripsi ?? '-';
            })
            ->addColumn('action', function($hiburan) {
                $content['hiburan'] = $hiburan;
                return view('datatables.hiburan.action', $content);
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

        $tags = (new HiburanService())->getHiburanList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(hiburan_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'hiburans.pemohon_id')
            ->orderBy('hiburan_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->hiburan_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
}
