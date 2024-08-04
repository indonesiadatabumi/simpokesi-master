<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Parkir extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'parkir_pemilik',
        'parkir_npwpd',
        'parkir_nama',
        'parkir_alamat',
        'parkir_kecamatan',
        'parkir_kelurahan',
        'parkir_rt',
        'parkir_rw',
        'parkir_srp_mobil',
        'parkir_srp_motor',
        'parkir_tarif_mobil',
        'parkir_tarif_motor',
        'parkir_durasi_avg',
        'parkir_potensi_pajak',
        'parkir_potensi_pajak_motor',
        'parkir_potensi_pajak_mobil',
        'parkir_persentase_pajak',
        'parkir_telepon',
        'parkir_foto',
        'status_aktif_id',
        'parkir_latitude',
        'parkir_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function tingkat_kunjungan()
    {
        return $this->hasOne(ParkirTingkatKunjunganAvg::class, 'parkir_id', 'id');
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
