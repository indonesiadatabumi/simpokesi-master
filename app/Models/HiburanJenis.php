<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanJenis extends Model
{
    protected $table = 'hiburan_jenises';
    public $timestamps = false;
    protected $fillable = [
        'hiburan_jenis_deskripsi',
        'hiburan_jenis_persentase',
        'hiburan_jenis_have_ruangan',
        'hiburan_jenis_have_multiple_tarif',
        'hiburan_jenis_have_multiple_kunjungan',
        'hiburan_jenis_slug',
        'hiburan_jenis_jumlah_label',
        'hiburan_jenis_jumlah_unit',
        'hiburan_jenis_jumlah_is_count',
        'hiburan_jenis_kapasitas_label',
        'hiburan_jenis_kapasitas_unit',
        'hiburan_jenis_kunjungan_label',
        'hiburan_jenis_kunjungan_unit',
        'hiburan_jenis_htm_label',
        'hiburan_jenis_htm_unit',
        'hiburan_jenis_durasi_label',
        'hiburan_jenis_durasi_unit',
    ];

    public function kategori()
    {
        return $this->hasMany(HiburanKategori::class, 'hiburan_jenis_id', 'id');
    }

    public function tarif()
    {
        return $this->hasMany(HiburanTarif::class, 'hiburan_jenis_id', 'id');
    }

    public function kunjungan()
    {
        return $this->hasMany(HiburanKunjungan::class, 'hiburan_jenis_id', 'id');
    }
}
