<table>
    <thead>
        <tr>
            <th colspan="{{ $col['hiburan'] }}">Informasi Hiburan</th>
            
            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && !$jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                <th rowspan="2">{{ @$jenis_hiburan->hiburan_jenis_htm_label }}</th>
            @endif
            
            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                <th colspan="{{ $jenis_hiburan->tarif->count() }}">{{ @$jenis_hiburan->hiburan_jenis_htm_label }}</th>
            @endif
            
            <th colspan="2">Jam Operasional</th>

            @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                <th colspan="{{ $col['ruangan'] }}">Jenis Ruangan</th>
                <th colspan="2">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? @$jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . @$jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</th>
                <th colspan="2">Informasi Potensi Pajak</th>
            @else
                <th colspan="2">Jumlah Hari dalam Setahun</th>
                
                @if(!@$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                    <th colspan="2">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? @$jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . @$jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</th>
                @else
                    @foreach ($jenis_hiburan->kunjungan as $jenis_hiburan_kunjungan)
                        <th colspan="2">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? @$jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . @$jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</th>
                    @endforeach
                @endif
                <th>Informasi Potensi Pajak</th>
            @endif
        </tr>
        <tr>
            <th>Nama Pemilik</th>
            <th>Nama Hiburan</th>
            <th>Jenis Hiburan</th>
            <th>Kategori</th>
            <th>Nomor Telepon</th>
            <th>Nomor NPWPD</th>
            <th>Alamat</th>
            <th>Kecamatan</th>
            <th>Kelurahan</th>
            <th>RT</th>
            <th>RW</th>
            <th>Foto</th>
            
            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
            <th>Jumlah {{ @$jenis_hiburan->hiburan_jenis_jumlah_label }}</th> 
            @endif
            
            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !$jenis_hiburan->hiburan_jenis_have_ruangan)
            <th>Jumlah {{ @$jenis_hiburan->hiburan_jenis_kapasitas_label }}</th> 
            @endif

            <th>Persentase Pajak</th>
            <th>Status Pajak</th>
            <th>Latitude</th>
            <th>Longitude</th>

            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                @foreach($jenis_hiburan->tarif as $jenis_hiburan_tarif)
                    <th>{{ $jenis_hiburan_tarif->hiburan_tarif_deskripsi }}</th>
                @endforeach
            @endif

            <th>Hari Kerja</th>
            <th>Hari Libur</th>
            
            @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                <th>Jenis Ruangan</th>
                <th>{{ @$jenis_hiburan->hiburan_jenis_htm_label }}</th>
                <th>Jumlah Room</th>

                @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label)
                    <th>Jumlah {{ @$jenis_hiburan->hiburan_jenis_kapasitas_label }}</th>
                @endif

                <th>Hari Kerja</th>
                <th>Hari Libur</th>
                
                <th>Potensi Pajak Per Ruangan</th>
                <th>Potensi Pajak Hiburan</th>
            @else
                <th>Hari Kerja</th>
                <th>Hari Libur</th>
                
                @if(!$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                    <th>Hari Kerja</th>
                    <th>Hari Libur</th>
                @else
                    @foreach($jenis_hiburan->kunjungan as $jenis_hiburan_kunjungan)
                        <th>Hari Kerja {{ '(' . @$jenis_hiburan_kunjungan->hiburan_kunjungan_deskripsi . ')' }}</th>
                        <th>Hari Libur {{ '(' . @$jenis_hiburan_kunjungan->hiburan_kunjungan_deskripsi . ')' }}</th>
                    @endforeach
                @endif

                <th>Potensi Pajak Hiburan</th>
            @endif

        </tr>
    </thead>
    <tbody>
        @foreach($hiburans as $row)
        <tr>
            <td>{{ @$row->hiburan_pemilik }}</td>
            <td>{{ @$row->hiburan_nama }}</td>
            <td>{{ @$row->hiburan_jenis_deskripsi }}</td>
            <td>{{ @$row->hiburan_kategori_deskripsi }}</td>
            <td>{{ @$row->hiburan_telepon }}</td>
            <td>{{ @$row->hiburan_npwpd }}</td>
            <td>{{ @$row->hiburan_alamat }}</td>
            <td>{{ @$row->hiburan_kecamatan }}</td>
            <td>{{ @$row->hiburan_kelurahan }}</td>
            <td>{{ @$row->hiburan_rt }}</td>
            <td>{{ @$row->hiburan_rw }}</td>
            <td>{{ @$row->hiburan_foto ? (str_contains($row->hiburan_foto, 'http') ? $row->hiburan_foto : asset('uploads/hiburan/'.$row->hiburan_foto)) : '' }}</td>
            
            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
            <td>{{ @$row->hiburan_jumlah }}</td>
            @endif

            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !$jenis_hiburan->hiburan_jenis_have_ruangan)
            <td>{{ @$row->hiburan_kapasitas }}</td>
            @endif

            <td>{{ @$row->hiburan_persentase_pajak }}</td>
            <td>{{ @$row->status_aktif_deskripsi }}</td>
            <td>{{ @$row->hiburan_latitude }}</td>
            <td>{{ @$row->hiburan_longitude }}</td>

            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && !$jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                <td>{{ @$row->hiburan_tarif }}</td>
            @endif

            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                @foreach($jenis_hiburan->tarif as $key => $jenis_hiburan_tarif)
                    <td>{{ @$row->tarif->slice($key, 1)->first()->hiburan_tarif_value }}</td>
                @endforeach
            @endif

            <td>{{ @$row->hiburan_jam_weekdays ?? @$row->hiburan_jenis_ruangan_jam_weekdays }}</td>
            <td>{{ @$row->hiburan_jam_weekends ?? @$row->hiburan_jenis_ruangan_jam_weekends }}</td>

            @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                <td>{{ @$row->hiburan_jenis_ruangan_deskripsi }}</td>
                <td>{{ @$row->hiburan_jenis_ruangan_tarif }}</td>
                <td>{{ @$row->hiburan_jenis_ruangan_jumlah }}</td>

                @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label)
                    <th>Jumlah {{ @$row->hiburan_jenis_ruangan_kapasitas }}</th>
                @endif

                <td>{{ @$row->hiburan_jenis_ruangan_avg_weekdays }}</td>
                <td>{{ @$row->hiburan_jenis_ruangan_avg_weekends }}</td>
                
                <td>{{ @$row->hiburan_jenis_ruangan_potensi_pajak }}</td>
                <td>{{ @$row->hiburan_potensi_pajak }}</td>
            @else
                <td>{{ @$row->situasi_kunjungan_weekdays }}</td>
                <td>{{ @$row->situasi_kunjungan_weekends }}</td>
                
                @if(!$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                    <td>{{ @$row->tingkat_kunjungan_weekdays }}</td>
                    <td>{{ @$row->tingkat_kunjungan_weekends }}</td>
                @else
                    @foreach($jenis_hiburan->kunjungan as $key => $jenis_hiburan_kunjungan)
                        <td>{{ @$row->kunjungan->slice($key, 1)->first()->hiburan_tarif_weekdays_value }}</td>
                        <td>{{ @$row->kunjungan->slice($key, 1)->first()->hiburan_tarif_weekends_value }}</td>
                    @endforeach
                @endif

                <td>{{ @$row->hiburan_potensi_pajak }}</td>
            @endif

        </tr>
        @endforeach
    </tbody>
</table>
