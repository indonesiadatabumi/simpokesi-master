<?php
    function generateDate($date, $date_format)
    {
        if(@$date){
            return \Carbon\Carbon::createFromFormat('Y-m-d', $date)->format($date_format);
        }else{
            return '-';
        }
    }

    function generateRupiah($string, $withRp = true)
    {
        if(@$string){
            return $withRp ? 'Rp. '.number_format($string,2,',','.') : number_format($string,2,',','.');
        }else{
            return $withRp ? 'Rp. 0' : '0';
        }
    }

    function generateNumber($string)
    {
        if(@$string){
            return number_format($string,0,',','.');
        }else{
            return '0';
        }
    }

    function toUpper($string)
    {
        return @$string ? strtoupper($string) : null;
    }

function numIndo($num,$precision=2,$decimal='.',$thousand=','){
  if (is_null($num)) {
    return 0;
  }
  if($num===''){
   return null;
  }
  $num = (float) $num;
  return number_format($num,$precision,$decimal,$thousand);
}

function jenisPajak()
    {
        $jenisPajak = [
            ['id' => 1, 'code' => '4.1.01.06', 'name' => 'Pajak Hotel'],
            ['id' => 2, 'code' => '4.1.01.07', 'name' => 'Pajak Restoran'],
            ['id' => 3, 'code' => '4.1.01.08', 'name' => 'Pajak Hiburan'],
            ['id' => 4, 'code' => '4.1.01.09', 'name' => 'Pajak Reklame'],
            ['id' => 6, 'code' => '4.1.01.10', 'name' => 'Pajak Penerangan Jalan'],
            ['id' => 7, 'code' => '4.1.01.11', 'name' => 'Pajak Parkir'],
            ['id' => 8, 'code' => '4.1.01.12', 'name' => 'Pajak Air Tanah'],
        ];
        return $jenisPajak;
    }

    function foreCast($valueData=[]){
    // Input Data
    // $years = [1, 2, 3, 4, 5, 6];
        $values = [];
        foreach ($valueData as $key => $value) {
            $values[] = $value;
        }
    $years = [];
    $i = 1;
    foreach ($valueData as $key => $value) {
        $years[] = $i;
        $i++;
    }
    // dd($years);
    // $values = $valueData;
    // $values = [289873023638, 311795506420, 352436804465, 355244474867, 378656303172, 391711770952];

    // Calculate sums
    $n = count($years);
    $sumX = array_sum($years);
    $sumY = array_sum($values);
    $sumXY = 0;
    $sumX2 = 0;
    // print_r($years);
    // print_r($values);
    // exit();
    for ($i = 0; $i < $n; $i++) {
        $sumXY += $years[$i] * $values[$i];
        $sumX2 += $years[$i] * $years[$i];
    }

    // Calculate slope (m)
    $m = ($n * $sumXY - $sumX * $sumY) / ($n * $sumX2 - $sumX * $sumX);

    // Calculate intercept (b)
    $b = ($sumY - $m * $sumX) / $n;

    // Forecast for 2024 (index 7)
    // $forecastIndex = 7;
    $forecastIndex = count($years) + 1;
    $forecast = $m * $forecastIndex + $b;

    // echo "Forecast for 2024: " . number_format($forecast, 2) . "\n";
    return $forecast;
}

function apiRealisasi($idPajak)
{
    $curl = curl_init();

    $postData = json_encode([
        "jenis_pajak" => $idPajak,
        "periode" => ""
    ]);

    curl_setopt_array($curl, array(
      CURLOPT_URL => 'http://sipdah.bekasikota.go.id/api/simpokesi/data_realisasi_jenis_pajak',
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => '',
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => 'POST',
      CURLOPT_POSTFIELDS => $postData,
      CURLOPT_HTTPHEADER => array(
        'Content-Type: application/json'
      ),
    ));

    $response = curl_exec($curl);

    curl_close($curl);
    return $response;
}

function realisasiTahunSort($idPajak)
{
    $apiRealisasi = apiRealisasi($idPajak);
    $tahunRealisasi = [];
    $realisasiFirst = (json_decode($apiRealisasi, true));
    foreach ($realisasiFirst['data'] as $r) {
        $tahunRealisasi[$r['periode']] = $r['total_realisasi'];
    }

    ksort($tahunRealisasi);

    return $tahunRealisasi;
}

function realisasiFiltered($idPajak, $startYear='', $endYear='')
{
    $realisasiTahunSort  = realisasiTahunSort($idPajak);

    $newTahunRealisasi = [];
    for ($i=$startYear; $i <= $endYear; $i++) { 
        $newTahunRealisasi[$i] = $realisasiTahunSort[$i];
    }

    return $newTahunRealisasi;
}