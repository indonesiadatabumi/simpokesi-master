<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CwpLog;
use App\Services\CwpLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class CwpLogController extends Controller
{
    public function jsonDatatable()
    {
        $data = DB::table('cwp_logs')->select([
            DB::raw('cwp_logs.id as id'),
            DB::raw('cwp_logs.cwp_status as cwp_status'),
            DB::raw('cwp_logs.cwp_type as cwp_type'),
            DB::raw('cwp_logs.cwp_name as cwp_name'),
            DB::raw('cwp_logs.cwp_id as cwp_id'),
            DB::raw('cwp_logs.created_at as created_at'),
            DB::raw('users.name as name'),
        ])->leftJoin('users', 'users.id', 'cwp_logs.created_by')
            ->orderBy('id', 'desc');

        return DataTables::query($data)
            ->editColumn('cwp_type', function($log) {
                return ucfirst(@$log->cwp_type);
            })
            ->editColumn('created_at', function($log) {
                return date('d-M-Y @ h:i:s', strtotime($log->created_at)) . '<br>Oleh: ' . @$log->name;
            })
            ->addColumn('action', function($log) {
                $content['log'] = $log;
                return view('datatables.cwp-log.action', $content);
            })
            ->rawColumns(['created_at', 'action'])
            ->toJson();
    }
}
