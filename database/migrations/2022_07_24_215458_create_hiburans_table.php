<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHiburansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiburans', function (Blueprint $table) {
            $table->id();
            $table->string('hiburan_pemilik')->nullable();
            $table->string('hiburan_npwpd')->nullable();
            $table->string('hiburan_nama')->nullable();
            $table->string('hiburan_alamat')->nullable();
            $table->string('hiburan_kecamatan')->nullable();
            $table->string('hiburan_kelurahan')->nullable();
            $table->string('hiburan_rt')->nullable();
            $table->string('hiburan_rw')->nullable();
            $table->integer('hiburan_jumlah_ruangan')->nullable();
            $table->integer('hiburan_kapasitas')->nullable();
            $table->integer('hiburan_htm')->nullable();
            $table->float('hiburan_jam_operasional')->nullable();
            $table->double('hiburan_potensi_pajak')->nullable();
            $table->double('hiburan_persentase_pajak')->nullable();
            $table->string('hiburan_telepon')->nullable();
            $table->text('hiburan_foto')->nullable();
            $table->string('hiburan_latitude')->nullable();
            $table->string('hiburan_longitude')->nullable();
            $table->integer('status_aktif_id')->nullable()->default(1);
            $table->integer('hiburan_jenis_id')->nullable();
            $table->integer('hiburan_kategori_id')->nullable();
            $table->integer('created_by')->nullable();
            $table->integer('updated_by')->nullable();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hiburans');
    }
}
