<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Penerangan;
use App\Services\PeneranganService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class PeneranganController extends Controller
{
    public function show($id)
    {
        $data = Penerangan::with('pemohon')->where('id', $id)->first();

        return response()->json([
            'penerangan' => @$data ?? null
        ]); 
    }

    public function jsonDatatable()
    {
        $data = (new PeneranganService())->getPeneranganList();

        if(@request()->tahun && @request()->tahun != ''){
            $tahun = request()->tahun;
            $data = $data->whereYear('penerangans.created_at', $tahun);
        }
        

        if(@request()->penerangan_klasifikasi_id && @request()->penerangan_klasifikasi_id != ''){
            $peneranganKlasifikasiId = request()->penerangan_klasifikasi_id;
            $data = $data->where('klasifikasi_id', $peneranganKlasifikasiId);
        }

        if(@request()->kecamatan && @request()->kecamatan != ''){
            $kecamatan = request()->kecamatan;
            $data = $data->where(DB::raw('LOWER(penerangan_kecamatan)'), strtolower($kecamatan));
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
            ->editColumn('npwpd', function($penerangan) {
                return $penerangan->npwpd ?? '-';
            })
            ->editColumn('nama_objek', function($penerangan) {
                return $penerangan->nama_objek ?? '-';
            })
            ->editColumn('rekening_objek', function($penerangan) {
                return $penerangan->rekening_objek ?? '-';
            })
            ->editColumn('nama', function($penerangan) {
                return $penerangan->nama ?? '-';
            })
            ->editColumn('alamat', function($penerangan) {
                return $penerangan->alamat_objek ?? '-';
            })
            ->addColumn('action', function($penerangan) {
                $content['penerangan'] = $penerangan;
                return view('datatables.penerangan.action', $content);
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

        $tags = (new PeneranganService())->getPeneranganList();

        if (@$request->rekomtek) {
            $tipeRekomtek = $request->rekomtek;

            if ($tipeRekomtek == 'rhtl') {
                $tags = $tags->where('rencana_penggunaan_id', 1);
            } else {
                $tags = $tags->whereNotIn('rencana_penggunaan_id', [1]);
            }
        }

        $tags = $tags->where(function($q) use($keyword) {
                $q->where(DB::raw('LOWER(penerangan_no_rekomendasi)'), 'like', '%'.strtolower($keyword).'%')
                    ->orWhere(DB::raw('LOWER(pemohon_nama)'), 'like', '%'.strtolower($keyword).'%');
            })
            ->join('pemohons', 'pemohons.id', '=', 'penerangans.pemohon_id')
            ->orderBy('penerangan_no_rekomendasi', 'asc')->paginate(10);

        $formatted_tags = [];

        foreach ($tags->toArray()['data'] as $tag) {
            $formatted_tags[] = ['id' => $tag->id, 'text' => $tag->penerangan_no_rekomendasi.' - '.$tag->pemohon_nama];
        }

        return response()->json([
            'items' => $formatted_tags,
            'pagination' => $tags->nextPageUrl() ? true : false
        ]);
    }
    */
}
