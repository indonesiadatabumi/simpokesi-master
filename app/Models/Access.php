<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Access extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'access_code',
        'description',
    ];

    public function accesses()
    {
        return $this->hasMany(UserAccess::class, 'access_id', 'id');
    }
}
