<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanKunjunganValue extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'hiburan_id',
        'hiburan_kunjungan_id',
        'hiburan_kunjungan_weekends_value',
        'hiburan_kunjungan_weekdays_value',
    ];

    public function hiburan()
    {
        return $this->hasOne(Hiburan::class, 'id', 'hiburan_id');
    }

    public function hiburan_kunjungan()
    {
        return $this->hasOne(HiburanKunjungan::class, 'id', 'hiburan_kunjungan_id');
    }
}
