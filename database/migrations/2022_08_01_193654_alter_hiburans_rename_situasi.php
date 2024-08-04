<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburansRenameSituasi extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_jenis_ruangans', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_ruangan_avg_normal');
            $table->renameColumn('hiburan_jenis_ruangan_avg_ramai', 'hiburan_jenis_ruangan_avg_weekends');
            $table->renameColumn('hiburan_jenis_ruangan_avg_sepi', 'hiburan_jenis_ruangan_avg_weekdays');
        });

        Schema::table('hiburan_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->dropColumn('situasi_kunjungan_normal');
            $table->dropColumn('tingkat_kunjungan_normal');
            $table->renameColumn('situasi_kunjungan_ramai', 'situasi_kunjungan_weekends');
            $table->renameColumn('situasi_kunjungan_sepi', 'situasi_kunjungan_weekdays');
            $table->renameColumn('tingkat_kunjungan_ramai', 'tingkat_kunjungan_weekends');
            $table->renameColumn('tingkat_kunjungan_sepi', 'tingkat_kunjungan_weekdays');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburan_jenis_ruangans', function (Blueprint $table) {
            $table->integer('hiburan_jenis_ruangan_avg_normal')->nullable()->default(0);
            $table->renameColumn('hiburan_jenis_ruangan_avg_weekends', 'hiburan_jenis_ruangan_avg_ramai');
            $table->renameColumn('hiburan_jenis_ruangan_avg_weekdays', 'hiburan_jenis_ruangan_avg_sepi');
        });

        Schema::table('hiburan_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->integer('situasi_kunjungan_normal')->nullable()->default(0);
            $table->integer('tingkat_kunjungan_normal')->nullable()->default(0);
            $table->renameColumn('situasi_kunjungan_weekends', 'situasi_kunjungan_ramai');
            $table->renameColumn('situasi_kunjungan_weekdays', 'situasi_kunjungan_sepi');
            $table->renameColumn('tingkat_kunjungan_weekends', 'tingkat_kunjungan_ramai');
            $table->renameColumn('tingkat_kunjungan_weekdays', 'tingkat_kunjungan_sepi');
        });
    }
}
