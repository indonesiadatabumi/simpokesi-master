<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HiburanKategori extends Model
{
    protected $table = 'hiburan_kategoris';
    public $timestamps = false;
    protected $fillable = [
        'hiburan_kategori_deskripsi',
        'hiburan_kategori_persentase',
    ];
}
