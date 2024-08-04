<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

class RekapitulasiDokumenLainService
{
    public function getRecapitulation($jenisDokumenId)
    {
        $kecamatans = DB::table('kecamatans')
            ->select(['kecamatans.*'])
            ->orderBy('kecamatan', 'asc')->get('kecamatan');

        $data = [];
        foreach ($kecamatans as $key => $row) {
            $data[$key]['kecamatan'] = $row->kecamatan;
            $data[$key]['rekapitulasi'] = DB::table('dokumen_lains')
                ->select([
                    DB::raw('YEAR(dokumen_lain_tanggal) as tahun'),
                    DB::raw('count(YEAR(dokumen_lain_tanggal)) as jumlah'),
                    DB::raw('SUM(YEAR(dokumen_lain_tanggal) IS NULL) as jumlah_null')
                ])
                ->groupBy(DB::raw('YEAR(dokumen_lain_tanggal)'))
                ->where('jenis_dokumen_id', $jenisDokumenId)
                ->where(DB::raw('UPPER(dokumen_lain_kecamatan)'), $row->kecamatan)
                ->whereNull('deleted_at')
                ->orderBy(DB::raw('YEAR(dokumen_lain_tanggal)'), 'asc')->get()->toArray();
        }

        $data[$key+1]['kecamatan'] = 'TIDAK TERINDETIFIKASI';
        $data[$key+1]['rekapitulasi'] = DB::table('dokumen_lains')
            ->select([
                DB::raw('YEAR(dokumen_lain_tanggal) as tahun'),
                DB::raw('count(YEAR(dokumen_lain_tanggal)) as jumlah'),
                DB::raw('SUM(YEAR(dokumen_lain_tanggal) IS NULL) as jumlah_null')
            ])
            ->groupBy(DB::raw('YEAR(dokumen_lain_tanggal)'))
            ->where('jenis_dokumen_id', $jenisDokumenId)
            ->whereNotIn(DB::raw('UPPER(dokumen_lain_kecamatan)'), $kecamatans->pluck('kecamatan')->toArray())
            ->whereNull('deleted_at')
            ->orderBy(DB::raw('YEAR(dokumen_lain_tanggal)'), 'asc')->get()->toArray();

        return $data;
    }
}
