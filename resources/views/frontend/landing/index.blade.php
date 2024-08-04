@extends('frontend.layout.app')

@push('styles')
    <style>
        .chart-container {
            width: 100%;
            height: 300px;
        }
        .features-box:hover .features-img img {
            left: 30px;
            top: 70px;
            right: auto;
            opacity: 1;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('frontend' )}}/js/counter.init.js"></script>
    <script src="{{ asset('frontend' )}}/js/echarts/echarts.min.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            // based on prepared DOM, initialize echarts instance
            var myChart = echarts.init(document.getElementById('echart-pie'));
            var colorPallete = ['#f8d62b', '#eb7f20', '#dc3545', '#000222']

            // specify chart configuration item and data
            var option = {
                aria: {
                    enabled: true
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series : [
                    {
                        name: 'Persentase Potensi Pajak',
                        type: 'pie',
                        radius : ['40%', '80%'],
                        color : colorPallete,
                        data:[
                            {value: {!! $countHotel !!}, name:'Hotel'},
                            {value: {!! $countRestoran !!}, name:'Restoran'},
                            {value: {!! $countKostan !!}, name:'Kostan'},
                            {value: {!! $countRusun !!}, name:'Rusun'}
                        ],
                        itemStyle: {
                            borderRadius: 10,
                            borderColor: '#fff',
                            borderWidth: 2
                        },
                        emphasis: {
                            itemStyle: {
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            // use configuration item and data specified to show chart
            myChart.setOption(option);
        });
    </script>
@endpush

@section('content')
<!-- START HOME -->
<section class="bg-light" id="home">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="home-contact mt-5 pt-5 text-center">


                    <h1 class="home-title mt-5">Sistem Manajemen Potensi Pajak dan Retribusi Kota Bekasi</h1>

                    <p class="text-muted mt-4 mb-0">
                        Selamat datang di Si Mpo Kesi. Aplikasi ini berguna untuk memperkirakan penerimaan berdasarkan data potensi yang dimiliki oleh Pemerintah Kota Bekasi.
                    </p>

                    <div class="home-img-2">
                        <img src="{{ asset('frontend' )}}/images/img-2.png" class="img-fluid" alt="">
                    </div>

                </div>
            </div>


        </div>
    </div>
</section>
<!-- END HOME -->

<!-- START FEATURES -->
<section class="section pb-5" id="fitur">
    <div class="container">
        <div class="row mt-5 pt-3">
            <div class="col-lg-12">
                <div class="text-center">
                    <p class="title-sub-heading text-primary f-18">Fitur Kami</p>
                    <h2 class="title-heading">Sulit Memperkirakan Potensi Pajak?</h2>
                    <p class="title-desc text-muted mt-2">Nikmati fitur yang memudahkan memperkirakan potensi penerimaan pajak Kota Bekasi disini.</p>
                </div>
            </div>
        </div>

        <div class="row mt-5 pt-4">
            <div class="col-lg-4">
                <div class="features-box mt-4">
                    <h1 class="features-title">01</h1>
                    <div class="features-img">
                        <img src="{{ asset('frontend' )}}/images/icon/rulers.png" class="img-fluid" alt="" />
                    </div>

                    <h5 class="f-18 mt-4">Monitoring Peta</h5>
                    <p class="text-muted mt-3">Dapatkan kemudahan melihat informasi mengenai dimana lokasi potensi pajak melalui peta.</p>
                    <div class="mt-3">
                        <a href="{{ url('rekapitulasi-peta') }}" class="text-primary font-weight-600"> Lebih Detail <i class="mdi mdi-arrow-right ml-2"></i> </a>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="features-box mt-4">
                    <h1 class="features-title">02</h1>
                    <div class="features-img">
                        <img src="{{ asset('frontend' )}}/images/icon/compose.png" class="img-fluid" alt="" />
                    </div>

                    <h5 class="f-18 mt-4">Monitoring Grafik</h5>
                    <p class="text-muted mt-3">Dapatkan kemudahan melihat informasi potensi pajak melalui info grafik.</p>
                    <div class="mt-3">
                        <a href="{{ url('rekapitulasi-grafik') }}" class="text-primary font-weight-600"> Lebih Detail <i class="mdi mdi-arrow-right ml-2"></i> </a>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="features-box mt-4">
                    <h1 class="features-title">03</h1>
                    <div class="features-img">
                        <img src="{{ asset('frontend' )}}/images/icon/presentation.png" class="img-fluid" alt="" />
                    </div>

                    <h5 class="f-18 mt-4">Monitoring Rekapitulasi</h5>
                    <p class="text-muted mt-3">Selain grafik dan peta, aplikasi ini juga memberikan informasi berbentuk tabel rekapitulasi.</p>
                    <div class="mt-3">
                        <a href="{{ url('rekapitulasi-tabular') }}" class="text-primary font-weight-600"> Lebih Detail <i class="mdi mdi-arrow-right ml-2"></i> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- END SERVICES -->

<!-- START COUNTER -->
<section class="section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="text-center">
                    <p class="title-sub-heading text-primary f-18">Perhitungan Data</p>
                    <h2 class="title-heading">Ada berapa data yang tersimpan?</h2>
                    <p class="title-desc text-muted mt-2">Berikut adalah perhitungan seberapa banyak data yang telah kami simpan.</p>
                </div>
            </div>
        </div>

        <div class="row align-items-center justify-content-center mt-4 pt-3">
            <div class="col-lg-6 col-md-12">
                <div class="p-4">
                    <div id="echart-pie" class="chart-container"></div>
                </div>
            </div>
        </div>

        <div class="row align-items-center justify-content-center" id="counter">
            <div class="col-lg-3 col-md-6">
                <div class="counter-box mt-4 p-4 text-center">
                    <h2 class="counter-count text-primary"><span class="counter-value" data-count="{{ $countHotel }}">0</span></h2>
                    <h5 class="mt-2 f-18">Hotel</h5>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="counter-box mt-4 p-4 text-center">
                    <h2 class="counter-count text-primary"><span class="counter-value" data-count="{{ $countRestoran }}">0</span></h2>
                    <h5 class="mt-2 f-18">Restoran</h5>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="counter-box mt-4 p-4 text-center">
                    <h2 class="counter-count text-primary"><span class="counter-value" data-count="{{ $countKostan }}">0</span></h2>
                    <h5 class="mt-2 f-18">Kostan</h5>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="counter-box mt-4 p-4 text-center">
                    <h2 class="counter-count text-primary"><span class="counter-value" data-count="{{ $countRusun }}">0</span></h2>
                    <h5 class="mt-2 f-18">Rusun</h5>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- END COUNTER -->
@endsection
