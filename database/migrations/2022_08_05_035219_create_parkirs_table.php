<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateParkirsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('parkirs', function (Blueprint $table) {
            $table->id();
            $table->string('parkir_pemilik')->nullable();
            $table->string('parkir_npwpd')->nullable();
            $table->string('parkir_nama')->nullable();
            $table->string('parkir_alamat')->nullable();
            $table->string('parkir_kecamatan')->nullable();
            $table->string('parkir_kelurahan')->nullable();
            $table->string('parkir_rt')->nullable();
            $table->string('parkir_rw')->nullable();
            $table->integer('parkir_srp_motor')->nullable();
            $table->integer('parkir_srp_mobil')->nullable();
            $table->integer('parkir_tarif_motor')->nullable();
            $table->integer('parkir_tarif_mobil')->nullable();
            $table->float('parkir_durasi_avg')->nullable();
            $table->double('parkir_potensi_pajak')->nullable();
            $table->double('parkir_persentase_pajak')->nullable();
            $table->string('parkir_telepon')->nullable();
            $table->text('parkir_foto')->nullable();
            $table->string('parkir_latitude')->nullable();
            $table->string('parkir_longitude')->nullable();
            $table->integer('status_aktif_id')->nullable()->default(1);
            $table->integer('created_by')->nullable();
            $table->integer('updated_by')->nullable();
            $table->softDeletes();
        });

        Schema::create('parkir_tingkat_kunjungan_avgs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('parkir_id')->nullable();
            $table->integer('mobil_situasi_kunjungan_sepi')->nullable();
            $table->integer('mobil_situasi_kunjungan_normal')->nullable();
            $table->integer('mobil_situasi_kunjungan_ramai')->nullable();
            $table->double('mobil_avg_kunjungan_sepi')->nullable();
            $table->double('mobil_avg_kunjungan_normal')->nullable();
            $table->double('mobil_avg_kunjungan_ramai')->nullable();
            $table->integer('motor_situasi_kunjungan_sepi')->nullable();
            $table->integer('motor_situasi_kunjungan_normal')->nullable();
            $table->integer('motor_situasi_kunjungan_ramai')->nullable();
            $table->double('motor_avg_kunjungan_sepi')->nullable();
            $table->double('motor_avg_kunjungan_normal')->nullable();
            $table->double('motor_avg_kunjungan_ramai')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('parkirs');
        Schema::dropIfExists('parkir_tingkat_kunjungan_avgs');
    }
}
