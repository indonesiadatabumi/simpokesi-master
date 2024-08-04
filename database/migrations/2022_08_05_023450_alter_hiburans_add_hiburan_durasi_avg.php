<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburansAddHiburanDurasiAvg extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburans', function (Blueprint $table) {
            $table->double('hiburan_durasi')->nullable()->after('hiburan_tarif');
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->string('hiburan_jenis_durasi_label')->nullable();
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
            $table->dropColumn('hiburan_durasi');
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_durasi_label');
        });
    }
}