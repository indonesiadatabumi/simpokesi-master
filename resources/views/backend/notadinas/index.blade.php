@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush

@push('styles')
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

    <script>
        $(document).ready(function() {
            $('#pajakHiburan').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/hiburan') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.hiburan_nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

            $('#pajakHotel').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/hotel') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.hotel_nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

            $('#pajakRestoran').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/restoran') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.restoran_nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

            $('#pajakReklame').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/reklame') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.reklame_nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

            $('#pajakParkir').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/parkir') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.parkir_nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            

            });

            $('#pajakTanahAir').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/air') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

            $('#pajakPju').select2({
                ajax: {
                    url: "{{ url('jenis_pajak/pju') }}", // URL API Laravel
                    dataType: 'json',
                    delay: 250,  // menunggu 250ms sebelum mengirim request
                    processResults: function(data) {
                        return {
                            results: data.map(function(item) {
                                return {
                                    id: item.id,
                                    text: item.nama // field yang ditampilkan di dropdown
                                };
                            })
                        };
                    },
                    data: function (params) {
                        /*if (!$("#startDate").val()) {
                            alert("Start Date cannot be blank.");
                            return false;
                        }
                        if (!$("#endDate").val()) {
                            alert("End Date cannot be blank.");
                            return false;
                        }*/
                        var query = {
                            q: params.term, // kata kunci pencarian
                            wilayah: $('#wilayah').val(), // mengirimkan nilai wilayah
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }
                        return query;
                    },
                    cache: true
                }
            });

        });
    </script>
@endpush

@section('title', 'Nota Dinas')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Nota Dinas</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Nota Dinas</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row project-cards">
            <div class="col-md-12 project-list">
                <div class="card" style="height: 650px;">
                    <div class="row" style="display: none;">
                        @canany(['manage-parkir', 'admin'])
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-light" href="javascript:void(0);" data-bs-toggle="modal" data-original-title="Import Data Parkir" data-bs-target="#import-modal">
                                <i data-feather="file-plus"></i> Import
                            </a>
                        </div>
                        @endcanany
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-light btnExport" href="javascript:void(0);">
                                <i data-feather="download"></i> Export
                            </a>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-light dropdown-toggle" id="btnPrint" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i data-feather="printer"></i> Print
                            </button>
                            <div class="dropdown-menu" aria-labelledby="btnPrint">
                                <a class="dropdown-item btnPrint" href="{{ url('parkir/print-potensi-pajak') }}">Potensi Pajak</a>
                            </div>
                        </div>
                        @canany(['manage-parkir', 'admin'])
                        <div class="col-auto ms-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-success" href="{{ url('/parkir/create') }}">
                                <i data-feather="plus-square"></i> Tambah Parkir
                            </a>
                        </div>
                        @endcanany
                    </div>

                    <div class="row">
                        <form class="form-horizontal" action="{{ url('notadinas/print-pdf') }}" method="post" target="_blank">
                            @csrf
                            <div class="form-group row">
                                <label class="col-3">Tanggal Surat</label>
                                <div class="col-3">
                                    <input type="date" name="tanggalSurat" class="form-control" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-3">Start Date</label>
                                <div class="col-3">
                                    <input type="date" name="startDate" id="startDate" class="form-control" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-3">End Date</label>
                                <div class="col-3">
                                    <input type="date" name="endDate" id="endDate" class="form-control" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-3">Wilayah</label>
                                <div class="col-3">
                                    @canany('admin')
                                    <select class="form-control" name="wilayah" id="wilayah" required>
                                        @foreach($kecamatans as $row)
                                        <option value="{{ $row->kecamatan }}">{{ $row->kecamatan }}</option>
                                        @endforeach
                                    </select>
                                    @endcanany
                                    @canany('surveyor')
                                        @foreach($kecamatans as $row)
                                            @if(auth()->user()->kecamatan_id == $row->id)
                                                <input type="text" class="form-control" readonly name="wilayah" id="wilayah" value="{{ $row->kecamatan }}">
                                                <!-- <option value="{{ $row->kecamatan }}">{{ $row->kecamatan }}</option> -->
                                            @endif
                                        @endforeach
                                    @endcanany
                                </div>
                            </div>
                            
                            <div class="form-group row" style="display: none;">
                                <label class="col-3">Pajak Hotel</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakHotel[]" id="pajakHotel" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                                <label class="col-3">Pajak Hiburan</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakHiburan[]" id="pajakHiburan" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                            </div>
                            <div class="form-group row" style="display: none;">
                                <label class="col-3">Pajak Restoran</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakRestoran[]" id="pajakRestoran" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                                <label class="col-3">Pajak Reklame</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakReklame[]" id="pajakReklame" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                            </div>
                            <div class="form-group row" style="display: none;">
                                <label class="col-3">Pajak Parkir</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakParkir[]" id="pajakParkir" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                                <label class="col-3">Pajak Tanah Air</label>
                                <div class="col-3">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakTanahAir[]" id="pajakTanahAir" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-3" style="display: none;">Penerangan Jalan</label>
                                <div class="col-3" style="display: none;">
                                    <!-- Menambahkan multiple untuk multi-select -->
                                    <select class="form-control" name="pajakPju[]" id="pajakPju" multiple="multiple">
                                        <!-- Data akan dimuat menggunakan Select2 -->
                                    </select>

                                </div>
                                <div class="col-2">
                                    <button class="btn btn-primary" style="width: 100%;">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->

@endsection