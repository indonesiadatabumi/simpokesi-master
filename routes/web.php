<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Backend\DashboardController;
use App\Http\Controllers\Backend\PersentasePajakController;
use App\Http\Controllers\Backend\UserContoller;
use App\Http\Controllers\Backend\UserAccessContoller;
use App\Http\Controllers\Backend\UserLogController;
use App\Http\Controllers\Backend\CwpLogController;
use App\Http\Controllers\Backend\HotelController;
use App\Http\Controllers\Backend\HiburanController;
use App\Http\Controllers\Backend\RestoranController;
use App\Http\Controllers\Backend\RestoranCwpController;
use App\Http\Controllers\Backend\ParkirController;
use App\Http\Controllers\Backend\KostanController;
use App\Http\Controllers\Backend\RusunController;
use App\Http\Controllers\Backend\RekapitulasiTabularController;
use App\Http\Controllers\Backend\RekapitulasiGrafikController;
use App\Http\Controllers\Backend\RekapitulasiPetaController;
use App\Http\Controllers\Frontend\LandingController;
use App\Http\Controllers\Frontend\MonitoringPetaController;
use App\Http\Controllers\Frontend\MonitoringGrafikController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes();

// Maintenance mode =========================
// Route::get('/', function() {
//     return redirect('/under-maintenance');
// });
// Route::get('/under-maintenance', function() {
//     return view('errors.under-maintenance');
// });

Route::get('/', [LandingController::class, 'index'])->name('landing.index');
Route::get('/monitoring-peta', [MonitoringPetaController::class, 'index'])->name('monitoring-peta.index');
//Route::get('/monitoring-grafik', [MonitoringGrafikController::class, 'index'])->name('monitoring-grafik.index');

Route::group(['middleware' => 'auth'], function(){
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard.index');
    Route::post('/setting-persentase', [PersentasePajakController::class, 'update'])->name('persentase-pajak.update');
    // Hotel
    Route::post('hotel/import', [HotelController::class, 'import'])->name('hotel.import');
    Route::get('hotel/export', [HotelController::class, 'export'])->name('hotel.export');
    Route::get('hotel/print-potensi-pajak', [HotelController::class, 'printPotensiPajak'])->name('hotel.print-potensi-pajak');
    Route::get('hotel/print-tingkat-hunian', [HotelController::class, 'printTingkatHunian'])->name('hotel.print-tingkat-hunian');
    Route::resource('hotel', HotelController::class);

    // Restoran
    Route::post('restoran/import', [RestoranController::class, 'import'])->name('restoran.import');
    Route::get('restoran/export', [RestoranController::class, 'export'])->name('restoran.export');
    Route::get('restoran/print-potensi-pajak', [RestoranController::class, 'printPotensiPajak'])->name('restoran.print-potensi-pajak');
    Route::get('restoran/print-tingkat-hunian', [RestoranController::class, 'printTingkatKunjungan'])->name('restoran.print-tingkat-kunjungan');
    Route::resource('restoran', RestoranController::class);

    // Restoran CWP
    Route::post('restoran-cwp/import', [RestoranCwpController::class, 'import'])->name('restoran-cwp.import');
    Route::get('restoran-cwp/export', [RestoranCwpController::class, 'export'])->name('restoran-cwp.export');
    Route::get('restoran-cwp/print-potensi-pajak', [RestoranCwpController::class, 'printPotensiPajak'])->name('restoran-cwp.print-potensi-pajak');
    Route::get('restoran-cwp/print-tingkat-hunian', [RestoranCwpController::class, 'printTingkatKunjungan'])->name('restoran-cwp.print-tingkat-kunjungan');
    Route::post('restoran-cwp/{id}/convert', [RestoranCwpController::class, 'convert'])->name('restoran-cwp.convert');
    Route::resource('restoran-cwp', RestoranCwpController::class);
    Route::get('cwp-log', [CwpLogController::class, 'index'])->name('cwp.log');

    // Parkir
    Route::post('parkir/import', [ParkirController::class, 'import'])->name('parkir.import');
    Route::get('parkir/export', [ParkirController::class, 'export'])->name('parkir.export');
    Route::get('parkir/print-potensi-pajak', [ParkirController::class, 'printPotensiPajak'])->name('parkir.print-potensi-pajak');
    Route::get('parkir/print-tingkat-hunian', [ParkirController::class, 'printTingkatKunjungan'])->name('parkir.print-tingkat-kunjungan');
    Route::resource('parkir', ParkirController::class);

    // Kostan
    Route::post('kostan/import', [KostanController::class, 'import'])->name('kostan.import');
    Route::get('kostan/export', [KostanController::class, 'export'])->name('kostan.export');
    Route::get('kostan/print-potensi-pajak', [KostanController::class, 'printPotensiPajak'])->name('kostan.print-potensi-pajak');
    Route::resource('kostan', KostanController::class);

    // Rusun
    Route::post('rusun/import', [RusunController::class, 'import'])->name('rusun.import');
    Route::get('rusun/export', [RusunController::class, 'export'])->name('rusun.export');
    Route::get('rusun/print-retribusi-daerah', [RusunController::class, 'printRetribusiDaerah'])->name('rusun.print-retribusi-daerah');
    Route::resource('rusun', RusunController::class);

    // Hiburan
    Route::post('hiburan/setting-persentase', [HiburanController::class, 'settingPersentase'])->name('hiburan.settingPersentase');
    Route::post('hiburan/import', [HiburanController::class, 'import'])->name('hiburan.import');
    Route::get('hiburan/export', [HiburanController::class, 'export'])->name('hiburan.export');
    Route::get('hiburan/print-potensi-pajak', [HiburanController::class, 'printPotensiPajak'])->name('hiburan.print-potensi-pajak');
    Route::get('hiburan/print-tingkat-kunjungan', [HiburanController::class, 'printTingkatKunjungan'])->name('hiburan.print-tingkat-kunjungan');
    Route::resource('hiburan', HiburanController::class);

    // Rekapitulasi Dokumen Teknis
    Route::get('rekapitulasi-tabular', function() {
        return redirect('rekapitulasi-tabular/hotel');
    });
    Route::get('rekapitulasi-tabular/{jenis}', [RekapitulasiTabularController::class, 'show'])->name('rekapitulasi-tabular.show');
    Route::get('rekapitulasi-tabular/{jenis}/export', [RekapitulasiTabularController::class, 'export'])->name('rekapitulasi-tabular.export');
    Route::get('rekapitulasi-grafik', [RekapitulasiGrafikController::class, 'index'])->name('rekapitulasi-grafik.index');
    Route::get('rekapitulasi-peta', [RekapitulasiPetaController::class, 'index'])->name('rekapitulasi-peta.index');

    Route::resource('users', UserContoller::class)->middleware('can:admin');
    Route::resource('user-accesses', UserAccessContoller::class)->only(['index', 'update'])->middleware('can:user-access');
    Route::get('user-log', [UserLogController::class, 'index'])->name('user.log')->middleware('can:admin');
});

Route::get('/bcrypt', function(){
    return bcrypt('123');
});
