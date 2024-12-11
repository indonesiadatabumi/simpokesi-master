<table>
    <thead>
        <tr>
            <th colspan="17">Informasi Air</th>
            <th colspan="4">Informasi Frekuensi Jumlah Hari</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th colspan="4">Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Air</th>
            <th>Klasifikasi Air</th>
            <th>Nomor Telepon</th>
            <th>Nomor NPWPD</th>
            <th>Alamat</th>
            <th>Kecamatan</th>
            <th>Kelurahan</th>
            <th>RT</th>
            <th>RW</th>
            <th>Foto</th>
            <th>Jumlah Pegawai</th>
            <th>Persentase Pajak</th>
            <th>Status Tapping Box</th>
            <th>Status Pajak</th>
            <th>Latitude</th>
            <th>Longitude</th>

            <th>Ramai Penuh</th>
            <th>Ramai Akhir Pekan</th>
            <th>Normal</th>
            <th>Sepi</th>

            <th>Jenis Kamar</th>
            <th>Tarif Kamar</th>
            <th>Jumlah Semua Kamar</th>

            <th>Ramai Penuh</th>
            <th>Ramah Akhir Pekan</th>
            <th>Normal</th>
            <th>Sepi</th>

            <th>Potensi Pajak Per Kamar</th>
            <th>Potensi Pajak Air</th>
        </tr>
    </thead>
    <tbody>
        @foreach($airs as $row)
        <tr>
            <td>{{ @$row->air_pemilik }}</td>
            <td>{{ @$row->air_nama }}</td>
            <td>{{ @$row->air_klasifikasi_deskripsi }}</td>
            <td>{{ @$row->air_telepon }}</td>
            <td>{{ @$row->air_npwpd }}</td>
            <td>{{ @$row->air_alamat }}</td>
            <td>{{ @$row->air_kecamatan }}</td>
            <td>{{ @$row->air_kelurahan }}</td>
            <td>{{ @$row->air_rt }}</td>
            <td>{{ @$row->air_rw }}</td>
            <td>{{ @$row->air_foto ? (str_contains($row->air_foto, 'http') ? $row->air_foto : asset('uploads/air/'.$row->air_foto)) : '' }}</td>
            <td>{{ @$row->air_jumlah_pegawai }}</td>
            <td>{{ @$row->air_persentase_pajak }}</td>
            <td>{{ @$row->air_status_tapping_box }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->air_latitude }}</td>
            <td>{{ @$row->air_longitude }}</td>

            <td>{{ @$row->kunjungan_penuh }}</td>
            <td>{{ @$row->kunjungan_akhir_pekan }}</td>
            <td>{{ @$row->kunjungan_normal }}</td>
            <td>{{ @$row->kunjungan_sepi }}</td>

            <td>{{ @$row->air_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->air_jenis_kamar_tarif }}</td>
            <td>{{ @$row->air_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->air_jenis_kamar_avg_penuh }}</td>
            <td>{{ @$row->air_jenis_kamar_avg_akhir_pekan }}</td>
            <td>{{ @$row->air_jenis_kamar_avg_normal }}</td>
            <td>{{ @$row->air_jenis_kamar_avg_sepi }}</td>

            <td>{{ @$row->air_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->air_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
