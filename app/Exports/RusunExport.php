<?php

namespace App\Exports;

use App\Models\Rusun;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class RusunExport implements FromView
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
        $rusun = DB::table('rusuns')->select([
            DB::raw('*'),
            DB::raw('rusuns.id as id'),
        ])->whereNull('rusuns.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $rusun = $rusun->whereYear('rusuns.created_at', $this->tahun);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $rusun = $rusun->where(DB::raw('LOWER(rusun_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $rusun = $rusun->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $rusun = $rusun->where(DB::raw('LOWER(rusun_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $rusun = $rusun->leftJoin('rusun_jenis_kamars', 'rusun_jenis_kamars.rusun_id', '=', 'rusuns.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'rusuns.status_aktif_id');

        $data['rusuns'] = $rusun->get();

        return view('backend.exports.rusun', $data);
    }
}
