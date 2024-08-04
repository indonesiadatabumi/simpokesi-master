<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburansAddJamOperasional extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburans', function (Blueprint $table) {
            $table->string('hiburan_jam_weekends')->after('hiburan_jam_operasional')->nullable();
            $table->string('hiburan_jam_weekdays')->after('hiburan_jam_operasional')->nullable();
        });

        Schema::table('hiburan_jenis_ruangans', function (Blueprint $table) {
            $table->string('hiburan_jenis_ruangan_jam_weekends')->after('hiburan_jenis_ruangan_kapasitas')->nullable();
            $table->string('hiburan_jenis_ruangan_jam_weekdays')->after('hiburan_jenis_ruangan_kapasitas')->nullable();
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
            $table->dropColumn('hiburan_jam_weekends');
            $table->dropColumn('hiburan_jam_weekdays');
        });

        Schema::table('hiburan_jenis_ruangans', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_ruangan_jam_weekends');
            $table->dropColumn('hiburan_jenis_ruangan_jam_weekdays');
        });
    }
}
