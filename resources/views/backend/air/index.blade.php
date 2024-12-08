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

            var tableAir = $('.table-datatable').DataTable({
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
                    url: '{{ url('api/air-datatable') }}',
                    data: function(d){
                        d.air_klasifikasi_id = $('#select-air-klasifikasi').val();
                        d.tahun = $('#select-tahun').val();
                        d.kecamatan = $('#select-kecamatan').val();
                        d.verifikasi = $('.radio-verifikasi:checked').val();
                    }
                },
                drawCallback: function() {
                    $('[data-toggle="popover"]').popover();
                    $('[data-toggle="tooltip"]').tooltip();
                    feather.replace();
                },
                columns: [
                    { data: 'DT_RowIndex', name: 'DT_RowIndex', orderable: false, searchable: false },
                    { data: 'npwpd', name: 'npwpd' },
                    { data: 'nama_objek', name: 'nama_objek' },
                    { data: 'rekening_objek', name: 'rekening_objek' },
                    { data: 'nama', name: 'nama' },
                    { data: 'alamat', name: 'alamat' },
                    { data: 'action', name: 'action', searchable: false, width: 150 }
                ]
            });

            $('#select-air-klasifikasi').on('select2:select', function(){
                tableAir.ajax.reload();
            });

            $('#select-tahun').on('select2:select', function(){
                tableAir.ajax.reload();
            });

            $('#select-kecamatan').on('select2:select', function(){
                tableAir.ajax.reload();
            });

            $('.radio-verifikasi').on('change', function(){
                tableAir.ajax.reload();
            });

            $('[name="import_tipe"]').on('change', function(){
                var text = $(this).val();
                var url = $(this).val().toLowerCase().split(' ').join('-') + '.xls';

                $('.form-download').attr('href', '{{ url('downloads/format') }}/' + url);
                $('.import-type').text(text);
            })

            $('.btnExport').on('click', function(e){
                e.preventDefault();

                var air_klasifikasi = $('#select-air-klasifikasi').val();
                var tahun = $('#select-tahun').val();
                var kecamatan = $('#select-kecamatan').val();
                var statusVerifikasi = $('[name="radio-verifikasi"]:checked').val();

                window.open('{{ url('air/export') }}?tahun=' + tahun
                    + (air_klasifikasi ? '&air_klasifikasi_id=' + air_klasifikasi : '')
                    + (kecamatan ? '&kecamatan=' + kecamatan : '')
                    + (statusVerifikasi ? '&status_aktif_id=' + statusVerifikasi : ''));
            });

            $('.btnPrint').on('click', function(e){
                e.preventDefault();

                var url = $(this).attr('href');
                var air_klasifikasi = $('#select-air-klasifikasi').val();
                var tahun = $('#select-tahun').val();
                var kecamatan = $('#select-kecamatan').val();
                var statusVerifikasi = $('[name="radio-verifikasi"]:checked').val();

                window.open(url + '?tahun=' + tahun
                    + (air_klasifikasi ? '&air_klasifikasi_id=' + air_klasifikasi : '')
                    + (kecamatan ? '&kecamatan=' + kecamatan : '')
                    + (statusVerifikasi ? '&status_aktif_id=' + statusVerifikasi : ''));
            });
        })
    </script>
@endpush

