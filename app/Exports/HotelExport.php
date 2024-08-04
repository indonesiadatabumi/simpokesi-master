<?php

namespace App\Exports;

use App\Models\Hotel;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class HotelExport implements FromView
{
    public function __construct($input = null)
    {
        $this->hotel_klasifikasi_id = @$input['hotel_klasifikasi_id'];
        $this->tahun = @$input['tahun'];
        $this->kecamatan = @$input['kecamatan'];
        $this->status_aktif_id = @$input['status_aktif_id'];
    }

    /**
    * @return \Illuminate\Contracts\View\View
    */
    public function view(): View
    {
        $hotel = DB::table('hotels')->select([
            DB::raw('*'),
            DB::raw('hotels.id as id'),
        ])->whereNull('hotels.deleted_at');

        if (@$this->tahun && ($this->tahun != '')) {
            $hotel = $hotel->whereYear('hotels.created_at', $this->tahun);
        }

        if (@$this->hotel_klasifikasi_id && ($this->hotel_klasifikasi_id != '')) {
            $hotel = $hotel->where('hotel_klasifikasi_id', $this->hotel_klasifikasi_id);
        }

        if(@$this->kecamatan && @$this->kecamatan != ''){
            $hotel = $hotel->where(DB::raw('LOWER(hotel_kecamatan)'), strtolower($this->kecamatan));
        }

        if(@$this->status_aktif_id && @$this->status_aktif_id != ''){
            $hotel = $hotel->where('status_aktif_id', $this->status_aktif_id);
        }

        if(@auth()->user()->kecamatan->kecamatan){
            $hotel = $hotel->where(DB::raw('LOWER(hotel_kecamatan)'), strtolower(@auth()->user()->kecamatan->kecamatan));
        }

        $hotel = $hotel->join('hotel_klasifikasis', 'hotel_klasifikasis.id', '=', 'hotels.hotel_klasifikasi_id')
            ->leftJoin('hotel_tingkat_hunian_avgs', 'hotel_tingkat_hunian_avgs.hotel_id', '=', 'hotels.id')
            ->leftJoin('hotel_jenis_kamars', 'hotel_jenis_kamars.hotel_id', '=', 'hotels.id')
            ->leftJoin('status_aktifs', 'status_aktifs.id', '=', 'hotels.status_aktif_id');

        $data['hotels'] = $hotel->get();

        return view('backend.exports.hotel', $data);
    }
}
