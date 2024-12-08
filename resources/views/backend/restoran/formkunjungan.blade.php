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


@section('title', $title.' Makanan dan/atau Minuman')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Makanan dan/atau Minuman</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/restoran') }}">Potensi Pajak Makanan dan/atau Minuman</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Makanan dan/atau Minuman</li>
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
                            <h5>{{ $title }} Makanan dan/atau Minuman</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Restoran</b>.</span>
                        </div>
                        <div class="card-body animate-chk">
                            <h6 class="pb-3 mb-0">Informasi Situasi <span class="restoran-visit-text">Kunjungan Tamu</span> Dalam Setahun (FJH)</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_ramai') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.situasi_kunjungan_ramai') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_ramai]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_ramai', @$restoran->tingkat_kunjungan->situasi_kunjungan_ramai) }}">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_ramai')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.situasi_kunjungan_normal') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_normal', @$restoran->tingkat_kunjungan->situasi_kunjungan_normal) }}">
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
                                        <input class="form-control inputFJH @error('tingkat_kunjungan.situasi_kunjungan_sepi') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.situasi_kunjungan_sepi', @$restoran->tingkat_kunjungan->situasi_kunjungan_sepi) }}">
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
                                           value="{{ (@$tingkat_kunjungan->created_at ? date('m/d/Y @ h:i:s', strtotime($tingkat_kunjungan->created_at)) : null) }}" disabled>
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
@endsection
