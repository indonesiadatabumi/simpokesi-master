<?php

namespace App\Exports;

use App\Models\Penerangan;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class PeneranganExport implements FromView
{
    public function __construct($input = null)
    {
        $this->penerangan_klasifikasi_id = @$input['penerangan_klasifikasi_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
        $this->status_aktif_id = @$input['status_aktif_id'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $penerangan = DB::table('penerangans')->select([
            DB::raw('*'),
            DB::raw('penerangans.id as id'),
        ])->whereNull('penerangans.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $penerangan = $penerangan->whereYear('penerangans.created_at', $this->tahun);
        }

        if (@$this->penerangan_klasifikasi_id && ($this->penerangan_klasifikasi_id != '')) {
            $penerangan = $penerangan->where('penerangan_klasifikasi_id', $this->penerangan_klasifikasi_id);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $penerangan = $penerangan->where(DB::raw('LOWER(penerangan_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $penerangan = $penerangan->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $penerangan = $penerangan->where(DB::raw('LOWER(penerangan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $penerangan = $penerangan->join('penerangan_klasifikasis', 'penerangan_klasifikasis.id', '=', 'penerangans.penerangan_klasifikasi_id')
            ->leftJoin('penerangan_tingkat_hunian_avgs', 'penerangan_tingkat_hunian_avgs.penerangan_id', '=', 'penerangans.id')
            ->leftJoin('penerangan_jenis_kamars', 'penerangan_jenis_kamars.penerangan_id', '=', 'penerangans.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'penerangans.status_aktif_id');

        $data['penerangans'] = $penerangan->get();

        return view('backend.exports.penerangan', $data);
    }
}
