@extends('frontend.layout.app')

@push('styles')
    <style>
        .pie-chart-container {
            width: 100%;
            height: 700px;
        }
        .bar-chart-container {
            width: 100%;
            height: 350px;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('frontend' )}}/js/echarts/echarts.min.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            initPieChart();
            initBarChart();
        });

        function initPieChart() {
            // based on prepared DOM, initialize echarts instance
            var myChart = echarts.init(document.getElementById('pie-chart'));

            // specify chart configuration item and data
            option = {
                legend: {
                    top: 'bottom'
                },
                toolbox: {
                    show: false
                },
                series: [
                    {
                        name: '面积模式',
                        type: 'pie',
                        radius: [50, 250],
                        center: ['50%', '50%'],
                        roseType: 'area',
                        itemStyle: {
                            borderRadius: 8
                        },
                        data: [
                            {value: 1300, name: 'KRK'},
                            {value: 400, name: 'KRKRT'},
                            {value: 330, name: 'PRTB'},
                            {value: 200, name: 'TAPAK'},
                            {value: 160, name: 'RHTL'},
                        ]
                    }
                ]
            };

            // use configuration item and data specified to show chart
            myChart.setOption(option);
        }

        function initBarChart() {
            barChart = echarts.init(document.getElementById('bar-chart'));
            var dataAxis = ["Cikarang Pusat", "Tambun", "Tambun Selatan", "Tambun Utara", null];

            var barChartoption = {
                legend: {},
                tooltip: {},
                dataset: {
                    source: [["Kecamatan", "KRK", "KRKRT", "PRTB", "TAPAK", "RHTL"], ["Bantar Gebang", 31, 11, 5, 10, 25], ["Bekasi Barat", 21, 6, 42, 22, 10], ["Bekasi Timur", 12, 9, 10, 11, 20], ["Jatiasih", 7, 15, 80, 10, 5]]
                },

                xAxis: {
                    type: 'category',
                    splitLine: { show: true },
                    axisLabel: {
                        interval: 0,
                        rotate: 30
                    },
                },
                yAxis: {},
                // Declare several bar series, each will be mapped
                // to a column of dataset.source by default.
                dataZoom: [
                    {
                        type: 'inside'
                    }
                ],
                series: [
                    {
                        type: 'bar',
                        label: {
                            normal: {
                                show: true
                            }
                        },
                        itemStyle: {color: '#5470c6'},
                    },
                    {
                        type: 'bar',
                        label: {
                            normal: {
                                show: true
                            }
                        },
                        itemStyle: {color: '#91cc75'},
                    },
                    {
                        type: 'bar',
                        label: {
                            normal: {
                                show: true
                            }
                        },
                        itemStyle: {color: '#fac858'},
                    },
                    {
                        type: 'bar',
                        label: {
                            normal: {
                                show: true
                            }
                        },
                        itemStyle: {color: '#ee6666'},
                    },
                    {
                        type: 'bar',
                        label: {
                            normal: {
                                show: true
                            }
                        },
                        itemStyle: {color: '#73c0de'},
                    }
                ]
            };
            barChart.setOption(barChartoption);

            // Enable data zoom when user click bar.
            var zoomSize = 6;
            barChart.on('click', function (params) {
                barChart.dispatchAction({
                    type: 'dataZoom',
                    startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
                    endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
                });
            });
        }
    </script>
@endpush

@section('content')
<!-- START HOME -->
<section class="bg-light" id="home">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="home-contact mt-5 pt-5 text-center">
                    <h1 class="home-title mt-5">Monitoring Grafik</h1>
                    <p class="text-muted mt-3 mb-5">
                        Lihat informasi mengenai berkas berbentuk grafik.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- END HOME -->

<!-- START FEATURES -->
<section class="section pb-5" id="fitur">
    <div class="container">
        <div class="row mt-5 pt-4">
            <div class="col-lg-8">
                <div class="row mb-5">
                    <div class="col-12">
                        <div id="pie-chart" class="pie-chart-container"></div>
                    </div>
                </div>
                <hr>
                <div class="row mt-5">
                    <div class="col-12">
                        <h3 class="text-center mb-5"><b>Dokumen Berdasarkan Kecamatan</b></h3>
                        <div id="bar-chart" class="bar-chart-container"></div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5>Filter Data Berdasarkan</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-group mb-4">
                            <label>Tanggal Dari</label>
                            <input type="text" class="form-control" placeholder="dd/mm/yyyy">
                        </div>
                        <div class="form-group mb-4">
                            <label>Tanggal Sampai</label>
                            <input type="text" class="form-control" placeholder="dd/mm/yyyy">
                        </div>
                        <div class="form-group mb-4">
                            <label>Tahun</label>
                            <input type="text" class="form-control" placeholder="yyyy">
                        </div>
                        <div class="form-group mb-5">
                            <label>Kecamatan</label>
                            <select class="form-control" name="kecamatan">
                                <option value="Bantar Gebang">Bantar Gebang</option>
                                <option value="Bekasi Barat">Bekasi Barat</option>
                                <option value="Bekasi Selatan">Bekasi Selatan</option>
                                <option value="Bekasi Timur">Bekasi Timur</option>
                                <option value="Bekasi Utara">Bekasi Utara</option>
                                <option value="Jatiasih">Jatiasih</option>
                            </select>
                        </div>
                        <div class="form-group text-right">
                            <button class="btn btn-primary">Tampilkan</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- END SERVICES -->
@endsection
