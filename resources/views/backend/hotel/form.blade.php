@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/dropzone.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/date-picker.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/leaflet/leaflet.css">
    
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
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
    <script src="{{ asset('backend') }}/assets/js/form_npwpd.js"></script>
    
    <script src="{{ asset('backend') }}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/jszip.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.colVis.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/pdfmake.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/vfs_fonts.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.autoFill.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.select.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.html5.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.print.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.keyTable.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.colReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.fixedHeader.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.rowReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.scroller.min.js"></script>
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
            
            mask_npwpd('hotel',1);
/*
            let npwpd=$('#search_npwpd');

            npwpd.mask('P9.99.9999999.99.99',{placeholder: "P_.__._______.__.__"});
            
			npwpd.keyup(function() {
              //  console.log('up');
                let th=$(this);
                let no_npwpd=th.val();
                
                if (no_npwpd.length>=14){
                  //  console.log('start');
                    th.attr('disabled','disabled');
                    let link = `http://sipdah.bekasikota.go.id/api/simpokesi/data_wp`;
                    let spin=$('.spinner-npwpd');
                    spin.attr('style','');                    
        
                    $.ajax({
                        url: link,
                        type: 'POST',
                        data: JSON.stringify({
                            'npwpd' : no_npwpd
                        }),
                        contentType: "application/json; charset=utf-8",
                        traditional: true,
                        dataType: 'json',
                        success: function(res) {
        					if(res.statusError=='00'){
                            	respValue(res.data);
                            }else{
                                respValue();
                                if(res.statusError=='99'){
            						$('[name="hotel[status_aktif_id]"]').val('1').change();
            					}
            					
                                
                                respValue();
                                th.parent().append('<div class="invalid-feedback err_npwpd" style=display:block>'+res.statusMessage+'</div>');
                            }
                        }
                    });
                }else{$('err_npwpd').remove();}
            });
*/
            @if((empty(old('hotel.hotel_latitude', @$hotel->hotel_latitude)) && empty(old('hotel.hotel_longitude', @$hotel->hotel_longitude))))
            getLocation();
            @endif

            initMap('{{ asset('data/kecamatanV2.json') }}', $('[name="hotel[hotel_latitude]"]'), $('[name="hotel[hotel_longitude]"]'));

            $('.btnOpenMap').on('click', function(e) {
                e.preventDefault();
                setTimeout(function(){
                    map.invalidateSize();
                    map.fitBounds(polygon.getBounds());
                }, 500);
            });

            var newOption;

            @if(!empty(old('hotel.hotel_klasifikasi_id')) && !is_numeric(old('hotel.hotel_klasifikasi_id')))
                newOption = new Option("{{ old('hotel.hotel_klasifikasi_id') }}", "{{ old('hotel.hotel_klasifikasi_id') }}", true, true);
                $('#select-hotel-klasifikasi').append(newOption).trigger('change');
            @endif

            

            inputFile.onchange = evt => {
                const [file] = inputFile.files
                if (file) {
                    imagePreview.src = URL.createObjectURL(file)
                }
            }
        });
        /*
        function respValue(data=undefined){
            let val=['','','','','','','','',''];
            if (typeof(data) != "undefined"){
            	val=[data.wp_wr_nama_milik,data.wp_wr_nama,data.wp_wr_almt,data.wp_wr_camat,data.wp_wr_lurah,'','',data.wp_wr_telp,data.wp_wr_status_aktif];
			}
		//	console.log(data,val);
			let i=0;
            $('[name="hotel[hotel_pemilik]"]').val(val[i++]);
            $('[name="hotel[hotel_nama]"]').val(val[i++]);
            $('[name="hotel[hotel_alamat]"]').val(val[i++]);
            $('[name="hotel[hotel_kecamatan]"]').val(val[i++]).change();
            $('[name="hotel[hotel_kelurahan]"]').val(val[i++]).change();
            $('[name="hotel[hotel_rt]"]').val(val[i++]);
            $('[name="hotel[hotel_rw]"]').val(val[i++]);
            $('[name="hotel[hotel_telepon]"]').val(val[i++]);
            $('[name="hotel[status_aktif_id]"]').val(val[i++].includes('t')?'2':'1').change();
            let th=$('#search_npwpd');
            th.removeAttr('disabled');
            $('.spinner-npwpd').attr('style','display:none');
            th.focus();
            $('.err_npwpd').remove();
        }
		*/
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(setPosition);
            }
        }

        function setPosition(position) {
            $('[name="hotel[hotel_latitude]"]').val(position.coords.latitude);
            $('[name="hotel[hotel_longitude]"]').val(position.coords.longitude);
        }
        
        $('#ch_fasilitas7').on('change',function(){
           $('#fasilitas_lain').hide();
           if(this.checked){
             $('#fasilitas_lain').show();
           }
        });
        $('#ch_fasilitas_umum7').on('change',function(){
           $('#fasilitas_umum_lain').hide();
           if(this.checked){
             $('#fasilitas_umum_lain').show();
           }
        });
        @if(!empty(@old('hotel.fasilitas', @$hotel->fasilitas)))
            @if(is_array(@old('hotel.fasilitas', @$hotel->fasilitas)))
                initValues=@json(old('hotel.fasilitas', @$hotel->fasilitas));
                $('input[name="hotel[fasilitas][]"]').each(function () {
                	$(this).prop("checked", $.inArray($(this).val(), initValues) == -1 ? false : true );
                	$(this).trigger("change");
                });
            @endif
        @endif
        @if(!empty(@old('hotel.fasilitas_umum', @$hotel->fasilitas_umum)))
            @if(is_array(@old('hotel.fasilitas_umum', @$hotel->fasilitas_umum)))
                initValues=@json(old('hotel.fasilitas_umum', @$hotel->fasilitas_umum));
                $('input[name="hotel[fasilitas_umum][]"]').each(function () {
                	$(this).prop("checked", $.inArray($(this).val(), initValues) == -1 ? false : true );
                	$(this).trigger("change");
                });
            @endif
        @endif
    </script>
