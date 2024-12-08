<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rekapitulasi Potensi Pajak {{ $jenis_hiburan->hiburan_jenis_deskripsi }}</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        table {
            width: 100%;
        }
        .text-center {
            text-align: center;
        }
        .text-right {
            text-align: right;
        }
        .m-0 {
            margin: 0;
        }
        .mb-1 { margin-bottom: 8px; }
        .mb-2 { margin-bottom: 16px; }
        .mb-3 { margin-bottom: 24px; }
        .mb-4 { margin-bottom: 32px; }
        .mb-5 { margin-bottom: 40px; }
        .data-header {
            border-bottom: 7px groove;
            margin-bottom: 32px;
        }
        .data-body {
            border-top: 1px solid #222;
            border-bottom: none;
            border-right: none;
            border-spacing: 0;
            margin-bottom: 40px;
        }
        .data-body th,
        .data-body td {
            border-right: 1px solid #222;
            border-bottom: 1px solid #222;
            padding: 10px;
        }
        .data-body th {
            font-size: 12px;
        }
        .data-body td {
            font-size: 11px;
        }
        .data-body .secondary-header th {
            font-size: 9px;
        }
        .first-col {
            border-left: 1px solid #222;
        }
        tr {
            page-break-inside: avoid !important;
        }
    </style>
</head>
<body>
    <table class="data-header">
        <tr>
            <td>
                <img src="{{ public_path('frontend/images/logo-icon.png') }}" alt="Gambar">
            </td>
            <td>
                <h2 class="text-center m-0">PEMERINTAH KOTA BEKASI</h2>
                <h2 class="text-center m-0 mb-2">LAPORAN PERHITUNGAN POTENSI PAJAK {{ strtoupper($jenis_hiburan->hiburan_jenis_deskripsi) }}</h2>
                <p class="text-center m-0"><em>per Tanggal {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</em></p>
            </td>
        </tr>
    </table>
    <table class="data-body">
        <tr>
            <th rowspan="2" class="first-col">No</th>
            <th rowspan="2">Nama {{ $jenis_hiburan->hiburan_jenis_deskripsi }} dan Nama Pemilik</th>
            <th rowspan="2">Alamat Nomor Telepon</th>
            <th rowspan="2">Kategori</th>
            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
            <th rowspan="2">Jumlah {{ @$jenis_hiburan->hiburan_jenis_jumlah_label }}</th> 
            @endif
            
            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !$jenis_hiburan->hiburan_jenis_have_ruangan)
            <th rowspan="2">Jumlah {{ @$jenis_hiburan->hiburan_jenis_kapasitas_label }}</th> 
            @endif

            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && !$jenis_hiburan->hiburan_jenis_have_multiple_tarif)
            <th rowspan="2">{{ @$jenis_hiburan->hiburan_jenis_htm_label }}</th>
            @endif
            
            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                <th colspan="{{ $jenis_hiburan->tarif->count() }}">{{ @$jenis_hiburan->hiburan_jenis_htm_label }}</th>
            @endif

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
            @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                @foreach($jenis_hiburan->tarif as $jenis_hiburan_tarif)
                    <th>{{ $jenis_hiburan_tarif->hiburan_tarif_deskripsi }}</th>
                @endforeach
            @endif
            
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
        <tr class="secondary-header">
            @for($i = 0; $i < $col['hiburan']; $i++)
                <th class="text-center {{ $i == 0 ? 'first-col' : null }}">{{ $i+1 }}</th>
            @endfor
        </tr>

        @foreach($hiburans as $key => $row)
            <tr>
                <td class="text-center first-col" rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ $key + 1 }}</td>
                <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">
                    <strong>{{ @$row->hiburan_nama ?? '-' }}</strong><br>
                    {{ @$row->hiburan_pemilik ?? '-' }} <br>
                    Persentase: {{ @$row->hiburan_persentase_pajak }}%
                </td>
                <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">
                    <strong>{{ @$row->hiburan_alamat ?? '-' }}</strong><br>
                    {{ @$row->hiburan_telepon ?? '-' }}
                </td>
                <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ @$row->kategori->hiburan_kategori_deskripsi ?? '-' }}</td>

                @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
                <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ generateNumber(@$row->hiburan_jumlah) }}</td>
                @endif

                @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !$jenis_hiburan->hiburan_jenis_have_ruangan)
                <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ generateNumber(@$row->hiburan_kapasitas) }}</td>
                @endif

                @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && !$jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                    <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ generateRupiah(@$row->hiburan_tarif, false) }}</td>
                @endif

                @if(!$jenis_hiburan->hiburan_jenis_have_ruangan && $jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                    @foreach($jenis_hiburan->tarif as $key => $jenis_hiburan_tarif)
                        <td rowspan="{{ $row->jenis_ruangan->count()+1 }}">{{ generateRupiah(@$row->tarif->slice($key, 1)->first()->hiburan_tarif_value, false) }}</td>
                    @endforeach
                @endif

                @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                    @foreach($row->jenis_ruangan as $key => $rowRuangan)
                        <tr>
                            <td>{{ @$rowRuangan->hiburan_jenis_ruangan_deskripsi }}</td>
                            <td>{{ generateRupiah(@$rowRuangan->hiburan_jenis_ruangan_tarif, false) }}</td>
                            <td>{{ generateNumber(@$rowRuangan->hiburan_jenis_ruangan_jumlah) }}</td>

                            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label)
                                <th>{{ generateNumber(@$rowRuangan->hiburan_jenis_ruangan_kapasitas) }}</th>
                            @endif

                            <td>{{ generateNumber(@$rowRuangan->hiburan_jenis_ruangan_avg_weekdays) }}</td>
                            <td>{{ generateNumber(@$rowRuangan->hiburan_jenis_ruangan_avg_weekends) }}</td>
                            
                            <td>{{ generateRupiah(@$rowRuangan->hiburan_jenis_ruangan_potensi_pajak, false) }}</td>

                            @if ($key == 0)
                                <td rowspan="{{ $row->jenis_ruangan->count() }}">{{ generateRupiah(@$row->hiburan_potensi_pajak, false) }}</td>
                            @endif
                        </tr>
                    @endforeach
                @else
                    <td>{{ generateNumber(@$row->tingkat_kunjungan->situasi_kunjungan_weekdays) }}</td>
                    <td>{{ generateNumber(@$row->tingkat_kunjungan->situasi_kunjungan_weekends) }}</td>
                    
                    @if(!$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                        <td>{{ generateNumber(@$row->tingkat_kunjungan->tingkat_kunjungan_weekdays) }}</td>
                        <td>{{ generateNumber(@$row->tingkat_kunjungan->tingkat_kunjungan_weekends) }}</td>
                    @else
                        @foreach($jenis_hiburan->kunjungan as $key => $jenis_hiburan_kunjungan)
                            <td>{{ generateNumber(@$row->kunjungan->slice($key, 1)->first()->hiburan_tarif_weekdays_value) }}</td>
                            <td>{{ generateNumber(@$row->kunjungan->slice($key, 1)->first()->hiburan_tarif_weekends_value) }}</td>
                        @endforeach
                    @endif

                    <td>{{ generateRupiah(@$row->hiburan_potensi_pajak, false) }}</td>
                @endif
            </tr>
        @endforeach
        <tr>
            <th class="text-center first-col" colspan="{{ $col['hiburan'] - 1 }}">JUMLAH</th>
            <th class="text-right">{{ generateRupiah($hiburans->sum('hiburan_potensi_pajak'), false) }}</th>
        </tr>
    </table>
    <p class="text-right">Bekasi, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</p>
</body>
</html>
