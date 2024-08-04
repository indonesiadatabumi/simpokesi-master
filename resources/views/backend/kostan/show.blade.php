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

            @if (@$kostan->kostan_latitude && @$kostan->kostan_longitude)
                marker = new L.marker([{!! $kostan->kostan_latitude !!}, {!! $kostan->kostan_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-home"></i></div>' +
                                '<div class="back face"><i class="fa fa-home"></i></div>' +
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

@section('title', 'Detail Kosan '.$kostan->kostan_no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Kosan - {{ $kostan->kostan_nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/kostan') }}">Potensi Pajak Kosan</a>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-kostan') && ($kostan->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/kostan/'.$kostan->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/kostan/'.$kostan->id) }}">
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
                        <h5 class="mb-3">Detail Potensi Pajak Kosan</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan kosan.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Perhitungan Potensi Pajak Kosan</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul class="nav nav-tabs nav-primary mb-3 mt-3" id="pills-jenis_kamar" role="tablist">
                                            @foreach($kostan->jenis_kamar as $key => $jenis_kamar)
                                                <li class="nav-item">
                                                    <a class="nav-link {{ $key == 0 ? 'active' : null  }}" id="pills-jenis_kamar-tab-{{ $key }}" data-bs-toggle="pill" href="#pills-jenis_kamar-{{ $key }}" role="tab" aria-controls="pills-jenis_kamar-{{ $key }}" aria-selected="true">
                                                        {{ @$jenis_kamar->kostan_jenis_kamar_deskripsi ?? '-' }}
                                                    </a>
                                                </li>
                                            @endforeach
                                        </ul>
                                        <div class="tab-content mb-3" id="pills-jenis_kamar-content">
                                            @foreach($kostan->jenis_kamar as $key => $jenis_kamar)
                                                <div class="tab-pane p-3 fade {{ $key == 0 ? 'show active' : null  }}" id="pills-jenis_kamar-{{ $key }}" role="tabpanel" aria-labelledby="pills-jenis_kamar-tab-{{ $key }}">
                                                    <ul>
                                                        <li class="mb-3">
                                                            <h6 class="mb-0 text-black-50">Deskripsi Kamar</h6>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Jenis Kamar</label>
                                                                <p><b>{{ @$jenis_kamar->kostan_jenis_kamar_deskripsi ?? '-' }}</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Tarif Resmi Kosan</label>
                                                                <p><b>{{ generateRupiah(@$jenis_kamar->kostan_jenis_kamar_tarif) }}</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Jumlah Seluruh Kamar</label>
                                                                <p><b>{{ @$jenis_kamar->kostan_jenis_kamar_jumlah ?? '0' }} Kamar</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Rata - rata Hunian dalam 1 Tahun</label>
                                                                <p><b>{{ @$jenis_kamar->kostan_jenis_kamar_hunian_avg ?? '0' }} Kamar</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <h6 class="mb-0 text-black-50">Potensi Pajak Kamar {{ @$jenis_kamar->kostan_jenis_kamar_deskripsi }} per Tahun</h6>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Tarif Kamar x 12 x {{ @$kostan->kostan_persentase_pajak }}% </label>
                                                                <p><b>{{ generateRupiah($jenis_kamar->kostan_jenis_kamar_potensi_pajak) }}</b></p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            @endforeach
                                        </div>
                                        <hr class="mt-4 mb-4">
                                        <h6 class="mb-3 text-black-50">Potensi Pajak Kosan per Tahun</h6>
                                        <div class="form-group">
                                            <label class="m-0">Jumlah Potensi Pajak Seluruh Kamar per Tahun</label>
                                            <p><b>{{ generateRupiah($kostan->kostan_potensi_pajak) }}</b></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Kosan</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$kostan->kostan_foto)
                                                <img class="img-thumbnail" src="{{ strpos($kostan->kostan_foto, 'http') !== false ? $kostan->kostan_foto : asset('uploads/kostan/'.$kostan->kostan_foto) }}"
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
                                        <h5>Peta Lokasi Kosan</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$kostan->kostan_latitude && @$kostan->kostan_longitude)
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
                                                    <label class="m-0">Pemilik</label>
                                                    <p><b>{{ @$kostan->kostan_pemilik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Kosan</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Kosan</label>
                                                    <p><b>{{ @$kostan->kostan_nama ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$kostan->kostan_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor Telepon</label>
                                                    <p><b>{{ @$kostan->kostan_telepon ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat</label>
                                                    <p><b>{{ @$kostan->kostan_alamat ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">RT/RW</label>
                                                    <p><b>{{ (@$kostan->kostan_rt ?? '-').' / '.(@$kostan->kostan_rw ?? '-') }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kelurahan</label>
                                                    <p><b>{{ @$kostan->kostan_kelurahan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kecamatan</label>
                                                    <p><b>{{ @$kostan->kostan_kecamatan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah Pegawai</label>
                                                    <p><b>{{ @$kostan->kostan_jumlah_pegawai ?? '0' }} orang</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$kostan->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
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
                                                    <label class="m-0">Pembuat Data Kosan</label>
                                                    <p><b>{{ @$kostan->user->name ? (@$kostan->user->name.' ('.@$kostan->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($kostan->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($kostan->updated_at)->toDayDateTimeString() }}</b></p>
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
