<table>
    <thead>
    <tr>
        <th>Kecamatan</th>
        @for($i = 2018; $i <= date('Y'); $i++)
            <th class="text-center">{{ $i }}</th>
            <th class="text-center">WP {{ $i }}</th>
        @endfor
        <th class="text-center">n/a</th>
        <th class="text-center">WP n/a</th>
        <th class="text-center">Jumlah</th>
    </tr>
    </thead>
    <tbody>
    <?php
    $rowCount = [];
    $wpCount = [];
    $totalCount = 0;
    ?>
    @foreach($recapitulations as $kecamatan)
        <?php 
            $colCount = 0; 
        ?>
        <tr>
            <td>{{ $kecamatan['kecamatan'] }}</td>
            @for($i = 2018; $i <= date('Y'); $i++)
                <?php
                $rekapitulasiKey = array_search($i, array_column($kecamatan['rekapitulasi'], 'tahun'));
                $jumlah = (@$rekapitulasiKey || $rekapitulasiKey === 0) ? $kecamatan['rekapitulasi'][$rekapitulasiKey]->jumlah : 0;
                $jumlahWp = ((@$rekapitulasiKey || $rekapitulasiKey === 0) && $jumlah > 0) ? $kecamatan['rekapitulasi'][$rekapitulasiKey]->jumlah_wp : 0;
                $rowCount[$i] = (@$rowCount[$i] ?? 0) + $jumlah;
                $wpCount[$i] = (@$wpCount[$i] ?? 0) + $jumlahWp;
                $colCount += $jumlah;
                ?>
                <td class="text-center">{{ @$jumlah }}</td>
                <td class="text-center">{{ @$jumlahWp }}</td>
            @endfor
            <?php
            $nullKey = array_search(null, array_column($kecamatan['rekapitulasi'], 'tahun'));
            $jumlah = (@$nullKey || $nullKey === 0) ? $kecamatan['rekapitulasi'][$nullKey]->jumlah_null : 0;
            $jumlahWp = ((@$nullKey || $nullKey === 0) && $jumlah > 0) ? $kecamatan['rekapitulasi'][$nullKey]->jumlah_wp : 0;
            $rowCount[0] = (@$rowCount[0] ?? 0) + $jumlah;
            $wpCount[0] = (@$wpCount[0] ?? 0) + $jumlahWp;
            $colCount += $jumlah;
            ?>
            <td class="text-center">{{ @$jumlah }}</td>
            <td class="text-center">{{ @$jumlahWp }}</td>

            <td class="text-center">{{ $colCount }}</td>
        </tr>
    @endforeach
    </tbody>
    <tfoot>
    <tr>
        <th>Total</th>
        @for($i = 2018; $i <= date('Y'); $i++)
            <th class="text-center">{{ $rowCount[$i] }}</th>
            <th class="text-center">{{ $wpCount[$i] }}</th>
            <?php $totalCount += $rowCount[$i]; ?>
        @endfor
        <th class="text-center">{{ $rowCount[0] }}</th>
        <th class="text-center">{{ $wpCount[0] }}</th>
        <th class="text-center">{{ $totalCount + $rowCount[0] }}</th>
    </tr>
    </tfoot>
</table>
