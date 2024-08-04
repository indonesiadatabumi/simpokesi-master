<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHiburanJenisesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburan_jenises', function (Blueprint $table) {
            $table->id();
            $table->string('hiburan_jenis_deskripsi')->nullable();
            $table->float('hiburan_jenis_persentase')->nullable()->default(10);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburan_jenises');
    }
}
