<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RestoranKlasifikasi extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'restoran_klasifikasi_deskripsi',
    ];
}
