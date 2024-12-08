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
            
            $('.date').datepicker({
                format: '{{ config('app.date_format_js') }}'
            });
            
            @if((empty(old('air.latitude', @$air->latitude)) && empty(old('air.longitude', @$air->longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="air[latitude]"]'), $('[name="air[longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            var newOption;

            @if(!empty(old('air.klasifikasi_id')) && !is_numeric(old('air.klasifikasi_id')))
                newOption = new Option("{{ old('air.klasifikasi_id') }}", "{{ old('air.klasifikasi_id') }}", true, true);
                $('#select-air-klasifikasi').append(newOption).trigger('change');
            @endif

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

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(setPosition);
            }
        }

        function setPosition(position) {
            $('[name="air[latitude]"]').val(position.coords.latitude);
            $('[name="air[longitude]"]').val(position.coords.longitude);
        }
    </script>
@endpush

@section('title', $title.' Air')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Air</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/air') }}">Potensi Pajak Air</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Air</li>
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
                            <h5>{{ $title }} Air</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Air</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('air.nama_objek') is-invalid @enderror" name="air[nama_objek]" type="text" placeholder="Contoh: John Doe" value="{{ old('air.nama_objek', @$air->nama_objek) }}" required>
                                @error('air.nama_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Air Bawah Tanah</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$air->foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($air->foto, 'http') !== false ? $air->foto : asset('uploads/air/'.$air->foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('air.foto') is-invalid @enderror" name="air[foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('air.foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('air.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="air[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('air.status_aktif_id', @$air->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('air.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                             
                            <div class="mb-3">
                                <label class="col-form-label">Rekening Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('air.rekening_objek') is-invalid @enderror" name="air[rekening_objek]" type="text" value="{{ old('air.rekening_objek', @$air->rekening_objek) }}" required>
                                @error('air.rekening_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('air.kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-air-kelurahan" name="air[kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('air.kelurahan', @$air->kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('air.kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">Alamat_Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('air.alamat_objek') is-invalid @enderror" name="air[alamat_objek]" type="text" value="{{ old('air.alamat_objek', @$air->alamat_objek) }}" required>
                                @error('air.alamat_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('air.latitude') is-invalid @enderror" name="air[latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('air.latitude', @$air->latitude) }}">
                                        @error('air.latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('air.longitude') is-invalid @enderror" name="air[longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('air.longitude', @$air->longitude) }}">
                                        @error('air.longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('air.persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control @error('air.persentase_pajak') is-invalid @enderror" name="air[persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('air.persentase_pajak', (@$air->persentase_pajak ?? @$currentPersentasePajak)) }}">
                                </div>
                                @error('air.persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-f orm-label">No. NPWPD</label>
                                <input class="form-control @error('air.npwpd') is-invalid @enderror" name="air[npwpd]" type="text"  value="{{ old('air.npwpd', @$air->npwpd) }}">
                                @error('air.npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">No. Permohonan</label>
                                <input class="form-control @error('air.no_permohonan') is-invalid @enderror" name="air[no_permohonan]" type="text"  value="{{ old('air.no_permohonan', @$air->no_permohonan) }}">
                                @error('air.no_permohonan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama</label>
                                <input class="form-control @error('air.nama') is-invalid @enderror" name="air[nama]" type="text"  value="{{ old('air.nama', @$air->nama) }}">
                                @error('air.nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Badan</label>
                                <input class="form-control @error('air.nama_badan') is-invalid @enderror" name="air[nama_badan]" type="text"  value="{{ old('air.nama_badan', @$air->nama_badan) }}">
                                @error('air.nama_badan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Fasilitas</label>
                                <input class="form-control @error('air.fasilitas') is-invalid @enderror" name="air[fasilitas]" type="text"  value="{{ old('air.fasilitas', @$air->fasilitas) }}">
                                @error('air.fasilitas')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pihak Lain</label>
                                <input class="form-control @error('air.nama_pihak_lain') is-invalid @enderror" name="air[nama_pihak_lain]" type="text"  value="{{ old('air.nama_pihak_lain', @$air->nama_pihak_lain) }}">
                                @error('air.nama_pihak_lain')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Lama Operasional</label>
                                <input class="form-control @error('air.lama_operasional') is-invalid @enderror" name="air[lama_operasional]" type="text"  value="{{ old('air.lama_operasional', @$air->lama_operasional) }}">
                                @error('air.lama_operasional')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Email</label>
                                <input class="form-control @error('air.email') is-invalid @enderror" name="air[email]" type="text"  value="{{ old('air.email', @$air->email) }}">
                                @error('air.email')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Website</label>
                                <input class="form-control @error('air.website') is-invalid @enderror" name="air[website]" type="text"  value="{{ old('air.website', @$air->website) }}">
                                @error('air.website')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Sosmed</label>
                                <input class="form-control @error('air.sosmed') is-invalid @enderror" name="air[sosmed]" type="text"  value="{{ old('air.sosmed', @$air->sosmed) }}">
                                @error('air.sosmed')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Telp Kantor</label>
                                <input class="form-control @error('air.telp_kantor') is-invalid @enderror" name="air[telp_kantor]" type="text"  value="{{ old('air.telp_kantor', @$air->telp_kantor) }}">
                                @error('air.telp_kantor')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Telp Manajemen</label>
                                <input class="form-control @error('air.telp_manajemen') is-invalid @enderror" name="air[telp_manajemen]" type="text"  value="{{ old('air.telp_manajemen', @$air->telp_manajemen) }}">
                                @error('air.telp_manajemen')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Fax</label>
                                <input class="form-control @error('air.no_fax') is-invalid @enderror" name="air[no_fax]" type="text"  value="{{ old('air.no_fax', @$air->no_fax) }}">
                                @error('air.no_fax')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Pengukuhan NPWPD</label>
                                <input class="date form-control @error('air.pengukuhan_npwpd') is-invalid @enderror" name="air[pengukuhan_npwpd]" type="text" value="{{ old('air.pengukuhan_npwpd', @$air->pengukuhan_npwpd) }}">
                                @error('air.pengukuhan_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Perijinan</label>
                                <input class="form-control @error('air.perijinan') is-invalid @enderror" name="air[perijinan]" type="text"  value="{{ old('air.perijinan', @$air->perijinan) }}">
                                @error('air.perijinan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Klasifikasi Air <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('air.klasifikasi_id') is-invalid @enderror" multiple="multiple" id="select-air-klasifikasi" name="air[klasifikasi_id]" required>
                                    @foreach($klasifikasis as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('air.klasifikasi_id', @$air->klasifikasi_id) ? 'selected' : null }}>{{ $row->air_klasifikasi_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('air.klasifikasi_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$air->created_at ? date('m/d/Y @ h:i:s', strtotime($air->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$air->updated_at ? date('m/d/Y @ h:i:s', strtotime($air->updated_at)) : null) }}" disabled>
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
