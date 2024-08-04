<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rekapitulasi Tingkat Hunian Hotel</title>
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
                <img src="{{ asset('backend') }}/assets/images/logo/logo-icon.png" alt="Logo Bekasi">
            </td>
            <td>
                <h2 class="text-center m-0">PEMERINTAH KOTA BEKASI</h2>
                <h2 class="text-center m-0 mb-2">LAPORAN PERHITUNGAN TINGKAT HUNIAN (OKUPANSI) HOTEL</h2>
                <p class="text-center m-0"><em>per Tanggal {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</em></p>
            </td>
        </tr>
    </table>
    <table class="data-body">
            <tr>
                <th rowspan="2" class="first-col">No</th>
                <th rowspan="2">Nama Hotel dan Nama Pemilik</th>
                <th rowspan="2">Alamat Nomor Telepon</th>
                <th colspan="2">Klasifikasi</th>
                <th colspan="4">Frekuensi Jumlah Hari (FJH)</th>
                <th colspan="4">Bobot FJH</th>
                <th colspan="4">Jumlah Kamar Terpakai</th>
                <th colspan="4">Tingkat Hunian (Bobot FJH x JKT)</th>
                <th rowspan="2">Jumlah Tingkat Hunian</th>
            </tr>
            <tr>
                <th class="first-col">Hotel</th>
                <th>Kamar</th>
                <th>Ramai Penuh</th>
                <th>Ramai Akhir Pekan</th>
                <th>Normal</th>
                <th>Sepi</th>
                <th>Ramai Penuh</th>
                <th>Ramai Akhir Pekan</th>
                <th>Normal</th>
                <th>Sepi</th>
                <th>Ramai Penuh</th>
                <th>Ramai Akhir Pekan</th>
                <th>Normal</th>
                <th>Sepi</th>
                <th>Ramai Penuh</th>
                <th>Ramai Akhir Pekan</th>
                <th>Normal</th>
                <th>Sepi</th>
            </tr>
            <tr class="secondary-header">
                <th class="text-center first-col">1</th>
                <th class="text-center">2</th>
                <th class="text-center">3</th>
                <th class="text-center">4</th>
                <th class="text-center">5</th>
                <th class="text-center">6</th>
                <th class="text-center">7</th>
                <th class="text-center">8</th>
                <th class="text-center">9</th>
                <th class="text-center">10 = 6/(6+7+8+9)</th>
                <th class="text-center">11 = 7/(6+7+8+9)</th>
                <th class="text-center">12 = 8/(6+7+8+9)</th>
                <th class="text-center">13 = 9/(6+7+8+9) </th>
                <th class="text-center">14</th>
                <th class="text-center">15</th>
                <th class="text-center">16</th>
                <th class="text-center">17</th>
                <th class="text-center">18 = 10x14</th>
                <th class="text-center">19 = 11x15</th>
                <th class="text-center">20 = 12x16</th>
                <th class="text-center">21 = 13x17</th>
                <th class="text-center">22 = 18+19+20+21</th>
            </tr>
            @foreach($hotels as $key => $row)
                @foreach($row->jenis_kamar()->get() as $keyKamar => $rowKamar)
                <tr>
                    @if($keyKamar === 0)
                        <td class="text-center first-col" rowspan="{{ $row->jenis_kamar()->count() }}">{{ $key + 1 }}</td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">
                            <strong>{{ @$row->hotel_nama ?? '-' }}</strong><br>
                            {{ @$row->hotel_pemilik ?? '-' }}
                        </td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">
                            <strong>{{ @$row->hotel_alamat ?? '-' }}</strong><br>
                            {{ @$row->hotel_telepon ?? '-' }}
                        </td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->klasifikasi->hotel_klasifikasi_deskripsi ?? '-' }}</td>
                    @endif
                    <td>{{ @$rowKamar->hotel_jenis_kamar_deskripsi ?? '-' }}</td>

                    @if($keyKamar === 0)
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->tingkat_hunian->kunjungan_penuh }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->tingkat_hunian->kunjungan_akhir_pekan }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->tingkat_hunian->kunjungan_normal }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->tingkat_hunian->kunjungan_sepi }}</td>

                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ (new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_penuh, $row->tingkat_hunian) }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ (new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_akhir_pekan, $row->tingkat_hunian) }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ (new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_normal, $row->tingkat_hunian) }}</td>
                        <td class="text-right" rowspan="{{ $row->jenis_kamar()->count() }}">{{ (new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_sepi, $row->tingkat_hunian) }}</td>
                    @endif

                    <td class="text-right">{{ @$rowKamar->hotel_jenis_kamar_avg_penuh ?? '0' }}</td>
                    <td class="text-right">{{ @$rowKamar->hotel_jenis_kamar_avg_akhir_pekan ?? '0' }}</td>
                    <td class="text-right">{{ @$rowKamar->hotel_jenis_kamar_avg_normal ?? '0' }}</td>
                    <td class="text-right">{{ @$rowKamar->hotel_jenis_kamar_avg_sepi ?? '0' }}</td>

                    <td class="text-right">{{ round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_penuh, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_penuh, 4) }}</td>
                    <td class="text-right">{{ round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_akhir_pekan, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_akhir_pekan, 4) }}</td>
                    <td class="text-right">{{ round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_normal, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_normal, 4) }}</td>
                    <td class="text-right">{{ round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_sepi, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_sepi, 4) }}</td>

                    @php
                        $total_tingkat_hunian = round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_penuh, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_penuh, 4)
                                + round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_akhir_pekan, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_akhir_pekan, 4)
                                + round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_normal, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_normal, 4)
                                + round((new \App\Services\HotelService())->getBobotFJH($row->tingkat_hunian->kunjungan_sepi, $row->tingkat_hunian, false) * @$rowKamar->hotel_jenis_kamar_avg_sepi, 4);
                    @endphp
                    <td class="text-right">{{ $total_tingkat_hunian }}</td>
                </tr>
                @endforeach
            @endforeach
    </table>
    <p class="text-right">Bekasi, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</p>
</body>
</html>
