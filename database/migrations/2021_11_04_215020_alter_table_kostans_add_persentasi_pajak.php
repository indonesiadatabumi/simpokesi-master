<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableKostansAddPersentasiPajak extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('kostans', function (Blueprint $table) {
            $table->integer('status_aktif_id')->nullable()->default(1)->after('kostan_foto');
            $table->float('kostan_persentase_pajak')->nullable()->default(10)->after('kostan_potensi_pajak');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('kostans', function (Blueprint $table) {
            //
        });
    }
}
