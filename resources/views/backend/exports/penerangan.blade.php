<table>
    <thead>
        <tr>
            <th colspan="17">Informasi Penerangan</th>
            <th colspan="4">Informasi Frekuensi Jumlah Hari</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th colspan="4">Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Penerangan</th>
            <th>Klasifikasi Penerangan</th>
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
            <th>Potensi Pajak Penerangan</th>
        </tr>
    </thead>
    <tbody>
        @foreach($penerangans as $row)
        <tr>
            <td>{{ @$row->penerangan_pemilik }}</td>
            <td>{{ @$row->penerangan_nama }}</td>
            <td>{{ @$row->penerangan_klasifikasi_deskripsi }}</td>
            <td>{{ @$row->penerangan_telepon }}</td>
            <td>{{ @$row->penerangan_npwpd }}</td>
            <td>{{ @$row->penerangan_alamat }}</td>
            <td>{{ @$row->penerangan_kecamatan }}</td>
            <td>{{ @$row->penerangan_kelurahan }}</td>
            <td>{{ @$row->penerangan_rt }}</td>
            <td>{{ @$row->penerangan_rw }}</td>
            <td>{{ @$row->penerangan_foto ? (str_contains($row->penerangan_foto, 'http') ? $row->penerangan_foto : asset('uploads/penerangan/'.$row->penerangan_foto)) : '' }}</td>
            <td>{{ @$row->penerangan_jumlah_pegawai }}</td>
            <td>{{ @$row->penerangan_persentase_pajak }}</td>
            <td>{{ @$row->penerangan_status_tapping_box }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->penerangan_latitude }}</td>
            <td>{{ @$row->penerangan_longitude }}</td>

            <td>{{ @$row->kunjungan_penuh }}</td>
            <td>{{ @$row->kunjungan_akhir_pekan }}</td>
            <td>{{ @$row->kunjungan_normal }}</td>
            <td>{{ @$row->kunjungan_sepi }}</td>

            <td>{{ @$row->penerangan_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->penerangan_jenis_kamar_tarif }}</td>
            <td>{{ @$row->penerangan_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->penerangan_jenis_kamar_avg_penuh }}</td>
            <td>{{ @$row->penerangan_jenis_kamar_avg_akhir_pekan }}</td>
            <td>{{ @$row->penerangan_jenis_kamar_avg_normal }}</td>
            <td>{{ @$row->penerangan_jenis_kamar_avg_sepi }}</td>

            <td>{{ @$row->penerangan_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->penerangan_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
