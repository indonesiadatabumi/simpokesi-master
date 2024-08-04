<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanTarifValue extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hiburan_id',
        'hiburan_tarif_id',
        'hiburan_tarif_value',
    ];

    public function hiburan()
    {
        return $this->hasOne(Hiburan::class, 'id', 'hiburan_id');
    }

    public function hiburan_tarif()
    {
        return $this->hasOne(HiburanTarif::class, 'id', 'hiburan_tarif_id');
    }
}
