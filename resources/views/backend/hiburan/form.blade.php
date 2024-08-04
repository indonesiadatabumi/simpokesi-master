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
        var map, polygon, marker;
        var hiburanKategori = JSON.parse('{!! $hiburan_kategories !!}');

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
            
            @if((empty(old('hiburan.hiburan_latitude', @$hiburan->hiburan_latitude)) && empty(old('hiburan.hiburan_longitude', @$hiburan->hiburan_longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="hiburan[hiburan_latitude]"]'), $('[name="hiburan[hiburan_longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            var newOption;

            @if(!empty(old('hiburan.hiburan_kategori_id')) && !is_numeric(old('hiburan.hiburan_kategori_id')))
                newOption = new Option("{{ old('hiburan.hiburan_kategori_id') }}", "{{ old('hiburan.hiburan_kategori_id') }}", true, true);
                $('#select-hiburan-kategori').append(newOption).trigger('change');
            @endif

            $('.btnAdd').on('click', function(e) {
                e.preventDefault();
                addJenisRuangan();
            });

            $('body, html').on('click', '.btnRemove', function(e) {
                e.preventDefault();
                removeJenisRuangan($(this));
            });

            $('#select-hiburan-kategori').on('change', function(e) {
                e.preventDefault();
                const val = $(this).val();

                if (val[0] && (hiburanKategori.length > 0)) {
                    const selectedKategori = hiburanKategori.find((persentase) => persentase.id == val[0]);
                    
                    if (selectedKategori?.hiburan_kategori_persentase) {
                        $('.persentase-pajak').val(selectedKategori?.hiburan_kategori_persentase);
                    }
                }
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

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(setPosition);
            }
        }

        function setPosition(position) {
            $('[name="hiburan[hiburan_latitude]"]').val(position.coords.latitude);
            $('[name="hiburan[hiburan_longitude]"]').val(position.coords.longitude);
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
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pemilik <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('hiburan.hiburan_pemilik') is-invalid @enderror" name="hiburan[hiburan_pemilik]" type="text" placeholder="Contoh: John Doe" value="{{ old('hiburan.hiburan_pemilik', @$hiburan->hiburan_pemilik) }}" required>
                                @error('hiburan.hiburan_pemilik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$hiburan->hiburan_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($hiburan->hiburan_foto, 'http') !== false ? $hiburan->hiburan_foto : asset('uploads/hiburan/'.$hiburan->hiburan_foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('hiburan.hiburan_foto') is-invalid @enderror" name="hiburan[hiburan_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('hiburan.hiburan_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('hiburan.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="hiburan[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('hiburan.status_aktif_id', @$hiburan->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('hiburan.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                            <div class="mb-3">
                                <label class="col-form-label">Nama {{ @$jenis_hiburan->hiburan_jenis_deskripsi }} <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('hiburan.hiburan_nama') is-invalid @enderror" name="hiburan[hiburan_nama]" type="text" placeholder="Contoh: {{ @$jenis_hiburan->hiburan_jenis_deskripsi }} Mawar" value="{{ old('hiburan.hiburan_nama', @$hiburan->hiburan_nama) }}" required>
                                @error('hiburan.hiburan_nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. NPWPD</label>
                                <input class="form-control @error('hiburan.hiburan_npwpd') is-invalid @enderror" name="hiburan[hiburan_npwpd]" type="text" placeholder="Contoh: 420938278129382" value="{{ old('hiburan.hiburan_npwpd', @$hiburan->hiburan_npwpd) }}">
                                @error('hiburan.hiburan_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('hiburan.hiburan_telepon') is-invalid @enderror" name="hiburan[hiburan_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('hiburan.hiburan_telepon', @$hiburan->hiburan_telepon) }}">
                                @error('hiburan.hiburan_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @if($hiburan_kategories->count() > 0)
                            <div class="mb-3">
                                <label class="col-form-label">Kategori <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('hiburan.hiburan_kategori_id') is-invalid @enderror" multiple="multiple" id="select-hiburan-kategori" name="hiburan[hiburan_kategori_id]" required>
                                    @foreach($hiburan_kategories as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('hiburan.hiburan_kategori_id', @$hiburan->hiburan_kategori_id) ? 'selected' : null }}>{{ $row->hiburan_kategori_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('hiburan.hiburan_kategori_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endif
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Hiburan <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <textarea class="form-control @error('hiburan.hiburan_alamat') is-invalid @enderror" name="hiburan[hiburan_alamat]"
                                          placeholder="Contoh: Jl. Gempora I RT.002/004"
                                          cols="3" required>{{ old('hiburan.hiburan_alamat', @$hiburan->hiburan_alamat) }}</textarea>
                                @error('hiburan.hiburan_alamat')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('hiburan.hiburan_kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-hiburan-kelurahan" name="hiburan[hiburan_kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('hiburan.hiburan_kelurahan', @$hiburan->hiburan_kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('hiburan.hiburan_kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RW</label>
                                <input class="form-control @error('hiburan.hiburan_rw') is-invalid @enderror" name="hiburan[hiburan_rw]" type="text" placeholder="Contoh: 001" value="{{ old('hiburan.hiburan_rw', @$hiburan->hiburan_rw) }}">
                                @error('hiburan.hiburan_rw')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RT</label>
                                <input class="form-control @error('hiburan.hiburan_rt') is-invalid @enderror" name="hiburan[hiburan_rt]" type="text" placeholder="Contoh: 001" value="{{ old('hiburan.hiburan_rt', @$hiburan->hiburan_rt) }}">
                                @error('hiburan.hiburan_rt')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('hiburan.hiburan_latitude') is-invalid @enderror" name="hiburan[hiburan_latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('hiburan.hiburan_latitude', @$hiburan->hiburan_latitude) }}">
                                        @error('hiburan.hiburan_latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('hiburan.hiburan_longitude') is-invalid @enderror" name="hiburan[hiburan_longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('hiburan.hiburan_longitude', @$hiburan->hiburan_longitude) }}">
                                        @error('hiburan.hiburan_longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-outline-info btn-sm mt-2 btnOpenMap" data-bs-toggle="modal" data-bs-target="#mapModal" type="button">Pilih Titik Peta</button>
                            </div>
                        
                            {{-- Kalo ga punya ruangan --}}
                            @if(!@$jenis_hiburan->hiburan_jenis_have_ruangan)
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="col-form-label">Jam Operasional Hari Kerja</label>
                                        <input class="form-control daterangepicker-time @error('hiburan.hiburan_jam_weekdays') is-invalid @enderror" type="text" name="hiburan[hiburan_jam_weekdays]" placeholder="Contoh: 10:00 - 17:00" value="{{ old('hiburan.hiburan_jam_weekdays', @$hiburan->hiburan_jam_weekdays) }}">
                                        @error('hiburan.hiburan_jam_weekdays')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="col-form-label">Jam Operasional Hari Libur</label>
                                        <input class="form-control daterangepicker-time @error('hiburan.hiburan_jam_weekends') is-invalid @enderror" type="text" name="hiburan[hiburan_jam_weekends]" placeholder="Contoh: 10:00 - 17:00" value="{{ old('hiburan.hiburan_jam_weekends', @$hiburan->hiburan_jam_weekends) }}">
                                        @error('hiburan.hiburan_jam_weekends')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            @endif
                            
                            {{-- Kalo punya jumlah sesuatu --}}
                            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
                                <div class="mb-3">
                                    <label class="col-form-label">Jumlah {{ $jenis_hiburan->hiburan_jenis_jumlah_label }}</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah') is-invalid @enderror">
                                        <span class="input-group-text">{{ $jenis_hiburan->hiburan_jenis_jumlah_unit }}</span>
                                        <input class="form-control @error('hiburan.hiburan_jumlah') is-invalid @enderror" name="hiburan[hiburan_jumlah]" type="number" placeholder="Contoh: 222" value="{{ old('hiburan.hiburan_jumlah', @$hiburan->hiburan_jumlah) }}">
                                    </div>
                                    @error('hiburan.hiburan_jumlah')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            @endif
                            
                            {{-- Kalo punya jumlah kapasitas & ga punya ruangan --}}
                            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !@$jenis_hiburan->hiburan_jenis_have_ruangan)
                                <div class="mb-3">
                                    <label class="col-form-label">Jumlah {{ $jenis_hiburan->hiburan_jenis_kapasitas_label }}</label>
                                    <div class="input-group @error('hiburan.hiburan_kapasitas') is-invalid @enderror">
                                        <span class="input-group-text">{{ $jenis_hiburan->hiburan_jenis_kapasitas_unit }}</span>
                                        <input class="form-control @error('hiburan.hiburan_kapasitas') is-invalid @enderror" name="hiburan[hiburan_kapasitas]" type="number" placeholder="Contoh: 222" value="{{ old('hiburan.hiburan_kapasitas', @$hiburan->hiburan_kapasitas) }}">
                                    </div>
                                    @error('hiburan.hiburan_kapasitas')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            @endif

                            {{-- Kalo ga punya ruangan & gapunya multiple tarif --}}
                            @if(!@$jenis_hiburan->hiburan_jenis_have_ruangan && !@$jenis_hiburan->hiburan_jenis_have_multiple_tarif)
                                <div class="mb-3">
                                    <label class="col-form-label">{{ $jenis_hiburan->hiburan_jenis_htm_label }}</label>
                                    <div class="input-group @error('hiburan.hiburan_tarif') is-invalid @enderror">
                                        <span class="input-group-text">Rp</span>
                                        <input class="form-control @error('hiburan.hiburan_tarif') is-invalid @enderror" name="hiburan[hiburan_tarif]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif', @$hiburan->hiburan_tarif) }}">
                                        @if (@$jenis_hiburan->hiburan_jenis_htm_unit)
                                        <span class="input-group-text">/ {{ $jenis_hiburan->hiburan_jenis_htm_unit }}</span>
                                        @endif
                                    </div>
                                    @error('hiburan.hiburan_tarif')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            @endif

                            {{-- Kalo jenis hiburan punya jumlah durasi --}}
                            @if(@$jenis_hiburan->hiburan_jenis_durasi_label)
                                <div class="mb-3">
                                    <label class="col-form-label">{{ $jenis_hiburan->hiburan_jenis_durasi_label }}</label>
                                    <div class="input-group @error('hiburan.hiburan_durasi') is-invalid @enderror">
                                        <input class="form-control @error('hiburan.hiburan_durasi') is-invalid @enderror" name="hiburan[hiburan_durasi]" type="number" step="any" placeholder="Contoh: 25" value="{{ old('hiburan.hiburan_durasi', @$hiburan->hiburan_durasi) }}">
                                        <span class="input-group-text">{{ $jenis_hiburan->hiburan_jenis_durasi_unit }}</span>
                                    </div>
                                    @error('hiburan.hiburan_durasi')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            @endif

                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('hiburan.hiburan_persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control persentase-pajak @error('hiburan.hiburan_persentase_pajak') is-invalid @enderror" name="hiburan[hiburan_persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('hiburan.hiburan_persentase_pajak', (@$hiburan->hiburan_persentase_pajak ?? @$jenis_hiburan->hiburan_jenis_persentase)) }}">
                                </div>
                                @error('hiburan.hiburan_persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

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
                                        <strong class="mb-0">{{ @$jenis_hiburan_kunjungan->hiburan_kunjungan->hiburan_kunjungan_deskripsi ?? @$jenis_hiburan_kunjungan->hiburan_kunjungan_deskripsi }}</strong>
                                        <input type="hidden" name="hiburan_kunjungan_value[{{ $key }}][hiburan_kunjungan_id]" class="id-hiburan_kunjungan" value="{{ @$jenis_hiburan_kunjungan['hiburan_kunjungan_id'] ?? @$jenis_hiburan_kunjungan['id'] }}">
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

                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$hiburan->created_at ? date('m/d/Y @ h:i:s', strtotime($hiburan->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$hiburan->updated_at ? date('m/d/Y @ h:i:s', strtotime($hiburan->updated_at)) : null) }}" disabled>
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