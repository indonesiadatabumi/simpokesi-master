<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Kostan extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'kostan_pemilik',
        'kostan_npwpd',
        'kostan_nama',
        'kostan_alamat',
        'kostan_kecamatan',
        'kostan_kelurahan',
        'kostan_rt',
        'kostan_rw',
        'kostan_jumlah_pegawai',
        'kostan_potensi_pajak',
        'kostan_persentase_pajak',
        'kostan_telepon',
        'kostan_foto',
        'status_aktif_id',
        'kostan_latitude',
        'kostan_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function jenis_kamar()
    {
        return $this->hasMany(KostanJenisKamar::class, 'kostan_id', 'id');
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
