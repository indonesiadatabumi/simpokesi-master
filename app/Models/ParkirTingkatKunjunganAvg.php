<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ParkirTingkatKunjunganAvg extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'parkir_id',
        'mobil_situasi_kunjungan_sepi',
        'mobil_situasi_kunjungan_normal',
        'mobil_situasi_kunjungan_ramai',
        'mobil_avg_kunjungan_sepi',
        'mobil_avg_kunjungan_normal',
        'mobil_avg_kunjungan_ramai',
        'motor_situasi_kunjungan_sepi',
        'motor_situasi_kunjungan_normal',
        'motor_situasi_kunjungan_ramai',
        'motor_avg_kunjungan_sepi',
        'motor_avg_kunjungan_normal',
        'motor_avg_kunjungan_ramai',
    ];
}
