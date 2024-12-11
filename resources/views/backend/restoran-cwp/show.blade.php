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

            @if (@$restoran->restoran_latitude && @$restoran->restoran_longitude)
                marker = new L.marker([{!! $restoran->restoran_latitude !!}, {!! $restoran->restoran_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-{{ @$restoran->restoran_status_tapping_box == 0 ? 'belum' : 'sudah' }}">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-coffee"></i></div>' +
                                '<div class="back face"><i class="fa fa-coffee"></i></div>' +
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

@section('title', 'Detail Usaha/Merk Dagang Makanan dan/atau Minuman '.$restoran->restoran_no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Usaha/Merk Dagang - {{ $restoran->restoran_nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/restoran-cpw') }}">Usaha/Merk Dagang Makanan dan/atau Minuman</a>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-restoran') && ($restoran->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/restoran/'.$restoran->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/restoran/'.$restoran->id) }}">
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
                        <h5 class="mb-3">Detail Potensi Pajak Usaha/Merk Dagang</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan Usaha/Merk Dagang.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Perhitungan Potensi Pajak Usaha/Merk Dagang</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Situasi {{ $restoranVisitText }} dalam Setahun (FJH)</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->situasi_kunjungan_ramai ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->situasi_kunjungan_normal ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->situasi_kunjungan_sepi ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Jumlah</label>
                                                            <p><b>{{ 
                                                                @$restoran->tingkat_kunjungan->situasi_kunjungan_ramai * 1 +
                                                                @$restoran->tingkat_kunjungan->situasi_kunjungan_normal * 1 +
                                                                @$restoran->tingkat_kunjungan->situasi_kunjungan_sepi * 1
                                                            }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <hr class="mb-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Tingkat {{ $restoranVisitText }} Rata - rata per Hari</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->avg_kunjungan_ramai ?? '0' }} {{ $restoranVisitTextPrefix }}</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->avg_kunjungan_normal ?? '0' }} {{ $restoranVisitTextPrefix }}</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$restoran->tingkat_kunjungan->avg_kunjungan_sepi ?? '0' }} {{ $restoranVisitTextPrefix }}</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        @can('admin')
                                        <hr class="mb-4">
                                        <h6 class="mb-3 text-black-50">Potensi Pajak Usaha/Merk Dagang per Tahun</h6>
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Pengeluaran Konsumen Rata - rata {{ $restoranVisitAvg }}</label>
                                                    <p><b>{{ generateRupiah($restoran->restoran_pengeluaran_avg) }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">FJH x Rata - rata {{ $restoranVisitText }} x Rata - rata pengeluaran x {{ @$restoran->restoran_persentase_pajak }}%</label>
                                                    <p><b>{{ generateRupiah($restoran->restoran_potensi_pajak) }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                        @endcan
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Usaha/Merk Dagang</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$restoran->restoran_foto)
                                                <img class="img-thumbnail" src="{{ strpos($restoran->restoran_foto, 'http') !== false ? $restoran->restoran_foto : asset('uploads/restoran/'.$restoran->restoran_foto) }}"
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
                                        <h5>Peta Lokasi Usaha/Merk Dagang</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$restoran->restoran_latitude && @$restoran->restoran_longitude)
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
                                                    <p><b>{{ @$restoran->restoran_pemilik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jenis Pemilik Usaha</label>
                                                    <p><b>{{ @$restoran->restoran_jenis_usaha == 0 ? 'Pribadi' : 'Badan Usaha' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">No. NIB/NIK</label>
                                                    <p><b>{{ @$restoran->restoran_nib_nik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Foto NIB/NIK</label>
                                                    <div class="img-preview">
                                                        @if(@$restoran->id_foto)
                                                            <img class="img-thumbnail" src="{{ strpos($restoran->id_foto, 'http') !== false ? $restoran->id_foto : asset('uploads/restoran/'.$restoran->id_foto) }}"
                                                                 onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                                 alt="img preview">
                                                        @else
                                                            <img class="img-thumbnail" src="{{ asset('backend/assets/images/default.jpg') }}"
                                                                 onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                                 alt="img preview">
                                                        @endif
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Usaha/Merk Dagang</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Usaha/Merk Dagang</label>
                                                    <p><b>{{ @$restoran->restoran_nama ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$restoran->restoran_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor Telepon</label>
                                                    <p><b>{{ @$restoran->restoran_telepon ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tipe Usaha/Merk Dagang</label>
                                                    <p><b>{{ @$restoran->restoran_tipe ? ucfirst(@$restoran->restoran_tipe) : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat</label>
                                                    <p><b>{{ @$restoran->restoran_alamat ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">RT/RW</label>
                                                    <p><b>{{ (@$restoran->restoran_rt ?? '-').' / '.(@$restoran->restoran_rw ?? '-') }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kelurahan</label>
                                                    <p><b>{{ @$restoran->restoran_kelurahan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kecamatan</label>
                                                    <p><b>{{ @$restoran->restoran_kecamatan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah Pegawai</label>
                                                    <p><b>{{ @$restoran->restoran_jumlah_pegawai ?? '0' }} orang</b></p>
                                                </div>
                                            </li>
                                            @if(@$restoran->restoran_tipe != 'online')
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kapasitas Kursi</label>
                                                    <p><b>{{ @$restoran->restoran_kapasitas_kursi ?? '0' }} kursi</b></p>
                                                </div>
                                            </li>
                                            @endif
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Status Tapping Box</label>
                                                    <p><b>{{ @$restoran->restoran_tapping_box == 0 ? 'Belum Tersedia' : 'Sudah Tersedia' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$restoran->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
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
                                                    <label class="m-0">Pembuat Data Usaha/Merk Dagang</label>
                                                    <p><b>{{ @$restoran->user->name ? (@$restoran->user->name.' ('.@$restoran->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($restoran->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($restoran->updated_at)->toDayDateTimeString() }}</b></p>
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
