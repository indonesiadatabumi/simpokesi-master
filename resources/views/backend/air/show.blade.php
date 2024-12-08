@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/leaflet/leaflet.css">
@endpush

@push('styles')
    <style>
        hr {
            background: #bdbdbd;
        }
        .text-black-50 {
            color: rgba(0, 0, 0, 0.25) !important;
        }
        .img-preview {
            width: 100%;
        }
        .img-thumbnail {
            width: 100%;
            object-fit: cover;
        }
        .marker-belum .marker-arrow {
            border-color: #dc3545 transparent transparent;
        }
        .marker-belum .face.front {
            border: 2px solid #dc3545;
            color: #dc3545;
        }
        .marker-belum .face.back {
            background: #dc3545;
            border-color: #dc3545;
        }

        .marker-sudah .marker-arrow {
            border-color: #5cb85c transparent transparent;
        }
        .marker-sudah .face.front {
            border: 2px solid #5cb85c;
            color: #5cb85c;
        }
        .marker-sudah .face.back {
            background: #5cb85c;
            border-color: #5cb85c;
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
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
    <script src="{{ asset('backend') }}/assets/js/map.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            $('.pdf-viewer').each(function(k, el) {
                var id = $(el).attr('id');
                var url = $(el).data('url');
                var options = {
                    fallbackLink: '<div class="alert alert-info"><b>Gagal menampilkan arsip! Browser Anda tidak support pdf.</b> Download arsip disini : <a href="[url]" download></a></div>',
                };
                PDFObject.embed(url, "#" + id, options);
            });

            initMap('{{ asset('data/kecamatanV2.json') }}');

            @if (@$air->latitude && @$air->longitude)
                marker = new L.marker([{!! $air->latitude !!}, {!! $air->longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-{{ @$air->status_tapping_box == 0 ? 'belum' : 'sudah' }}">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-air"></i></div>' +
                                '<div class="back face"><i class="fa fa-air"></i></div>' +
                                '<div class="marker-arrow"></div>' +
                                '</div>' +
                                '</div>'
                        }
                    )
                });
                map.addLayer(marker);
            @endif

            $($('#pills-tab .nav-link')[0]).addClass('active');
            $($('#pills-tabContent .tab-pane')[0]).addClass('active show');
        })
    </script>
@endpush

@section('title', 'Detail Air Bawah Tanah '.$air->no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Air Bawah Tanah - {{ $air->nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/air') }}">Potensi Pajak Air Bawah Tanah</a>
                        </li>
                        <li class="breadcrumb-item active">Detail Potensi Pajak</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row">
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-air') && ($air->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/air/'.$air->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/air/'.$air->id) }}">
                                <i data-feather="trash-2"></i> Hapus
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            @endif
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Detail Potensi Pajak Air Bawah Tanah</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan air bawah tanah.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Potensi Pajak Air Bawah Tanah</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <div class="form-group">
                                            <label class="m-0">Jumlah Potensi Pajak per Tahun</label>
                                            <p><b>{{ generateRupiah($air->potensi_pajak) }}</b></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Air Bawah Tanah</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$air->foto)
                                                <img class="img-thumbnail" src="{{ strpos($air->foto, 'http') !== false ? $air->foto : asset('uploads/air/'.$air->foto) }}"
                                                     onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                     alt="img preview">
                                            @else
                                                <img class="img-thumbnail" src="{{ asset('backend/assets/images/default.jpg') }}"
                                                     onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                     alt="img preview">
                                            @endif
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Peta Lokasi Air Bawah Tanah</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$air->latitude && @$air->longitude)
                                            <div class="map-container">
                                                <div id="map">
                                                </div>
                                            </div>
                                        @else
                                            <div class="alert alert-light dark" role="alert">
                                                <i data-feather="alert-circle"></i>
                                                <p>Peta lokasi belum dilengkapi.</p>
                                            </div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Pemilik</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Objek</label>
                                                    <p><b>{{ @$air->nama_objek ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                                                                        
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Rekening Objek</label>
                                                    <p><b>{{ @$air->rekening_objek ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                                                                        
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat Objek</label>
                                                    <p><b>{{ @$air->alamat_objek ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Air Bawah Tanah</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Air Bawah Tanah</label>
                                                    <p><b>{{ @$air->nama ?? '-' }}</b></p>
                                                </div>
                                            </li>                                            
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Badan</label>
                                                    <p><b>{{ @$air->nama_badan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$air->npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">No Permohonan</label>
                                                    <p><b>{{ @$air->no_permohonan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Klasifikasi Air Bawah Tanah</label>
                                                    <p><b>{{ @$air->klasifikasi->klasifikasi_deskripsi ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Fasilitas</label>
                                                    <p><b>{{ @$air->fasilitas ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Pihak Lain</label>
                                                    <p><b>{{ @$air->nama_pihak_lain ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Lama Operasional</label>
                                                    <p><b>{{ @$air->lama_operasional ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Email</label>
                                                    <p><b>{{ @$air->email ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Website</label>
                                                    <p><b>{{ @$air->website ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Sosmed</label>
                                                    <p><b>{{ @$air->sosmed ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Telp Kantor</label>
                                                    <p><b>{{ @$air->telp_kantor ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Telp Manajemen</label>
                                                    <p><b>{{ @$air->telp_manajemen ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">No Fax</label>
                                                    <p><b>{{ @$air->no_fax ?? '-' }}</b></p>
                                                </div>
                                            </li><li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Pengukuhan Npwpd</label>
                                                    <p><b>{{ @$air->pengukuhan_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">perijinan</label>
                                                    <p><b>{{ @$air->perijinan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$air->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Meta Data</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Pembuat Data Air Bawah Tanah</label>
                                                    <p><b>{{ @$air->user->name ? (@$air->user->name.' ('.@$air->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($air->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($air->updated_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
