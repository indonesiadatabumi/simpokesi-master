<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Rusun extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'rusun_pemilik',
        'rusun_npwpd',
        'rusun_nama',
        'rusun_alamat',
        'rusun_kecamatan',
        'rusun_kelurahan',
        'rusun_rt',
        'rusun_rw',
        'rusun_jumlah_pegawai',
        'rusun_potensi_pajak',
        'rusun_telepon',
        'rusun_foto',
        'status_aktif_id',
        'rusun_latitude',
        'rusun_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function jenis_kamar()
    {
        return $this->hasMany(RusunJenisKamar::class, 'rusun_id', 'id');
    }

    public function status_aktif()
    {
        return $this->hasOne(StatusAktif::class, 'id', 'status_aktif_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'created_by');
    }
}
