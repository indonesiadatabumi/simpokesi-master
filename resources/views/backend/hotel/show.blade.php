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

            @if (@$hotel->hotel_latitude && @$hotel->hotel_longitude)
                marker = new L.marker([{!! $hotel->hotel_latitude !!}, {!! $hotel->hotel_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-{{ @$hotel->hotel_status_tapping_box == 0 ? 'belum' : 'sudah' }}">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-hotel"></i></div>' +
                                '<div class="back face"><i class="fa fa-hotel"></i></div>' +
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

@section('title', 'Detail Hotel '.$hotel->hotel_no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Hotel - {{ $hotel->hotel_nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hotel') }}">Potensi Pajak Hotel</a>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hotel') && ($hotel->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/hotel/'.$hotel->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/hotel/'.$hotel->id) }}">
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
                        <h5 class="mb-3">Detail Potensi Pajak Hotel</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan hotel.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Perhitungan Potensi Pajak Hotel</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Situasi Kunjungan Tamu dalam Setahun (FJH)</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai Penuh</label>
                                                            <p><b>{{ @$hotel->tingkat_hunian->kunjungan_penuh ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Ramai Akhir Pekan</label>
                                                            <p><b>{{ @$hotel->tingkat_hunian->kunjungan_akhir_pekan ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Normal</label>
                                                            <p><b>{{ @$hotel->tingkat_hunian->kunjungan_normal ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Sepi</label>
                                                            <p><b>{{ @$hotel->tingkat_hunian->kunjungan_sepi ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Jumlah</label>
                                                            <p><b>{{ 
                                                                @$hotel->tingkat_hunian->kunjungan_penuh * 1 +
                                                                @$hotel->tingkat_hunian->kunjungan_akhir_pekan * 1 +
                                                                @$hotel->tingkat_hunian->kunjungan_normal * 1 +
                                                                @$hotel->tingkat_hunian->kunjungan_sepi * 1
                                                            }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        @if($hotel->jenis_kamar->count() === 0)
                                            <div class="alert alert-light dark" role="alert">
                                                <i data-feather="alert-circle"></i>
                                                <p>Data jenis kamar belum dilengkapi.</p>
                                            </div>
                                        @else
                                        <ul class="nav nav-tabs nav-primary mb-3 mt-3" id="pills-jenis_kamar" role="tablist">
                                            @foreach($hotel->jenis_kamar as $key => $jenis_kamar)
                                                <li class="nav-item">
                                                    <a class="nav-link {{ $key == 0 ? 'active' : null  }}" id="pills-jenis_kamar-tab-{{ $key }}" data-bs-toggle="pill" href="#pills-jenis_kamar-{{ $key }}" role="tab" aria-controls="pills-jenis_kamar-{{ $key }}" aria-selected="true">
                                                        {{ @$jenis_kamar->hotel_jenis_kamar_deskripsi ?? '-' }}
                                                    </a>
                                                </li>
                                            @endforeach
                                        </ul>
                                        <div class="tab-content mb-3" id="pills-jenis_kamar-content">
                                            @foreach($hotel->jenis_kamar as $key => $jenis_kamar)
                                                <div class="tab-pane p-3 fade {{ $key == 0 ? 'show active' : null  }}" id="pills-jenis_kamar-{{ $key }}" role="tabpanel" aria-labelledby="pills-jenis_kamar-tab-{{ $key }}">
                                                    <ul>
                                                        <li class="mb-3">
                                                            <h6 class="mb-0 text-black-50">Deskripsi Kamar</h6>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Jenis Kamar</label>
                                                                <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_deskripsi ?? '-' }}</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Tarif Resmi Hotel</label>
                                                                <p><b>{{ generateRupiah(@$jenis_kamar->hotel_jenis_kamar_tarif) }}</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">Jumlah Seluruh Kamar</label>
                                                                <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_jumlah ?? '0' }} Kamar</b></p>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <h6 class="mb-0 text-black-50">Rata - rata Tingkat Hunian Hotel (Okupansi)</h6>
                                                        </li>
                                                        <li>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="m-0">Ramai Penuh</label>
                                                                        <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_avg_penuh ?? '0' }} Kamar</b></p>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="m-0">Ramai Akhir Pekan</label>
                                                                        <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_avg_akhir_pekan ?? '0' }} Kamar</b></p>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="m-0">Normal</label>
                                                                        <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_avg_normal ?? '0' }} Kamar</b></p>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="m-0">Sepi</label>
                                                                        <p><b>{{ @$jenis_kamar->hotel_jenis_kamar_avg_sepi ?? '0' }} Kamar</b></p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="mb-3">
                                                            <h6 class="mb-0 text-black-50">Potensi Pajak Kamar {{ @$jenis_kamar->hotel_jenis_kamar_deskripsi }} per Tahun</h6>
                                                        </li>
                                                        <li class="mb-3">
                                                            <div class="form-group">
                                                                <label class="m-0">(Bobot FJH x Tingkat Hunian) x Tarif Kamar x 365 Hari x {{ @$hotel->hotel_persentase_pajak }}% </label>
                                                                <p><b>{{ generateRupiah($jenis_kamar->hotel_jenis_kamar_potensi_pajak) }}</b></p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            @endforeach
                                        </div>
                                        @endif
                                        <hr class="mt-4 mb-4">
                                        <h6 class="mb-3 text-black-50">Potensi Pajak Hotel per Tahun</h6>
                                        <div class="form-group">
                                            <label class="m-0">Jumlah Potensi Pajak Seluruh Kamar per Tahun</label>
                                            <p><b>{{ generateRupiah($hotel->hotel_potensi_pajak) }}</b></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Hotel</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$hotel->hotel_foto)
                                                <img class="img-thumbnail" src="{{ strpos($hotel->hotel_foto, 'http') !== false ? $hotel->hotel_foto : asset('uploads/hotel/'.$hotel->hotel_foto) }}"
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
                                        <h5>Peta Lokasi Hotel</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$hotel->hotel_latitude && @$hotel->hotel_longitude)
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
                                                    <p><b>{{ @$hotel->hotel_pemilik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Hotel</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Hotel</label>
                                                    <p><b>{{ @$hotel->hotel_nama ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$hotel->hotel_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor Telepon</label>
                                                    <p><b>{{ @$hotel->hotel_telepon ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Klasifikasi Hotel</label>
                                                    <p><b>{{ @$hotel->klasifikasi->hotel_klasifikasi_deskripsi ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat</label>
                                                    <p><b>{{ @$hotel->hotel_alamat ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">RT/RW</label>
                                                    <p><b>{{ (@$hotel->hotel_rt ?? '-').' / '.(@$hotel->hotel_rw ?? '-') }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kelurahan</label>
                                                    <p><b>{{ @$hotel->hotel_kelurahan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kecamatan</label>
                                                    <p><b>{{ @$hotel->hotel_kecamatan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah Pegawai</label>
                                                    <p><b>{{ @$hotel->hotel_jumlah_pegawai ?? '0' }} orang</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Status Tapping Box</label>
                                                    <p><b>{{ @$hotel->hotel_tapping_box == 0 ? 'Belum Tersedia' : 'Sudah Tersedia' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$hotel->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
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
                                                    <label class="m-0">Pembuat Data Hotel</label>
                                                    <p><b>{{ @$hotel->user->name ? (@$hotel->user->name.' ('.@$hotel->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($hotel->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($hotel->updated_at)->toDayDateTimeString() }}</b></p>
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
