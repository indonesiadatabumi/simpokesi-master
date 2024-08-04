<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kelurahan extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'kecamatan_id',
        'kelurahan',
        'kode_pos',
        'default_latitude',
        'default_longitude',
    ];

    public function kecamatan()
    {
        return $this->hasOne(Kecamatan::class, 'id', 'kecamatan_id');
    }
}
