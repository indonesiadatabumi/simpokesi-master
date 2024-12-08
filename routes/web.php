<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Backend\DashboardController;
use App\Http\Controllers\Backend\PersentasePajakController;
use App\Http\Controllers\Backend\UserContoller;
use App\Http\Controllers\Backend\UserAccessContoller;
use App\Http\Controllers\Backend\UserLogController;
use App\Http\Controllers\Backend\CwpLogController;
use App\Http\Controllers\Backend\HotelController;
use App\Http\Controllers\Backend\ReklameController;
use App\Http\Controllers\Backend\PeneranganController;
use App\Http\Controllers\Backend\AirController; 
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
use App\Http\Controllers\Backend\NotaDinasContorller;
use App\Http\Controllers\Backend\ReportExportController;
use App\Http\Controllers\Backend\RealisasiPendapatanController;
use App\Http\Controllers\Backend\FileController;

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
    Route::get('hotelkamar/{id}', [HotelController::class, 'kamar']);
    Route::get('hotelkamar/{id}/create', [HotelController::class, 'createkamar']);
    Route::get('hotelkamar/{hotel_id}/{id}', [HotelController::class, 'showkamar']);
    Route::get('hotelkamar/{hotel_id}/{id}/edit', [HotelController::class, 'editkamar']);
  //  Route::get('hotelhunian/{id}', [HotelController::class, 'hunian']);
    Route::post('hotelhunian/{id}', [HotelController::class, 'storehunian']);
    Route::get('hotelhunian/{id}/create', [HotelController::class, 'createhunian']);
   // Route::get('hotelhunian/{hotel_id}/{id}', [HotelController::class, 'showhunian']);
  //  Route::get('hotelhunian/{hotel_id}/{id}/edit', [HotelController::class, 'edithunian']);
    Route::get('hotel/print-potensi-pajak', [HotelController::class, 'printPotensiPajak'])->name('hotel.print-potensi-pajak');
    Route::get('hotel/print-tingkat-hunian', [HotelController::class, 'printTingkatHunian'])->name('hotel.print-tingkat-hunian');
   // Route::post('hotel', [HotelController::class, 'store']);
    Route::resource('hotel', HotelController::class);
  //  Route::resource('hotelhunian/{id}', HotelController::class);
    
 
    // Restoran
    Route::post('restokunjungan/{id}', [RestoranController::class, 'storekunjungan']);
    Route::get('restokunjungan/{id}/create', [RestoranController::class, 'createkunjungan']);
    Route::post('restoran/import', [RestoranController::class, 'import'])->name('restoran.import');
    Route::get('restoran/export', [RestoranController::class, 'export'])->name('restoran.export');
    Route::get('restoran/print-potensi-pajak', [RestoranController::class, 'printPotensiPajak'])->name('restoran.print-potensi-pajak');
    Route::get('restoran/print-tingkat-hunian', [RestoranController::class, 'printTingkatKunjungan'])->name('restoran.print-tingkat-kunjungan');
    Route::resource('restoran', RestoranController::class);

    // Restoran CWP
    Route::post('restoran-cwpkunjungan/{id}', [RestoranCwpController::class, 'storekunjungan']);
    Route::get('restoran-cwpkunjungan/{id}/create', [RestoranCwpController::class, 'createkunjungan']);
    Route::post('restoran-cwp/import', [RestoranCwpController::class, 'import'])->name('restoran-cwp.import');
    Route::get('restoran-cwp/export', [RestoranCwpController::class, 'export'])->name('restoran-cwp.export');
    Route::get('restoran-cwp/print-potensi-pajak', [RestoranCwpController::class, 'printPotensiPajak'])->name('restoran-cwp.print-potensi-pajak');
    Route::get('restoran-cwp/print-tingkat-hunian', [RestoranCwpController::class, 'printTingkatKunjungan'])->name('restoran-cwp.print-tingkat-kunjungan');
    Route::post('restoran-cwp/{id}/convert', [RestoranCwpController::class, 'convert'])->name('restoran-cwp.convert');
    Route::resource('restoran-cwp', RestoranCwpController::class);
    Route::get('cwp-log', [CwpLogController::class, 'index'])->name('cwp.log');

    // Parkir
    Route::post('parkirkunjungan/{id}', [ParkirController::class, 'storekunjungan']);
    Route::get('parkirkunjungan/{id}/create', [ParkirController::class, 'createkunjungan']);
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
    Route::post('hiburankunjungan/{id}', [HiburanController::class, 'storekunjungan']);
    Route::get('hiburankunjungan/{id}/create', [HiburanController::class, 'createkunjungan']);
    Route::post('hiburan/setting-persentase', [HiburanController::class, 'settingPersentase'])->name('hiburan.settingPersentase');
    Route::post('hiburan/import', [HiburanController::class, 'import'])->name('hiburan.import');
    Route::get('hiburan/export', [HiburanController::class, 'export'])->name('hiburan.export');
    Route::get('hiburan/print-potensi-pajak', [HiburanController::class, 'printPotensiPajak'])->name('hiburan.print-potensi-pajak');
    Route::get('hiburan/print-tingkat-kunjungan', [HiburanController::class, 'printTingkatKunjungan'])->name('hiburan.print-tingkat-kunjungan');
    Route::resource('hiburan', HiburanController::class);

    // Reklame
    Route::post('reklame/import', [ReklameController::class, 'import'])->name('reklame.import');
    Route::get('reklame/export', [ReklameController::class, 'export'])->name('reklame.export');
    Route::get('reklame/print-potensi-pajak', [ReklameController::class, 'printPotensiPajak'])->name('reklame.print-potensi-pajak');
    Route::get('reklame/print-tingkat-hunian', [ReklameController::class, 'printTingkatHunian'])->name('reklame.print-tingkat-hunian');
    Route::resource('reklame', ReklameController::class);
     
    
    // Penerangan
    Route::post('penerangan/import', [PeneranganController::class, 'import'])->name('penerangan.import');
    Route::get('penerangan/export', [PeneranganController::class, 'export'])->name('penerangan.export');
    Route::get('penerangan/print-potensi-pajak', [PeneranganController::class, 'printPotensiPajak'])->name('penerangan.print-potensi-pajak');
    Route::get('penerangan/print-tingkat-hunian', [PeneranganController::class, 'printTingkatHunian'])->name('penerangan.print-tingkat-hunian');
    Route::resource('penerangan', PeneranganController::class);
    
    // Air
    Route::post('air/import', [AirController::class, 'import'])->name('air.import');
    Route::get('air/export', [AirController::class, 'export'])->name('air.export');
    Route::get('air/print-potensi-pajak', [AirController::class, 'printPotensiPajak'])->name('air.print-potensi-pajak');
    Route::get('air/print-tingkat-hunian', [AirController::class, 'printTingkatHunian'])->name('air.print-tingkat-hunian');
    Route::resource('air', AirController::class);
     
    
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

    // nota dinas
    Route::get('notadinas/print-pdf', [NotaDinasContorller::class, 'printPdf']);
    Route::post('notadinas/print-pdf', [NotaDinasContorller::class, 'printPdf']);
    Route::resource('notadinas', NotaDinasContorller::class);
    // routes/web.php
    Route::get('/jenis_pajak/{jenis_pajak}', [NotaDinasContorller::class, 'getDataByJenis'])->name('jenis.pajak');
    // ReportExportController
    Route::get('/realisasi-pendapatan', [RealisasiPendapatanController::class, 'index']);
    Route::get('/realisasi-pendapatan-forecast', [RealisasiPendapatanController::class, 'forecastData']);
    Route::get('/report-export/realisasi-pendapatan', [ReportExportController::class, 'realisasiPendapatan']);
    Route::post('/report-export/realisasi-pendapatan', [ReportExportController::class, 'realisasiPendapatan']);

    Route::get('/files', [FileController::class, 'index'])->name('files.index');
    Route::get('/files/download/{fileName}', [FileController::class, 'download'])->name('files.download');

});

Route::get('/bcrypt', function(){
    return bcrypt('123');
});
