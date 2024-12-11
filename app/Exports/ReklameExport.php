<?php

namespace App\Exports;

use App\Models\Reklame;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class ReklameExport implements FromView
{
    public function __construct($input = null)
    {
        $this->reklame_klasifikasi_id = @$input['reklame_klasifikasi_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
        $this->status_aktif_id = @$input['status_aktif_id'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $reklame = DB::table('reklames')->select([
            DB::raw('*'),
            DB::raw('reklames.id as id'),
        ])->whereNull('reklames.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $reklame = $reklame->whereYear('reklames.created_at', $this->tahun);
        }

        if (@$this->reklame_klasifikasi_id && ($this->reklame_klasifikasi_id != '')) {
            $reklame = $reklame->where('reklame_klasifikasi_id', $this->reklame_klasifikasi_id);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $reklame = $reklame->where(DB::raw('LOWER(reklame_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $reklame = $reklame->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $reklame = $reklame->where(DB::raw('LOWER(reklame_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $reklame = $reklame->join('reklame_klasifikasis', 'reklame_klasifikasis.id', '=', 'reklames.reklame_klasifikasi_id')
            ->leftJoin('reklame_tingkat_hunian_avgs', 'reklame_tingkat_hunian_avgs.reklame_id', '=', 'reklames.id')
            ->leftJoin('reklame_jenis_kamars', 'reklame_jenis_kamars.reklame_id', '=', 'reklames.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'reklames.status_aktif_id');

        $data['reklames'] = $reklame->get();

        return view('backend.exports.reklame', $data);
    }
}
