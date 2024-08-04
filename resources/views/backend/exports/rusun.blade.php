<table>
    <thead>
        <tr>
            <th colspan="12">Informasi Rusun</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th>Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Rusun</th>
            <th>Nomor Telepon</th>
            <th>Nomor NPWPD</th>
            <th>Alamat</th>
            <th>Kecamatan</th>
            <th>Kelurahan</th>
            <th>RT</th>
            <th>RW</th>
            <th>Foto</th>
            <th>Jumlah Pegawai</th>
            <th>Status Retribusi</th>
            <th>Latitude</th>
            <th>Longitude</th>

            <th>Jenis Kamar</th>
            <th>Tarif Kamar</th>
            <th>Jumlah Semua Kamar</th>

            <th>Rata - rata Hunian</th>

            <th>Potensi Pajak Per Kamar</th>
            <th>Potensi Pajak Rusun</th>
        </tr>
    </thead>
    <tbody>
        @foreach($rusuns as $row)
        <tr>
            <td>{{ @$row->rusun_pemilik }}</td>
            <td>{{ @$row->rusun_nama }}</td>
            <td>{{ @$row->rusun_telepon }}</td>
            <td>{{ @$row->rusun_npwpd }}</td>
            <td>{{ @$row->rusun_alamat }}</td>
            <td>{{ @$row->rusun_kecamatan }}</td>
            <td>{{ @$row->rusun_kelurahan }}</td>
            <td>{{ @$row->rusun_rt }}</td>
            <td>{{ @$row->rusun_rw }}</td>
            <td>{{ @$row->rusun_foto ? (str_contains($row->rusun_foto, 'http') ? $row->rusun_foto : asset('uploads/rusun/'.$row->rusun_foto)) : '' }}</td>
            <td>{{ @$row->rusun_jumlah_pegawai }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->rusun_latitude }}</td>
            <td>{{ @$row->rusun_longitude }}</td>

            <td>{{ @$row->rusun_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->rusun_jenis_kamar_tarif }}</td>
            <td>{{ @$row->rusun_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->rusun_jenis_kamar_hunian_avg }}</td>

            <td>{{ @$row->rusun_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->rusun_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
