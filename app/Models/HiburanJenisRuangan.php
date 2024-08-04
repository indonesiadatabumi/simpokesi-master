<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanJenisRuangan extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hiburan_id',
        'hiburan_jenis_ruangan_deskripsi',
        'hiburan_jenis_ruangan_tarif',
        'hiburan_jenis_ruangan_jumlah',
        'hiburan_jenis_ruangan_kapasitas',
        'hiburan_jenis_ruangan_avg_weekends',
        'hiburan_jenis_ruangan_avg_weekdays',
        'hiburan_jenis_ruangan_potensi_pajak',
        'hiburan_jenis_ruangan_jam_weekdays',
        'hiburan_jenis_ruangan_jam_weekends',
    ];
}
