@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush
@push('styles')
    <style>
        .card.bg-grey {
            background-color: #919191 !important;
            color: #fff;
        }
        .card.bg-orange {
            background-color: #eb7f20 !important;
            color: #fff;
        }
        .card.bg-blue {
            background-color: #20b7eb !important;
            color: #fff;
        }
        .card.bg-info {
            background-color: #3949ab !important;
            color: #fff;
        }
        .card.bg-gray {
            background-color: #666666 !important;
            color: #fff;
        }
        .card-count {
            margin-bottom: 16px;
        }
        .card-count .card-body {
            padding: 1rem 1.5rem !important;
        }
        .card-count h4 {
            margin-bottom: 0;
            font-size: 1rem;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('frontend' )}}/js/echarts/echarts.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function() {
            $('.select2-single').select2();

            $('#select-tahun').on('select2:select', function(){
                const year = $(this).val();
                window.location.replace('{{ url('/dashboard') }}?tahun=' + year);
            });

            // based on prepared DOM, initialize echarts instance
            var myChart = echarts.init(document.getElementById('echart-pie'));
            var colorPallete = ['#f8d62b', '#eb7f20', '#dc3545', '#20b7eb', '#000222', '#3949ab', '#000222', '#666666']

            // specify chart configuration item and data
            var option = {
                aria: {
                    enabled: true
                },
                tooltip : {
                    trigger: 'item',
                    formatter: function(params){
                        return `${params.seriesName}<br/>${params.name} : ${formatRupiah(params.value)} (${params.percent}%)`
                    }
                },
                series : [
                    {
                        name: 'Persentase Potensi Pajak',
                        type: 'pie',
                        radius : ['40%', '80%'],
                        color : colorPallete,
                        data:[
                            {value: {!! $sumHotel !!}, name:'Hotel'},
                            {value: {!! $sumRestoran !!}, name:'Restoran'},
                            {value: {!! $sumRestoranCwp !!}, name:'Calon Wajib Pajak Restoran'},
                            {value: {!! $sumKostan !!}, name:'Kostan'},
                            {value: {!! $sumRusun !!}, name:'Rusun'},
                            {value: {!! $sumHiburan !!}, name:'Hiburan'},
                            {value: {!! $sumParkir !!}, name:'Parkir'},
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

        function formatRupiah(total)
        {
            return new Intl.NumberFormat("id-ID", {
                style: "currency",
                currency: "IDR"
            }).format(total);
        }
    </script>
@endpush

@section('content')
<div class="container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-6">
                <h3>Dashboard</h3>
            </div>
            <div class="col-6">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                    </li>
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<!-- Container-fluid starts-->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-md-12">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="card card-count bg-primary">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumHotel + $sumRestoran + $sumKostan + $sumRusun) }}</h4>
                            <span>Total Potensi Pajak </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-warning">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumHotel) }}</h4>
                            <span>Hotel </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-orange">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumRestoran) }}</h4>
                            <span>Restoran </span>
                            @if(@$sumRestoranGroup->count() > 0)
                            <hr>
                            @endif
                            @foreach($sumRestoranGroup as $key => $row)
                            <div class="row">
                                <div class="col">
                                    {{ ucfirst($key) }}
                                </div>
                                <div class="col-auto">
                                    : {{ generateRupiah($row->sum('restoran_potensi_pajak')) }}
                                </div>
                            </div>
                            @endforeach
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-danger">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumRestoranCwp) }}</h4>
                            <span>Calon Wajib Pajak Restoran </span>
                            @if(@$sumRestoranCwpGroup->count() > 0)
                            <hr>
                            @endif
                            @foreach($sumRestoranCwpGroup as $key => $row)
                            <div class="row">
                                <div class="col">
                                    {{ ucfirst($key) }}
                                </div>
                                <div class="col-auto">
                                    : {{ generateRupiah($row->sum('restoran_potensi_pajak')) }}
                                </div>
                            </div>
                            @endforeach
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-blue">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumKostan) }}</h4>
                            <span>Kostan </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-secondary">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumRusun) }}</h4>
                            <span>Rusun </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-info">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumHiburan) }}</h4>
                            <span>Hiburan </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-6 col-sm-12">
                    <div class="card card-count bg-gray">
                        <div class="card-body p-4">
                            <h4>{{ generateRupiah($sumParkir) }}</h4>
                            <span>Parkir </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col">
                            <h5 class="mb-3">
                                Persentase Potensi Pajak per Periode
                            </h5>
                            <span>Sistem Manajemen Potensi Pajak dan Retribusi Kota Bekasi</span>
                        </div>
                        <div class="col-auto">
                            <select class="select2-single" id="select-tahun">
                                <option value="">SEMUA TAHUN</option>
                                @for($i = date('Y'); $i >= 2018; $i--)
                                    <option value="{{ $i }}" {{ @$_GET['tahun'] ? (@$_GET['tahun'] == $i ? 'selected' : null) : null }}>
                                        {{ $i }}
                                    </option>
                                @endfor
                            </select>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="apache-cotainer" id="echart-pie"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Container-fluid Ends-->
@endsection
