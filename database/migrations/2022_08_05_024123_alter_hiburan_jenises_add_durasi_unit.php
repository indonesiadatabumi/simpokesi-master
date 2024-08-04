<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanJenisesAddDurasiUnit extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->string('hiburan_jenis_durasi_unit')->nullable();
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
            $table->dropColumn('hiburan_jenis_durasi_unit');
        });
    }
}
