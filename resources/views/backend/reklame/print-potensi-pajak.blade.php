<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rekapitulasi Potensi Pajak Reklame</title>
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
                <h2 class="text-center m-0 mb-2">LAPORAN PERHITUNGAN POTENSI PAJAK HOTEL</h2>
                <p class="text-center m-0"><em>per Tanggal {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</em></p>
            </td>
        </tr>
    </table>
    <table class="data-body">
        <tr>
            <th rowspan="2" class="first-col">No</th>
            <th rowspan="2">Nama Reklame dan Nama Pemilik</th>
            <th rowspan="2">Alamat Nomor Telepon</th>
            <th colspan="2">Klasifikasi</th>
            <th rowspan="2">Tingkat Hunian</th>
            <th rowspan="2">Tarif Kamar (Rp)</th>
            <th rowspan="2">Potensi Pajak (Rp)</th>
        </tr>
        <tr>
            <th>Reklame</th>
            <th>Kamar</th>
        </tr>
        <tr class="secondary-header">
            <th class="text-center first-col">1</th>
            <th class="text-center">2</th>
            <th class="text-center">3</th>
            <th class="text-center">4</th>
            <th class="text-center">5</th>
            <th class="text-center">6</th>
            <th class="text-center">7</th>
            <th class="text-center">8 = (6x7) x 365 x Persentase</th>
        </tr>

        @foreach($reklames as $key => $row)
            @if($row->jenis_kamar()->count() > 0)
                @foreach($row->jenis_kamar()->get() as $keyKamar => $rowKamar)
                <tr>
                    @if($keyKamar === 0)
                        <td class="text-center first-col" rowspan="{{ $row->jenis_kamar()->count() }}">{{ $key + 1 }}</td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">
                            <strong>{{ @$row->reklame_nama ?? '-' }}</strong><br>
                            {{ @$row->reklame_pemilik ?? '-' }} <br>
                            Persentase: {{ @$row->reklame_persentase_pajak }}%
                        </td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">
                            <strong>{{ @$row->reklame_alamat ?? '-' }}</strong><br>
                            {{ @$row->reklame_telepon ?? '-' }}
                        </td>
                        <td rowspan="{{ $row->jenis_kamar()->count() }}">{{ @$row->klasifikasi->reklame_klasifikasi_deskripsi ?? '-' }}</td>
                    @endif
                    <td>{{ @$rowKamar->reklame_jenis_kamar_deskripsi ?? '-' }}</td>

                    @php
                        $total_tingkat_hunian = round((new \App\Services\ReklameService())->getBobotFJH($row->tingkat_hunian->kunjungan_penuh, $row->tingkat_hunian, false) * @$rowKamar->reklame_jenis_kamar_avg_penuh, 4)
                                + round((new \App\Services\ReklameService())->getBobotFJH($row->tingkat_hunian->kunjungan_akhir_pekan, $row->tingkat_hunian, false) * @$rowKamar->reklame_jenis_kamar_avg_akhir_pekan, 4)
                                + round((new \App\Services\ReklameService())->getBobotFJH($row->tingkat_hunian->kunjungan_normal, $row->tingkat_hunian, false) * @$rowKamar->reklame_jenis_kamar_avg_normal, 4)
                                + round((new \App\Services\ReklameService())->getBobotFJH($row->tingkat_hunian->kunjungan_sepi, $row->tingkat_hunian, false) * @$rowKamar->reklame_jenis_kamar_avg_sepi, 4);
                    @endphp
                    <td class="text-right">{{ $total_tingkat_hunian }}</td>
                    <td class="text-right">{{ generateRupiah($rowKamar->reklame_jenis_kamar_tarif, false) }}</td>
                    <td class="text-right">{{ generateRupiah($rowKamar->reklame_jenis_kamar_potensi_pajak, false) }}</td>
                </tr>
                @endforeach

                <tr>
                    <th class="text-center first-col" colspan="7">Sub Total</th>
                    <th class="text-right">{{ generateRupiah($row->jenis_kamar()->get()->sum('reklame_jenis_kamar_potensi_pajak'), false) }}</th>
                </tr>
            @endif
        @endforeach
        <tr>
            <th class="text-center first-col" colspan="7">TOTAL POTENSI PENDAPATAN PAJAK</th>
            <th class="text-right">{{ generateRupiah($reklames->sum('reklame_potensi_pajak'), false) }}</th>
        </tr>
    </table>
    <p class="text-right">Bekasi, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</p>
</body>
</html>
