<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PeneranganKlasifikasi extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'penerangan_klasifikasi_deskripsi',
    ];
}
