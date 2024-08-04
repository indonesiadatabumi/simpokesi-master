<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCwpLogsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cwp_logs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('cwp_id')->nullable();
            $table->string('cwp_name')->nullable();
            $table->string('cwp_type')->nullable();
            $table->string('cwp_status')->nullable();
            $table->bigInteger('created_by')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cwp_logs');
    }
}
