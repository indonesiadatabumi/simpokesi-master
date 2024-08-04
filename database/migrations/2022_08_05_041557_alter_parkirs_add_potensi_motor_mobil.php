<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterParkirsAddPotensiMotorMobil extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('parkirs', function (Blueprint $table) {
            $table->double('parkir_potensi_pajak_motor')->nullable()->after('parkir_potensi_pajak');
            $table->double('parkir_potensi_pajak_mobil')->nullable()->after('parkir_potensi_pajak');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('parkirs', function (Blueprint $table) {
            $table->dropColumn('parkir_potensi_pajak_motor');
            $table->dropColumn('parkir_potensi_pajak_mobil');
        });
    }
}
