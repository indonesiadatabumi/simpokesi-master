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

            @if (@$parkir->parkir_latitude && @$parkir->parkir_longitude)
                marker = new L.marker([{!! $parkir->parkir_latitude !!}, {!! $parkir->parkir_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-{{ @$parkir->parkir_status_tapping_box == 0 ? 'belum' : 'sudah' }}">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-truck"></i></div>' +
                                '<div class="back face"><i class="fa fa-truck"></i></div>' +
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

@section('title', 'Detail Parkir '.$parkir->parkir_no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Parkir - {{ $parkir->parkir_nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/parkir') }}">Potensi Pajak Parkir</a>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-parkir') && ($parkir->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/parkir/'.$parkir->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/parkir/'.$parkir->id) }}">
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
                        <h5 class="mb-3">Detail Potensi Pajak Parkir</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan parkir.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Perhitungan Potensi Pajak Parkir</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Situasi Kunjungan Mobil dalam Setahun</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_ramai ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_normal ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_sepi ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Jumlah</label>
                                                            <p><b>{{ 
                                                                @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_ramai * 1 + 
                                                                @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_normal * 1 + 
                                                                @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_sepi * 1 
                                                            }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Tingkat Kunjungan Mobil Rata - Rata dalam Sehari</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_ramai ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_normal ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_sepi ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <hr class="mb-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Situasi Kunjungan Motor dalam Setahun</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_ramai ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_normal ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_sepi ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Jumlah</label>
                                                            <p><b>{{ 
                                                                @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_ramai * 1 + 
                                                                @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_normal * 1 + 
                                                                @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_sepi * 1 
                                                            }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Tingkat Kunjungan Motor Rata - Rata dalam Sehari</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_avg_kunjungan_ramai ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_avg_kunjungan_normal ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$parkir->tingkat_kunjungan->motor_avg_kunjungan_sepi ?? '0' }} Kendaraan</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <hr class="mb-4">
                                        <h6 class="mb-3 text-black-50">Potensi Pajak Parkir per Tahun</h6>
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tarif Parkir Mobil</label>
                                                    <p><b>{{ generateRupiah($parkir->parkir_tarif_mobil) }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tarif Parkir Motor</label>
                                                    <p><b>{{ generateRupiah($parkir->parkir_tarif_motor) }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Durasi Parkir Rata - Rata</label>
                                                    <p><b>{{ $parkir->parkir_durasi_avg }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Situasi Kunjungan Setahun x Tingkat Kunjungan Rata - Rata kunjungan x Tarif x Durasi Rata - Rata Parkir x {{ @$parkir->parkir_persentase_pajak }}%</label>
                                                    <p><b>{{ generateRupiah($parkir->parkir_potensi_pajak) }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Parkir</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$parkir->parkir_foto)
                                                <img class="img-thumbnail" src="{{ strpos($parkir->parkir_foto, 'http') !== false ? $parkir->parkir_foto : asset('uploads/parkir/'.$parkir->parkir_foto) }}"
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
                                        <h5>Peta Lokasi Parkir</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$parkir->parkir_latitude && @$parkir->parkir_longitude)
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
                                                    <p><b>{{ @$parkir->parkir_pemilik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Parkir</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Parkir</label>
                                                    <p><b>{{ @$parkir->parkir_nama ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$parkir->parkir_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor Telepon</label>
                                                    <p><b>{{ @$parkir->parkir_telepon ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat</label>
                                                    <p><b>{{ @$parkir->parkir_alamat ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">RT/RW</label>
                                                    <p><b>{{ (@$parkir->parkir_rt ?? '-').' / '.(@$parkir->parkir_rw ?? '-') }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kelurahan</label>
                                                    <p><b>{{ @$parkir->parkir_kelurahan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kecamatan</label>
                                                    <p><b>{{ @$parkir->parkir_kecamatan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">SRP Mobil</label>
                                                    <p><b>{{ @$parkir->parkir_srp_mobil ?? '0' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">SRP Motor</label>
                                                    <p><b>{{ @$parkir->parkir_srp_motor ?? '0' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$parkir->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
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
                                                    <label class="m-0">Pembuat Data Parkir</label>
                                                    <p><b>{{ @$parkir->user->name ? (@$parkir->user->name.' ('.@$parkir->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($parkir->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($parkir->updated_at)->toDayDateTimeString() }}</b></p>
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
