<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\UserLog;
use App\Services\UserLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class UserLogController extends Controller
{
    public function jsonDatatable()
    {
        $data = DB::table('user_logs')->select([
            DB::raw('user_logs.id as id'),
            DB::raw('user_logs.created_at as created_at'),
            'username',
            'name',
            'email',
            DB::raw('roles.description as role_description'),
            DB::raw('roles.color as role_color'),
        ])->leftJoin('users', 'users.id', 'user_logs.user_id')
            ->leftJoin('roles', 'roles.id', 'users.role_id')
            ->orderBy('id', 'desc');

        return DataTables::query($data)
            ->editColumn('created_at', function($log) {
                return date('d M Y @ H:i:s', strtotime($log->created_at));
            })
            ->addColumn('label_role', function($log) {
                return '<div class="badge badge-'.$log->role_color.'">
                    '.$log->role_description.'
                </div>';
            })
            ->rawColumns(['label_role'])
            ->toJson();
    }
}
