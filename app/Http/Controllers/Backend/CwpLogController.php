<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\CwpLog;

class CwpLogController extends Controller
{
    public function index()
    {
        return view('backend.cwp-log.index');
    }
}
