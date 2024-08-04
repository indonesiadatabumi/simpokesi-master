@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush

@push('styles')
    <style>
        .btnExport svg {
            vertical-align: middle;
            height: 16px;
        }
        .btnExport {
            margin-right: 5px;
            vertical-align: -12px;
            float: right;
        }
        .apache-cotainer {
            height: 500px;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('frontend' )}}/js/echarts/echarts.min.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            $('.select2-single').select2();

            $('#select-tahun').on('select2:select', function(){
                loadGraph();
            });

            $('#select-kecamatan').on('select2:select', function(){
                loadGraph();
            });

            $('.btnExport').on('click', function(e) {
                e.preventDefault();

                exportChart();
            })

            getAllKecamatan();
        });

        function loadGraph() {
            var tahun = $('#select-tahun').val();
            var kecamatanId = $('#select-kecamatan').val();

            $('#chart-kecamatan').html('<div class="apache-cotainer" id="echart-bar"></div>');

            if (kecamatanId) {
                getKecamatan(kecamatanId, tahun);
            } else {
                getAllKecamatan(tahun);
            }
        }

        function exportChart() {
            var canvas = $('#chart-kecamatan').find('canvas')[0];
            var img = canvas.toDataURL("image/jpg");
            var link = document.createElement('a');

            link.href = img;
            link.target = '_blank';
            link.download = 'Grafik Kecamatan.jpg';

            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function getAllKecamatan(tahun = '') {
            $.ajax({
                url: '{{ url('api/rekapitulasi-chart-all') }}?tahun=' + tahun,
                type: 'get',
                success: function(res) {
                    if (res.success) {
                        initChartAll(res);
                    }
                }
            });
        }

        function getKecamatan(kecamatanId, tahun = '') {
            $.ajax({
                url: '{{ url('api/rekapitulasi-chart') }}?kecamatan_id=' + kecamatanId + '&tahun=' + tahun,
                type: 'get',
                success: function(res) {
                    if (res.success) {
                        initChartKecamatan(res);
                    } else {
                        swal("Gagal Menampilkan!", res.message, "error");
                    }
                }
            });
        }

        function initChartKecamatan(data) {
            // based on prepared DOM, initialize echarts instance
            var myChart = echarts.init(document.getElementById('echart-bar'));

            // specify chart configuration item and data
            option = {
                backgroundColor: '#fff',
                legend: {},
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                dataset: {
                    source: data.source
                },
                xAxis: { type: 'category' },
                yAxis: { type: 'value' },
                // Declare several bar series, each will be mapped
                // to a column of dataset.source by default.
                series: [
                    {
                        type: 'bar',
                        color: '#f8d62b'
                    },
                    {
                        type: 'bar',
                        color: '#eb7f20'
                    },
                    {
                        type: 'bar',
                        color: '#20b7eb'
                    },
                    {
                        type: 'bar',
                        color: '#dc3545'
                    },
                    {
                        type: 'bar',
                        color: '#000222'
                    },
                    {
                        type: 'bar',
                        color: '#3949ab'
                    },
                    {
                        type: 'bar',
                        color: '#666666'
                    }
                ]
            };

            // use configuration item and data specified to show chart
            myChart.setOption(option);
        }

        function initChartAll(data) {
            // based on prepared DOM, initialize echarts instance
            var myChart = echarts.init(document.getElementById('echart-bar'));

            // specify chart configuration item and data
            var option = {
                backgroundColor: '#fff',
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // Use axis to trigger tooltip
                        type: 'shadow'        // 'shadow' as default; can also be 'line' or 'shadow'
                    }
                },
                legend: {
                    data: data.legends
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value'
                },
                yAxis: {
                    type: 'category',
                    data: data.categories
                },
                series: data.series
            };

            // use configuration item and data specified to show chart
            myChart.setOption(option);
        }
    </script>
@endpush

@section('title', 'Rekapitulasi Potensi Pajak & Retribusi Grafik')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Rekapitulasi Grafik</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Rekapitulasi Grafik</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row project-cards">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Rekapitulasi Grafik</h5>
                        <span>Berikut ini adalah rekapitulasi grafik dokumen teknis.</span>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-end mb-4">
                            <div class="col-md-4">
                                <label class="col-form-label">Filter Kecamatan</label>
                                <select class="select2-single" id="select-kecamatan">
                                    <option value="">SEMUA</option>
                                    @foreach($kecamatans as $row)
                                        <option value="{{ $row->id }}">{{ $row->kecamatan }}</option>
                                    @endforeach
                                    <option value="null">TIDAK TERIDENTIFIKASI</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="col-form-label">Filter Tahun</label>
                                <select class="select2-single" id="select-tahun">
                                    <option value="">SEMUA</option>
                                    @for($i = 2018; $i <= date('Y'); $i++)
                                        <option value="{{ $i }}">{{ $i }}</option>
                                    @endfor
                                </select>
                            </div>
                            <div class="col col-auto ms-auto">
                                <a class="btn btn-success btnExport" href="javascript:void(0);">
                                    <i data-feather="download"></i> Export
                                </a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="chart-kecamatan">
                                <div class="apache-cotainer" id="echart-bar"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
