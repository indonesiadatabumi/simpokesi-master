@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush

@push('styles')
    <style>
        .radio-input span {
            transform: translate(-5px, -2px);
            display: inline-block;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/jszip.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.colVis.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/pdfmake.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/vfs_fonts.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.autoFill.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.select.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.html5.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.print.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.keyTable.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.colReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.fixedHeader.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.rowReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.scroller.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            $('.select2-single').select2();

            var table = $('.table-kamar').DataTable({
                responsive: true,
                language: {
                    search: "",
                    processing:  '<div class="loading-container">\n' +
                        '<div class="spinner-border text-success" role="status">\n' +
                        '<span class="sr-only">Loading...</span>\n' +
                        '</div></div>'
                },
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{{ url('api/hotel-kamartable') }}',
                    data: function(d){
                        d.id = '{{old('hotel_id', @$hotel_id)}}';
                        d.tahun = $('#select-tahun').val();
                        d.musim = $('#select-musim').val();
                        d.category = $('#select-kategory').val();
                    }
                },
                drawCallback: function() {
                    $('[data-toggle="popover"]').popover();
                    $('[data-toggle="tooltip"]').tooltip();
                    feather.replace();
                },
                columnDefs: [
                    {
                        // The `data` parameter refers to the data for the cell (defined by the
                        // `data` option, which defaults to the column being worked with, in
                        // this case `data: 0`.
                        render: (data, type, row) => parseInt(data)==1?'peak':'normal',
                        targets: 2
                    },
                    {
                        // The `data` parameter refers to the data for the cell (defined by the
                        // `data` option, which defaults to the column being worked with, in
                        // this case `data: 0`.
                        render: (data, type, row) => parseInt(data)==1?'week day':'week end',
                        targets: 3
                    },
                    { visible: false, targets: [5,7,8,9,10,11] }
                ],
                columns: [
                    { data: 'DT_RowIndex', name: 'DT_RowIndex', orderable: false, searchable: false },
                    { data: 'created_at', name: 'created_at' },
                    { data: 'musim', name: 'musim' },
                    { data: 'category_hari', name: 'category_hari' },
                    { data: 'hotel_jenis_kamar_deskripsi', name: 'hotel_jenis_kamar_deskripsi' },
                    { data: 'hotel_jenis_kamar_tarif', name: 'hotel_jenis_kamar_tarif' },
                    { data: 'hotel_jenis_kamar_jumlah', name: 'hotel_jenis_kamar_jumlah' },
                    { data: 'hotel_jenis_kamar_avg_penuh', name: 'hotel_jenis_kamar_avg_penuh' },
                    { data: 'hotel_jenis_kamar_avg_akhir_pekan', name: 'hotel_jenis_kamar_avg_akhir_pekan' },
                    { data: 'hotel_jenis_kamar_avg_normal', name: 'hotel_jenis_kamar_avg_normal' },
                    { data: 'hotel_jenis_kamar_avg_sepi', name: 'hotel_jenis_kamar_avg_sepi' },
                    { data: 'hotel_jenis_kamar_potensi_pajak', name: 'hotel_jenis_kamar_potensi_pajak' },
                    { data: 'action', name: 'action', searchable: false, width: 150 }
                ]
            });

            $('#select-tahun').on('select2:select', function(){
                table.ajax.reload();
            });

            $('#select-musim').on('select2:select', function(){
                table.ajax.reload();
            });
            
            $('#select-kategory').on('select2:select', function(){
                table.ajax.reload();
            });
        })
    </script>
@endpush

@section('title', 'Potensi Kamar Hotel')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Kamar Hotel</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hotel/') }}">Hotel</a>
                        </li>
                        <li class="breadcrumb-item active">Jenis Kamar</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row project-cards">
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        @canany(['manage-hotel', 'admin'])
                        <div class="col-auto ms-auto">
                            <a class="btn btn-success" href="{{ url('/hotelkamar/'.old('hotel_id', @$hotel_id).'/create') }}">
                                <i data-feather="plus-square"></i> Tambah Kamar Hotel
                            </a>
                        </div>
                        @endcanany
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Daftar Kamar Hotel</h5>
                        <span>Berikut ini adalah daftar kapasitas <b>Kamar Hotel</b>.</span>
                    </div>
                    <div class="card-body">
                          <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter Tahun</label>
                                    <select class="select2-single" id="select-tahun">
                                        <option value="">SEMUA</option>
                                        @for($i = 2018; $i <= date('Y'); $i++)
                                            <option value="{{ $i }}">{{ $i }}</option>
                                        @endfor
                                    </select>
                                </div>
                            </div>
                            @if(auth()->user()->role_id === 1 || auth()->user()->role_id === 3)
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter kategory hari</label>
                                    <select class="select2-single" id="select-kategory">
                                        <option value="">SEMUA</option>
                                        <option value="1">Week Day</option>
                                        <option value="2">Week End</option>
                                    </select>
                                </div>
                            </div>
                            @endif
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter Musim</label>
                                    <select class="select2-single" id="select-musim">
                                        <option value="">SEMUA</option>
                                        <option value="1">Peak Season</option>
                                        <option value="2">Normal</option>
                                    </select>
                                </div>
                            </div>
                        </div>
						<h6 class="pb-3 mb-0">Informasi Jenis Kamar</h6>
                        <div class="dt-ext table-responsive">
                            <table class="table-kamar">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>Tanggal</th>
                                    <th>Musim</th>
                                    <th>Category</th>
                                    <th>Keterangan</th>
                                    <th>Tarif</th>
                                    <th>Jumlah</th>
                                    <th>Penuh</th>
                                    <th>Akhir Pekan</th>
                                    <th>Normal</th>
                                    <th>Sepi</th>
                                    <th>Potensi Pajak</th>
                                    <th>Opsi</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th></th>
                                    <th>Tanggal</th>
                                    <th>Musim</th>
                                    <th>Category</th>
                                    <th>Keterangan</th>
                                    <th>Tarif</th>
                                    <th>Jumlah</th>
                                    <th>Penuh</th>
                                    <th>Akhir Pekan</th>
                                    <th>Normal</th>
                                    <th>Sepi</th>
                                    <th>Potensi Pajak</th>
                                    <th>Opsi</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
