<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AirKlasifikasi extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'air_klasifikasi_deskripsi',
    ];
}
