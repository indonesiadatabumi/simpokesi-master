<?php

namespace App\Exports;

use App\Models\Kostan;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class KostanExport implements FromView
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
        $kostan = DB::table('kostans')->select([
            DB::raw('*'),
            DB::raw('kostans.id as id'),
        ])->whereNull('kostans.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $kostan = $kostan->whereYear('kostans.created_at', $this->tahun);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $kostan = $kostan->where(DB::raw('LOWER(kostan_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $kostan = $kostan->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $kostan = $kostan->where(DB::raw('LOWER(kostan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $kostan = $kostan->leftJoin('kostan_jenis_kamars', 'kostan_jenis_kamars.kostan_id', '=', 'kostans.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'kostans.status_aktif_id');

        $data['kostans'] = $kostan->get();

        return view('backend.exports.kostan', $data);
    }
}
