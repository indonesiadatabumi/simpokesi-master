<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rekapitulasi Potensi Pajak Restoran {{ ucfirst($tipe) }}</title>
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
                <h2 class="text-center m-0 mb-2">LAPORAN PERHITUNGAN POTENSI PAJAK RESTORAN {{ strtoupper($tipe) }}</h2>
                <p class="text-center m-0"><em>per Tanggal {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</em></p>
            </td>
        </tr>
    </table>
    <table class="data-body">
        <tr>
            <th rowspan="2" class="first-col">No</th>
            <th rowspan="2">Nama Restoran dan Nama Pemilik</th>
            <th rowspan="2">Alamat Nomor Telepon</th>
            <th rowspan="2">Jenis Restoran</th>
            <th rowspan="2">Kapasitas Kursi Restoran</th>
            <th colspan="3">Situasi Pesanan / Kunjungan Tamu</th>
            <th colspan="3">Tingkat Pesanan / Kunjungan Tamu</th>
            <th rowspan="2">Pengeluaran Rerata Pesanan / Tamu per Makan (Rp)</th>
            <th colspan="4">Potensi Pajak Restoran Setahun</th>
        </tr>
        <tr>
            <th>Ramai (hari)</th>
            <th>Normal (hari)</th>
            <th>Sepi (hari)</th>
            <th>Ramai (orang / pesanan)</th>
            <th>Normal (orang / pesanan)</th>
            <th>Sepi (orang / pesanan)</th>
            <th>Ramai (Rp)</th>
            <th>Normal (Rp)</th>
            <th>Sepi (Rp)</th>
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
            <th class="text-center">13 = 6x9*12*Persentase</th>
            <th class="text-center">14 = 7x10*12*Persentase</th>
            <th class="text-center">15 = 8x11*12*Persentase</th>
            <th class="text-center">16 = 13+14+15</th>
        </tr>

        @foreach($restorans as $key => $row)
            <tr>
                <td class="text-center first-col">{{ $key + 1 }}</td>
                <td>
                    <strong>{{ @$row->restoran_nama ?? '-' }}</strong><br>
                    {{ @$row->restoran_pemilik ?? '-' }} <br>
                    NPWPD: {{ @$row->restoran_npwpd ?? '-' }}<br>
                    Persentase: {{ @$row->restoran_persentase_pajak }}%
                </td>
                <td>
                    <strong>{{ @$row->restoran_alamat ?? '-' }}</strong><br>
                    {{ @$row->restoran_telepon ?? '-' }}
                </td>
                <td>{{ @$row->klasifikasi->restoran_klasifikasi_deskripsi ?? '-' }}</td>
                <td class="text-right">{{ generateNumber(@$row->restoran_kapasitas_kursi) }}</td>

                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->situasi_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->situasi_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->situasi_kunjungan_sepi) }}</td>

                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->avg_kunjungan_ramai) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->avg_kunjungan_normal) }}</td>
                <td class="text-right">{{ generateNumber(@$row->tingkat_kunjungan->avg_kunjungan_sepi) }}</td>

                <td class="text-right">{{ generateRupiah(@$row->restoran_pengeluaran_avg, false) }}</td>

                <td class="text-right">{{ (new \App\Services\RestoranService())->getPotensiSituasiKunjungan($row, 'ramai') }}</td>
                <td class="text-right">{{ (new \App\Services\RestoranService())->getPotensiSituasiKunjungan($row, 'normal') }}</td>
                <td class="text-right">{{ (new \App\Services\RestoranService())->getPotensiSituasiKunjungan($row, 'sepi') }}</td>
                <td class="text-right">{{ generateRupiah(@$row->restoran_potensi_pajak, false) }}</td>
            </tr>
        @endforeach
        <tr>
            <th class="text-center first-col" colspan="15">JUMLAH</th>
            <th class="text-right">{{ generateRupiah($restorans->sum('restoran_potensi_pajak'), false) }}</th>
        </tr>
    </table>
    <p class="text-right">Bekasi, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}</p>
</body>
</html>
