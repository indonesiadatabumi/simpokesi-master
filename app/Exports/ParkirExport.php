<?php

namespace App\Exports;

use App\Models\Parkir;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class ParkirExport implements FromView
{
    public function __construct($input = null)
    {
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $parkir = DB::table('parkirs')->select([
            DB::raw('*'),
            DB::raw('parkirs.id as id'),
        ])->whereNull('parkirs.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $parkir = $parkir->whereYear('parkirs.created_at', $this->tahun);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $parkir = $parkir->where(DB::raw('LOWER(parkir_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $parkir = $parkir->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $parkir = $parkir->where(DB::raw('LOWER(parkir_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $parkir = $parkir->leftJoin('parkir_tingkat_kunjungan_avgs', 'parkir_tingkat_kunjungan_avgs.parkir_id', '=', 'parkirs.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'parkirs.status_aktif_id');

        $data['parkirs'] = $parkir->get();

        return view('backend.exports.parkir', $data);
    }
}
