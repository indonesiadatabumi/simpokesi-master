<?php

namespace App\Exports;

use App\Models\Restoran;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class RestoranExport implements FromView
{
    public function __construct($input = null)
    {
        $this->restoran_klasifikasi_id = @$input['restoran_klasifikasi_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
        $this->tipe = @$input['tipe'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $restoran = DB::table('restorans')->select([
            DB::raw('*'),
            DB::raw('restorans.id as id'),
        ])->where('restoran_is_cwp', false)->whereNull('restorans.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $restoran = $restoran->whereYear('restorans.created_at', $this->tahun);
        }

        if (@$this->restoran_klasifikasi_id && ($this->restoran_klasifikasi_id != '')) {
            $restoran = $restoran->where('restoran_klasifikasi_id', $this->restoran_klasifikasi_id);
        }

        if (@$this->tipe && ($this->tipe != '')) {
            $restoran = $restoran->where('restoran_tipe', str_replace('_', '/', $this->tipe));
            $data['tipe'] = $this->tipe;
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $restoran = $restoran->where(DB::raw('LOWER(restoran_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $restoran = $restoran->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $restoran = $restoran->where(DB::raw('LOWER(restoran_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $restoran = $restoran->join('restoran_klasifikasis', 'restoran_klasifikasis.id', '=', 'restorans.restoran_klasifikasi_id')
            ->leftJoin('restoran_tingkat_kunjungan_avgs', 'restoran_tingkat_kunjungan_avgs.restoran_id', '=', 'restorans.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'restorans.status_aktif_id');

        $data['restorans'] = $restoran->get();

        return view('backend.exports.restoran', $data);
    }
}
