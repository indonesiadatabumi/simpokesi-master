<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserLogController;
use App\Http\Controllers\Api\CwpLogController;
use App\Http\Controllers\Api\HotelController;
use App\Http\Controllers\Api\HiburanController;
use App\Http\Controllers\Api\RestoranController;
use App\Http\Controllers\Api\RestoranCwpController;
use App\Http\Controllers\Api\ParkirController;
use App\Http\Controllers\Api\KostanController;
use App\Http\Controllers\Api\RusunController;
use App\Http\Controllers\Api\RekapitulasiGrafikController;
use App\Http\Controllers\Api\RekapitulasiPetaController;
use App\Http\Controllers\Api\RekapitulasiDokumenLainGrafikController;
use App\Http\Controllers\Api\RekapitulasiDokumenLainPetaController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['middleware' => 'auth'], function(){
    // User Log
    Route::get('/user-log-datatable', [UserLogController::class, 'jsonDatatable']);

    // CWP Log
    Route::get('/cwp-log-datatable', [CwpLogController::class, 'jsonDatatable']);

    // Hotel
    Route::get('/hotel-datatable', [HotelController::class, 'jsonDatatable']);
    Route::get('/hotel-select2', [HotelController::class, 'jsonSelect2']);
    Route::get('/hotel/{id}', [HotelController::class, 'show']);

    // Restoran
    Route::get('/restoran-datatable', [RestoranController::class, 'jsonDatatable']);
    Route::get('/restoran-select2', [RestoranController::class, 'jsonSelect2']);
    Route::get('/restoran/{id}', [RestoranController::class, 'show']);

    // Restoran
    Route::get('/restoran-cwp-datatable', [RestoranCwpController::class, 'jsonDatatable']);
    Route::get('/restoran-cwp-select2', [RestoranCwpController::class, 'jsonSelect2']);
    Route::get('/restoran-cwp/{id}', [RestoranCwpController::class, 'show']);

    // Parkir
    Route::get('/parkir-datatable', [ParkirController::class, 'jsonDatatable']);
    Route::get('/parkir-select2', [ParkirController::class, 'jsonSelect2']);
    Route::get('/parkir/{id}', [ParkirController::class, 'show']);

    // Kostan
    Route::get('/kostan-datatable', [KostanController::class, 'jsonDatatable']);
    Route::get('/kostan-select2', [KostanController::class, 'jsonSelect2']);
    Route::get('/kostan/{id}', [KostanController::class, 'show']);

    // Rusun
    Route::get('/rusun-datatable', [RusunController::class, 'jsonDatatable']);
    Route::get('/rusun-select2', [RusunController::class, 'jsonSelect2']);
    Route::get('/rusun/{id}', [RusunController::class, 'show']);
    
    // Hiburan
    Route::get('/hiburan-datatable', [HiburanController::class, 'jsonDatatable']);
    Route::get('/hiburan-select2', [HiburanController::class, 'jsonSelect2']);
    Route::get('/hiburan/{id}', [HiburanController::class, 'show']);

    // Rekapitulasi
    Route::get('/rekapitulasi-chart-all', [RekapitulasiGrafikController::class, 'getChartAll']);
    Route::get('/rekapitulasi-chart', [RekapitulasiGrafikController::class, 'getChartKecamatan']);
});

Route::get('/rekapitulasi-map-all', [RekapitulasiPetaController::class, 'getMapAll']);
Route::get('/rekapitulasi-map-detail/{jenis}/{id}', [RekapitulasiPetaController::class, 'getMapDetail']);

