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

            @if((empty(old('rusun.rusun_latitude', @$rusun->rusun_latitude)) && empty(old('rusun.rusun_longitude', @$rusun->rusun_longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="rusun[rusun_latitude]"]'), $('[name="rusun[rusun_longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            $('.btnAdd').on('click', function(e) {
                e.preventDefault();
                addJenisKamar();
            });

            $('body, html').on('click', '.btnRemove', function(e) {
                e.preventDefault();
                removeJenisKamar($(this));
            });

            inputFile.onchange = evt => {
                const [file] = inputFile.files
                if (file) {
                    imagePreview.src = URL.createObjectURL(file)
                }
            }
        });

        function removeJenisKamar(el) {
            if ($('.accordion-item').length == 1) {
                swal("Gagal menghapus item!", "Setidaknya harus terdapat 1 jenis kamar.", "error");
                return;
            }

            var jenisKamarItem = $(el.parents('.accordion-item')[0]);
            var id = jenisKamarItem.find('.id-jenis_kamar');

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
                        var deletedId = $('#input-deleted-jenis_kamar').val().split(';');
                        deletedId.push(id.val());

                        $('#input-deleted-jenis_kamar').val(deletedId.join(';'));
                    }

                    jenisKamarItem.remove();
                    initJenisKamarItem();
                }
            });

        }

        function addJenisKamar() {
            var jenisKamarItem = $($('.accordion-item')[0]).clone();
            var jenisKamarContainer = $('#accordion');

            jenisKamarItem.find('input').val('');
            jenisKamarItem.find('.id-jenis_kamar').remove();

            jenisKamarContainer.append(jenisKamarItem);

            initJenisKamarItem();
        }

        function initJenisKamarItem() {
            $('.accordion-item').each(function(k, el){
                var item = $(el);
                item.find('.card-header').attr('id', 'accordion-heading-' + k);
                item.find('.card-header .btn-link').attr('data-bs-target', '#accordion-collapse-' + k);
                item.find('.card-header .btn-link').attr('aria-controls', '#accordion-collapse-' + k);
                item.find('.card-header .btn-link span').text(k + 1);
                item.find('.collapse').attr('id', '#accordion-collapse-' + k);

                item.find('input[name$="[id]"]').attr('name', `jenis_kamar[${k}][id]`);
                item.find('input[name$="[rusun_jenis_kamar_deskripsi]"]').attr('name', `jenis_kamar[${k}][rusun_jenis_kamar_deskripsi]`);
                item.find('input[name$="[rusun_jenis_kamar_tarif]"]').attr('name', `jenis_kamar[${k}][rusun_jenis_kamar_tarif]`);
                item.find('input[name$="[rusun_jenis_kamar_jumlah]"]').attr('name', `jenis_kamar[${k}][rusun_jenis_kamar_jumlah]`);
                item.find('input[name$="[rusun_jenis_kamar_hunian_avg]"]').attr('name', `jenis_kamar[${k}][rusun_jenis_kamar_hunian_avg]`);
            });
        }

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(setPosition);
            }
        }

        function setPosition(position) {
            $('[name="rusun[rusun_latitude]"]').val(position.coords.latitude);
            $('[name="rusun[rusun_longitude]"]').val(position.coords.longitude);
        }
    </script>
@endpush

