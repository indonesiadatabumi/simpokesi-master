<?php

namespace App\Providers;

use App\Models\PersentasePajak;
use App\Models\HiburanJenis;
use Carbon\Carbon;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {

        setlocale(LC_TIME, 'id_ID');
        Carbon::setLocale('id');

        $persentasePajak = PersentasePajak::first();
        View::share('currentPersentasePajak', $persentasePajak->persentase);
        
        $jenisHiburans = HiburanJenis::orderBy('hiburan_jenis_have_ruangan')
        ->where('hiburan_jenis_deskripsi','not like','Olahraga Permainan%')
        ->get();
        $jenisHiburanPermainans = HiburanJenis::selectRaw("id,replace(replace(hiburan_jenis_deskripsi,')',''),'Olahraga Permainan (','') as hiburan_jenis_deskripsi")
        ->where('hiburan_jenis_deskripsi','like','Olahraga Permainan%')
        ->get();
        //die(json_encode($jenisHiburanPermainans));
        View::share('jenisHiburans', $jenisHiburans);
        View::share('jenisHiburanPermainans', $jenisHiburanPermainans);
    }
}
