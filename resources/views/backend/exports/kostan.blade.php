<table>
    <thead>
        <tr>
            <th colspan="14">Informasi Kostan</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th>Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Kostan</th>
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
            <th>Status Pajak</th>
            <th>Latitude</th>
            <th>Longitude</th>

            <th>Jenis Kamar</th>
            <th>Tarif Kamar</th>
            <th>Jumlah Semua Kamar</th>

            <th>Rata - rata Hunian</th>

            <th>Potensi Pajak Per Kamar</th>
            <th>Potensi Pajak Kostan</th>
        </tr>
    </thead>
    <tbody>
        @foreach($kostans as $row)
        <tr>
            <td>{{ @$row->kostan_pemilik }}</td>
            <td>{{ @$row->kostan_nama }}</td>
            <td>{{ @$row->kostan_telepon }}</td>
            <td>{{ @$row->kostan_npwpd }}</td>
            <td>{{ @$row->kostan_alamat }}</td>
            <td>{{ @$row->kostan_kecamatan }}</td>
            <td>{{ @$row->kostan_kelurahan }}</td>
            <td>{{ @$row->kostan_rt }}</td>
            <td>{{ @$row->kostan_rw }}</td>
            <td>{{ @$row->kostan_foto ? (str_contains($row->kostan_foto, 'http') ? $row->kostan_foto : asset('uploads/kostan/'.$row->kostan_foto)) : '' }}</td>
            <td>{{ @$row->kostan_jumlah_pegawai }}</td>
            <td>{{ @$row->kostan_persentase_pajak }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->kostan_latitude }}</td>
            <td>{{ @$row->kostan_longitude }}</td>

            <td>{{ @$row->kostan_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->kostan_jenis_kamar_tarif }}</td>
            <td>{{ @$row->kostan_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->kostan_jenis_kamar_hunian_avg }}</td>

            <td>{{ @$row->kostan_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->kostan_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
