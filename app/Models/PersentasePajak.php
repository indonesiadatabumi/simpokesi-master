<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PersentasePajak extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'persentase'
    ];
}
