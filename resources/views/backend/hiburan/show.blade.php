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

        .marker-hiburan .marker-arrow {
            border-color: #3949ab transparent transparent;
        }
        .marker-hiburan .face.front {
            border: 2px solid #3949ab;
            color: #3949ab;
        }
        .marker-hiburan .face.back {
            background: #3949ab;
            border-color: #3949ab;
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

            @if (@$hiburan->hiburan_latitude && @$hiburan->hiburan_longitude)
                marker = new L.marker([{!! $hiburan->hiburan_latitude !!}, {!! $hiburan->hiburan_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-hiburan">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-{{ $jenis_hiburan->hiburan_jenis_icon }}"></i></div>' +
                                '<div class="back face"><i class="fa fa-{{ $jenis_hiburan->hiburan_jenis_icon }}"></i></div>' +
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

@section('title', 'Detail ' . $jenis_hiburan->hiburan_jenis_deskripsi . ' - ' . $hiburan->hiburan_nama)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail {{ $jenis_hiburan->hiburan_jenis_deskripsi }} - {{ $hiburan->hiburan_nama }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hiburan?hiburan_jenis_id=' . $jenis_hiburan->id) }}">Potensi Pajak {{ $jenis_hiburan->hiburan_jenis_deskripsi }}</a>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hiburan') && ($hiburan->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/hiburan/'.$hiburan->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/hiburan/'.$hiburan->id) }}">
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
                        <h5 class="mb-3">Detail Potensi Pajak {{ $jenis_hiburan->hiburan_jenis_deskripsi }}</h5>
                        <span>Berikut ini adalah detail potensi pajak yang dihasilkan hiburan.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Perhitungan Potensi Pajak Hiburan</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah {{ $jenis_hiburan->hiburan_jenis_jumlah_label }}</label>
                                                    <p><b>{{ @$hiburan->hiburan_jumlah ?? '0' }} {{ $jenis_hiburan->hiburan_jenis_jumlah_unit }}</b></p>
                                                </div>
                                            </li>
                                            @endif

                                            @if(@$jenis_hiburan->hiburan_jenis_durasi_label)
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah {{ $jenis_hiburan->hiburan_jenis_durasi_label }}</label>
                                                    <p><b>{{ @$hiburan->hiburan_durasi ?? '0' }} {{ $jenis_hiburan->hiburan_jenis_durasi_unit }}</b></p>
                                                </div>
                                            </li>
                                            @endif
                                        </ul>

                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Jumlah Hari dalam Setahun</h6>
                                        <ul>
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Hari Kerja</label>
                                                            <p><b>{{ @$hiburan->tingkat_kunjungan->situasi_kunjungan_weekdays ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">Hari Libur</label>
                                                            <p><b>{{ @$hiburan->tingkat_kunjungan->situasi_kunjungan_weekends ?? '0' }} Hari</b></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>

                                        @if(!$jenis_hiburan->hiburan_jenis_have_ruangan)
                                            <hr class="mb-4">
                                            <h6 class="pb-3 mb-0 text-black-50">Informasi Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? $jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . $jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</h6>
                                            <ul>
                                                {{-- Kalo gapunya multiple kunjungan --}}
                                                @if(!$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">Hari Kerja</label>
                                                                    <p><b>{{ @$hiburan->tingkat_kunjungan->tingkat_kunjungan_weekdays ?? '0' }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? 'Orang' }}</b></p>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">Hari Libur</label>
                                                                    <p><b>{{ @$hiburan->tingkat_kunjungan->tingkat_kunjungan_weekends ?? '0' }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? 'Orang' }}</b></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                @else
                                                    <li>
                                                        @foreach($hiburan->kunjungan as $kunjungan)
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <strong>{{ $kunjungan->hiburan_kunjungan->hiburan_kunjungan_deskripsi }}</strong>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6 mb-3">
                                                                    <div class="form-group">
                                                                        <label class="m-0">Hari Kerja</label>
                                                                        <p><b>{{ generateNumber($kunjungan->hiburan_kunjungan_weekdays_value) }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? 'Orang' }}</b></p>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 mb-3">
                                                                    <div class="form-group">
                                                                        <label class="m-0">Hari Libur</label>
                                                                        <p><b>{{ generateNumber($kunjungan->hiburan_kunjungan_weekends_value) }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? 'Orang' }}</b></p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        @endforeach
                                                    </li>
                                                @endif
                                            </ul>
                                            <hr class="mb-4">
                                            <h6 class="mb-3 text-black-50">Potensi Pajak Hiburan / Tahun</h6>
                                            <ul>
                                                @if($jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                                                    <li>
                                                        <div class="row">
                                                            @foreach($hiburan->tarif as $tarif)
                                                                <div class="col-md-6 mb-3">
                                                                    <div class="form-group">
                                                                        <label class="m-0">{{ $jenis_hiburan->hiburan_jenis_htm_label }} {{ @$tarif->hiburan_tarif->hiburan_tarif_deskripsi }}</label>
                                                                        <p><b>{{ generateRupiah($tarif->hiburan_tarif_value) }}</b></p>
                                                                    </div>
                                                                </div>
                                                            @endforeach
                                                        </div>
                                                    </li>
                                                @else
                                                    <li class="mb-3">
                                                        <div class="form-group">
                                                            <label class="m-0">{{ $jenis_hiburan->hiburan_jenis_htm_label }} {{ @$jenis_hiburan->hiburan_jenis_htm_unit ? '/ ' . $jenis_hiburan->hiburan_jenis_htm_unit : null }}</label>
                                                            <p><b>{{ generateRupiah($hiburan->hiburan_tarif) }}</b></p>
                                                        </div>
                                                    </li>
                                                @endif
                                                <li class="mb-3">
                                                    <div class="form-group">
                                                        <label class="m-0">
                                                            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label && @$jenis_hiburan->hiburan_jenis_jumlah_is_count == 1) Jumlah {{ $jenis_hiburan->hiburan_jenis_jumlah_label }} x @endif
                                                            @if(@$jenis_hiburan->hiburan_jenis_durasi_label) Jumlah {{ $jenis_hiburan->hiburan_jenis_durasi_label }} x @endif
                                                            Jumlah hari dalam Setahun x Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? $jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . $jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari x {{ $jenis_hiburan->hiburan_jenis_htm_label }} x {{ @$hiburan->hiburan_persentase_pajak }}%
                                                        </label>
                                                        <p><b>{{ generateRupiah($hiburan->hiburan_potensi_pajak) }}</b></p>
                                                    </div>
                                                </li>
                                            </ul>
                                        @endif
                                        @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                                            @if($hiburan->jenis_ruangan->count() === 0)
                                                <div class="alert alert-light dark" role="alert">
                                                    <i data-feather="alert-circle"></i>
                                                    <p>Data jenis kamar belum dilengkapi.</p>
                                                </div>
                                            @else
                                            <ul class="nav nav-tabs nav-primary mb-3 mt-3" id="pills-jenis_ruangan" role="tablist">
                                                @foreach($hiburan->jenis_ruangan as $key => $jenis_ruangan)
                                                    <li class="nav-item">
                                                        <a class="nav-link {{ $key == 0 ? 'active' : null  }}" id="pills-jenis_ruangan-tab-{{ $key }}" data-bs-toggle="pill" href="#pills-jenis_ruangan-{{ $key }}" role="tab" aria-controls="pills-jenis_ruangan-{{ $key }}" aria-selected="true">
                                                            {{ @$jenis_ruangan->hiburan_jenis_ruangan_deskripsi ?? '-' }}
                                                        </a>
                                                    </li>
                                                @endforeach
                                            </ul>
                                            <div class="tab-content mb-3" id="pills-jenis_ruangan-content">
                                                @foreach($hiburan->jenis_ruangan as $key => $jenis_ruangan)
                                                    <div class="tab-pane p-3 fade {{ $key == 0 ? 'show active' : null  }}" id="pills-jenis_ruangan-{{ $key }}" role="tabpanel" aria-labelledby="pills-jenis_ruangan-tab-{{ $key }}">
                                                        <ul>
                                                            <li class="mb-3">
                                                                <h6 class="mb-0 text-black-50">Deskripsi Ruangan</h6>
                                                            </li>
                                                            <li class="mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">Jenis Ruangan</label>
                                                                    <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_deskripsi ?? '-' }}</b></p>
                                                                </div>
                                                            </li>
                                                            <li class="mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">{{ $jenis_hiburan->hiburan_jenis_htm_label }}</label>
                                                                    <p><b>{{ generateRupiah(@$jenis_ruangan->hiburan_jenis_ruangan_tarif) }} {{ @$jenis_hiburan->hiburan_jenis_htm_unit ? '/ ' . $jenis_hiburan->hiburan_jenis_htm_unit : null }}</b></p>
                                                                </div>
                                                            </li>
                                                            <li class="mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">Jumlah Room</label>
                                                                    <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_jumlah ?? '0' }} Room</b></p>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="form-group">
                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label class="m-0">Jam Operasional Hari Kerja</label>
                                                                            <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_jam_weekdays ?? '-' }}</b></p>
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label class="m-0">Jam Operasional Hari Libur</label>
                                                                            <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_jam_weekends ?? '-' }}</b></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label)
                                                            <li class="mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">Jumlah {{ $jenis_hiburan->hiburan_jenis_kapasitas_label }}</label>
                                                                    <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_kapasitas ?? '0' }} {{ $jenis_hiburan->hiburan_jenis_kapasitas_unit }}</b></p>
                                                                </div>
                                                            </li>
                                                            @endif
                                                            <li class="mb-3">
                                                                <h6 class="mb-0 text-black-50">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? $jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . $jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</h6>
                                                            </li>
                                                            <li>
                                                                <div class="form-group">
                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label class="m-0">Hari Kerja</label>
                                                                            <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_avg_weekdays ?? '0' }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? $jenis_hiburan->hiburan_jenis_htm_unit }}</b></p>
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label class="m-0">Hari Libur</label>
                                                                            <p><b>{{ @$jenis_ruangan->hiburan_jenis_ruangan_avg_weekends ?? '0' }} {{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? $jenis_hiburan->hiburan_jenis_htm_unit }}</b></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <li class="mb-3">
                                                                <h6 class="mb-0 text-black-50">Potensi Pajak {{ @$jenis_ruangan->hiburan_jenis_ruangan_deskripsi }} per Tahun</h6>
                                                            </li>
                                                            <li class="mb-3">
                                                                <div class="form-group">
                                                                    <label class="m-0">
                                                                        @if(@$jenis_hiburan->hiburan_jenis_jumlah_label && @$jenis_hiburan->hiburan_jenis_jumlah_is_count == 1) Jumlah {{ $jenis_hiburan->hiburan_jenis_jumlah_label }} x @endif
                                                                        @if(@$jenis_hiburan->hiburan_jenis_durasi_label) Jumlah {{ $jenis_hiburan->hiburan_jenis_durasi_label }} x @endif Jumlah hari dalam Setahun x Rata - Rata Kunjungan x {{ $jenis_hiburan->hiburan_jenis_htm_label }} x {{ @$hiburan->hiburan_persentase_pajak }}% </label>
                                                                    <p><b>{{ generateRupiah($jenis_ruangan->hiburan_jenis_ruangan_potensi_pajak) }}</b></p>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                @endforeach
                                            </div>
                                            @endif
                                            <hr class="mt-4 mb-4">
                                            <h6 class="mb-3 text-black-50">Potensi Pajak Hiburan per Tahun</h6>
                                            <div class="form-group">
                                                <label class="m-0">Jumlah Potensi Pajak Seluruh Ruangan per Tahun</label>
                                                <p><b>{{ generateRupiah($hiburan->hiburan_potensi_pajak) }}</b></p>
                                            </div>
                                        @endif
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Foto Hiburan</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="img-preview">
                                            @if(@$hiburan->hiburan_foto)
                                                <img class="img-thumbnail" src="{{ strpos($hiburan->hiburan_foto, 'http') !== false ? $hiburan->hiburan_foto : asset('uploads/hiburan/'.$hiburan->hiburan_foto) }}"
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
                                        <h5>Peta Lokasi Hiburan</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$hiburan->hiburan_latitude && @$hiburan->hiburan_longitude)
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
                                                    <p><b>{{ @$hiburan->hiburan_pemilik ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Objek Hiburan</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nama Objek Hiburan</label>
                                                    <p><b>{{ @$hiburan->hiburan_nama ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor NPWPD</label>
                                                    <p><b>{{ @$hiburan->hiburan_npwpd ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Nomor Telepon</label>
                                                    <p><b>{{ @$hiburan->hiburan_telepon ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            @if($jenis_hiburan->kategori->count() > 0)
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kategori</label>
                                                    <p><b>{{ @$hiburan->kategori->hiburan_kategori_deskripsi ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            @endif
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Alamat</label>
                                                    <p><b>{{ @$hiburan->hiburan_alamat ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">RT/RW</label>
                                                    <p><b>{{ (@$hiburan->hiburan_rt ?? '-').' / '.(@$hiburan->hiburan_rw ?? '-') }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kelurahan</label>
                                                    <p><b>{{ @$hiburan->hiburan_kelurahan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Kecamatan</label>
                                                    <p><b>{{ @$hiburan->hiburan_kecamatan ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            
                                            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !$jenis_hiburan->hiburan_jenis_have_ruangan)
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jumlah {{ $jenis_hiburan->hiburan_jenis_kapasitas_label }}</label>
                                                    <p><b>{{ @$hiburan->hiburan_kapasitas ?? '0' }} {{ $jenis_hiburan->hiburan_jenis_kapasitas_unit }}</b></p>
                                                </div>
                                            </li>
                                            @endif

                                            @if(@!$jenis_hiburan->hiburan_jenis_have_ruangan)
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jam Operasional Hari Kerja</label>
                                                    <p><b>{{ @$hiburan->hiburan_jam_weekdays ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Jam Operasional Hari Libur</label>
                                                    <p><b>{{ @$hiburan->hiburan_jam_weekends ?? '-' }}</b></p>
                                                </div>
                                            </li>
                                            @endif

                                            <li class="mb-4">
                                                <div class="form-group">
                                                    <label class="m-0">Status Pajak</label>
                                                    <p><b>{{ @$hiburan->status_aktif->status_aktif_deskripsi ?? '-' }}</b></p>
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
                                                    <label class="m-0">Pembuat Data Hiburan</label>
                                                    <p><b>{{ @$hiburan->user->name ? (@$hiburan->user->name.' ('.@$hiburan->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($hiburan->created_at)->toDayDateTimeString() }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Terakhir Diubah</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($hiburan->updated_at)->toDayDateTimeString() }}</b></p>
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
