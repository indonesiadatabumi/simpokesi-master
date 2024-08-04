@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/dropzone.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/date-picker.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/leaflet/leaflet.css">
@endpush
@push('styles')
    <style>
        .img-preview {
            width: 200px;
            height: 200px;
        }
        .img-thumbnail {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .radio-input span {
            transform: translate(-5px, -2px);
            display: inline-block;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.id.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.custom.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
    <script src="{{ asset('backend') }}/assets/js/map.js"></script>
@endpush

@push('scripts')
    <script>
        var map, polygon, marker;

        $(document).ready(function () {
            $('.select2-single').select2({
                placeholder: function () {
                    return $(this).data('placeholder');
                }
            });
            $('.select2-create').select2({
                maximumSelectionLength: 1,
                tags: true,
                createTag: function (params) {
                    var term = $.trim(params.term);

                    if (term === '') {
                        return null;
                    }

                    return {
                        id: params.term,
                        text: params.term,
                        newTag: true
                    }
                },
                placeholder: "Ketik untuk mencari / menambahkan"
            });

            @if((empty(old('parkir.parkir_latitude', @$parkir->parkir_latitude)) && empty(old('parkir.parkir_longitude', @$parkir->parkir_longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="parkir[parkir_latitude]"]'), $('[name="parkir[parkir_longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            inputFile.onchange = evt => {
                const [file] = inputFile.files
                if (file) {
                    imagePreview.src = URL.createObjectURL(file)
                }
            }
        });

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(setPosition);
            }
        }

        function setPosition(position) {
            $('[name="parkir[parkir_latitude]"]').val(position.coords.latitude);
            $('[name="parkir[parkir_longitude]"]').val(position.coords.longitude);
        }
    </script>
@endpush

@section('title', $title.' Parkir')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Parkir</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/parkir') }}">Potensi Pajak Parkir</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Parkir</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                @if($errors->any())
                    <div class="alert alert-danger dark alert-dismissible fade show" role="alert">
                        <strong>{{ $title }} data gagal!</strong>
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
                <form class="theme-form mega-form" method="post" enctype="multipart/form-data" action="{{ $url }}">
                    @csrf
                    @if($title !== 'Tambah')
                        @method('put')
                    @endif
                    <div class="card">
                        <div class="card-header">
                            <h5>{{ $title }} Parkir</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Parkir</b>.</span>
                        </div>
                        <div class="card-body animate-chk">
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pemilik <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('parkir.parkir_pemilik') is-invalid @enderror" name="parkir[parkir_pemilik]" type="text" placeholder="Contoh: John Doe" value="{{ old('parkir.parkir_pemilik', @$parkir->parkir_pemilik) }}" required>
                                @error('parkir.parkir_pemilik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Parkir</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$parkir->parkir_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($parkir->parkir_foto, 'http') !== false ? $parkir->parkir_foto : asset('uploads/parkir/'.$parkir->parkir_foto) }}"
                                                 onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                 alt="img preview">
                                        @else
                                            <img class="img-thumbnail" id="imagePreview" src="{{ asset('backend/assets/images/default.jpg') }}"
                                                 onerror="this.src='{{ asset('backend/assets/images/broken.jpg') }}'"
                                                 alt="img preview">
                                        @endif
                                    </div>
                                </div>
                                <div class="col col-auto">
                                    <label class="col-form-label">{{ $title !== 'Tambah' ? 'Ubah ' : '' }}Foto</label>
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('parkir.parkir_foto') is-invalid @enderror" name="parkir[parkir_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('parkir.parkir_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('parkir.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="parkir[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('parkir.status_aktif_id', @$parkir->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('parkir.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                            <div class="mb-3">
                                <label class="col-form-label">Nama Parkir <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('parkir.parkir_nama') is-invalid @enderror" name="parkir[parkir_nama]" type="text" placeholder="Contoh: Parkir Mawar" value="{{ old('parkir.parkir_nama', @$parkir->parkir_nama) }}" required>
                                @error('parkir.parkir_nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. NPWPD</label>
                                <input class="form-control @error('parkir.parkir_npwpd') is-invalid @enderror" name="parkir[parkir_npwpd]" type="text" placeholder="Contoh: 420938278129382" value="{{ old('parkir.parkir_npwpd', @$parkir->parkir_npwpd) }}">
                                @error('parkir.parkir_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('parkir.parkir_telepon') is-invalid @enderror" name="parkir[parkir_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('parkir.parkir_telepon', @$parkir->parkir_telepon) }}">
                                @error('parkir.parkir_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Parkir <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <textarea class="form-control @error('parkir.parkir_alamat') is-invalid @enderror" name="parkir[parkir_alamat]"
                                          placeholder="Contoh: Jl. Gempora I RT.002/004"
                                          cols="3" required>{{ old('parkir.parkir_alamat', @$parkir->parkir_alamat) }}</textarea>
                                @error('parkir.parkir_alamat')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('parkir.parkir_kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-parkir-kelurahan" name="parkir[parkir_kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('parkir.parkir_kelurahan', @$parkir->parkir_kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('parkir.parkir_kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RW</label>
                                <input class="form-control @error('parkir.parkir_rw') is-invalid @enderror" name="parkir[parkir_rw]" type="text" placeholder="Contoh: 001" value="{{ old('parkir.parkir_rw', @$parkir->parkir_rw) }}">
                                @error('parkir.parkir_rw')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RT</label>
                                <input class="form-control @error('parkir.parkir_rt') is-invalid @enderror" name="parkir[parkir_rt]" type="text" placeholder="Contoh: 001" value="{{ old('parkir.parkir_rt', @$parkir->parkir_rt) }}">
                                @error('parkir.parkir_rt')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('parkir.parkir_latitude') is-invalid @enderror" name="parkir[parkir_latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('parkir.parkir_latitude', @$parkir->parkir_latitude) }}">
                                        @error('parkir.parkir_latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('parkir.parkir_longitude') is-invalid @enderror" name="parkir[parkir_longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('parkir.parkir_longitude', @$parkir->parkir_longitude) }}">
                                        @error('parkir.parkir_longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-outline-info btn-sm mt-2 btnOpenMap" data-bs-toggle="modal" data-bs-target="#mapModal" type="button">Pilih Titik Peta</button>
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Rata - Rata Durasi Parkir</label>
                                <div class="input-group @error('parkir.parkir_durasi_avg') is-invalid @enderror">
                                    <span class="input-group-text">Jam</span>
                                    <input class="form-control @error('parkir.parkir_durasi_avg') is-invalid @enderror" name="parkir[parkir_durasi_avg]" type="number" placeholder="Contoh: 5" value="{{ old('parkir.parkir_durasi_avg', @$parkir->parkir_durasi_avg) }}">
                                </div>
                                @error('parkir.parkir_durasi_avg')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('parkir.parkir_persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control @error('parkir.parkir_persentase_pajak') is-invalid @enderror" name="parkir[parkir_persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('parkir.parkir_persentase_pajak', (@$parkir->parkir_persentase_pajak ?? 30)) }}">
                                </div>
                                @error('parkir.parkir_persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi SRP</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Mobil</label>
                                    <input class="form-control @error('parkir.parkir_srp_mobil') is-invalid @enderror" name="parkir[parkir_srp_mobil]" type="number" placeholder="Contoh: 10" value="{{ old('parkir.parkir_srp_mobil', @$parkir->parkir_srp_mobil) }}">
                                    @error('parkir.parkir_srp_mobil')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Motor</label>
                                    <input class="form-control @error('parkir.parkir_srp_motor') is-invalid @enderror" name="parkir[parkir_srp_motor]" type="number" placeholder="Contoh: 10" value="{{ old('parkir.parkir_srp_motor', @$parkir->parkir_srp_motor) }}">
                                    @error('parkir.parkir_srp_motor')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Tarif Parkir</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Mobil</label>
                                    <div class="input-group @error('parkir.parkir_tarif_mobil') is-invalid @enderror">
                                        <span class="input-group-text">Rp</span>
                                        <input class="form-control @error('parkir.parkir_tarif_mobil') is-invalid @enderror" name="parkir[parkir_tarif_mobil]" type="number" placeholder="Contoh: 40" value="{{ old('parkir.parkir_tarif_mobil', @$parkir->parkir_tarif_mobil) }}">
                                    </div>
                                    @error('parkir.parkir_tarif_mobil')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Motor</label>
                                    <div class="input-group @error('parkir.parkir_tarif_motor') is-invalid @enderror">
                                        <span class="input-group-text">Rp</span>
                                        <input class="form-control @error('parkir.parkir_tarif_motor') is-invalid @enderror" name="parkir[parkir_tarif_motor]" type="number" placeholder="Contoh: 40" value="{{ old('parkir.parkir_tarif_motor', @$parkir->parkir_tarif_motor) }}">
                                    </div>
                                    @error('parkir.parkir_tarif_motor')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Situasi Kunjungan Mobil Dalam Setahun</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_situasi_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.mobil_situasi_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[mobil_situasi_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_situasi_kunjungan_ramai', @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_situasi_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_situasi_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.mobil_situasi_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[mobil_situasi_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_situasi_kunjungan_normal', @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_situasi_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_situasi_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.mobil_situasi_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[mobil_situasi_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_situasi_kunjungan_sepi', @$parkir->tingkat_kunjungan->mobil_situasi_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_situasi_kunjungan_sepi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Tingkat Kunjungan Mobil Rata - Rata Dalam Sehari</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_avg_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.mobil_avg_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[mobil_avg_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_avg_kunjungan_ramai', @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_avg_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_avg_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.mobil_avg_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[mobil_avg_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_avg_kunjungan_normal', @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_avg_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.mobil_avg_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.mobil_avg_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[mobil_avg_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.mobil_avg_kunjungan_sepi', @$parkir->tingkat_kunjungan->mobil_avg_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.mobil_avg_kunjungan_sepi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Situasi Kunjungan Motor Dalam Setahun</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_situasi_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH2 @error('tingkat_kunjungan.motor_situasi_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[motor_situasi_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_situasi_kunjungan_ramai', @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_situasi_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_situasi_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH2 @error('tingkat_kunjungan.motor_situasi_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[motor_situasi_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_situasi_kunjungan_normal', @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_situasi_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_situasi_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH2 @error('tingkat_kunjungan.motor_situasi_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[motor_situasi_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_situasi_kunjungan_sepi', @$parkir->tingkat_kunjungan->motor_situasi_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_situasi_kunjungan_sepi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Tingkat Kunjungan Motor Rata - Rata Dalam Sehari</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_avg_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.motor_avg_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[motor_avg_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_avg_kunjungan_ramai', @$parkir->tingkat_kunjungan->motor_avg_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_avg_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_avg_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.motor_avg_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[motor_avg_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_avg_kunjungan_normal', @$parkir->tingkat_kunjungan->motor_avg_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_avg_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.motor_avg_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Kendaraan</span>
                                        <input class="form-control @error('tingkat_kunjungan.motor_avg_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[motor_avg_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.motor_avg_kunjungan_sepi', @$parkir->tingkat_kunjungan->motor_avg_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.motor_avg_kunjungan_sepi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$parkir->created_at ? date('m/d/Y @ h:i:s', strtotime($parkir->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$parkir->updated_at ? date('m/d/Y @ h:i:s', strtotime($parkir->updated_at)) : null) }}" disabled>
                                </div>
                            @endif
                        </div>
                        <div class="card-footer text-end">
                            <button type="submit" class="btn btn-primary">Simpan</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->

    <div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="mapModal" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Pilih Titik Peta</h5>
                    <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="map-container">
                        <div id="map" data-map-scroll="true">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary btnPick" data-bs-dismiss="modal" type="button">Pilih</button>
                </div>
            </div>
        </div>
    </div>
@endsection
