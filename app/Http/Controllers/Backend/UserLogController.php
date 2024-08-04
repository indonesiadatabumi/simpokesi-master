<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\UserLog;

class UserLogController extends Controller
{
    public function index()
    {
        return view('backend.user-log.index');
    }
}
