<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RusunJenisKamar extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'rusun_id',
        'rusun_jenis_kamar_deskripsi',
        'rusun_jenis_kamar_tarif',
        'rusun_jenis_kamar_jumlah',
        'rusun_jenis_kamar_hunian_avg',
        'rusun_jenis_kamar_potensi_pajak',
    ];
}
