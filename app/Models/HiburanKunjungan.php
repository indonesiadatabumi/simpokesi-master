<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanKunjungan extends Model
{
    protected $table = 'hiburan_kunjungans';
    public $timestamps = false;
    protected $fillable = [
        'hiburan_jenis_id',
        'hiburan_kunjungan_deskripsi',
    ];

    public function hiburan_jenis()
    {
        return $this->hasOne(HiburanJenis::class, 'id', 'hiburan_jenis_id');
    }
}
