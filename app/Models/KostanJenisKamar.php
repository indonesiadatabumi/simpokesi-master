<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KostanJenisKamar extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'kostan_id',
        'kostan_jenis_kamar_deskripsi',
        'kostan_jenis_kamar_tarif',
        'kostan_jenis_kamar_jumlah',
        'kostan_jenis_kamar_hunian_avg',
        'kostan_jenis_kamar_potensi_pajak',
    ];
}
