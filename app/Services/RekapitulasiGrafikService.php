<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

class RekapitulasiGrafikService
{
    public function getRecapitulation($selectedDokumen)
    {
        $kecamatans = DB::table('kecamatans')
            ->select(['kecamatans.*'])
            ->orderBy('kecamatan', 'asc')->get('kecamatan');

        $data = [];
        foreach ($kecamatans as $key => $row) {
            $data[$key]['kecamatan'] = $row->kecamatan;
            $data[$key]['rekapitulasi'] = DB::table($selectedDokumen[2].'s')
                ->select([
                    DB::raw('YEAR('.$selectedDokumen[1].') as tahun'),
                    DB::raw('count(YEAR('.$selectedDokumen[1].')) as jumlah'),
                    DB::raw('SUM(YEAR('.$selectedDokumen[1].') IS NULL) as jumlah_null')
                ])
                ->groupBy(DB::raw('YEAR('.$selectedDokumen[1].')'))
                ->where(DB::raw('UPPER('.$selectedDokumen[2].'_kecamatan)'), $row->kecamatan)
                ->whereNull('deleted_at')
                ->orderBy(DB::raw('YEAR('.$selectedDokumen[1].')'), 'asc')->get()->toArray();
        }

        $data[$key+1]['kecamatan'] = 'TIDAK TERINDETIFIKASI';
        $data[$key+1]['rekapitulasi'] = DB::table($selectedDokumen[2].'s')
            ->select([
                DB::raw('YEAR('.$selectedDokumen[1].') as tahun'),
                DB::raw('count(YEAR('.$selectedDokumen[1].')) as jumlah'),
                DB::raw('SUM(YEAR('.$selectedDokumen[1].') IS NULL) as jumlah_null')
            ])
            ->groupBy(DB::raw('YEAR('.$selectedDokumen[1].')'))
            ->whereNotIn(DB::raw('UPPER('.$selectedDokumen[2].'_kecamatan)'), $kecamatans->pluck('kecamatan')->toArray())
            ->whereNull('deleted_at')
            ->orderBy(DB::raw('YEAR('.$selectedDokumen[1].')'), 'asc')->get()->toArray();

        return $data;
    }
}
