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
            
            @if((empty(old('penerangan.latitude', @$penerangan->latitude)) && empty(old('penerangan.longitude', @$penerangan->longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="penerangan[latitude]"]'), $('[name="penerangan[longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            var newOption;

            @if(!empty(old('penerangan.klasifikasi_id')) && !is_numeric(old('penerangan.klasifikasi_id')))
                newOption = new Option("{{ old('penerangan.klasifikasi_id') }}", "{{ old('penerangan.klasifikasi_id') }}", true, true);
                $('#select-penerangan-klasifikasi').append(newOption).trigger('change');
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
            $('[name="penerangan[latitude]"]').val(position.coords.latitude);
            $('[name="penerangan[longitude]"]').val(position.coords.longitude);
        }
    </script>
@endpush

@section('title', $title.' Penerangan')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Penerangan</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/penerangan') }}">Potensi Pajak Penerangan</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Penerangan</li>
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
                            <h5>{{ $title }} Penerangan</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Penerangan</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('penerangan.nama_objek') is-invalid @enderror" name="penerangan[nama_objek]" type="text" placeholder="Contoh: John Doe" value="{{ old('penerangan.nama_objek', @$penerangan->nama_objek) }}" required>
                                @error('penerangan.nama_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Penerangan Bawah Tanah</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$penerangan->foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($penerangan->foto, 'http') !== false ? $penerangan->foto : asset('uploads/penerangan/'.$penerangan->foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('penerangan.foto') is-invalid @enderror" name="penerangan[foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('penerangan.foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('penerangan.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="penerangan[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('penerangan.status_aktif_id', @$penerangan->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('penerangan.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                             
                            <div class="mb-3">
                                <label class="col-form-label">Rekening Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('penerangan.rekening_objek') is-invalid @enderror" name="penerangan[rekening_objek]" type="text" value="{{ old('penerangan.rekening_objek', @$penerangan->rekening_objek) }}" required>
                                @error('penerangan.rekening_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('penerangan.kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-penerangan-kelurahan" name="penerangan[kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('penerangan.kelurahan', @$penerangan->kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('penerangan.kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">Alamat_Objek <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('penerangan.alamat_objek') is-invalid @enderror" name="penerangan[alamat_objek]" type="text" value="{{ old('penerangan.alamat_objek', @$penerangan->alamat_objek) }}" required>
                                @error('penerangan.alamat_objek')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('penerangan.latitude') is-invalid @enderror" name="penerangan[latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('penerangan.latitude', @$penerangan->latitude) }}">
                                        @error('penerangan.latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('penerangan.longitude') is-invalid @enderror" name="penerangan[longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('penerangan.longitude', @$penerangan->longitude) }}">
                                        @error('penerangan.longitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('penerangan.persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control @error('penerangan.persentase_pajak') is-invalid @enderror" name="penerangan[persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('penerangan.persentase_pajak', (@$penerangan->persentase_pajak ?? @$currentPersentasePajak)) }}">
                                </div>
                                @error('penerangan.persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-f orm-label">No. NPWPD</label>
                                <input class="form-control @error('penerangan.npwpd') is-invalid @enderror" name="penerangan[npwpd]" type="text"  value="{{ old('penerangan.npwpd', @$penerangan->npwpd) }}">
                                @error('penerangan.npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">No. Permohonan</label>
                                <input class="form-control @error('penerangan.no_permohonan') is-invalid @enderror" name="penerangan[no_permohonan]" type="text"  value="{{ old('penerangan.no_permohonan', @$penerangan->no_permohonan) }}">
                                @error('penerangan.no_permohonan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama</label>
                                <input class="form-control @error('penerangan.nama') is-invalid @enderror" name="penerangan[nama]" type="text"  value="{{ old('penerangan.nama', @$penerangan->nama) }}">
                                @error('penerangan.nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Badan</label>
                                <input class="form-control @error('penerangan.nama_badan') is-invalid @enderror" name="penerangan[nama_badan]" type="text"  value="{{ old('penerangan.nama_badan', @$penerangan->nama_badan) }}">
                                @error('penerangan.nama_badan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Fasilitas</label>
                                <input class="form-control @error('penerangan.fasilitas') is-invalid @enderror" name="penerangan[fasilitas]" type="text"  value="{{ old('penerangan.fasilitas', @$penerangan->fasilitas) }}">
                                @error('penerangan.fasilitas')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pihak Lain</label>
                                <input class="form-control @error('penerangan.nama_pihak_lain') is-invalid @enderror" name="penerangan[nama_pihak_lain]" type="text"  value="{{ old('penerangan.nama_pihak_lain', @$penerangan->nama_pihak_lain) }}">
                                @error('penerangan.nama_pihak_lain')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Lama Operasional</label>
                                <input class="form-control @error('penerangan.lama_operasional') is-invalid @enderror" name="penerangan[lama_operasional]" type="text"  value="{{ old('penerangan.lama_operasional', @$penerangan->lama_operasional) }}">
                                @error('penerangan.lama_operasional')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Email</label>
                                <input class="form-control @error('penerangan.email') is-invalid @enderror" name="penerangan[email]" type="text"  value="{{ old('penerangan.email', @$penerangan->email) }}">
                                @error('penerangan.email')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Website</label>
                                <input class="form-control @error('penerangan.website') is-invalid @enderror" name="penerangan[website]" type="text"  value="{{ old('penerangan.website', @$penerangan->website) }}">
                                @error('penerangan.website')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Sosmed</label>
                                <input class="form-control @error('penerangan.sosmed') is-invalid @enderror" name="penerangan[sosmed]" type="text"  value="{{ old('penerangan.sosmed', @$penerangan->sosmed) }}">
                                @error('penerangan.sosmed')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Telp Kantor</label>
                                <input class="form-control @error('penerangan.telp_kantor') is-invalid @enderror" name="penerangan[telp_kantor]" type="text"  value="{{ old('penerangan.telp_kantor', @$penerangan->telp_kantor) }}">
                                @error('penerangan.telp_kantor')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Telp Manajemen</label>
                                <input class="form-control @error('penerangan.telp_manajemen') is-invalid @enderror" name="penerangan[telp_manajemen]" type="text"  value="{{ old('penerangan.telp_manajemen', @$penerangan->telp_manajemen) }}">
                                @error('penerangan.telp_manajemen')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. Fax</label>
                                <input class="form-control @error('penerangan.no_fax') is-invalid @enderror" name="penerangan[no_fax]" type="text"  value="{{ old('penerangan.no_fax', @$penerangan->no_fax) }}">
                                @error('penerangan.no_fax')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Pengukuhan NPWPD</label>
                                <input class="date form-control @error('penerangan.pengukuhan_npwpd') is-invalid @enderror" name="penerangan[pengukuhan_npwpd]" type="text" value="{{ old('penerangan.pengukuhan_npwpd', @$penerangan->pengukuhan_npwpd) }}">
                                @error('penerangan.pengukuhan_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Perijinan</label>
                                <input class="form-control @error('penerangan.perijinan') is-invalid @enderror" name="penerangan[perijinan]" type="text"  value="{{ old('penerangan.perijinan', @$penerangan->perijinan) }}">
                                @error('penerangan.perijinan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Klasifikasi Penerangan <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('penerangan.klasifikasi_id') is-invalid @enderror" multiple="multiple" id="select-penerangan-klasifikasi" name="penerangan[klasifikasi_id]" required>
                                    @foreach($klasifikasis as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('penerangan.klasifikasi_id', @$penerangan->klasifikasi_id) ? 'selected' : null }}>{{ $row->penerangan_klasifikasi_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('penerangan.klasifikasi_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$penerangan->created_at ? date('m/d/Y @ h:i:s', strtotime($penerangan->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$penerangan->updated_at ? date('m/d/Y @ h:i:s', strtotime($penerangan->updated_at)) : null) }}" disabled>
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
