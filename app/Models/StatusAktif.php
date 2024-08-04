<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StatusAktif extends Model
{
    // NOTE!
    // On table should have at least this data:
    // 1 = aktif
    // 2 = tidak aktif (sementara)
    // 3 = tidak aktif (permanen)
    // 4 = belum verifikasi

    public $timestamps = false;
    protected $fillable = [
        'status_aktif_deskripsi'
    ];

    public function hotels()
    {
        return $this->hasMany(Hotel::class);
    }

    public function kostans()
    {
        return $this->hasMany(Kostan::class);
    }

    public function rusuns()
    {
        return $this->hasMany(Rusun::class);
    }

    public function restorans()
    {
        return $this->hasMany(Restoran::class);
    }
}
