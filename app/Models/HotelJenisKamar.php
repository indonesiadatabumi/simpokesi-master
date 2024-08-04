<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HotelJenisKamar extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hotel_id',
        'hotel_jenis_kamar_deskripsi',
        'hotel_jenis_kamar_tarif',
        'hotel_jenis_kamar_jumlah',
        'hotel_jenis_kamar_avg_penuh',
        'hotel_jenis_kamar_avg_akhir_pekan',
        'hotel_jenis_kamar_avg_normal',
        'hotel_jenis_kamar_avg_sepi',
        'hotel_jenis_kamar_potensi_pajak',
    ];
}
