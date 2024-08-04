<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HotelTingkatHunianAvg extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hotel_id',
        'kunjungan_penuh',
        'kunjungan_akhir_pekan',
        'kunjungan_normal',
        'kunjungan_sepi',
    ];
}
