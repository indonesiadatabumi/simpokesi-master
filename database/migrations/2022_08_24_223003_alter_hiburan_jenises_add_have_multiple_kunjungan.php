<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanJenisesAddHaveMultipleKunjungan extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburan_kunjungans', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_jenis_id')->nullable();
            $table->string('hiburan_kunjungan_deskripsi')->nullable();
        });

        Schema::create('hiburan_kunjungan_values', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('hiburan_id')->nullable();
            $table->bigInteger('hiburan_kunjungan_id')->nullable();
            $table->double('hiburan_kunjungan_weekends_value')->nullable()->default(0);
            $table->double('hiburan_kunjungan_weekdays_value')->nullable()->default(0);
            
            $table->unique(['hiburan_kunjungan_id', 'hiburan_id']);
        });

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->boolean('hiburan_jenis_have_multiple_kunjungan')->default(false)->nullable()->after('hiburan_jenis_have_multiple_tarif');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburan_kunjungans');

        Schema::dropIfExists('hiburan_kunjungan_values');

        Schema::table('hiburan_jenises', function (Blueprint $table) {
            $table->dropColumn('hiburan_jenis_have_multiple_kunjungan');
        });
    }
}
