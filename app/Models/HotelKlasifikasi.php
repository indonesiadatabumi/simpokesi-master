<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class HotelKlasifikasi extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hotel_klasifikasi_deskripsi',
    ];
}
