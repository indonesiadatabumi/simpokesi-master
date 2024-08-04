<table>
    <thead>
        <tr>
            <th colspan="14">Informasi Parkir</th>
            <th colspan="2">SRP</th>
            <th colspan="6">Informasi Situasi Kunjungan Kendaraan</th>
            <th colspan="6">Informasi Tingkat Kunjungan Kendaraan</th>
            <th colspan="2">Tarif Parkir</th>
            <th colspan="4">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Tempat</th>
            <th>Nomor Telepon</th>
            <th>Nomor NPWPD</th>
            <th>Alamat</th>
            <th>Kecamatan</th>
            <th>Kelurahan</th>
            <th>RT</th>
            <th>RW</th>
            <th>Foto</th>
            <th>Persentase Pajak</th>
            <th>Status Pajak</th>
            <th>Latitude</th>
            <th>Longitude</th>

            <th>Mobil</th>
            <th>Motor</th>

            <th>Mobil - Ramai</th>
            <th>Mobil - Normal</th>
            <th>Mobil - Sepi</th>
            <th>Motor - Ramai</th>
            <th>Motor - Normal</th>
            <th>Motor - Sepi</th>

            <th>Mobil - Ramai</th>
            <th>Mobil - Normal</th>
            <th>Mobil - Sepi</th>
            <th>Motor - Ramai</th>
            <th>Motor - Normal</th>
            <th>Motor - Sepi</th>

            <th>Mobil</th>
            <th>Motor</th>

            <th>Durasi Rata - Rata Parkir</th>
            <th>Potensi Pajak Parkir Mobil</th>
            <th>Potensi Pajak Parkir Motor</th>
            <th>Potensi Pajak Parkir Total</th>
        </tr>
    </thead>
    <tbody>
        @foreach($parkirs as $row)
        <tr>
            <td>{{ @$row->parkir_pemilik }}</td>
            <td>{{ @$row->parkir_nama }}</td>
            <td>{{ @$row->parkir_telepon }}</td>
            <td>{{ @$row->parkir_npwpd }}</td>
            <td>{{ @$row->parkir_alamat }}</td>
            <td>{{ @$row->parkir_kecamatan }}</td>
            <td>{{ @$row->parkir_kelurahan }}</td>
            <td>{{ @$row->parkir_rt }}</td>
            <td>{{ @$row->parkir_rw }}</td>
            <td>{{ @$row->parkir_foto ? (str_contains($row->parkir_foto, 'http') ? $row->parkir_foto : asset('uploads/parkir/'.$row->parkir_foto)) : '' }}</td>
            <td>{{ @$row->parkir_persentase_pajak }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->parkir_latitude }}</td>
            <td>{{ @$row->parkir_longitude }}</td>
            
            <td>{{ @$row->parkir_srp_mobil }}</td>
            <td>{{ @$row->parkir_srp_motor }}</td>

            <td>{{ @$row->mobil_situasi_kunjungan_ramai }}</td>
            <td>{{ @$row->mobil_situasi_kunjungan_normal }}</td>
            <td>{{ @$row->mobil_situasi_kunjungan_sepi }}</td>
            <td>{{ @$row->motor_situasi_kunjungan_ramai }}</td>
            <td>{{ @$row->motor_situasi_kunjungan_normal }}</td>
            <td>{{ @$row->motor_situasi_kunjungan_sepi }}</td>
            
            <td>{{ @$row->mobil_avg_kunjungan_ramai }}</td>
            <td>{{ @$row->mobil_avg_kunjungan_normal }}</td>
            <td>{{ @$row->mobil_avg_kunjungan_sepi }}</td>
            <td>{{ @$row->motor_avg_kunjungan_ramai }}</td>
            <td>{{ @$row->motor_avg_kunjungan_normal }}</td>
            <td>{{ @$row->motor_avg_kunjungan_sepi }}</td>

            <td>{{ @$row->parkir_tarif_mobil }}</td>
            <td>{{ @$row->parkir_tarif_motor }}</td>

            <td>{{ @$row->parkir_durasi_avg }}</td>
            <td>{{ @$row->parkir_potensi_pajak_mobil }}</td>
            <td>{{ @$row->parkir_potensi_pajak_motor }}</td>
            <td>{{ @$row->parkir_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
