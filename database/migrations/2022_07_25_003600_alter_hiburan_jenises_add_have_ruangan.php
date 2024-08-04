<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanJenisesAddHaveRuangan extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->boolean('hiburan_jenis_have_ruangan')->nullable()->default(false);
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
            $table->dropColumn('hiburan_jenis_have_ruangan');
        });
    }
}
