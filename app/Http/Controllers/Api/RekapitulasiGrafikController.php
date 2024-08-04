<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Kecamatan;
use App\Models\Kostan;
use App\Models\Restoran;
use App\Models\Rusun;
use App\Models\Hiburan;
use App\Models\Parkir;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RekapitulasiGrafikController extends Controller
{
    public function getChartAll(Request $request)
    {
        $potensi_pajak = [
            'hotel' => ['Hotel', 'hotel', '#f8d62b'],
            'restoran_notcwp' => ['Restoran', 'restoran_notcwp', '#eb7f20'],
            'restoran_cwp' => ['Calon Wajib Pajak Restoran', 'restoran_cwp', '#20b7eb'],
            'kostan' => ['Kosan', 'kostan', '#dc3545'],
            'rusun' => ['Rusun', 'rusun', '#000222'],
            'hiburan' => ['Hiburan', 'hiburan', '#3949ab'],
            'parkir' => ['Parkir', 'parkir', '#666666'],
        ];

        $kecamatans = Kecamatan::orderBy('kecamatan', 'asc')->get()->pluck('kecamatan')->toArray();

        $series = [];
        foreach ($potensi_pajak as $row) {
            $tableName = str_replace('_notcwp', '', str_replace('_cwp', '', $row[1]));
            $dataSum = DB::table($tableName.'s')->select([
                DB::raw('UPPER('.$tableName.'s.'.$tableName.'_kecamatan) as kecamatan'),
                DB::raw('SUM('.$tableName.'s.'.$tableName.'_potensi_pajak) as jumlah_dokumen')
            ])->when(str_contains($row[1], '_cwp'), function($q) use($tableName){
                $q->where($tableName.'_is_cwp', true);
            })
            ->when(str_contains($row[1], '_notcwp'), function($q) use($tableName){
                $q->where($tableName.'_is_cwp', false);
            });
            
            if(@$request->tahun) { 
                $dataSum = $dataSum->whereYear('created_at', $request->tahun);
            }

            $dataSum = $dataSum->whereNull('deleted_at')->where('status_aktif_id', 1)->groupBy('kecamatan');

            $dataKecamatan = DB::table('kecamatans')
                ->select([
                    'kecamatans.kecamatan',
                    'jumlah_dokumen'
                ])
                ->leftJoinSub($dataSum, 'sum_potensi_pajak', function ($join) {
                    $join->on('kecamatans.kecamatan', '=', 'sum_potensi_pajak.kecamatan');
                })
                ->orderBy('kecamatans.kecamatan', 'asc')
                ->groupBy(['kecamatans.kecamatan', 'jumlah_dokumen'])->get()->toArray();

            $dataUndefined = DB::table($tableName.'s')
                ->whereNotIn(DB::raw('upper('.$tableName.'_kecamatan)'), $kecamatans)
                ->orWhereNull($tableName.'_kecamatan')
                ->when(str_contains($row[1], '_cwp'), function($q) use($tableName){
                    $q->where($tableName.'_is_cwp', true);
                })
                ->when(str_contains($row[1], '_notcwp'), function($q) use($tableName){
                    $q->where($tableName.'_is_cwp', false);
                });
            
            if(@$request->tahun) { 
                $dataUndefined = $dataUndefined->whereYear('created_at', $request->tahun);
            }
                
            $dataUndefined = $dataUndefined->whereNull('deleted_at')->where('status_aktif_id', 1)->sum($tableName.'_potensi_pajak');
            $dataSeries = array_column($dataKecamatan, 'jumlah_dokumen');
            $dataSeries[12] = $dataUndefined;

            $series[] = [
                'name' => $row[0],
                'type' => 'bar',
                'stack' => 'total',
                'color' => $row[2],
                'label' => [
                    'show' => false
                ],
                'emphasis' => [
                    'focus' => 'series'
                ],
                'data' => $dataSeries
            ];
        }

        $kecamatans[] = 'TIDAK TERIDENTIFIKASI';

        return response()->json([
            'success' => true,
            'categories' => $kecamatans,
            'series' => $series,
            'legends' => array_column($potensi_pajak, 0)
        ]);
    }

    public function getChartKecamatan(Request $request)
    {
        $data[0] = ['Kecamatan', 'Hotel', 'Restoran', 'Calon Wajib Pajak Restoran', 'Kosan', 'Rusun', 'Hiburan', 'Parkir'];

        if (@$request->kecamatan_id) {
            $kecamatanId = $request->kecamatan_id;

            if ($kecamatanId === 'null') {
                $kecamatans = Kecamatan::get()->pluck('kecamatan')->toArray();

                $data[1] = [
                    'TIDAK TERIDENTIFIKASI',
                    Hotel::whereNotIn(DB::raw('upper(hotel_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('hotel_kecamatan')->where('status_aktif_id', 1)->sum('hotel_potensi_pajak'),
                    Restoran::whereNotIn(DB::raw('upper(restoran_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->where('restoran_is_cwp', false)->orWhereNull('restoran_kecamatan')->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                    Restoran::whereNotIn(DB::raw('upper(restoran_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->where('restoran_is_cwp', true)->orWhereNull('restoran_kecamatan')->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                    Kostan::whereNotIn(DB::raw('upper(kostan_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('kostan_kecamatan')->where('status_aktif_id', 1)->sum('kostan_potensi_pajak'),
                    Rusun::whereNotIn(DB::raw('upper(rusun_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('rusun_kecamatan')->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                    Hiburan::whereNotIn(DB::raw('upper(hiburan_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('hiburan_kecamatan')->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                    Parkir::whereNotIn(DB::raw('upper(parkir_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('parkir_kecamatan')->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                ];
            } else {
                $kecamatan = Kecamatan::find($kecamatanId);

                if (empty($kecamatan)) {
                    return response()->json(['success' => false, 'message' => 'Kecamatan tidak ditemukan.']);
                }

                if (@$request->tahun) {
                    $data[1] = [
                        $kecamatan->kecamatan,
                        $kecamatan->hotel()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('hotel_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', false)->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', true)->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->kostan()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('kostan_potensi_pajak'),
                        $kecamatan->rusun()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                        $kecamatan->hiburan()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                        $kecamatan->parkir()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                    ];
                } else {
                    $data[1] = [
                        $kecamatan->kecamatan,
                        $kecamatan->hotel()->where('status_aktif_id', 1)->sum('hotel_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', false)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', true)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->kostan()->where('status_aktif_id', 1)->sum('kostan_potensi_pajak'),
                        $kecamatan->rusun()->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                        $kecamatan->hiburan()->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                        $kecamatan->parkir()->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                    ];
                }
            }

            return response()->json([
                'success' => true,
                'source' => $data
            ]);
        } else {
            return response()->json(['success' => false, 'message' => 'Input kurang lengkap.']);
        }
    }
}
