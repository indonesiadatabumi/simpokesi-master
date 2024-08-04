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

            @if((empty(old('restoran.restoran_latitude', @$restoran->restoran_latitude)) && empty(old('restoran.restoran_longitude', @$restoran->restoran_longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="restoran[restoran_latitude]"]'), $('[name="restoran[restoran_longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            $('#select-restoran-tipe').on('select2:select', function(){
                const val = $(this).val();
                if (val === 'online') {
                    $('.restoran-visit-avg-text').text('per Pesanan');
                    $('.restoran-visit-text').text('Jumlah Pesanan');
                    $('.restoran-visit-prefix').text('Pesanan');
                    $('.input-restoran-offline').addClass('d-none');
                } else if (val === 'offline') {
                    $('.restoran-visit-avg-text').text('per Sekali Datang');
                    $('.restoran-visit-text').text('Kunjungan Tamu');
                    $('.restoran-visit-prefix').text('Orang');
                    $('.input-restoran-offline').removeClass('d-none');
                } else {
                    $('.restoran-visit-avg-text').text('per Pesanan / per Sekali Datang');
                    $('.restoran-visit-text').text('Jumlah Pesanan / Kunjungan Tamu');
                    $('.restoran-visit-prefix').text('Orang atau Pesanan');
                    $('.input-restoran-offline').removeClass('d-none');
                }
            });

            $('#select-restoran-tipe').trigger({
                type: 'select2:select'
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
            $('[name="restoran[restoran_latitude]"]').val(position.coords.latitude);
            $('[name="restoran[restoran_longitude]"]').val(position.coords.longitude);
        }
    </script>
@endpush

@section('title', $title.' Restoran')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Restoran</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/restoran-cwp') }}">Potensi Calon Wajib Pajak Restoran</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Restoran</li>
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
                            <h5>{{ $title }} Restoran</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Restoran</b>.</span>
                        </div>
                        <div class="card-body animate-chk">
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pemilik <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('restoran.restoran_pemilik') is-invalid @enderror" name="restoran[restoran_pemilik]" type="text" placeholder="Contoh: John Doe" value="{{ old('restoran.restoran_pemilik', @$restoran->restoran_pemilik) }}" required>
                                @error('restoran.restoran_pemilik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Restoran</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$restoran->restoran_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($restoran->restoran_foto, 'http') !== false ? $restoran->restoran_foto : asset('uploads/restoran-cwp/'.$restoran->restoran_foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('restoran.restoran_foto') is-invalid @enderror" name="restoran[restoran_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('restoran.restoran_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('restoran.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="restoran[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('restoran.status_aktif_id', @$restoran->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('restoran.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                            <div class="mb-3">
                                <label class="col-form-label">Tipe Restoran <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('restoran.restoran_tipe') is-invalid @enderror" id="select-restoran-tipe" name="restoran[restoran_tipe]" required>
                                    <option value="online/offline" {{ old('restoran.restoran_tipe', @$restoran->restoran_tipe) == 'online/offline' ? 'selected' : null }}>Online / Offline</option>
                                    <option value="online" {{ old('restoran.restoran_tipe', @$restoran->restoran_tipe) == 'online' ? 'selected' : null }}>Online</option>
                                    <option value="offline" {{ old('restoran.restoran_tipe', @$restoran->restoran_tipe) == 'offline' ? 'selected' : null }}>Offline</option>
                                </select>
                                @error('restoran.restoran_tipe')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Restoran <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('restoran.restoran_nama') is-invalid @enderror" name="restoran[restoran_nama]" type="text" placeholder="Contoh: Restoran Mawar" value="{{ old('restoran.restoran_nama', @$restoran->restoran_nama) }}" required>
                                @error('restoran.restoran_nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Sudah Ada Tapping Box?</label>
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_sudah" type="radio" name="restoran[restoran_status_tapping_box]" value="1" {{ @old('restoran.restoran_status_tapping_box', @$restoran->restoran_status_tapping_box) ? (@old('restoran.restoran_status_tapping_box', @$restoran->restoran_status_tapping_box) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="status_sudah">Sudah</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_belum" type="radio" name="restoran[restoran_status_tapping_box]" value="0" {{ @old('restoran.restoran_status_tapping_box', @$restoran->restoran_status_tapping_box) == 0 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="status_belum">Belum</label>
                                    </div>
                                </div>
                                @error('restoran.restoran_status_tapping_box')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('restoran.restoran_telepon') is-invalid @enderror" name="restoran[restoran_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('restoran.restoran_telepon', @$restoran->restoran_telepon) }}">
                                @error('restoran.restoran_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Klasifikasi Restoran <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <div class="row mt-2">
                                    @foreach($klasifikasis as $key => $row)
                                    <div class="col col-auto me-2">
                                        <label class="mb-0 radio-input" for="restoran_klasifikasi_{{ $row->id }}">
                                            <input class="radio_animated" id="restoran_klasifikasi_{{ $row->id }}" type="radio" name="restoran[restoran_klasifikasi_id]" value="{{ $row->id }}"
                                                {{
                                                    @old('restoran.restoran_klasifikasi_id', @$restoran->restoran_klasifikasi_id) ?
                                                    ($row->id == old('restoran.restoran_klasifikasi_id', @$restoran->restoran_klasifikasi_id) ? 'checked' : null) :
                                                    ($key === 0 ? 'checked' : null)
                                                }}> <span>{{ $row->restoran_klasifikasi_deskripsi }}</span>
                                        </label>
                                    </div>
                                    @endforeach
                                </div>
                                @error('restoran.restoran_klasifikasi_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Restoran <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <textarea class="form-control @error('restoran.restoran_alamat') is-invalid @enderror" name="restoran[restoran_alamat]"
                                          placeholder="Contoh: Jl. Gempora I RT.002/004"
                                          cols="3" required>{{ old('restoran.restoran_alamat', @$restoran->restoran_alamat) }}</textarea>
                                @error('restoran.restoran_alamat')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('restoran.restoran_kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-restoran-kelurahan" name="restoran[restoran_kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('restoran.restoran_kelurahan', @$restoran->restoran_kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('restoran.restoran_kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RW</label>
                                <input class="form-control @error('restoran.restoran_rw') is-invalid @enderror" name="restoran[restoran_rw]" type="text" placeholder="Contoh: 001" value="{{ old('restoran.restoran_rw', @$restoran->restoran_rw) }}">
                                @error('restoran.restoran_rw')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RT</label>
                                <input class="form-control @error('restoran.restoran_rt') is-invalid @enderror" name="restoran[restoran_rt]" type="text" placeholder="Contoh: 001" value="{{ old('restoran.restoran_rt', @$restoran->restoran_rt) }}">
                                @error('restoran.restoran_rt')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('restoran.restoran_latitude') is-invalid @enderror" name="restoran[restoran_latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('restoran.restoran_latitude', @$restoran->restoran_latitude) }}">
                                        @error('restoran.restoran_latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('restoran.restoran_longitude') is-invalid @enderror" name="restoran[restoran_longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('restoran.restoran_longitude', @$restoran->restoran_longitude) }}">
                                        @error('restoran.restoran_longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-outline-info btn-sm mt-2 btnOpenMap" data-bs-toggle="modal" data-bs-target="#mapModal" type="button">Pilih Titik Peta</button>
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Jumlah Pegawai</label>
                                <div class="input-group @error('restoran.restoran_jumlah_pegawai') is-invalid @enderror">
                                    <span class="input-group-text">Orang</span>
                                    <input class="form-control @error('restoran.restoran_jumlah_pegawai') is-invalid @enderror" name="restoran[restoran_jumlah_pegawai]" type="number" placeholder="Contoh: 10" value="{{ old('restoran.restoran_jumlah_pegawai', @$restoran->restoran_jumlah_pegawai) }}">
                                </div>
                                @error('restoran.restoran_jumlah_pegawai')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3 input-restoran-offline">
                                <label class="col-form-label">Kapasitas Kursi Restoran</label>
                                <div class="input-group @error('restoran.restoran_kapasitas_kursi') is-invalid @enderror">
                                    <span class="input-group-text">Kursi</span>
                                    <input class="form-control @error('restoran.restoran_kapasitas_kursi') is-invalid @enderror" name="restoran[restoran_kapasitas_kursi]" type="number" placeholder="Contoh: 40" value="{{ old('restoran.restoran_kapasitas_kursi', @$restoran->restoran_kapasitas_kursi) }}">
                                </div>
                                @error('restoran.restoran_kapasitas_kursi')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Pengeluaran Konsumen Rata - rata <span class="restoran-visit-avg-text">per Sekali Datang</span></label>
                                <div class="input-group @error('restoran.restoran_pengeluaran_avg') is-invalid @enderror">
                                    <span class="input-group-text">Rp</span>
                                    <input class="form-control @error('restoran.restoran_pengeluaran_avg') is-invalid @enderror" name="restoran[restoran_pengeluaran_avg]" type="number" placeholder="Contoh: 50000" value="{{ old('restoran.restoran_pengeluaran_avg', @$restoran->restoran_pengeluaran_avg) }}">
                                    <span class="input-group-text">/ <span class="restoran-visit-prefix">Orang</span></span>
                                </div>
                                @error('restoran.restoran_pengeluaran_avg')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('restoran.restoran_persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control @error('restoran.restoran_persentase_pajak') is-invalid @enderror" name="restoran[restoran_persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('restoran.restoran_persentase_pajak', (@$restoran->restoran_persentase_pajak ?? @$currentPersentasePajak)) }}">
                                </div>
                                @error('restoran.restoran_persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Situasi <span class="restoran-visit-text">Kunjungan Tamu</span> Dalam Setahun (FJH)</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control @error('tingkat_kunjungan.situasi_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_ramai', @$restoran->tingkat_kunjungan->situasi_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control @error('tingkat_kunjungan.situasi_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_normal', @$restoran->tingkat_kunjungan->situasi_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control @error('tingkat_kunjungan.situasi_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_sepi', @$restoran->tingkat_kunjungan->situasi_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_sepi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Tingkat <span class="restoran-visit-text">Kunjungan Tamu</span> Rata - rata per Hari</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.avg_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text restoran-visit-prefix">Orang</span>
                                        <input class="form-control @error('tingkat_kunjungan.avg_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[avg_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.avg_kunjungan_ramai', @$restoran->tingkat_kunjungan->avg_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.avg_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.avg_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text restoran-visit-prefix">Orang</span>
                                        <input class="form-control @error('tingkat_kunjungan.avg_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[avg_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.avg_kunjungan_normal', @$restoran->tingkat_kunjungan->avg_kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_kunjungan.avg_kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_kunjungan.avg_kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text restoran-visit-prefix">Orang</span>
                                        <input class="form-control @error('tingkat_kunjungan.avg_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[avg_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.avg_kunjungan_sepi', @$restoran->tingkat_kunjungan->avg_kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_kunjungan.avg_kunjungan_sepi')
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
                                           value="{{ (@$restoran->created_at ? date('m/d/Y @ h:i:s', strtotime($restoran->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$restoran->updated_at ? date('m/d/Y @ h:i:s', strtotime($restoran->updated_at)) : null) }}" disabled>
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
