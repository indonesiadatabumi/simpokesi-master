<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kecamatan extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'kecamatan'
    ];

    public function kelurahan()
    {
        return $this->hasMany(Kelurahan::class, 'kecamatan_id', 'id');
    }

    public function hotel()
    {
        return $this->hasMany(Hotel::class, 'hotel_kecamatan', 'kecamatan');
    }

    public function restoran()
    {
        return $this->hasMany(Restoran::class, 'restoran_kecamatan', 'kecamatan');
    }

    public function kostan()
    {
        return $this->hasMany(Kostan::class, 'kostan_kecamatan', 'kecamatan');
    }

    public function rusun()
    {
        return $this->hasMany(Rusun::class, 'rusun_kecamatan', 'kecamatan');
    }

    public function hiburan()
    {
        return $this->hasMany(Hiburan::class, 'hiburan_kecamatan', 'kecamatan');
    }

    public function parkir()
    {
        return $this->hasMany(Parkir::class, 'parkir_kecamatan', 'kecamatan');
    }
}
