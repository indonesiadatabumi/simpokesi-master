<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

class RekapitulasiTabularService
{
    public function getRecapitulation($selectedDokumen)
    {
        $kecamatans = DB::table('kecamatans')
            ->select(['kecamatans.*'])
            ->orderBy('kecamatan', 'asc')->get('kecamatan');
        $tableName = str_replace('_notcwp', '', str_replace('_cwp', '', $selectedDokumen[1]));

        $data = [];
        foreach ($kecamatans as $key => $row) {
            $data[$key]['kecamatan'] = $row->kecamatan;
            $data[$key]['id'] = $row->id;
            $data[$key]['rekapitulasi'] = DB::table($tableName.'s')
                ->select([
                    DB::raw('YEAR(created_at) as tahun'),
                    DB::raw('COUNT(id) as jumlah_wp'),
                    DB::raw('SUM('.$tableName.'_potensi_pajak) as jumlah'),
                    DB::raw('SUM(YEAR(created_at) IS NULL) as jumlah_null')
                ])
                ->groupBy(DB::raw('YEAR(created_at)'))
                ->when(str_contains($selectedDokumen[1], '_cwp'), function($q) use($selectedDokumen, $tableName){
                    $q->where($tableName.'_is_cwp', true);
                })
                ->when(str_contains($selectedDokumen[1], '_notcwp'), function($q) use($selectedDokumen, $tableName){
                    $q->where($tableName.'_is_cwp', false);
                })
                ->where(DB::raw('UPPER('.$tableName.'_kecamatan)'), $row->kecamatan)
                ->whereNull('deleted_at')
                ->orderBy(DB::raw('YEAR(created_at)'), 'asc')->get()->toArray();
        }

        $data[$key+1]['kecamatan'] = 'TIDAK TERINDETIFIKASI';
        $data[$key+1]['id'] = '';
        $data[$key+1]['rekapitulasi'] = DB::table($tableName.'s')
            ->select([
                DB::raw('YEAR(created_at) as tahun'),
                DB::raw('COUNT(id) as jumlah_wp'),
                DB::raw('SUM('.$tableName.'_potensi_pajak) as jumlah'),
                DB::raw('SUM(YEAR(created_at) IS NULL) as jumlah_null')
            ])
            ->groupBy(DB::raw('YEAR(created_at)'))
            ->when(str_contains($selectedDokumen[1], '_cwp'), function($q) use($selectedDokumen, $tableName){
                $q->where($tableName.'_is_cwp', true);
            })
            ->when(str_contains($selectedDokumen[1], '_notcwp'), function($q) use($selectedDokumen, $tableName){
                $q->where($tableName.'_is_cwp', false);
            })
            ->whereNotIn(DB::raw('UPPER('.$tableName.'_kecamatan)'), $kecamatans->pluck('kecamatan')->toArray())
            ->orWhereNull($tableName.'_kecamatan')
            ->whereNull('deleted_at')
            ->orderBy(DB::raw('YEAR(created_at)'), 'asc')->get()->toArray();

        return $data;
    }
}
