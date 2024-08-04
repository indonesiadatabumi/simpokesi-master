<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterHiburanTarifAddUnique extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('hiburan_tarif_values', function (Blueprint $table) {
            $table->unique(['hiburan_tarif_id', 'hiburan_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('hiburan_tarif_values', function (Blueprint $table) {
            $table->dropUnique('hiburan_tarif_values_hiburan_tarif_id_hiburan_id_unique');
        });
    }
}