@section('title', 'Potensi Air Bawah Tanah')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Air Bawah Tanah</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Potensi Pajak Air Bawah Tanah</li>
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
                        @canany(['manage-air', 'admin'])
                        <div class="col-auto">
                            <a class="btn btn-light" href="javascript:void(0);" data-bs-toggle="modal" data-original-title="Import Data Air Bawah Tanah" data-bs-target="#import-modal">
                                <i data-feather="file-plus"></i> Import
                            </a>
                        </div>
                        @endcanany
                        <div class="col-auto">
                            <a class="btn btn-light btnExport" href="{{ url('air/export') }}">
                                <i data-feather="download"></i> Export
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="dropdown2">
                                <button class="btn btn-light dropdown-toggle" id="btnPrint" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i data-feather="printer"></i> Print
                                </button>
                                <div class="dropdown-content2">
                                    <a class="dropdown-item btnPrint" href="{{ url('air/print-potensi-pajak') }}">Potensi Pajak</a>
                                </div>
                            </div>
                        </div>
                        @canany(['manage-air', 'admin'])
                        <div class="col-auto ms-auto">
                            <a class="btn btn-success" href="{{ url('/air/create') }}">
                                <i data-feather="plus-square"></i> Tambah Air Bawah Tanah
                            </a>
                        </div>
                        @endcanany
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Daftar Air Bawah Tanah</h5>
                        <span>Berikut ini adalah daftar potensi pajak <b>Air Bawah Tanah</b>.</span>
                    </div>
                    <div class="card-body">
                        @if (@session('failures') && (sizeof(session('failures')) > 0))
                            <div class="alert alert-danger dark alert-dismissible fade show" role="alert">
                                <strong>{{ sizeof(session('failures')) }} kesalahan terdeteksi!</strong> Terdapat beberapa error saat mengimport data :
                                <button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close"></button>
                                <ul class="list-circle ps-3">
                                    @foreach (session('failures') as $failure)
                                        <li>
                                            Error row - {{ $failure->row() }} : {{ implode(', ', $failure->errors()) }}
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        @if($errors->any())
                            <div class="alert alert-danger dark alert-dismissible fade show" role="alert">
                                <strong>Import data gagal!</strong>
                                <button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close"></button>
                                <ul class="list-circle ps-3">
                                    @foreach ($errors->all() as $error)
                                        <li>
                                            {{ $error }}
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif

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
                                    <label class="col-form-label">Filter Kecamatan</label>
                                    <select class="select2-single" id="select-kecamatan">
                                        <option value="">SEMUA</option>
                                        @foreach($kecamatans as $row)
                                            <option value="{{ $row->kecamatan }}">{{ $row->kecamatan }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            @endif
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter Klasifikasi Air Bawah Tanah</label>
                                    <select class="select2-single" id="select-air-klasifikasi">
                                        <option value="">SEMUA</option>
                                        @foreach($klasifikasis as $row)
                                            <option value="{{ $row->id }}">{{ $row->air_klasifikasi_deskripsi }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-12">
                                <div class="mb-3">
                                    <div class="btn-radio">
                                        <div class="btn-group" data-bs-toggle="buttons">
                                            <div class="btn btn-primary active">
                                                <div class="radio radio-primary">
                                                    <input id="radio1" class="radio-verifikasi" type="radio" name="radio-verifikasi" value="1" checked>
                                                    <label for="radio1" class="mb-0">Aktif (Sudah Diverifikasi)</label>
                                                </div>
                                            </div>
                                            <div class="btn btn-warning">
                                                <div class="radio radio-warning">
                                                    <input id="radio0" class="radio-verifikasi" type="radio" name="radio-verifikasi" value="4">
                                                    <label for="radio0" class="mb-0">Belum Diverifikasi</label>
                                                </div>
                                            </div>
                                            <div class="btn btn-danger">
                                                <div class="radio radio-danger">
                                                    <input id="radio2" class="radio-verifikasi" type="radio" name="radio-verifikasi" value="2">
                                                    <label for="radio2" class="mb-0">Tutup Sementara</label>
                                                </div>
                                            </div>
                                            <div class="btn btn-dark">
                                                <div class="radio radio-dark">
                                                    <input id="radio3" class="radio-verifikasi" type="radio" name="radio-verifikasi" value="3">
                                                    <label for="radio3" class="mb-0">Tutup Permanen</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="dt-ext table-responsive">
                            <table class="table-datatable">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>NPWPD</th>
                                    <th>Nama Objek</th>
                                    <th>Rekening</th>
                                    <th>Nama</th>
                                    <th>Alamat</th>
                                    <th>Opsi</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th></th>
                                    <th>NPWPD</th>
                                    <th>Nama Objek</th>
                                    <th>Rekening</th>
                                    <th>Nama</th>
                                    <th>Alamat</th>
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


    <div class="modal fade" id="import-modal" tabindex="-1" role="dialog" aria-labelledby="import-modal-label" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" enctype="multipart/form-data" action="{{ url('air/import') }}">
                    @csrf
                    <div class="modal-header">
                        <h5 class="modal-title" id="import-modal-label">Import Data Air Bawah Tanah</h5>
                        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="col-form-label">Pilih Tipe Import</label>
                            <div class="row mt-2 mb-3">
                                <div class="col col-auto">
                                    <label class="mb-0 radio-input" for="radio_air">
                                        <input class="radio_animated" id="radio_air" type="radio" name="import_tipe" value="Air" checked> <span>Import Data Air Bawah Tanah</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="col-form-label">File Excel
                                <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                            <input type="file" class="form-control" name="file" required>
                            <div class="invalid-feedback d-block text-muted">Format file: .xls / xlsx.</div>
                        </div>
                        <div class="alert alert-light dark" role="alert">
                            <p>Download file format import <span class="import-type">Air Bawah Tanah</span>: <a class="form-download" href="{{ asset('downloads/format/air.xls') }}" download>disini</a>.</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" type="submit">Upload</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
