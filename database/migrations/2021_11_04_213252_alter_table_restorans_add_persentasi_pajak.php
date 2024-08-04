<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableRestoransAddPersentasiPajak extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('restorans', function (Blueprint $table) {
            $table->integer('status_aktif_id')->nullable()->default(1)->after('restoran_status_tapping_box');
            $table->float('restoran_persentase_pajak')->nullable()->default(10)->after('restoran_potensi_pajak');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('restorans', function (Blueprint $table) {
            //
        });
    }
}