@endpush

@section('title', $title.' Hotel')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Hotel</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/hotel') }}">Potensi Pajak Hotel</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Hotel</li>
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
                            <h5>{{ $title }} Hotel</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Hotel</b>.</span>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="col-form-label">No. NPWPD</label>
                                <div class="input-group">
                                    <input style="max-width: 250px" class="form-control @error('hotel.hotel_npwpd') is-invalid @enderror" id="search_npwpd" name="hotel[hotel_npwpd]" type="text" placeholder="Contoh: 420938278129382" value="{{ str_replace('.','',old('hotel.hotel_npwpd', @$hotel->hotel_npwpd)) }}">
                                    <button class="btn spinner-npwpd" style="display:none" disabled>
                                        <span class="spinner-grow spinner-grow-sm"></span> Loading..
                                    </button>
                                </div>
                            </div>
                            
                            <h6>Informasi Pemilik</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama Pemilik <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('hotel.hotel_pemilik') is-invalid @enderror" name="hotel[hotel_pemilik]" type="text" placeholder="Contoh: John Doe" value="{{ old('hotel.hotel_pemilik', @$hotel->hotel_pemilik) }}" required>
                                @error('hotel.hotel_pemilik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Jenis Pemilik Usaha?</label>
                                
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_sudah" type="radio" name="hotel[hotel_jenis_usaha]" value="1" {{ @old('hotel.hotel_jenis_usaha', @$hotel->hotel_jenis_usaha) ? (@old('hotel.hotel_jenis_usaha', @$hotel->hotel_jenis_usaha) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="status_sudah">Badan Usaha</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_belum" type="radio" name="hotel[hotel_jenis_usaha]" value="0" {{ @old('hotel.hotel_jenis_usaha', @$hotel->hotel_jenis_usaha) == 0 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="status_belum">Pribadi</label>
                                    </div>
                                </div>
                                @error('hotel.hotel_jenis_usaha')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. NIB/NIK</label>
                                <input class="form-control @error('hotel.hotel_nib_nik') is-invalid @enderror"  id="search_nib_nik" name="hotel[hotel_nib_nik]" type="text" placeholder="" value="{{ old('hotel.hotel_nib_nik', @$hotel->hotel_nib_nik) }}">
                                @error('hotel.hotel_nib_nik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$hotel->id_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($hotel->id_foto, 'http') !== false ? $hotel->id_foto : asset('uploads/hotel/'.$hotel->id_foto) }}"
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
                                    <label class="col-form-label">{{ $title !== 'Tambah' ? 'Ubah ' : '' }}Foto NIB/NIK</label>
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('hotel.id_foto') is-invalid @enderror" name="hotel[id_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('hotel.id_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Hotel</h6>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$hotel->hotel_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($hotel->hotel_foto, 'http') !== false ? $hotel->hotel_foto : asset('uploads/hotel/'.$hotel->hotel_foto) }}"
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
                                    <label class="col-form-label">{{ $title !== 'Tambah' ? 'Ubah ' : '' }}Foto Hotel</label>
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('hotel.hotel_foto') is-invalid @enderror" name="hotel[hotel_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('hotel.hotel_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @can('admin')
                            <div class="mb-3">
                                <label class="col-form-label">Status Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('hotel.status_aktif_id') is-invalid @enderror" id="select-status-aktif" name="hotel[status_aktif_id]" required>
                                    @foreach($status_aktifs as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('hotel.status_aktif_id', @$hotel->status_aktif_id) ? 'selected' : null }}>{{ $row->status_aktif_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('hotel.status_aktif_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endcan
                            <div class="mb-3">
                                <label class="col-form-label">Nama Hotel <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <input class="form-control @error('hotel.hotel_nama') is-invalid @enderror" name="hotel[hotel_nama]" type="text" placeholder="Contoh: Hotel Mawar" value="{{ old('hotel.hotel_nama', @$hotel->hotel_nama) }}" required>
                                @error('hotel.hotel_nama')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <!-- 
                            <div class="mb-3">
                                <label class="col-form-label">Sudah Ada Tapping Box?</label>
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_sudah" type="radio" name="hotel[hotel_status_tapping_box]" value="1" {{ @old('hotel.hotel_status_tapping_box', @$hotel->hotel_status_tapping_box) ? (@old('hotel.hotel_status_tapping_box', @$hotel->hotel_status_tapping_box) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="status_sudah">Sudah</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_belum" type="radio" name="hotel[hotel_status_tapping_box]" value="0" {{ @old('hotel.hotel_status_tapping_box', @$hotel->hotel_status_tapping_box) == 0 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="status_belum">Belum</label>
                                    </div>
                                </div>
                                @error('hotel.hotel_status_tapping_box')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                             -->
                            <div class="mb-3">
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('hotel.hotel_telepon') is-invalid @enderror" name="hotel[hotel_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('hotel.hotel_telepon', @$hotel->hotel_telepon) }}">
                                @error('hotel.hotel_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Klasifikasi Hotel <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('hotel.hotel_klasifikasi_id') is-invalid @enderror" multiple="multiple" id="select-hotel-klasifikasi" name="hotel[hotel_klasifikasi_id]" required>
                                    @foreach($klasifikasis as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('hotel.hotel_klasifikasi_id', @$hotel->hotel_klasifikasi_id) ? 'selected' : null }}>{{ $row->hotel_klasifikasi_deskripsi }}</option>
                                    @endforeach
                                </select>
                                @error('hotel.hotel_klasifikasi_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Hotel <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <textarea class="form-control @error('hotel.hotel_alamat') is-invalid @enderror" name="hotel[hotel_alamat]"
                                          placeholder="Contoh: Jl. Gempora I RT.002/004"
                                          cols="3" required>{{ old('hotel.hotel_alamat', @$hotel->hotel_alamat) }}</textarea>
                                @error('hotel.hotel_alamat')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kelurahan / Desa <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('hotel.hotel_kelurahan') is-invalid @enderror" data-placeholder="Pilih Kelurahan / Desa" id="select-hotel-kelurahan" name="hotel[hotel_kelurahan]" required>
                                    <option value=""></option>
                                    @foreach($kecamatans as $kecamatan)
                                        <optgroup label="{{ $kecamatan->kecamatan }}">
                                            @foreach($kecamatan->kelurahan as $row)
                                                <option value="{{ $row->kelurahan }}" {{ $row->kelurahan == old('hotel.hotel_kelurahan', @$hotel->hotel_kelurahan) ? 'selected' : null }}>{{ $row->kelurahan }}</option>
                                            @endforeach
                                        </optgroup>
                                    @endforeach
                                </select>
                                @error('hotel.hotel_kelurahan')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RW</label>
                                <input class="form-control @error('hotel.hotel_rw') is-invalid @enderror" name="hotel[hotel_rw]" type="text" placeholder="Contoh: 001" value="{{ old('hotel.hotel_rw', @$hotel->hotel_rw) }}">
                                @error('hotel.hotel_rw')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">RT</label>
                                <input class="form-control @error('hotel.hotel_rt') is-invalid @enderror" name="hotel[hotel_rt]" type="text" placeholder="Contoh: 001" value="{{ old('hotel.hotel_rt', @$hotel->hotel_rt) }}">
                                @error('hotel.hotel_rt')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Latitude</label>
                                        <input class="form-control @error('hotel.hotel_latitude') is-invalid @enderror" name="hotel[hotel_latitude]" type="text" placeholder="Contoh: -6.9770117" value="{{ old('hotel.hotel_latitude', @$hotel->hotel_latitude) }}">
                                        @error('hotel.hotel_latitude')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <label class="col-form-label">Longitude</label>
                                        <input class="form-control @error('hotel.hotel_longitude') is-invalid @enderror" name="hotel[hotel_longitude]" type="text" placeholder="Contoh: 107.6807272" value="{{ old('hotel.hotel_longitude', @$hotel->hotel_longitude) }}">
                                        @error('hotel.hotel_longitude')
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
                                <div class="input-group @error('hotel.hotel_jumlah_pegawai') is-invalid @enderror">
                                    <span class="input-group-text">Orang</span>
                                    <input class="form-control @error('hotel.hotel_jumlah_pegawai') is-invalid @enderror" name="hotel[hotel_jumlah_pegawai]" type="number" placeholder="Contoh: 222" value="{{ old('hotel.hotel_jumlah_pegawai', @$hotel->hotel_jumlah_pegawai) }}">
                                </div>
                                @error('hotel.hotel_jumlah_pegawai')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            
                            <div class="mb-3">
                                <label class="col-form-label">Fasilitas Hotel?</label>
                                <div class="my-2 m-checkbox-inline custom-checkbox-ml">
                                    
                                    @foreach ( $fasilitas as $i => $txt )
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="ch_fasilitas{{$i}}" type="checkbox" name="hotel[fasilitas][]" value={{$i}}>
                                        <label class="form-check-label mb-0" for="ch_fasilitas{{$i}}">{{$txt}}</label>
                                    </div>
                                    @endforeach
                                </div>
                            </div>
                            <div class="mb-4" id="fasilitas_lain" style="display:none">
                                <label class="col-form-label">Fasilitas lainnya</label>
                                <div class="input-group @error('hotel.fasilitas_lain') is-invalid @enderror">
                                    <input class="form-control @error('hotel.fasilitas_lain') is-invalid @enderror" name="hotel[fasilitas_lain]" type="text" placeholder="Default: -" value="{{ old('hotel.fasilitas_lain', (@$hotel->fasilitas_lain ?? '-')) }}">
                                </div>
                                @error('hotel.fasilitas_lain')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Fasilitas Terbuka untuk Umum?</label>
                                <div class="my-2 m-checkbox-inline custom-checkbox-ml">
                                    
                                    @foreach ( $fasilitas as $i => $txt )
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="ch_fasilitas_umum{{$i}}" type="checkbox" name="hotel[fasilitas_umum][]" value={{$i}}>
                                        <label class="form-check-label mb-0" for="ch_fasilitas_umum{{$i}}">{{$txt}}</label>
                                    </div>
                                    @endforeach
                                </div>
                            </div>
                            <div class="mb-4" id="fasilitas_umum_lain" style="display:none">
                                <label class="col-form-label">Fasilitas Terbuka untuk Umum lainnya</label>
                                <div class="input-group @error('hotel.fasilitas_umum_lain') is-invalid @enderror">
                                    <input class="form-control @error('hotel.fasilitas_umum_lain') is-invalid @enderror" name="hotel[fasilitas_umum_lain]" type="text" placeholder="Default: -" value="{{ old('hotel.fasilitas_umum_lain', (@$hotel->fasilitas_umum_lain ?? '-')) }}">
                                </div>
                                @error('hotel.fasilitas_umum_lain')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-4">
                                <label class="col-form-label">Persentase Pajak</label>
                                <div class="input-group @error('hotel.hotel_persentase_pajak') is-invalid @enderror">
                                    <span class="input-group-text">%</span>
                                    <input class="form-control @error('hotel.hotel_persentase_pajak') is-invalid @enderror" name="hotel[hotel_persentase_pajak]" type="number" placeholder="Default: {{ @$currentPersentasePajak }}" value="{{ old('hotel.hotel_persentase_pajak', (@$hotel->hotel_persentase_pajak ?? @$currentPersentasePajak)) }}">
                                </div>
                                @error('hotel.hotel_persentase_pajak')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @if($title !== 'Tambah')
                                <hr class="mt-4 mb-4">
                                <h6 class="pb-3 mb-0">Informasi Tanggal Modifikasi</h6>
                                <div class="mb-3">
                                    <label class="col-form-label">Tanggal Dibuat</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$hotel->created_at ? date('m/d/Y @ h:i:s', strtotime($hotel->created_at)) : null) }}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label">Terakhir Dimodifikasi</label>
                                    <input class="form-control" type="text"
                                           value="{{ (@$hotel->updated_at ? date('m/d/Y @ h:i:s', strtotime($hotel->updated_at)) : null) }}" disabled>
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
