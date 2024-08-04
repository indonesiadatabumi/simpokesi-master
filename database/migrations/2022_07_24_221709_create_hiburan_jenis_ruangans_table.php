<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHiburanJenisRuangansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburan_jenis_ruangans', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_id')->nullable();
            $table->string('hiburan_jenis_ruangan_deskripsi')->nullable();
            $table->string('hiburan_jenis_ruangan_tarif')->nullable();
            $table->integer('hiburan_jenis_ruangan_jumlah')->nullable()->default(0);
            $table->integer('hiburan_jenis_ruangan_kapasitas')->nullable()->default(0);
            $table->integer('hiburan_jenis_ruangan_avg_ramai')->nullable()->default(0);
            $table->integer('hiburan_jenis_ruangan_avg_normal')->nullable()->default(0);
            $table->integer('hiburan_jenis_ruangan_avg_sepi')->nullable()->default(0);
            $table->double('hiburan_jenis_ruangan_potensi_pajak')->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburan_jenis_ruangans');
    }
}
