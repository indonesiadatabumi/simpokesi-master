<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableHiburanJenisesAddIsCount extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->boolean('hiburan_jenis_jumlah_is_count')->nullable()->after('hiburan_jenis_jumlah_unit')->default(1);
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
            $table->dropColumn('hiburan_jenis_jumlah_is_count');
        });
    }
}
