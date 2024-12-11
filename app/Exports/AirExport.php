<?php

namespace App\Exports;

use App\Models\Air;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class AirExport implements FromView
{
    public function __construct($input = null)
    {
        $this->air_klasifikasi_id = @$input['air_klasifikasi_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
        $this->status_aktif_id = @$input['status_aktif_id'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $air = DB::table('airs')->select([
            DB::raw('*'),
            DB::raw('airs.id as id'),
        ])->whereNull('airs.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $air = $air->whereYear('airs.created_at', $this->tahun);
        }

        if (@$this->air_klasifikasi_id && ($this->air_klasifikasi_id != '')) {
            $air = $air->where('air_klasifikasi_id', $this->air_klasifikasi_id);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $air = $air->where(DB::raw('LOWER(air_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $air = $air->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $air = $air->where(DB::raw('LOWER(air_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $air = $air->join('air_klasifikasis', 'air_klasifikasis.id', '=', 'airs.air_klasifikasi_id')
            ->leftJoin('air_tingkat_hunian_avgs', 'air_tingkat_hunian_avgs.air_id', '=', 'airs.id')
            ->leftJoin('air_jenis_kamars', 'air_jenis_kamars.air_id', '=', 'airs.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'airs.status_aktif_id');

        $data['airs'] = $air->get();

        return view('backend.exports.air', $data);
    }
}
