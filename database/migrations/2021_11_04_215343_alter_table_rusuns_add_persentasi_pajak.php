<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableRusunsAddPersentasiPajak extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('rusuns', function (Blueprint $table) {
            $table->integer('status_aktif_id')->nullable()->default(1)->after('rusun_foto');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('rusuns', function (Blueprint $table) {
            //
        });
    }
}
