<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanJenisesAddKunjunganLabel extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->string('hiburan_jenis_kunjungan_unit')->nullable()->after('hiburan_jenis_jumlah_unit');
            $table->string('hiburan_jenis_kunjungan_label')->nullable()->after('hiburan_jenis_jumlah_unit');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_kunjungan_unit');
            $table->dropColumn('hiburan_jenis_kunjungan_label');
        });
    }
}
