<table>
    <thead>
        <tr>
            <th colspan="17">Informasi Reklame</th>
            <th colspan="4">Informasi Frekuensi Jumlah Hari</th>
            <th colspan="3">Informasi Jenis Kamar</th>
            <th colspan="4">Informasi Rata - rata Tingkat Hunian</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Reklame</th>
            <th>Klasifikasi Reklame</th>
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
            <th>Potensi Pajak Reklame</th>
        </tr>
    </thead>
    <tbody>
        @foreach($reklames as $row)
        <tr>
            <td>{{ @$row->reklame_pemilik }}</td>
            <td>{{ @$row->reklame_nama }}</td>
            <td>{{ @$row->reklame_klasifikasi_deskripsi }}</td>
            <td>{{ @$row->reklame_telepon }}</td>
            <td>{{ @$row->reklame_npwpd }}</td>
            <td>{{ @$row->reklame_alamat }}</td>
            <td>{{ @$row->reklame_kecamatan }}</td>
            <td>{{ @$row->reklame_kelurahan }}</td>
            <td>{{ @$row->reklame_rt }}</td>
            <td>{{ @$row->reklame_rw }}</td>
            <td>{{ @$row->reklame_foto ? (str_contains($row->reklame_foto, 'http') ? $row->reklame_foto : asset('uploads/reklame/'.$row->reklame_foto)) : '' }}</td>
            <td>{{ @$row->reklame_jumlah_pegawai }}</td>
            <td>{{ @$row->reklame_persentase_pajak }}</td>
            <td>{{ @$row->reklame_status_tapping_box }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->reklame_latitude }}</td>
            <td>{{ @$row->reklame_longitude }}</td>

            <td>{{ @$row->kunjungan_penuh }}</td>
            <td>{{ @$row->kunjungan_akhir_pekan }}</td>
            <td>{{ @$row->kunjungan_normal }}</td>
            <td>{{ @$row->kunjungan_sepi }}</td>

            <td>{{ @$row->reklame_jenis_kamar_deskripsi }}</td>
            <td>{{ @$row->reklame_jenis_kamar_tarif }}</td>
            <td>{{ @$row->reklame_jenis_kamar_jumlah }}</td>

            <td>{{ @$row->reklame_jenis_kamar_avg_penuh }}</td>
            <td>{{ @$row->reklame_jenis_kamar_avg_akhir_pekan }}</td>
            <td>{{ @$row->reklame_jenis_kamar_avg_normal }}</td>
            <td>{{ @$row->reklame_jenis_kamar_avg_sepi }}</td>

            <td>{{ @$row->reklame_jenis_kamar_potensi_pajak }}</td>
            <td>{{ @$row->reklame_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
