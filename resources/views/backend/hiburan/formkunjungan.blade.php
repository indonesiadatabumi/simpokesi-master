@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/dropzone.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/date-picker.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/daterange-picker.css">
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
        .calendar.left .calendar-table, .calendar.right .calendar-table {
            display: none !important;
        }
        .daterangepicker select.hourselect, .daterangepicker select.minuteselect, .daterangepicker select.secondselect, .daterangepicker select.ampmselect {
            width: 70px !important;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.id.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.custom.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/daterange-picker/moment.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/daterange-picker/daterangepicker.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
    <script src="{{ asset('backend') }}/assets/js/map.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function() {
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

            initDatetimepicker();
            
            $('.btnAdd').on('click', function(e) {
                e.preventDefault();
                addJenisRuangan();
            });

            $('body, html').on('click', '.btnRemove', function(e) {
                e.preventDefault();
                removeJenisRuangan($(this));
            });

            inputFile.onchange = evt => {
                const [file] = inputFile.files
                if (file) {
                    imagePreview.src = URL.createObjectURL(file)
                }
            }
        });

        function initDatetimepicker(el = null) {
            if (!el) {
                el = $('.daterangepicker-time');
            }

            el.daterangepicker({
                timePicker: true,
                timePickerIncrement: 30,
                timePicker24Hour: true,
                locale: {
                    format: 'HH:mm'
                }
            });
        }

        function removeJenisRuangan(el) {
            if ($('.accordion-item').length == 1) {
                swal("Gagal menghapus item!", "Setidaknya harus terdapat 1 jenis ruangan.", "error");
                return;
            }

            var jenisRuanganItem = $(el.parents('.accordion-item')[0]);
            var id = jenisRuanganItem.find('.id-jenis_ruangan');

            swal({
                title: "Apakah Anda yakin?",
                text: "Data yang telah dihapus tidak dapat dikembalikan.",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    if(id.length > 0) {
                        console.log(id);
                        var deletedId = $('#input-deleted-jenis_ruangan').val().split(';');
                        deletedId.push(id.val());

                        $('#input-deleted-jenis_ruangan').val(deletedId.join(';'));
                    }

                    jenisRuanganItem.remove();
                    initJenisRuanganItem();
                }
            });

        }

        function addJenisRuangan() {
            var jenisRuanganItem = $($('.accordion-item')[0]).clone();
            var jenisRuanganContainer = $('#accordion');

            jenisRuanganItem.find('input').val('');
            jenisRuanganItem.find('.id-jenis_ruangan').remove();

            jenisRuanganContainer.append(jenisRuanganItem);

            initJenisRuanganItem();
        }

        function initJenisRuanganItem() {
            $('.accordion-item').each(function(k, el){
                var item = $(el);
                item.find('.card-header').attr('id', 'accordion-heading-' + k);
                item.find('.card-header .btn-link').attr('data-bs-target', '#accordion-collapse-' + k);
                item.find('.card-header .btn-link').attr('aria-controls', '#accordion-collapse-' + k);
                item.find('.card-header .btn-link span').text(k + 1);
                item.find('.collapse').attr('id', '#accordion-collapse-' + k);

                item.find('input[name$="[id]"]').attr('name', `jenis_ruangan[${k}][id]`);
                item.find('input[name$="[hiburan_jenis_ruangan_deskripsi]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_deskripsi]`);
                item.find('input[name$="[hiburan_jenis_ruangan_tarif]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_tarif]`);
                item.find('input[name$="[hiburan_jenis_ruangan_jumlah]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_jumlah]`);
                item.find('input[name$="[hiburan_jenis_ruangan_kapasitas]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_kapasitas]`);
                item.find('input[name$="[hiburan_jenis_ruangan_avg_weekends]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_avg_weekends]`);
                item.find('input[name$="[hiburan_jenis_ruangan_avg_weekdays]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_avg_weekdays]`);
                const timepicker1 = item.find('input[name$="[hiburan_jenis_ruangan_jam_weekends]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_jam_weekends]`);
                const timepicker2 = item.find('input[name$="[hiburan_jenis_ruangan_jam_weekdays]"]').attr('name', `jenis_ruangan[${k}][hiburan_jenis_ruangan_jam_weekdays]`);
                initDatetimepicker(timepicker1);
                initDatetimepicker(timepicker2);
            });
        }

    </script>
@endpush

@section('title', $title . ' ' . @$jenis_hiburan->hiburan_jenis_deskripsi)

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hiburan') }}">Potensi Pajak {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</li>
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
                    <input type="hidden" name="hiburan[hiburan_jenis_id]" value="{{ @$jenis_hiburan->id }}">
                    <div class="card">
                        <div class="card-header">
                            <h5>{{ $title }} {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>{{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</b>.</span>
                        </div>
                        <div class="card-body">
                            
                            {{-- Kalo punya multiple tarif --}}
                            @if($jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tarif</h6>
                                @foreach($jenis_hiburan_tarifs as $key => $jenis_hiburan_tarif)
                                    <input type="hidden" name="hiburan_tarif_value[{{ $key }}][hiburan_tarif_id]" class="id-hiburan_tarif" value="{{ @$jenis_hiburan_tarif['hiburan_tarif_id'] ?? @$jenis_hiburan_tarif['id'] }}">

                                    <div class="mb-3">
                                        <label class="col-form-label">Tarif {{ @$jenis_hiburan_tarif->hiburan_tarif->hiburan_tarif_deskripsi ?? $jenis_hiburan_tarif->hiburan_tarif_deskripsi }} <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                        <div class="input-group @error('hiburan_tarif_value.'.$key.'.hiburan_tarif_value') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control 
                                                @error('hiburan_tarif_value.'.$key.'.hiburan_tarif_value') is-invalid @enderror" 
                                                name="hiburan_tarif_value[{{ $key }}][hiburan_tarif_value]" 
                                                type="number" 
                                                min="0" 
                                                placeholder="Contoh: 500000" 
                                                required="required"
                                                value="{{ old('hiburan_tarif_value.'.$key.'.hiburan_tarif_value', @$jenis_hiburan_tarif['hiburan_tarif_value']) }}">
                                            <span class="input-group-text">/ {{ $jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                        </div>
                                        @error('hiburan_tarif_value.'.$key.'.hiburan_tarif_value')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                @endforeach
                            @endif
                            
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Jumlah Hari Dalam Setahun</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Hari Kerja</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_weekdays') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control @error('tingkat_kunjungan.situasi_kunjungan_weekdays') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_weekdays]" type="number" min="0" placeholder="Contoh: 50" value="260" readonly="readonly">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_weekdays')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Hari Libur</label>
                                    <div class="input-group @error('tingkat_kunjungan.situasi_kunjungan_weekends') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control @error('tingkat_kunjungan.situasi_kunjungan_weekends') is-invalid @enderror" name="tingkat_kunjungan[situasi_kunjungan_weekends]" type="number" min="0" placeholder="Contoh: 50" value="105" readonly="readonly">
                                    </div>
                                    @error('tingkat_kunjungan.situasi_kunjungan_weekends')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <hr class="mt-4 mb-4">
                            {{-- Kalo ga punya ruangan  --}}
                            @if(!@$jenis_hiburan->hiburan_jenis_have_ruangan)
                                <h6 class="pb-3 mb-0">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? $jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . $jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</h6>
                                @if(!@$jenis_hiburan->hiburan_jenis_have_multiple_kunjungan)
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="col-form-label">Hari Kerja</label>
                                            <div class="input-group @error('tingkat_kunjungan.tingkat_kunjungan_weekdays') is-invalid @enderror">
                                                <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_htm_unit ?? @$jenis_hiburan->hiburan_jenis_kapasitas_unit }}</span>
                                                <input class="form-control @error('tingkat_kunjungan.tingkat_kunjungan_weekdays') is-invalid @enderror" name="tingkat_kunjungan[tingkat_kunjungan_weekdays]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.tingkat_kunjungan_weekdays', @$hiburan->tingkat_kunjungan->tingkat_kunjungan_weekdays) }}">
                                            </div>
                                            @error('tingkat_kunjungan.tingkat_kunjungan_weekdays')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                            @enderror
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="col-form-label">Hari Libur</label>
                                            <div class="input-group @error('tingkat_kunjungan.tingkat_kunjungan_weekends') is-invalid @enderror">
                                                <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_htm_unit ?? @$jenis_hiburan->hiburan_jenis_kapasitas_unit }}</span>
                                                <input class="form-control @error('tingkat_kunjungan.tingkat_kunjungan_weekends') is-invalid @enderror" name="tingkat_kunjungan[tingkat_kunjungan_weekends]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_kunjungan.tingkat_kunjungan_weekends', @$hiburan->tingkat_kunjungan->tingkat_kunjungan_weekends) }}">
                                            </div>
                                            @error('tingkat_kunjungan.tingkat_kunjungan_weekends')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                            @enderror
                                        </div>
                                    </div>
                                @else
                                    @foreach($jenis_hiburan_kunjungans as $key => $jenis_hiburan_kunjungan)
                                        <strong class="mb-0">{{ @$jenis_hiburan_kunjungan->hiburan_kunjungan->hiburan_kunjungan_deskripsi?? @$jenis_hiburan_kunjungan->hiburan_kunjungan_deskripsi }}</strong>
                                        <input type="hidden" name="hiburan_kunjungan_value[{{ $key }}][hiburan_kunjungan_id]" class="id-hiburan_kunjungan" value="{{ @$jenis_hiburan_kunjungan['hiburan_kunjungan_id'] ?? @$jenis_hiburan_kunjungan['id']}}">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="col-form-label">Hari Kerja</label>
                                                <div class="input-group @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekdays_value') is-invalid @enderror">
                                                    <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? @$jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                                    <input class="form-control @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekdays_value') is-invalid @enderror" name="hiburan_kunjungan_value[{{ $key }}][hiburan_kunjungan_weekdays_value]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekdays_value', @$jenis_hiburan_kunjungan['hiburan_kunjungan_weekdays_value']) }}">
                                                </div>
                                                @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekdays_value')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="col-form-label">Hari Libur</label>
                                                <div class="input-group @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekends_value') is-invalid @enderror">
                                                    <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? @$jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                                    <input class="form-control @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekends_value') is-invalid @enderror" name="hiburan_kunjungan_value[{{ $key }}][hiburan_kunjungan_weekends_value]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekends_value', @$jenis_hiburan_kunjungan['hiburan_kunjungan_weekends_value']) }}">
                                                </div>
                                                @error('hiburan_kunjungan_value.'.$key.'.hiburan_kunjungan_weekends_value')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>
                                    @endforeach
                                @endif
                            @endif

                            {{-- Kalo punya ruangan --}}
                            @if($jenis_hiburan->hiburan_jenis_have_ruangan)
                                <h6 class="pb-3 mb-0">Informasi Jenis Ruangan</h6>
                                <div class="default-according mb-3" id="accordion">
                                    <input type="hidden" name="deleted_jenis_ruangan" id="input-deleted-jenis_ruangan">
                                    @foreach($jenis_ruangans as $key => $jenis_ruangan)
                                    <div class="card accordion-item">
                                        <div class="card-header bg-success" id="accordion-heading-{{ $loop->iteration }}">
                                            <h5 class="mb-0">
                                                <button class="btn btn-link text-white" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-collapse-{{ $loop->iteration }}" aria-expanded="true" aria-controls="accordion-collapse-{{ $loop->iteration }}">Jenis Ruangan #<span>{{ $loop->iteration }}</span></button>
                                            </h5>
                                        </div>
                                        <div class="collapse show" id="accordion-collapse-{{ $loop->iteration }}" data-bs-parent="#accordion">
                                            <div class="card-body">
                                                <div class="mb-3 text-end">
                                                    <button class="btn btn-danger btnRemove" type="button"><i class="fa fa-trash-o"></i></button>
                                                </div>

                                                @if(@$jenis_ruangan['id'])
                                                <input type="hidden" name="jenis_ruangan[{{ $key }}][id]" class="id-jenis_ruangan" value="{{ @$jenis_ruangan['id'] }}">
                                                @endif

                                                <div class="mb-3">
                                                    <label class="col-form-label">Deskripsi Jenis Ruangan</label>
                                                    <input class="form-control @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_deskripsi') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_deskripsi]" type="text" placeholder="Contoh: Standar" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_deskripsi'] }}">
                                                    @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_deskripsi')
                                                    <div class="invalid-feedback">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                                <div class="mb-3">
                                                    <label class="col-form-label">{{ $jenis_hiburan->hiburan_jenis_htm_label }}</label>
                                                    <div class="input-group @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_tarif') is-invalid @enderror">
                                                        <span class="input-group-text">IDR</span>
                                                        <input class="form-control hiburan_jenis_ruangan_tarif @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_tarif') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_tarif]" type="number" min="0" placeholder="Contoh: 500000" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_tarif'] ?? 0 }}">
                                                        <span class="input-group-text">/ {{ $jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                                    </div>
                                                    @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_tarif')
                                                    <div class="invalid-feedback">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                                <div class="mb-3">
                                                    <label class="col-form-label">Jumlah Room</label>
                                                    <div class="input-group @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jumlah') is-invalid @enderror">
                                                        <span class="input-group-text">Room</span>
                                                        <input class="form-control hiburan_jenis_ruangan_jumlah @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jumlah') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_jumlah]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_jumlah'] ?? 0 }}">
                                                    </div>
                                                    @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jumlah')
                                                    <div class="invalid-feedback">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                                @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label)
                                                <div class="mb-3">
                                                    <label class="col-form-label">Jumlah {{ $jenis_hiburan->hiburan_jenis_kapasitas_label }}</label>
                                                    <div class="input-group @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_kapasitas') is-invalid @enderror">
                                                        <span class="input-group-text">{{ $jenis_hiburan->hiburan_jenis_kapasitas_unit }}</span>
                                                        <input class="form-control hiburan_jenis_ruangan_kapasitas @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_kapasitas') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_kapasitas]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_kapasitas'] ?? 0 }}">
                                                    </div>
                                                    @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_kapasitas')
                                                    <div class="invalid-feedback">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                                @endif
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <label class="col-form-label">Jam Operasional Hari Kerja</label>
                                                        <input class="form-control daterangepicker-time @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jam_weekdays') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_jam_weekdays]" type="text" placeholder="Contoh: 10:00 - 17:00" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_jam_weekdays'] }}">
                                                        @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jam_weekdays')
                                                        <div class="invalid-feedback">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <label class="col-form-label">Jam Operasional Hari Libur</label>
                                                        <input class="form-control daterangepicker-time @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jam_weekends') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_jam_weekends]" type="text" placeholder="Contoh: 10:00 - 17:00" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_jam_weekends'] }}">
                                                        @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_jam_weekends')
                                                        <div class="invalid-feedback">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                </div>
                                                <hr class="mt-4 mb-4">
                                                <h6 class="pb-3 mb-0">Rata - Rata {{ (@$jenis_hiburan->hiburan_jenis_kunjungan_label ? $jenis_hiburan->hiburan_jenis_kunjungan_label . ' (' . $jenis_hiburan->hiburan_jenis_kunjungan_unit . ')' : 'Kunjungan (Orang)') }} / Hari</h6>
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <label class="col-form-label">Hari Kerja</label>
                                                        <div class="input-group @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekdays') is-invalid @enderror">
                                                            <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? $jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                                            <input class="form-control hiburan_jenis_ruangan_avg_weekdays @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekdays') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_avg_weekdays]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_avg_weekdays'] ?? 0 }}">
                                                        </div>
                                                        @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekdays')
                                                        <div class="invalid-feedback">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <label class="col-form-label">Hari Libur</label>
                                                        <div class="input-group @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekends') is-invalid @enderror">
                                                            <span class="input-group-text">{{ @$jenis_hiburan->hiburan_jenis_kunjungan_unit ?? $jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                                            <input class="form-control hiburan_jenis_ruangan_avg_weekends @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekends') is-invalid @enderror" name="jenis_ruangan[{{ $key }}][hiburan_jenis_ruangan_avg_weekends]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_ruangan['hiburan_jenis_ruangan_avg_weekends'] ?? 0 }}">
                                                        </div>
                                                        @error('jenis_ruangan.'.$key.'.hiburan_jenis_ruangan_avg_weekends')
                                                        <div class="invalid-feedback">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    @endforeach
                                </div>
                                <button class="btn btn-outline-success btn-sm btnAdd" type="button"><i class="fa fa-plus"></i> Tambah Jenis Ruangan</button>
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
