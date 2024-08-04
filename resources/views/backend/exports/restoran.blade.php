<table>
    <thead>
        <tr>
            <th colspan="{!! @$tipe != 'online' ? 18 : 17 !!}">Informasi Restoran</th>
            <th colspan="3">Informasi Frekuensi Jumlah Hari</th>
            <th colspan="3">Informasi Rata - rata Tingkat Kunjungan / Pesanan</th>
            <th colspan="2">Informasi Potensi Pajak</th>
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Restoran</th>
            <th>Klasifikasi Restoran</th>
            <th>Nomor Telepon</th>
            <th>Nomor NPWPD</th>
            <th>Alamat</th>
            <th>Kecamatan</th>
            <th>Kelurahan</th>
            <th>RT</th>
            <th>RW</th>
            <th>Foto</th>
            <th>Jumlah Pegawai</th>
            @if(@$tipe != 'online')
            <th>Kapasitas Kursi</th>
            @endif
            <th>Persentase Pajak</th>
            <th>Status Tapping Box</th>
            <th>Status Pajak</th>
            <th>Latitude</th>
            <th>Longitude</th>

            <th>Ramai</th>
            <th>Normal</th>
            <th>Sepi</th>

            <th>Ramai</th>
            <th>Normal</th>
            <th>Sepi</th>

            <th>Pengeluaran Rata - rata Pesanan / Tamu per Sekali Datang</th>
            <th>Potensi Pajak Restoran</th>
        </tr>
    </thead>
    <tbody>
        @foreach($restorans as $row)
        <tr>
            <td>{{ @$row->restoran_pemilik }}</td>
            <td>{{ @$row->restoran_nama }}</td>
            <td>{{ @$row->restoran_klasifikasi_deskripsi }}</td>
            <td>{{ @$row->restoran_telepon }}</td>
            <td>{{ @$row->restoran_npwpd }}</td>
            <td>{{ @$row->restoran_alamat }}</td>
            <td>{{ @$row->restoran_kecamatan }}</td>
            <td>{{ @$row->restoran_kelurahan }}</td>
            <td>{{ @$row->restoran_rt }}</td>
            <td>{{ @$row->restoran_rw }}</td>
            <td>{{ @$row->restoran_foto ? (str_contains($row->restoran_foto, 'http') ? $row->restoran_foto : asset('uploads/restoran/'.$row->restoran_foto)) : '' }}</td>
            <td>{{ @$row->restoran_jumlah_pegawai }}</td>
            @if(@$tipe != 'online')
            <td>{{ @$row->restoran_kapasitas_kursi }}</td>
            @endif
            <td>{{ @$row->restoran_persentase_pajak }}</td>
            <td>{{ @$row->restoran_status_tapping_box }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->restoran_latitude }}</td>
            <td>{{ @$row->restoran_longitude }}</td>

            <td>{{ @$row->situasi_kunjungan_ramai }}</td>
            <td>{{ @$row->situasi_kunjungan_normal }}</td>
            <td>{{ @$row->situasi_kunjungan_sepi }}</td>

            <td>{{ @$row->avg_kunjungan_ramai }}</td>
            <td>{{ @$row->avg_kunjungan_normal }}</td>
            <td>{{ @$row->avg_kunjungan_sepi }}</td>

            <td>{{ @$row->restoran_pengeluaran_avg }}</td>
            <td>{{ @$row->restoran_potensi_pajak }}</td>
        </tr>
        @endforeach
    </tbody>
</table>
