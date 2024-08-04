<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanTingkatKunjunganAvg extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hiburan_id',
        'tingkat_kunjungan_weekends',
        'tingkat_kunjungan_weekdays',
        'situasi_kunjungan_weekends',
        'situasi_kunjungan_weekdays',
    ];
}
