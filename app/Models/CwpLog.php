<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CwpLog extends Model
{
    protected $fillable = [
        'cwp_id',
        'cwp_type',
        'cwp_name',
        'cwp_status',
        'created_by',
        'created_at',
        'updated_at',
    ];

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'created_by');
    }
}