@section('title', $title.' Rusun')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Retribusi Daerah Rusun</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/rusun') }}">Retribusi Daerah Rusun</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Rusun</li>
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
                            <h5>{{ $title }} Rusun</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Rusun</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pemilik <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('rusun.rusun_pemilik') is-invalid @enderror" name="rusun[rusun_pemilik]" type="text" placeholder="Contoh: John Doe" value="{{ old('rusun.rusun_pemilik', @$rusun->rusun_pemilik) }}" required>
                                @error('rusun.rusun_pemilik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Rusun</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$rusun->rusun_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($rusun->rusun_foto, 'http') !== false ? $rusun->rusun_foto : asset('uploads/rusun/'.$rusun->rusun_foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('rusun.rusun_foto') is-invalid @enderror" name="rusun[rusun_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('rusun.rusun_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Retribusi <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('rusun.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="rusun[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('rusun.status_aktif_id', @$rusun->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('rusun.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                            <div class="mb-3">
                                <label class="col-form-label">Nama Rusun <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('rusun.rusun_nama') is-invalid @enderror" name="rusun[rusun_nama]" type="text" placeholder="Contoh: Rusun Mawar" value="{{ old('rusun.rusun_nama', @$rusun->rusun_nama) }}" required>
                                @error('rusun.rusun_nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. NPWPD</label>
                                <input class="form-control @error('rusun.rusun_npwpd') is-invalid @enderror" name="rusun[rusun_npwpd]" type="text" placeholder="Contoh: 420938278129382" value="{{ old('rusun.rusun_npwpd', @$rusun->rusun_npwpd) }}">
                                @error('rusun.rusun_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('rusun.rusun_telepon') is-invalid @enderror" name="rusun[rusun_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('rusun.rusun_telepon', @$rusun->rusun_telepon) }}">
                                @error('rusun.rusun_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Rusun <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <textarea class="form-control @error('rusun.rusun_alamat') is-invalid @enderror" name="rusun[rusun_alamat]"
                                          placeholder="Contoh: Jl. Gempora I RT.002/004"
                                          cols="3" required>{{ old('rusun.rusun_alamat', @$rusun->rusun_alamat) }}</textarea>
                                @error('rusun.rusun_alamat')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('rusun.rusun_kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-rusun-kelurahan" name="rusun[rusun_kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('rusun.rusun_kelurahan', @$rusun->rusun_kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('rusun.rusun_kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RW</label>
                                <input class="form-control @error('rusun.rusun_rw') is-invalid @enderror" name="rusun[rusun_rw]" type="text" placeholder="Contoh: 001" value="{{ old('rusun.rusun_rw', @$rusun->rusun_rw) }}">
                                @error('rusun.rusun_rw')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RT</label>
                                <input class="form-control @error('rusun.rusun_rt') is-invalid @enderror" name="rusun[rusun_rt]" type="text" placeholder="Contoh: 001" value="{{ old('rusun.rusun_rt', @$rusun->rusun_rt) }}">
                                @error('rusun.rusun_rt')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('rusun.rusun_latitude') is-invalid @enderror" name="rusun[rusun_latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('rusun.rusun_latitude', @$rusun->rusun_latitude) }}">
                                        @error('rusun.rusun_latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('rusun.rusun_longitude') is-invalid @enderror" name="rusun[rusun_longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('rusun.rusun_longitude', @$rusun->rusun_longitude) }}">
                                        @error('rusun.rusun_longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-outline-info btn-sm mt-2 btnOpenMap" data-bs-toggle="modal" data-bs-target="#mapModal" type="button">Pilih Titik Peta</button>
                            </div>
                            <div class="mb-4">
                                <label class="col-form-label">Jumlah Pegawai</label>
                                <div class="input-group @error('rusun.rusun_jumlah_pegawai') is-invalid @enderror">
                                    <span class="input-group-text">Orang</span>
                                    <input class="form-control @error('rusun.rusun_jumlah_pegawai') is-invalid @enderror" name="rusun[rusun_jumlah_pegawai]" type="number" placeholder="Contoh: 222" value="{{ old('rusun.rusun_jumlah_pegawai', @$rusun->rusun_jumlah_pegawai) }}">
                                </div>
                                @error('rusun.rusun_jumlah_pegawai')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Jenis Kamar</h6>
                            <div class="default-according mb-3" id="accordion">
                                <input type="hidden" name="deleted_jenis_kamar" id="input-deleted-jenis_kamar">
                                @foreach($jenis_kamars as $key => $jenis_kamar)
                                <div class="card accordion-item">
                                    <div class="card-header bg-success" id="accordion-heading-{{ $loop->iteration }}">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link text-white" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-collapse-{{ $loop->iteration }}" aria-expanded="true" aria-controls="accordion-collapse-{{ $loop->iteration }}">Jenis Kamar #<span>{{ $loop->iteration }}</span></button>
                                        </h5>
                                    </div>
                                    <div class="collapse show" id="accordion-collapse-{{ $loop->iteration }}" data-bs-parent="#accordion">
                                        <div class="card-body">
                                            <div class="mb-3 text-end">
                                                <button class="btn btn-danger btnRemove" type="button"><i class="fa fa-trash-o"></i></button>
                                            </div>

                                            @if(@$jenis_kamar['id'])
                                            <input type="hidden" name="jenis_kamar[{{ $key }}][id]" class="id-jenis_kamar" value="{{ @$jenis_kamar['id'] }}">
                                            @endif

                                            <div class="mb-3">
                                                <label class="col-form-label">Deskripsi Jenis Kamar</label>
                                                <input class="form-control @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_deskripsi') is-invalid @enderror" name="jenis_kamar[{{ $key }}][rusun_jenis_kamar_deskripsi]" type="text" placeholder="Contoh: Standar" value="{{ @$jenis_kamar['rusun_jenis_kamar_deskripsi'] }}">
                                                @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_deskripsi')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                            <div class="mb-3">
                                                <label class="col-form-label">Tarif Resmi Rusun</label>
                                                <div class="input-group @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_tarif') is-invalid @enderror">
                                                    <span class="input-group-text">IDR</span>
                                                    <input class="form-control rusun_jenis_kamar_tarif @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_tarif') is-invalid @enderror" name="jenis_kamar[{{ $key }}][rusun_jenis_kamar_tarif]" type="number" min="0" placeholder="Contoh: 500000" value="{{ @$jenis_kamar['rusun_jenis_kamar_tarif'] ?? 0 }}">
                                                </div>
                                                @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_tarif')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                            <div class="mb-3">
                                                <label class="col-form-label">Jumlah Seluruh Kamar</label>
                                                <div class="input-group @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_jumlah') is-invalid @enderror">
                                                    <span class="input-group-text">Kamar</span>
                                                    <input class="form-control rusun_jenis_kamar_jumlah @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_jumlah') is-invalid @enderror" name="jenis_kamar[{{ $key }}][rusun_jenis_kamar_jumlah]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['rusun_jenis_kamar_jumlah'] ?? 0 }}">
                                                </div>
                                                @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_jumlah')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                            <div class="mb-3">
                                                <label class="col-form-label">Rata-rata Tingkat Hunian Kos Per Tahun</label>
                                                <div class="input-group @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_hunian_avg') is-invalid @enderror">
                                                    <span class="input-group-text">Kamar</span>
                                                    <input class="form-control rusun_jenis_kamar_hunian_avg @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_hunian_avg') is-invalid @enderror" name="jenis_kamar[{{ $key }}][rusun_jenis_kamar_hunian_avg]" type="number" min="0" placeholder="Contoh: 50" value="{{ @$jenis_kamar['rusun_jenis_kamar_hunian_avg'] ?? 0 }}">
                                                </div>
                                                @error('jenis_kamar.'.$key.'.rusun_jenis_kamar_hunian_avg')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                            <button class="btn btn-outline-success btn-sm btnAdd" type="button"><i class="fa fa-plus"></i> Tambah Jenis Kamar</button>

                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$rusun->created_at ? date('m/d/Y @ h:i:s', strtotime($rusun->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$rusun->updated_at ? date('m/d/Y @ h:i:s', strtotime($rusun->updated_at)) : null) }}" disabled>
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
