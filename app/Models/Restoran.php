<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Restoran extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'restoran_klasifikasi_id',
        'restoran_tipe',
        'restoran_pemilik',
        'restoran_npwpd',
        'restoran_nama',
        'restoran_alamat',
        'restoran_kecamatan',
        'restoran_kelurahan',
        'restoran_rt',
        'restoran_rw',
        'restoran_jumlah_pegawai',
        'restoran_kapasitas_kursi',
        'restoran_pengeluaran_avg',
        'restoran_potensi_pajak',
        'restoran_persentase_pajak',
        'restoran_telepon',
        'restoran_foto',
        'restoran_status_tapping_box',
        'restoran_is_cwp',
        'status_aktif_id',
        'restoran_latitude',
        'restoran_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function klasifikasi()
    {
        return $this->hasOne(RestoranKlasifikasi::class, 'id', 'restoran_klasifikasi_id');
    }

    public function tingkat_kunjungan()
    {
        return $this->hasOne(RestoranTingkatKunjunganAvg::class, 'restoran_id', 'id');
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
