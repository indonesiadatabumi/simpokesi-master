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
        
        $jenisHiburans = HiburanJenis::orderBy('hiburan_jenis_have_ruangan')->get();
        View::share('jenisHiburans', $jenisHiburans);
    }
}
