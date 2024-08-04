<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburansRenameJumlah extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburans', function (Blueprint $table) {
            $table->renameColumn('hiburan_jumlah_ruangan', 'hiburan_jumlah');
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->string('hiburan_jenis_jumlah_label')->nullable();
            $table->string('hiburan_jenis_jumlah_unit')->nullable();
            $table->string('hiburan_jenis_kapasitas_label')->nullable()->default('Kapasitas Kursi');
            $table->string('hiburan_jenis_kapasitas_unit')->nullable()->default('Kursi');
            $table->string('hiburan_jenis_htm_label')->nullable()->default('HTM');
            $table->string('hiburan_jenis_htm_unit')->nullable()->default('Tiket');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburans', function (Blueprint $table) {
            $table->renameColumn('hiburan_jumlah', 'hiburan_jumlah_ruangan');
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_jumlah_label');
            $table->dropColumn('hiburan_jenis_jumlah_unit');
            $table->dropColumn('hiburan_jenis_kapasitas_label');
            $table->dropColumn('hiburan_jenis_kapasitas_unit');
            $table->dropColumn('hiburan_jenis_htm_label');
            $table->dropColumn('hiburan_jenis_htm_unit');
        });
    }
}
