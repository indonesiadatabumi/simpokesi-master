<?php 
	$tahunRealisasi = [];
	$realisasiFirst = (json_decode($realisasi[0]['realisasi'], true));
	foreach ($realisasiFirst['data'] as $r) {
		$tahunRealisasi[$r['periode']] = $r['total_realisasi'];
	}

	ksort($tahunRealisasi);

	$newTahunRealisasi = [];
	for ($i=$startYear; $i <= $endYear; $i++) { 
		$newTahunRealisasi[$i] = $tahunRealisasi[$i];
	}
	$tahunRealisasi = $newTahunRealisasi;
	// print_r($newTahunRealisasi);
?>

<table rules="all" border="1">
	<?php 
		$colsppanAll = (count($tahunRealisasi)*4) + 2;
	?>
	<tr>
		<th colspan="<?= $colsppanAll ?>">
			REALISASI PENDAPATAN ASLI DAERAH KOTA BEKASI TAHUN <?= date("Y") ?>
		</th>
	</tr>
	<tr>
		<th rowspan="3">Kode Rekening</th>
		<th rowspan="3">Uraian</th>
		@foreach($tahunRealisasi as $k=>$v)
		<th colspan="4" align="center">{{ $k }}</th>
		@endforeach
	</tr>
	<tr>
		@foreach($tahunRealisasi as $k=>$v)
		<th rowspan="2">Target</th>
		<th colspan="2">Realisasi</th>
		<th rowspan="2">Sisa Lebih<br>/ (Kurang)</th>
		@endforeach
	</tr>
	<tr>
		@foreach($tahunRealisasi as $k=>$v)
		<th>Rp</th>
		<th>%</th>
		@endforeach
	</tr>
	<?php 
		foreach ($realisasi as $jp) :
			$detailRealisasi = (json_decode($jp['realisasi'], true));

			$detailTahunRealisasi = [];
			foreach ($detailRealisasi['data'] as $r) {
				$detailTahunRealisasi[$r['periode']] = $r['total_realisasi'];
			}
	?>
		<tr>
			<td><?= $jp['code'] ?></td>
			<td><?= $jp['name'] ?></td>
			<!-- start -->
			<?php foreach($tahunRealisasi as $k=>$v):?>
				<?php 
					$targetnya = $target[$jp['id']][$k];
				?>
				<td><?= $targetnya ?></td>
				<td>
					<?= $detailTahunRealisasi[$k] ?>
				</td><!-- Realisasi Rp-->
				<td>
					<?php 
						$persentaseRealisasi = ($detailTahunRealisasi[$k] / $targetnya) * 100;
						echo floor($persentaseRealisasi * 100) / 100;
					?>
				</td>
				<td>
					<?= $detailTahunRealisasi[$k] - $targetnya  ?>
				</td>
			<?php endforeach;?>
			
			<!-- end -->
		</tr>
	<?php endforeach;?>
</table>