<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rekapitulasi Potensi Pajak Parkir</title>
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
                <h2 class="text-center m-0 mb-2">LAPORAN PERHITUNGAN POTENSI PAJAK PARKIR</h2>
                <p class="text-center m-0"><em>per Tanggal {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</em></p>
            </td>
        </tr>
    </table>
    <table class="data-body">
        <tr>
            <th rowspan="2" class="first-col">No</th>
            <th rowspan="2">Nama Tempat dan Nama Pemilik</th>
            <th rowspan="2">Alamat Nomor Telepon</th>
            <th colspan="2">SRP</th>
            <th colspan="2">Tarif</th>
            <th colspan="6">Situasi Kunjungan Kendaraan</th>
            <th colspan="6">Tingkat Kunjungan Kendaraan</th>
            <th rowspan="2">Durasi Rerata Parkir</th>
            <th colspan="3">Potensi Pajak Parkir Setahun</th>
        </tr>
        <tr>
            <th>Mobil</th>
            <th>Motor</th>
            <th>Mobil (Rp)</th>
            <th>Motor (Rp)</th>
            <th>Mobil - Ramai (hari)</th>
            <th>Mobil - Normal (hari)</th>
            <th>Mobil - Sepi (hari)</th>
            <th>Motor - Ramai (hari)</th>
            <th>Motor - Normal (hari)</th>
            <th>Motor - Sepi (hari)</th>
            <th>Mobil - Ramai (orang)</th>
            <th>Mobil - Normal (orang)</th>
            <th>Mobil - Sepi (orang)</th>
            <th>Motor - Ramai (orang)</th>
            <th>Motor - Normal (orang)</th>
            <th>Motor - Sepi (orang)</th>
            <th>Mobil (Rp)</th>
            <th>Motor (Rp)</th>
            <th>Jumlah (Rp)</th>
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
            <th class="text-center">10</th>
            <th class="text-center">11</th>
            <th class="text-center">12</th>
            <th class="text-center">13</th>
            <th class="text-center">14</th>
            <th class="text-center">15</th>
            <th class="text-center">16</th>
            <th class="text-center">17</th>
            <th class="text-center">18</th>
            <th class="text-center">19</th>
            <th class="text-center">20</th>
            <th class="text-center">21</th>
            <th class="text-center">22</th>
            <th class="text-center">23 = 21+22</th>
        </tr>

        @foreach($parkirs as $key => $row)
            <tr>
                <td class="text-center first-col">{{ $key + 1 }}</td>
                <td>
                    <strong>{{ @$row->parkir_nama ?? '-' }}</strong><br>
                    {{ @$row->parkir_pemilik ?? '-' }} <br>
                    Persentase: {{ @$row->parkir_persentase_pajak }}%
                </td>
                <td>
                    <strong>{{ @$row->parkir_alamat ?? '-' }}</strong><br>
                    {{ @$row->parkir_telepon ?? '-' }}
                </td>
                <td class="text-right">{{ generateNumber(@$row->parkir_srp_mobil) }}</td>
                <td class="text-right">{{ generateNumber(@$row->parkir_srp_motor) }}</td>

                <td class="text-right">{{ generateRupiah(@$row->parkir_tarif_mobil, false) }}</td>
                <td class="text-right">{{ generateRupiah(@$row->parkir_tarif_motor, false) }}</td>

                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_situasi_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_situasi_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_situasi_kunjungan_sepi) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_situasi_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_situasi_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_situasi_kunjungan_sepi) }}</td>

                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_avg_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_avg_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->mobil_avg_kunjungan_sepi) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_avg_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_avg_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->motor_avg_kunjungan_sepi) }}</td>

                <td class="text-right">{{ generateNumber(@$row->parkir_durasi_avg) }}</td>

                <td class="text-right">{{ generateRupiah(@$row->parkir_potensi_pajak_mobil, false) }}</td>
                <td class="text-right">{{ generateRupiah(@$row->parkir_potensi_pajak_motor, false) }}</td>
                <td class="text-right">{{ generateRupiah(@$row->parkir_potensi_pajak, false) }}</td>
            </tr>
        @endforeach
        <tr>
            <th class="text-center first-col" colspan="22">JUMLAH</th>
            <th class="text-right">{{ generateRupiah($parkirs->sum('parkir_potensi_pajak'), false) }}</th>
        </tr>
    </table>
    <p class="text-right">Bekasi, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</p>
</body>
</html>
