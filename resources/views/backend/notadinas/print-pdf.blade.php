<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nota Dinas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: auto;
            width: 780px;
            font-size: 13px;
/*            line-height: 1.5;*/
margin-top: 50px;
        }
        header, footer {
            text-align: center;
            margin-bottom: 20px;
        }
        .content {
            margin-top: 20px;
        }
        /*table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }*/
        @media print {
            .pagebreak { page-break-before: always; } /* page-break-after works, as well */
        }
    </style>
</head>
<body>
<table width="100%">
    <tr>
        <td rowspan="4" align="center">
            <img src="{{ public_path('frontend/images/logo.png') }}" alt="Gambar" height="100">
        </td>
        <td align="center">
            PEMERINTAH KOTA BEKASI
        </td>
    </tr>
    <tr>
        <td style="text-align: center; font-weight: bold; font-size: 20px;">
            BADAN PENDAPATAN DAERAH
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold; text-align: center;">
            UPTD PAJAK DAN RETRIBUSI DAERAH WILAYAH {{ $wilayah->kecamatan }}
        </td>
    </tr>
    <tr>
        <td style="text-align: center; font-size: 13px">
            <!-- Jalan Raya Narogong Km. 10 Nomor 17, RT 004, Kelurahan Bantargebang -->
            <?= nl2br($wilayah->alamat) ?>
        </td>
    </tr>
</table>
<div style="border-top: 3px solid black;border-bottom: 1px solid black; height: 2px;margin-bottom: 15px; margin-top: 10px;">
    
</div>
<center>
    NOTA DINAS  
</center>
<br>
<table cellspacing="1" cellpadding="1">
    <tr>
        <td width="100">Yth.</td>
        <td width="15">:</td>
        <td>Kepala Bidang Perencanaan dan Pengembangan Pendapatan Daerah</td>
    </tr>
    <tr>
        <td>Tembusan</td>
        <td>:</td>
        <td>Yth. Kepala Badan Pendapatan Daerah Kota Bekasi</td>
    </tr>
    <tr>
        <td>Dari</td>
        <td>:</td>
        <td>Kepala UPTD Pajak dan Retribusi Daerah Wilayah : <?= ucwords(strtolower($wilayah->kecamatan)) ?></td>
    </tr>
    <tr>
        <td>Tanggal</td>
        <td>:</td>
        <td> {{ $tanggalSurat }}</td>
    </tr>
    <tr>
        <td>Nomor</td>
        <td>:</td>
        <td></td>
    </tr>
    <tr>
        <td>Sifat</td>
        <td>:</td>
        <td>Biasa</td>
    </tr>
    <tr>
        <td>Lampiran</td>
        <td>:</td>
        <td>2 Berkas</td>
    </tr>
    <tr>
        <td>Hal</td>
        <td>:</td>
        <td>Laporan Rekapitulasi Hasil Pemutakhiran Data Profil Wajib Pajak Daerah</td>
    </tr>
</table>
<div style="border-bottom: 1px solid black; height: 2px;margin-bottom: 15px; margin-top: 10px;"></div>
<div class="content">
    <p>Dalam rangka penyusunan potensi pajak daerah, kami telah melakukan pendataan dan penginputan hasil data wajib pajak daerah pada Web Simpokesi.</p>
    <p>Bersama ini kami sampaikan rekapitulasi wajib pajak daerah yang telah diinput atau diperbaharui dari tanggal {{ $startDate }} s.d tanggal {{ $endDate }} , serta formulir hasil pendataan yang telah ditandatangani sesuai dengan data yang telah terinput pada Web Simpokesi.</p>
    <p>Demikian kami sampaikan, agar maklum.</p>
</div>
<br>
<br>
<br>
<table width="100%">
    <tr>
        <td width="33%"></td>
        <td width="33%"></td>
        <td width="33%">
            Kepala UPTD Pajak dan Retribusi<br>
            Daerah Wilayah <?= ucwords(strtolower($wilayah->kecamatan)) ?><br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <?= $wilayah->nama_ka_uptd ?><br>
            <?= $wilayah->golongan ?><br>
            <?= $wilayah->nip ?>
        </td>
    </tr>
</table>
<div class="pagebreak"> </div>
<table width="100%" style="margin-top: 70px;">
    <tr>
        <td width="50%"></td>
        <td valign="top">Lampiran</td>
        <td>:</td>
        <td>Nota Dinas Kepala UPTD Pajak dan Retribusi<br>Daerah Wilayah <?= ucwords(strtolower($wilayah->kecamatan)) ?></td>
    </tr>
    <tr>
        <td></td>
        <td>Nomor</td>
        <td>:</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>Tanggal</td>
        <td>:</td>
        <td>{{ $tanggalSurat }}</td>
    </tr>
</table><br>
<p>
    
Daftar WP yang telah dilakukan pembaharuan pada Web Simpokesi dari tanggal {{ $startDate }} s.d tanggal {{ $endDate }}
</p>
<table width="100%" rules="all" border="1">
    <thead>
        <tr>
            <th align="center" width="25">No.</th>
            <th align="center">Nama</th>
            <th align="center">NPWPD</th>
            <th align="center">Jenis Pajak</th>
        </tr>
    </thead>
    <tbody>
        <?php 
            $no = 1;
            if(isset($hotels)){
                foreach ($hotels as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->hotel_nama</td>
                        <td align='center'>$r->hotel_npwpd</td>
                        <td align='center'>Pajak Hotel</td>
                    </tr>";
                    $no++;
                }
            }

            if(isset($restorans)){
                foreach ($restorans as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->restoran_nama</td>
                        <td align='center'>$r->restoran_npwpd</td>
                        <td align='center'>Pajak Restoran</td>
                    </tr>";
                    $no++;
                }
            }

            if(isset($hiburans)){
                foreach ($hiburans as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->hiburan_nama</td>
                        <td align='center'>$r->hiburan_npwpd</td>
                        <td align='center'>Pajak Hiburan</td>
                    </tr>";
                    $no++;
                }
            }

            if(isset($parkirs)){
                foreach ($parkirs as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->parkir_nama</td>
                        <td align='center'>$r->parkir_npwpd</td>
                        <td align='center'>Pajak Parkir</td>
                    </tr>";
                    $no++;
                }
            }

            if(isset($airs)){
                foreach ($airs as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->nama</td>
                        <td align='center'>$r->npwpd</td>
                        <td align='center'>Pajak Air Tanah</td>
                    </tr>";
                    $no++;
                }
            }

            if(isset($penerangans)){
                foreach ($penerangans as $r) {
                    echo "<tr>
                        <td align='center'>$no</td>
                        <td align='center'>$r->nama</td>
                        <td align='center'>$r->npwpd</td>
                        <td align='center'>Pajak Penerangan Jalan</td>
                    </tr>";
                    $no++;
                }
            }
        ?>
    </tbody>
</table>
<br>
<br>
<br>
<table width="100%">
    <tr>
        <td width="33%"></td>
        <td width="33%"></td>
        <td width="33%">
            Kepala UPTD Pajak dan Retribusi<br>
            Daerah Wilayah <?= ucwords(strtolower($wilayah->kecamatan)) ?><br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <?= $wilayah->nama_ka_uptd ?><br>
            <?= $wilayah->golongan ?><br>
            <?= $wilayah->nip ?>
        </td>
    </tr>
</table>
</body>
</html>
