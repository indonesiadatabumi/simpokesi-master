@extends('backend.layout.app')


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

@section('title', 'Detail Kamar Hotel '.$jenis_kamar->hotel_no_rekomendasi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Detail Kamar Hotel - {{ (@old('jenis_kamar.musim', @$jenis_kamar->musim) == 1 ? 'Weekday':'weekend').' - ',(@old('jenis_kamar.category_hari', @$jenis_kamar->category_hari) == 1 ?'Peak Season':'Normal Season') }}</h3>
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
            @if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hotel') && ($jenis_kamar->status_aktif_id == 4)))
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-warning" href="{{ url('/hotelkamar/'.$jenis_kamar->hotel_id.'/'.$jenis_kamar->id.'/edit') }}">
                                <i data-feather="edit-3"></i> Ubah
                            </a>
                        </div>
                        <div class="col-auto">
                            <div class="form-group mb-0 me-0"></div>
                            <a class="btn btn-danger btnDelete" href="{{ url('/hotelkamar/'.$jenis_kamar->hotel_id.'/'.$jenis_kamar->id) }}">
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
                                    <div class="card-body p-4">
                                        <h6 class="pb-3 mb-0 text-black-50">Informasi Situasi Kunjungan Tamu dalam Setahun (FJH)</h6>
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
                                                    <label class="m-0">(Bobot FJH x Tingkat Hunian) x Tarif Kamar x 365 Hari x persentase pajak (%) </label>
                                                    <p><b>{{ generateRupiah($jenis_kamar->hotel_jenis_kamar_potensi_pajak) }}</b></p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">

                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Meta Data</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <ul>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Pembuat Data Hotel</label>
                                                    <p><b>{{ @$jenis_kamar->user->name ? (@$jenis_kamar->user->name.' ('.@$jenis_kamar->user->role->description.')') : '-' }}</b></p>
                                                </div>
                                            </li>
                                            <li class="mb-3">
                                                <div class="form-group">
                                                    <label class="m-0">Tanggal Dibuat</label>
                                                    <p><b>{{ \Carbon\Carbon::parse($jenis_kamar->created_at)->toDayDateTimeString() }}</b></p>
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
