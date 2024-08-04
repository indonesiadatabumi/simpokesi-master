<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHiburanTingkatKunjunganAvgsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburan_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_id')->nullable();
            $table->integer('kunjungan_ramai')->nullable()->default(0);
            $table->integer('kunjungan_normal')->nullable()->default(0);
            $table->integer('kunjungan_sepi')->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburan_tingkat_kunjungan_avgs');
    }
}
