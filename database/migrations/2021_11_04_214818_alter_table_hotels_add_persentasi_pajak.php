<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableHotelsAddPersentasiPajak extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hotels', function (Blueprint $table) {
            $table->integer('status_aktif_id')->nullable()->default(1)->after('hotel_foto');
            $table->integer('hotel_status_tapping_box')->nullable()->default(0)->after('hotel_foto');
            $table->float('hotel_persentase_pajak')->nullable()->default(10)->after('hotel_potensi_pajak');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hotels', function (Blueprint $table) {
            //
        });
    }
}
