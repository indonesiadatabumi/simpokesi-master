<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserAccess extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'user_id',
        'access_id',
    ];

    public function access()
    {
        return $this->hasOne(Access::class, 'id', 'access_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }
}
