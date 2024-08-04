<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanTarif extends Model
{
    protected $table = 'hiburan_tarifs';
    public $timestamps = false;
    protected $fillable = [
        'hiburan_jenis_id',
        'hiburan_tarif_deskripsi',
        'hiburan_tarif_type',
    ];

    public function hiburan_jenis()
    {
        return $this->hasOne(HiburanJenis::class, 'id', 'hiburan_jenis_id');
    }
}
