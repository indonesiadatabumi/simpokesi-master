<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHiburanJenisesAddMultipleHtm extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburan_tarifs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_jenis_id')->nullable();
            $table->string('hiburan_tarif_deskripsi')->nullable();
        });

        Schema::create('hiburan_tarif_values', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_id')->nullable();
            $table->bigInteger('hiburan_tarif_id')->nullable();
            $table->double('hiburan_tarif_value')->nullable()->default(0);
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->boolean('hiburan_jenis_have_multiple_tarif')->default(false)->nullable()->after('hiburan_jenis_have_ruangan');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburan_tarifs');

        Schema::dropIfExists('hiburan_tarif_values');

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_have_multiple_htm');
        });
    }
}
