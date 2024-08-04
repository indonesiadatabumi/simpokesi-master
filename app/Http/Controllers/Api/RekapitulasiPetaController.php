<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Kecamatan;
use App\Models\Kostan;
use App\Models\Restoran;
use App\Models\Rusun;
use App\Models\Parkir;
use App\Models\Hiburan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RekapitulasiPetaController extends Controller
{
    public function getMapAll()
    {
        $tahun = request()->tahun;
        $kecamatan = @request()->kecamatan;

        $markers = [
            'hotel' => Hotel::whereNotNull('hotel_latitude')
                ->whereNotNull('hotel_longitude')
                ->where('status_aktif_id', 1)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(hotel_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'hotel_latitude', 'hotel_longitude']),
            'restoran_notcwp' => Restoran::whereNotNull('restoran_latitude')
                ->whereNotNull('restoran_longitude')
                ->where('restoran_latitude', '!=', '-')
                ->where('restoran_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->where('restoran_is_cwp', false)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(restoran_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'restoran_latitude', 'restoran_longitude']),
            'restoran_cwp' => Restoran::whereNotNull('restoran_latitude')
                ->whereNotNull('restoran_longitude')
                ->where('restoran_latitude', '!=', '-')
                ->where('restoran_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->where('restoran_is_cwp', true)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(restoran_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'restoran_latitude', 'restoran_longitude']),
            'kostan' => Kostan::whereNotNull('kostan_latitude')
                ->whereNotNull('kostan_longitude')
                ->where('kostan_latitude', '!=', '-')
                ->where('kostan_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(kostan_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'kostan_latitude', 'kostan_longitude']),
            'rusun' => Rusun::whereNotNull('rusun_latitude')
                ->whereNotNull('rusun_longitude')
                ->where('rusun_latitude', '!=', '-')
                ->where('rusun_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(rusun_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'rusun_latitude', 'rusun_longitude']),
            'hiburan' => Hiburan::whereNotNull('hiburan_latitude')
                ->whereNotNull('hiburan_longitude')
                ->where('hiburan_latitude', '!=', '-')
                ->where('hiburan_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(hiburan_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'hiburan_latitude', 'hiburan_longitude']),
            'parkir' => Parkir::whereNotNull('parkir_latitude')
                ->whereNotNull('parkir_longitude')
                ->where('parkir_latitude', '!=', '-')
                ->where('parkir_longitude', '!=', '-')
                ->where('status_aktif_id', 1)
                ->whereYear('created_at', $tahun)
                ->when($kecamatan, function ($query, $kecamatan) {
                    return $query->where(DB::raw('UPPER(parkir_kecamatan)'), $kecamatan);
                })
                ->get(['id', 'parkir_latitude', 'parkir_longitude']),
        ];

        return response()->json([
            'success' => true,
            'markers' => $markers
        ]);
    }

    public function getMapDetail($jenis, $id)
    {
        $private = false;

        if (@$_GET['private-key']) {
            if ($_GET['private-key'] === '91dh379821gdgu3if298f493gf34onis8fe92ffoiu4f9s87dfo23ri3') {
                $private = true;
            }
        }

        $data['jenis_nomor'] = [
            'hotel' => 'hotel_nama',
            'restoran_notcwp' => 'restoran_nama',
            'restoran_cwp' => 'restoran_nama',
            'kostan' => 'kostan_nama',
            'rusun' => 'rusun_nama',
            'hiburan' => 'hiburan_nama',
            'parkir' => 'parkir_nama',
        ];

        $tableName = str_replace('_notcwp', '', str_replace('_cwp', '', $jenis));
        $data['dokumen'] = DB::table($tableName.'s')->where($tableName.'s.id', $id)
            ->select([
                DB::raw('*'),
                DB::raw($tableName.'s.id as id')
            ])->whereNull('deleted_at')->first();

        if (@$data['dokumen']) {
            $data['jenis'] = $tableName;
            $data['private'] = $private;
            $data['dokumen'] = json_decode(json_encode($data['dokumen']), true);

            return view('backend.rekapitulasi-peta.popup', $data);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak ditemukan.'
            ]);
        }
    }
}
