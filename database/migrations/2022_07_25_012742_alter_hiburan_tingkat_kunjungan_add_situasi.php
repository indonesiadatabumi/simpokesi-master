<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanTingkatKunjunganAddSituasi extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->renameColumn('kunjungan_ramai', 'situasi_kunjungan_ramai');
            $table->renameColumn('kunjungan_normal', 'situasi_kunjungan_normal');
            $table->renameColumn('kunjungan_sepi', 'situasi_kunjungan_sepi');
            $table->integer('tingkat_kunjungan_ramai')->nullable()->default(0);
            $table->integer('tingkat_kunjungan_normal')->nullable()->default(0);
            $table->integer('tingkat_kunjungan_sepi')->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburan_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->renameColumn('situasi_kunjungan_ramai', 'kunjungan_ramai');
            $table->renameColumn('situasi_kunjungan_normal', 'kunjungan_normal');
            $table->renameColumn('situasi_kunjungan_sepi', 'kunjungan_sepi');
            $table->dropColumn('tingkat_kunjungan_ramai');
            $table->dropColumn('tingkat_kunjungan_normal');
            $table->dropColumn('tingkat_kunjungan_sepi');
        });
    }
}
