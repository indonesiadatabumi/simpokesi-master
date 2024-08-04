<?php

namespace App\Exports;

use App\Models\Hiburan;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class HiburanExport implements FromView
{
    public function __construct($input = null, $jenisHiburan)
    {
        $this->jenis_hiburan = $jenisHiburan;
        $this->hiburan_jenis_id = @$input['hiburan_jenis_id'];
        $this->hiburan_kategori_id = @$input['hiburan_kategori_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $hiburan = Hiburan::with(['tarif', 'kunjungan'])->select([
            DB::raw('*'),
            DB::raw('hiburans.id as id'),
        ])->whereNull('hiburans.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $hiburan = $hiburan->whereYear('hiburans.created_at', $this->tahun);
        }

        if (@$this->hiburan_jenis_id && ($this->hiburan_jenis_id != '')) {
            $hiburan = $hiburan->where('hiburans.hiburan_jenis_id', $this->hiburan_jenis_id);
        }

        if (@$this->hiburan_kategori_id && ($this->hiburan_kategori_id != '')) {
            $hiburan = $hiburan->where('hiburans.hiburan_kategori_id', $this->hiburan_kategori_id);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $hiburan = $hiburan->where(DB::raw('LOWER(hiburan_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $hiburan = $hiburan->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $hiburan = $hiburan->where(DB::raw('LOWER(hiburan_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $hiburan = $hiburan->join('hiburan_jenises', 'hiburan_jenises.id', '=', 'hiburans.hiburan_jenis_id')
            ->leftJoin('hiburan_tingkat_kunjungan_avgs', 'hiburan_tingkat_kunjungan_avgs.hiburan_id', '=', 'hiburans.id')
            ->leftJoin('hiburan_jenis_ruangans', 'hiburan_jenis_ruangans.hiburan_id', '=', 'hiburans.id')
            ->leftJoin('hiburan_kategoris', 'hiburan_kategoris.hiburan_jenis_id', '=', 'hiburan_jenises.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'hiburans.status_aktif_id');

        $data['hiburans'] = $hiburan->get();
        $data['jenis_hiburan'] = $this->jenis_hiburan;

        $data['col'] = [
            'hiburan' => 16,
            'ruangan' => 3,
        ];

        if (@$this->jenis_hiburan->hiburan_jenis_jumlah_label)
            $data['col']['hiburan'] += 1;
        
        if (@$this->jenis_hiburan->hiburan_jenis_kapasitas_label && !$this->jenis_hiburan->hiburan_jenis_have_ruangan)
            $data['col']['hiburan'] += 1;

        if (@$this->jenis_hiburan->hiburan_jenis_kapasitas_label && $this->jenis_hiburan->hiburan_jenis_have_ruangan)
            $data['col']['ruangan'] += 1;

        return view('backend.exports.hiburan', $data);
    }
}
