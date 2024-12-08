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
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.id.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.custom.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
@endpush

@push('scripts')
    <script>
      //  var map, polygon, marker;

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
            
            var newOption;

            @if(!empty(old('hotel.category_hari')) && !is_numeric(old('hotel.category_hari')))
                newOption = new Option("{{ old('hotel.category_hari') }}", "{{ old('hotel.category_hari') }}", true, true);
                $('#select-hotel-category').append(newOption).trigger('change');
            @endif

            @if(!empty(old('hotel.musim')) && !is_numeric(old('hotel.musim')))
                newOption = new Option("{{ old('hotel.musim') }}", "{{ old('hotel.musim') }}", true, true);
                $('#select-hotel-musim').append(newOption).trigger('change');
            @endif
        });
        
    </script>
@endpush

@section('title', $title.' Hotel')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Kamar Hotel</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hotel') }}">PBJT Hotel</a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hotelkamar/'.$hotel_id) }}">Potensi Kamar</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Kamar Hotel</li>
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
                            <h5>{{ $title }} Kamar Hotel</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Kamar Hotel</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6 class="pb-3 mb-0">Informasi Jenis Kamar</h6>
							<input type="hidden" name="jenis_kamar[hotel_id]" value="{{ @$jenis_kamar['hotel_id'] }}">
                            @if(@$jenis_kamar['id'])
                            <input type="hidden" name="jenis_kamar[id]" class="id-jenis_kamar" value="{{ @$jenis_kamar['id'] }}">
                            @endif
                            <div class="mb-3">
                                <label class="col-form-label">Deskripsi Jenis Kamar</label>
                                <input class="form-control @error('jenis_kamar.hotel_jenis_kamar_deskripsi') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_deskripsi]" type="text" placeholder="Contoh: Standar" value="{{ @$jenis_kamar['hotel_jenis_kamar_deskripsi'] }}">
                                @error('jenis_kamar.hotel_jenis_kamar_deskripsi')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Tarif Resmi Hotel</label>
                                <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_tarif') is-invalid @enderror">
                                    <span class="input-group-text">IDR</span>
                                    <input class="form-control hotel_jenis_kamar_tarif @error('jenis_kamar.hotel_jenis_kamar_tarif') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_tarif]" type="number" min="0" placeholder="Contoh: 500000" value="{{ @$jenis_kamar['hotel_jenis_kamar_tarif'] ?? 0 }}">
                                </div>
                                @error('jenis_kamar.hotel_jenis_kamar_tarif')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Jumlah Seluruh Kamar</label>
                                <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_jumlah') is-invalid @enderror">
                                    <span class="input-group-text">Kamar</span>
                                    <input class="form-control hotel_jenis_kamar_jumlah @error('jenis_kamar.hotel_jenis_kamar_jumlah') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_jumlah]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['hotel_jenis_kamar_jumlah'] ?? 0 }}">
                                </div>
                                @error('jenis_kamar.hotel_jenis_kamar_jumlah')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Rata - rata Tingkat Hunian Hotel</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Penuh</label>
                                    <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_avg_penuh') is-invalid @enderror">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_penuh @error('jenis_kamar.hotel_jenis_kamar_avg_penuh') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_avg_penuh]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['hotel_jenis_kamar_avg_penuh'] ?? 0 }}">
                                    </div>
                                    @error('jenis_kamar.hotel_jenis_kamar_avg_penuh')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Akhir Pekan</label>
                                    <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_avg_akhir_pekan') is-invalid @enderror">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_akhir_pekan @error('jenis_kamar.hotel_jenis_kamar_avg_akhir_pekan') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_avg_akhir_pekan]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['hotel_jenis_kamar_avg_akhir_pekan'] ?? 0 }}">
                                    </div>
                                    @error('jenis_kamar.hotel_jenis_kamar_avg_akhir_pekan')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_avg_normal') is-invalid @enderror">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_normal @error('jenis_kamar.hotel_jenis_kamar_avg_normal') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_avg_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['hotel_jenis_kamar_avg_normal'] ?? 0 }}">
                                    </div>
                                    @error('jenis_kamar.hotel_jenis_kamar_avg_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_avg_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_sepi @error('jenis_kamar.hotel_jenis_kamar_avg_sepi') is-invalid @enderror" name="jenis_kamar[hotel_jenis_kamar_avg_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['hotel_jenis_kamar_avg_sepi'] ?? 0 }}">
                                    </div>
                                    @error('jenis_kamar.hotel_jenis_kamar_avg_sepi')
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
                                           value="{{ (@$jenis_kamar->created_at ? date('m/d/Y @ h:i:s', strtotime($jenis_kamar->created_at)) : null) }}" disabled>
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
