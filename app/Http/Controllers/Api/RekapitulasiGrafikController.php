<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Kecamatan;
use App\Models\Restoran;
use App\Models\Rusun;
use App\Models\Hiburan;
use App\Models\Parkir;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Air;
use App\Models\Reklame;
use App\Models\Penerangan;

class RekapitulasiGrafikController extends Controller
{
    public function getChartAll(Request $request)
    {
        $potensi_pajak = [
            'hotel' => ['PBJT Jasa Perhotelan', 'hotel', '#f8d62b'],
            'restoran_notcwp' => ['PBJT Makanan dan/atau Minuman', 'restoran_notcwp', '#eb7f20'],
            'restoran_cwp' => ['PBJT Calon Wajib Pajak Makanan dan/atau Minuman', 'restoran_cwp', '#20b7eb'],
            'rusun' => ['Rusun', 'rusun', '#000222'],
            'hiburan' => ['PBJT Jasa Kesenian dan Hiburan', 'hiburan', '#3949ab'],
            'parkir' => ['PBJT Jasa Parkir', 'parkir', '#666666'],
            'air' => ['Air Bawah Tanah', 'air', '#dc35df'],
            'reklame' => ['Reklame', 'reklame', '#dc9945'],
            'penerangan' => ['PBJT Penerangan Jalan', 'penerangan', '#22ff45'],
        ];

        $kecamatans = Kecamatan::orderBy('kecamatan', 'asc')->get()->pluck('kecamatan')->toArray();

        $series = [];
        foreach ($potensi_pajak as $row) {
            $tableName = str_replace('_notcwp', '', str_replace('_cwp', '', $row[1]));
            $pre_table=($tableName=='air'||$tableName=='reklame'||$tableName=='penerangan'?'':$tableName.'_');
            $dataSum = DB::table($tableName.'s')->select([
                DB::raw('UPPER('.$tableName.'s.'.$pre_table.'kecamatan) as kecamatan'),
                DB::raw('SUM('.$tableName.'s.'.$pre_table.'potensi_pajak) as jumlah_dokumen')
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
                ->whereNotIn(DB::raw('upper('.$pre_table.'kecamatan)'), $kecamatans)
                ->orWhereNull($pre_table.'kecamatan')
                ->when(str_contains($row[1], '_cwp'), function($q) use($tableName){
                    $q->where($tableName.'_is_cwp', true);
                })
                ->when(str_contains($row[1], '_notcwp'), function($q) use($tableName){
                    $q->where($tableName.'_is_cwp', false);
                });
            
            if(@$request->tahun) { 
                $dataUndefined = $dataUndefined->whereYear('created_at', $request->tahun);
            }
                
            $dataUndefined = $dataUndefined->whereNull('deleted_at')->where('status_aktif_id', 1)->sum($pre_table.'potensi_pajak');
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
        $data[0] = ['Kecamatan', 'PBJT Jasa Perhotelan', 'PBJT Makanan dan/atau Minuman', 'PBJT Calon Wajib Pajak Makanan dan/atau Minuman', 'Rusun', 'PBJT Jasa Kesenian dan Hiburan', 'PBJT Jasa Parkir','Air Bawah Tanah','Reklame','PBJT Penerangan Jalan'];

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
                    Rusun::whereNotIn(DB::raw('upper(rusun_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('rusun_kecamatan')->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                    Hiburan::whereNotIn(DB::raw('upper(hiburan_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('hiburan_kecamatan')->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                    Parkir::whereNotIn(DB::raw('upper(parkir_kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('parkir_kecamatan')->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                    Air::whereNotIn(DB::raw('upper(kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('kecamatan')->where('status_aktif_id', 1)->sum('potensi_pajak'),
                    Reklame::whereNotIn(DB::raw('upper(kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('kecamatan')->where('status_aktif_id', 1)->sum('potensi_pajak'),
                    Penerangan::whereNotIn(DB::raw('upper(kecamatan)'), $kecamatans)->when(@$request->tahun, function($q) use($request){
                        $q->where('created_at', $request->tahun);
                    })->orWhereNull('kecamatan')->where('status_aktif_id', 1)->sum('potensi_pajak'),
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
                        $kecamatan->rusun()->whereYear('crepenerangant', $request->tahun)->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                        $kecamatan->hiburan()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                        $kecamatan->parkir()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                        $kecamatan->air()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('potensi_pajak'),
                        $kecamatan->reklame()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('potensi_pajak'),
                        $kecamatan->penerangan()->whereYear('created_at', $request->tahun)->where('status_aktif_id', 1)->sum('potensi_pajak'),
                    ];
                } else {
                    $data[1] = [
                        $kecamatan->kecamatan,
                        $kecamatan->hotel()->where('status_aktif_id', 1)->sum('hotel_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', false)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->restoran()->where('restoran_is_cwp', true)->where('status_aktif_id', 1)->sum('restoran_potensi_pajak'),
                        $kecamatan->rusun()->where('status_aktif_id', 1)->sum('rusun_potensi_pajak'),
                        $kecamatan->hiburan()->where('status_aktif_id', 1)->sum('hiburan_potensi_pajak'),
                        $kecamatan->parkir()->where('status_aktif_id', 1)->sum('parkir_potensi_pajak'),
                        $kecamatan->air()->where('status_aktif_id', 1)->sum('potensi_pajak'),
                        $kecamatan->reklame()->where('status_aktif_id', 1)->sum('potensi_pajak'),
                        $kecamatan->penerangan()->where('status_aktif_id', 1)->sum('potensi_pajak'),
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
