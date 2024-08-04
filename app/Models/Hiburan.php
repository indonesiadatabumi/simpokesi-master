<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Hiburan extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'hiburan_jenis_id',
        'hiburan_kategori_id',
        'hiburan_pemilik',
        'hiburan_npwpd',
        'hiburan_nama',
        'hiburan_alamat',
        'hiburan_kecamatan',
        'hiburan_kelurahan',
        'hiburan_rt',
        'hiburan_rw',
        'hiburan_jumlah',
        'hiburan_kapasitas',
        'hiburan_tarif',
        'hiburan_durasi',
        'hiburan_jam_operasional',
        'hiburan_jam_weekdays',
        'hiburan_jam_weekends',
        'hiburan_potensi_pajak',
        'hiburan_persentase_pajak',
        'hiburan_telepon',
        'hiburan_foto',
        'status_aktif_id',
        'hiburan_latitude',
        'hiburan_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function jenis()
    {
        return $this->hasOne(HiburanJenis::class, 'id', 'hiburan_jenis_id');
    }

    public function kategori()
    {
        return $this->hasOne(HiburanKategori::class, 'id', 'hiburan_kategori_id');
    }

    public function jenis_ruangan()
    {
        return $this->hasMany(HiburanJenisRuangan::class, 'hiburan_id', 'id');
    }

    public function tingkat_kunjungan()
    {
        return $this->hasOne(HiburanTingkatKunjunganAvg::class, 'hiburan_id', 'id');
    }

    public function status_aktif()
    {
        return $this->hasOne(StatusAktif::class, 'id', 'status_aktif_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'created_by');
    }

    public function tarif()
    {
        return $this->hasMany(HiburanTarifValue::class, 'hiburan_id', 'id');
    }

    public function kunjungan()
    {
        return $this->hasMany(HiburanKunjunganValue::class, 'hiburan_id', 'id');
    }
}
