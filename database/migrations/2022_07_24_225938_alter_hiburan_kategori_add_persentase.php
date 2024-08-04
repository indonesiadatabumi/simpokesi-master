<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanKategoriAddPersentase extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_kategoris', function (Blueprint $table) {
            $table->float('hiburan_kategori_persentase')->nullable()->default(10);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburan_kategoris', function (Blueprint $table) {
            $table->dropColumn('hiburan_kategori_persentase');
        });
    }
}
