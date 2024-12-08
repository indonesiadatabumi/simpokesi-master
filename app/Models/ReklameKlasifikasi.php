<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReklameKlasifikasi extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'reklame_klasifikasi_deskripsi',
    ];
}
