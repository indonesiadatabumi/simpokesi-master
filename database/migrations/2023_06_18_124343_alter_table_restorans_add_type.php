<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTableRestoransAddType extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('restorans', function (Blueprint $table) {
            $table->string('restoran_tipe')->after('restoran_is_cwp')->nullable()->default('offline');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('restorans', function (Blueprint $table) {
            $table->dropColumn('restoran_tipe');
        });
    }
}
