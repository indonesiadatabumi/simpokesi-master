<table>
    <thead>
        <tr>
            <th colspan="17">Informasi Hotel</th>
            <th colspan="4">Informasi Frekuensi Jumlah Hari</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th colspan="4">Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Hotel</th>
            <th>Klasifikasi Hotel</th>
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
            <th>Potensi Pajak Hotel</th>
        </tr>
    </thead>
    <tbody>
        @foreach($hotels as $row)
        <tr>
            <td>{{ @$row->hotel_pemilik }}</td>
            <td>{{ @$row->hotel_nama }}</td>
            <td>{{ @$row->hotel_klasifikasi_deskripsi }}</td>
            <td>{{ @$row->hotel_telepon }}</td>
            <td>{{ @$row->hotel_npwpd }}</td>
            <td>{{ @$row->hotel_alamat }}</td>
            <td>{{ @$row->hotel_kecamatan }}</td>
            <td>{{ @$row->hotel_kelurahan }}</td>
            <td>{{ @$row->hotel_rt }}</td>
            <td>{{ @$row->hotel_rw }}</td>
            <td>{{ @$row->hotel_foto ? (str_contains($row->hotel_foto, 'http') ? $row->hotel_foto : asset('uploads/hotel/'.$row->hotel_foto)) : '' }}</td>
            <td>{{ @$row->hotel_jumlah_pegawai }}</td>
            <td>{{ @$row->hotel_persentase_pajak }}</td>
            <td>{{ @$row->hotel_status_tapping_box }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->hotel_latitude }}</td>
            <td>{{ @$row->hotel_longitude }}</td>

            <td>{{ @$row->kunjungan_penuh }}</td>
            <td>{{ @$row->kunjungan_akhir_pekan }}</td>
            <td>{{ @$row->kunjungan_normal }}</td>
            <td>{{ @$row->kunjungan_sepi }}</td>

            <td>{{ @$row->hotel_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->hotel_jenis_kamar_tarif }}</td>
            <td>{{ @$row->hotel_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->hotel_jenis_kamar_avg_penuh }}</td>
            <td>{{ @$row->hotel_jenis_kamar_avg_akhir_pekan }}</td>
            <td>{{ @$row->hotel_jenis_kamar_avg_normal }}</td>
            <td>{{ @$row->hotel_jenis_kamar_avg_sepi }}</td>

            <td>{{ @$row->hotel_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->hotel_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
