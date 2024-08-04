<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Hotel extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'hotel_klasifikasi_id',
        'hotel_pemilik',
        'hotel_npwpd',
        'hotel_nama',
        'hotel_alamat',
        'hotel_kecamatan',
        'hotel_kelurahan',
        'hotel_rt',
        'hotel_rw',
        'hotel_jumlah_pegawai',
        'hotel_potensi_pajak',
        'hotel_persentase_pajak',
        'hotel_telepon',
        'hotel_foto',
        'hotel_status_tapping_box',
        'status_aktif_id',
        'hotel_latitude',
        'hotel_longitude',
        'created_by',
        'created_at',
        'updated_at'
    ];

    public function klasifikasi()
    {
        return $this->hasOne(HotelKlasifikasi::class, 'id', 'hotel_klasifikasi_id');
    }

    public function jenis_kamar()
    {
        return $this->hasMany(HotelJenisKamar::class, 'hotel_id', 'id');
    }

    public function tingkat_hunian()
    {
        return $this->hasOne(HotelTingkatHunianAvg::class, 'hotel_id', 'id');
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
