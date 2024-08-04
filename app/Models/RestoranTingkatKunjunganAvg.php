<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RestoranTingkatKunjunganAvg extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'restoran_id',
        'situasi_kunjungan_sepi',
        'situasi_kunjungan_normal',
        'situasi_kunjungan_ramai',
        'avg_kunjungan_sepi',
        'avg_kunjungan_normal',
        'avg_kunjungan_ramai',
    ];
}
