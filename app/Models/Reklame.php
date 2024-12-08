<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Reklame extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'nama_objek',
        'rekening_objek',
        'alamat_objek',
        'kecamatan',
        'kelurahan',
        'npwpd',
        'no_permohonan',
        'nama',
        'nama_badan',
        'fasilitas',
        'nama_pihak_lain',
        'lama_operasional',
        'email',
        'website',
        'sosmed',
        'telp_kantor',
        'telp_manajemen',
        'no_fax',
        'pengukuhan_npwpd',
        'perijinan',
        'potensi_pajak',
        'persentase_pajak',
        'foto',
        'status_aktif_id',
        'latitude',
        'longitude',
        'created_by',
        'created_at',
        'updated_at',
        'deleted_at',
        'klasifikasi_id'        
    ];

    public function klasifikasi()
    {
        return $this->hasOne(ReklameKlasifikasi::class, 'id', 'klasifikasi_id');
    }
/*
    public function jenis_kamar()
    {
        return $this->hasMany(ReklameJenisKamar::class, 'reklame_id', 'id');
    }

    public function tingkat_hunian()
    {
        return $this->hasOne(ReklameTingkatHunianAvg::class, 'reklame_id', 'id');
    }
*/
    public function status_aktif()
    {
        return $this->hasOne(StatusAktif::class, 'id', 'status_aktif_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'created_by');
    }
}
