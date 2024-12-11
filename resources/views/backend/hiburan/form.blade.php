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
    <script src="{{ asset('backend') }}/assets/js/form_npwpd.js"></script>
@endpush

@push('scripts')
    <script>
        var map, polygon, marker;
        @if(!empty(@$$hiburan_kategories))
        	var hiburanKategori = JSON.parse('{!! $hiburan_kategories !!}');
        @else
        	var hiburanKategori = [];
        @endif
        		
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
            
            let hiburan_jenis=$('#select-hiburan-jenis');
            hiburan_jenis.on('change', function() {
             //   console.log('up');
                let th=$(this);
                let val=hiburan_jenis.val();
                
                if (val>0){
                    console.log('start',th.val()[0]);
                    th.attr('disabled','disabled');
                    let link = '/api/hiburan-select2-jenis';
                    let spin=$('.spinner-jenis');
                    spin.attr('style','');
                    $.ajax({
                        url: link,
                        type: 'POST',
                        headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                    	data: JSON.stringify({
                          //  _token: @json(csrf_token()),
                            'jenis_id' : val[0]
                        }),
                        contentType: "application/json; charset=utf-8",
                        traditional: true,
                        dataType: 'json',
                        success: function(res) {
                        	console.log(res);
                        	th.removeAttr('disabled');
                        	spin.attr('style','display:none');
                        	respJenisValue(res);
                        }
                    });
                    
                    
                }
                
                $('#select-hiburan-kategori').select2({
                    minimumInputLength:0,
                    placeholder:'Select Kategori',
                    ajax:{
                        url:'/api/hiburan-select2-kategori/'+val,
                        dataType:'json',
                        processResults:data=>{
                           // console.log(data);
                            return {
                                results:data.map(res=>{
                                    return {text:res.hiburan_kategori_deskripsi,id:res.id}
                                })
                            }
                        }
                    }
              });
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
            
            mask_npwpd('hiburan',11);
            
            @if(empty(@$jenis_hiburan)&&old('hiburan.hiburan_jenis_id', @$hiburan->hiburan_jenis_id)>0)
            	hib_env=$('#select-hiburan-jenis');
            	hib_env.val({{old('hiburan.hiburan_jenis_id', @$hiburan->hiburan_jenis_id)}});
            	hib_env.trigger('change');
            	@if(empty(@$jenis_hiburan) &&old('hiburan.hiburan_kategori_id', @$hiburan->hiburan_kategori_id)>0)
                $.ajax({
                    url: '/api/hiburan-select2-kategori/{{old('hiburan.hiburan_jenis_id', @$hiburan->hiburan_jenis_id)}}',
                    type: 'POST',
                    headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                    data: JSON.stringify({
                        'cat_id' : {{old('hiburan.hiburan_kategori_id', @$hiburan->hiburan_kategori_id)}}
                    }),
                    contentType: "application/json; charset=utf-8",
                    traditional: true,
                    dataType: 'json',
                    success: function(res) {
                        control=$('#select-hiburan-kategori');
                        var initOption = new Option(res[0].hiburan_kategori_deskripsi, res[0].id, false, false);
                        control.append(initOption);
                        control.val(res[0].id).trigger('change');
                    	console.log('categori:',res);
                    }
                });
                @endif
            @endif
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
        
        function respJenisValue(data=undefined){
                let env=$(".var-input");
                console.log(env.html());
                if(data.length>0){
                   dt=data[0];
                   src=[{cl:'jumlah',label:dt.hiburan_jenis_jumlah_label,unit:dt.hiburan_jenis_jumlah_unit,name:'hiburan_jumlah',val:{{old('hiburan.hiburan_jumlah', @$hiburan->hiburan_jumlah)??0}} },
                   {cl:'kapasitas',label:dt.hiburan_jenis_kapasitas_label,unit:dt.hiburan_jenis_kapasitas_unit,name:'hiburan_kapasitas',val:{{old('hiburan.hiburan_kapasitas', @$hiburan->hiburan_kapasitas)??0}} },
                   {cl:'ruangan',label:dt.hiburan_jenis_htm_label,unit:dt.hiburan_jenis_htm_unit,name:'hiburan_tarif',val:{{old('hiburan.hiburan_tarif', @$hiburan->hiburan_tarif)??0}} },
                   {cl:'durasi',label:dt.hiburan_jenis_durasi_label,unit:dt.hiburan_jenis_durasi_unit,name:'hiburan_durasi',val:{{old('hiburan.hiburan_durasi', @$hiburan->hiburan_durasi)??0}} }];
                   for(i=0;i<src.length;i++){
                       console.log(src[i]);
                       edt=env.find('.'+src[i].cl);
                       edt.empty();
                       if(src[i].name.indexOf('kapasitas')>0&&$.trim(dt.hiburan_jenis_have_ruangan).length>0)continue;
                       if(src[i].name.indexOf('ruangan')>0&&($.trim(dt.hiburan_jenis_have_ruangan).length==0||$.trim(dt.hiburan_jenis_have_multiple_tarif).length>0))continue;
                       if($.trim(src[i].label).length > 0){
                           txt='	                       		            <label class="col-form-label">Jumlah '+src[i].label+'</label>'+
'                                               <div class="input-group">'+
'                                                   <span class="input-group-text">'+(src[i].name.indexOf('tarif')?'IDR':src[i].unit)+'</span>'+
'                                                   <input class="form-control" name="hiburan['+src[i].name+']" type="number" placeholder="Contoh: 222">'+
'                                                   '+(src[i].name.indexOf('tarif')?($.trim(src[i].unit).length>0?'<span class="input-group-text">'+src[i].unit+'</span>':''):'')+
'                                               </div>';
						   
                           if(env.find('.'+src[i].cl).length>0){
                               edt.append(txt);
                           }else{
                               txt='	                               			<div class="mb-3 '+src[i].cl+'">'+
'                               '+txt+
'											</div>';
                               env.append(txt);
                           }
                           @if(empty(@$jenis_hiburan) &&old('hiburan.hiburan_jenis_id', @$hiburan->hiburan_jenis_id)>0)
                            	env.find('input').val(src[i].val);
                           @endif
                       }
                   }
                   
                   console.log('htm:',env.html());
                }
                else{
                  env.empty();
                }
                console.log('pjg:',data.length);
                  
                let th=$('#search_jenis');
                th.removeAttr('disabled');
                $('.spinner-jenis').attr('style','display:none');
                th.focus();
                
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
        
        
       // console.log('{{empty(@old('hiburan.kategori', @$hiburan->kategori))?'kosong':'isi'}}');    
        @if(!empty(@old('hiburan.kategori', @$hiburan->kategori)))
            @if(is_array(@old('hiburan.kategori', @$hiburan->kategori)))
                initValues=@json(old('hiburan.kategori', @$hiburan->kategori));
                $('input[name="hiburan[kategori][]"]').each(function () {
                    console.log('kategori:',$(this).val(),initValues);
                	$(this).prop("checked", $.inArray($(this).val(), initValues) == -1 ? false : true );
                	$(this).trigger("change");
                });
            @endif
        @endif
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
                    @if(!empty(@$jenis_hiburan))
                        <input type="hidden" id="select-hiburan-jenis" name="hiburan[hiburan_jenis_id]" value="{{ @$jenis_hiburan->id }}">
                    @endif
                    
                    <div class="card">
                        <div class="card-header">
                            <h5>{{ $title }} {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>{{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</b>.</span>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="col-form-label">No. NPWPD</label>
                                <div class="input-group">
                                    <input style="max-width: 250px" class="form-control @error('hiburan.hiburan_npwpd') is-invalid @enderror" id="search_npwpd" name="hiburan[hiburan_npwpd]" type="text" placeholder="Contoh: 420938278129382" value="{{ str_replace('.','',old('hiburan.hiburan_npwpd', @$hiburan->hiburan_npwpd)) }}">
                                    <button class="btn spinner-npwpd" style="display:none" disabled>
                                        <span class="spinner-grow spinner-grow-sm"></span> Loading..
                                    </button>
                                </div>
                                @error('hiburan.hiburan_npwpd')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
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
                            <div class="mb-3">
                                <label class="col-form-label">Jenis Pemilik Usaha?</label>
                                
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_sudah" type="radio" name="hiburan[hiburan_jenis_usaha]" value="1" {{ @old('hiburan.hiburan_jenis_usaha', @$hiburan->hiburan_jenis_usaha) ? (@old('hiburan.hiburan_jenis_usaha', @$hiburan->hiburan_jenis_usaha) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="status_sudah">Badan Usaha</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="status_belum" type="radio" name="hiburan[hiburan_jenis_usaha]" value="0" {{ @old('hiburan.hiburan_jenis_usaha', @$hiburan->hiburan_jenis_usaha) == 0 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="status_belum">Pribadi</label>
                                    </div>
                                </div>
                                @error('hiburan.hiburan_jenis_usaha')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">No. NIB/NIK</label>
                                <input class="form-control @error('hiburan.hiburan_nib_nik') is-invalid @enderror"  id="search_nib_nik" name="hiburan[hiburan_nib_nik]" type="text" placeholder="" value="{{ old('hiburan.hiburan_nib_nik', @$hiburan->hiburan_nib_nik) }}">
                                @error('hiburan.hiburan_nib_nik')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row mb-3">
                                <div class="col col-auto">
                                    <div class="img-preview">
                                        @if(@$hiburan->id_foto)
                                            <img class="img-thumbnail" id="imagePreview" src="{{ strpos($hiburan->id_foto, 'http') !== false ? $hiburan->id_foto : asset('uploads/hiburan/'.$hiburan->id_foto) }}"
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
                                    <input type="file" accept="image/png,image/jpeg" id="inputFile" class="form-control input-file @error('hiburan.id_foto') is-invalid @enderror" name="hiburan[id_foto]">
                                    <div class="invalid-feedback d-block text-muted">Format file: .png / .jpg / .jpeg.</div>
                                    @error('hiburan.id_foto')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
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
                                <label class="col-form-label">No. Telepon</label>
                                <input class="form-control @error('hiburan.hiburan_telepon') is-invalid @enderror" name="hiburan[hiburan_telepon]" type="text" placeholder="Contoh: 0227209281" value="{{ old('hiburan.hiburan_telepon', @$hiburan->hiburan_telepon) }}">
                                @error('hiburan.hiburan_telepon')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @if(!empty(@$jenis_hiburan))
                            	@if($hiburan_kategories->count() > 0&&12!= @request()->hiburan_jenis_id)
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
                            @endif
                            @if(empty(@$jenis_hiburan))
                            <div class="mb-3">
                                <label class="col-form-label">Jenis hiburan <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('hiburan.hiburan_jenis_id') is-invalid @enderror" multiple="multiple" id="select-hiburan-jenis" name="hiburan[hiburan_jenis_id]" required>
                                    @foreach($hiburan_jenises as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('hiburan.hiburan_jenis_id', @$hiburan->hiburan_jenis_id) ? 'selected' : null }}>{{ $row->hiburan_jenis_deskripsi }}</option>
                                    @endforeach
                                </select>
                                <button class="btn spinner-jenis" style="display:none" disabled>
                                    <span class="spinner-grow spinner-grow-sm"></span> Loading..
                                </button>
                                @error('hiburan.hiburan_jenis_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kategori <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-create @error('hiburan.hiburan_kategori_id') is-invalid @enderror" multiple="multiple" id="select-hiburan-kategori" name="hiburan[hiburan_kategori_id]" required>
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
                            @if(12== @request()->hiburan_jenis_id)
                            <div class="mb-3">
                                <label class="col-form-label">Rata-rata Durasi Penggunaan Lapangan</label>
                                <div class="input-group @error('hiburan.pengunaan_avg') is-invalid @enderror">
                                	<input class="form-control @error('hiburan.pengunaan_avg') is-invalid @enderror" name="hiburan[pengunaan_avg]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.pengunaan_avg', @$hiburan->pengunaan_avg) }}">
                                </div>
                                @error('hiburan.pengunaan_avg')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @if($hiburan_kategories->count() > 0)
                             <div class="mb-3">
                                <label class="col-form-label">Kategori Lapangan<span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <div class="my-2 m-checkbox-inline custom-checkbox-ml">
                                    @foreach($hiburan_kategories as $i => $row)
                                        <div class="form-check form-check-inline checkbox checkbox-primary">
                                            <input class="form-check-input" id="ch_kategori{{$i}}" type="checkbox" name="hiburan[kategori][]" value={{ $row->id }}>
                                            <label class="form-check-label mb-0" for="ch_kategori{{$i}}">{{ $row->hiburan_kategori_deskripsi }}</label>
                                        </div>
                                    @endforeach
                                </div>
                                @error('hiburan.kategori')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endif
                            <div class="mb-3">
                                <label class="col-form-label">Tipe Harga Sewa Lapangan per Jam (HSL)?<span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single @error('hiburan.tipe_hsl') is-invalid @enderror" id="select-tipe-hasil" name="hiburan[tipe_hsl]" required>
                                    @foreach ( $tipe_hsl as $i => $txt )
                                        <option value="{{$i}}" {{ $i == old('hiburan.tipe_hsl', @$hiburan->tipe_hsl) ? 'selected' : null }}>{{ $txt }}</option>
                                    @endforeach
                                </select>
                                @error('hiburan.tipe_hsl')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @endif
                            <div class="mb-4">
                                <label class="col-form-label">Jam Operasional:</label>
                                <div class="input-group @error('hiburan.hiburan_jam_weekdays') is-invalid @enderror">
                                    <span class="input-group-text">Hari Kerja</span>
                                    <input class="form-control daterangepicker-time @error('hiburan.hiburan_jam_weekdays') is-invalid @enderror" name="hiburan[hiburan_jam_weekdays]" type="text" placeholder="Contoh: 10:00 - 17:00" value="{{ old('hiburan.hiburan_jam_weekdays', @$hiburan->hiburan_jam_weekdays) }}">
                                    @error('hiburan.hiburan_jam_weekdays')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="input-group @error('hiburan.hiburan_jam_weekends') is-invalid @enderror">
                                    <span class="input-group-text">Hari Libur</span>
                                    <input class="form-control daterangepicker-time @error('hiburan.hiburan_jam_weekends') is-invalid @enderror" name="hiburan[hiburan_jam_weekends]" type="text" placeholder="Contoh: 10:00 - 17:00" value="{{ old('hiburan.hiburan_jam_weekends', @$hiburan->hiburan_jam_weekends) }}">
                                    @error('hiburan.hiburan_jam_weekends')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
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
                            <h6 class="pb-3 mb-0">Informasi {{ @$jenis_hiburan->hiburan_jenis_deskripsi }}</h6>
                            <div class="var-input">
                            @if(!empty(@$jenis_hiburan))
                            {{-- Kalo punya jumlah sesuatu --}}
                            @if(@$jenis_hiburan->hiburan_jenis_jumlah_label)
                                <div class="mb-3 jumlah">
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
                            
                            @if(@$jenis_hiburan->hiburan_jenis_slug&&str_contains($jenis_hiburan->hiburan_jenis_slug,'bioskop'))
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="col-form-label">Studio 1 jumlah kursi</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah_kursi1') is-invalid @enderror">
                                        <span class="input-group-text">Kursi</span>
                                    	<input class="form-control @error('hiburan.hiburan_jumlah_kursi1') is-invalid @enderror" name="hiburan[hiburan_jumlah_kursi1]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_jumlah_kursi1', @$hiburan->hiburan_jumlah_kursi1) }}">
                                    </div>
                                    @error('hiburan.hiburan_jumlah_kursi1')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6">
                                    <label class="col-form-label">Studio 2 jumlah kursi</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah_kursi2') is-invalid @enderror">
                                        <span class="input-group-text">Kursi</span>
                                    	<input class="form-control @error('hiburan.hiburan_jumlah_kursi2') is-invalid @enderror" name="hiburan[hiburan_jumlah_kursi2]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_jumlah_kursi2', @$hiburan->hiburan_jumlah_kursi2) }}">
                                    </div>
                                    @error('hiburan.hiburan_jumlah_kursi2')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6">
                                    <label class="col-form-label">Studio 3 jumlah kursi</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah_kursi3') is-invalid @enderror">
                                        <span class="input-group-text">Kursi</span>
                                    	<input class="form-control @error('hiburan.hiburan_jumlah_kursi3') is-invalid @enderror" name="hiburan[hiburan_jumlah_kursi3]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_jumlah_kursi3', @$hiburan->hiburan_jumlah_kursi3) }}">
                                    </div>
                                    @error('hiburan.hiburan_jumlah_kursi3')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6">
                                    <label class="col-form-label">Studio 4 jumlah kursi</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah_kursi4') is-invalid @enderror">
                                        <span class="input-group-text">Kursi</span>
                                    	<input class="form-control @error('hiburan.hiburan_jumlah_kursi4') is-invalid @enderror" name="hiburan[hiburan_jumlah_kursi4]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_jumlah_kursi4', @$hiburan->hiburan_jumlah_kursi4) }}">
                                     </div>
                                     @error('hiburan.hiburan_jumlah_kursi4')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6">
                                    <label class="col-form-label">Dan Seterusnya</label>
                                    <div class="input-group @error('hiburan.hiburan_jumlah_kursi_lain') is-invalid @enderror">
                                        <span class="input-group-text">Kursi</span>
                                    	<input class="form-control @error('hiburan.hiburan_jumlah_kursi_lain') is-invalid @enderror" name="hiburan[hiburan_jumlah_kursi_lain]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_jumlah_kursi_lain', @$hiburan->hiburan_jumlah_kursi_lain) }}">
                                    </div>
                                    @error('hiburan.hiburan_jumlah_kursi_lain')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            @endif
                                
                            {{-- Kalo punya jumlah kapasitas & ga punya ruangan --}}
                            @if(@$jenis_hiburan->hiburan_jenis_kapasitas_label && !@$jenis_hiburan->hiburan_jenis_have_ruangan)
                                <div class="mb-3 kapasitas">
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
                                <div class="mb-3 ruangan">
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
                            
                            @if(@$jenis_hiburan->hiburan_jenis_slug&&str_contains($jenis_hiburan->hiburan_jenis_slug,'bioskop'))
                            <div class="mb-3">
                                <label class="col-form-label">Per Jenis Studio</label>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio1') is-invalid @enderror">
                                            <span class="input-group-text">Studio 1 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio1') is-invalid @enderror" name="hiburan[hiburan_tarif_studio1]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio1', @$hiburan->hiburan_tarif_studio1) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio1')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio2') is-invalid @enderror">
                                            <span class="input-group-text">Studio 2 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio2') is-invalid @enderror" name="hiburan[hiburan_tarif_studio2]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio2', @$hiburan->hiburan_tarif_studio2) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio2')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio3') is-invalid @enderror">
                                            <span class="input-group-text">Studio 3 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio3') is-invalid @enderror" name="hiburan[hiburan_tarif_studio3]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio3', @$hiburan->hiburan_tarif_studio3) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio3')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio4') is-invalid @enderror">
                                            <span class="input-group-text">Studio 4 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio4') is-invalid @enderror" name="hiburan[hiburan_tarif_studio4]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio4', @$hiburan->hiburan_tarif_studio4) }}">
                                         </div>
                                         @error('hiburan.hiburan_tarif_studio4')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Per Jenis Kursi</label>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio1') is-invalid @enderror">
                                            <span class="input-group-text">Kursi 1 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio1') is-invalid @enderror" name="hiburan[hiburan_tarif_studio1]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio1', @$hiburan->hiburan_tarif_studio1) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio1')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio2') is-invalid @enderror">
                                            <span class="input-group-text">Kursi 2 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio2') is-invalid @enderror" name="hiburan[hiburan_tarif_studio2]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio2', @$hiburan->hiburan_tarif_studio2) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio2')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio3') is-invalid @enderror">
                                            <span class="input-group-text">Kursi 3 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio3') is-invalid @enderror" name="hiburan[hiburan_tarif_studio3]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio3', @$hiburan->hiburan_tarif_studio3) }}">
                                        </div>
                                        @error('hiburan.hiburan_tarif_studio3')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group @error('hiburan.hiburan_tarif_studio4') is-invalid @enderror">
                                            <span class="input-group-text">Kursi 4 (IDR)</span>
                                        	<input class="form-control @error('hiburan.hiburan_tarif_studio4') is-invalid @enderror" name="hiburan[hiburan_tarif_studio4]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.hiburan_tarif_studio4', @$hiburan->hiburan_tarif_studio4) }}">
                                         </div>
                                         @error('hiburan.hiburan_tarif_studio4')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            @endif

							@if(@$jenis_hiburan->hiburan_jenis_slug&&str_contains($jenis_hiburan->hiburan_jenis_slug,'diskotik'))
                            <div class="mb-3">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="col-form-label">Harga Minuman Tertinggi</label>
                                        <div class="input-group @error('hiburan.harga_minuman_tertinggi') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control @error('hiburan.harga_minuman_tertinggi') is-invalid @enderror" name="hiburan[harga_minuman_tertinggi]" type="number" placeholder="Default: -" value="{{ old('hiburan.harga_minuman_tertinggi', (@$hiburan->harga_minuman_tertinggi ?? '-')) }}">
                                        </div>
                                        @error('hiburan.harga_minuman_tertinggi')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label class="col-form-label">Harga Minuman Terendah</label>
                                        <div class="input-group @error('hiburan.harga_minuman_terendah') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control @error('hiburan.harga_minuman_terendah') is-invalid @enderror" name="hiburan[harga_minuman_terendah]" type="number" placeholder="Default: -" value="{{ old('hiburan.harga_minuman_terendah', (@$hiburan->harga_minuman_terendah ?? '-')) }}">
                                        </div>
                                        @error('hiburan.harga_minuman_terendah')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <label class="col-form-label">Harga Makanan Tertinggi</label>
                                        <div class="input-group @error('hiburan.harga_makanan_tertinggi') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control @error('hiburan.harga_makanan_tertinggi') is-invalid @enderror" name="hiburan[harga_makanan_tertinggi]" type="number" placeholder="Default: -" value="{{ old('hiburan.harga_makanan_tertinggi', (@$hiburan->harga_makanan_tertinggi ?? '-')) }}">
                                        </div>
                                        @error('hiburan.harga_makanan_tertinggi')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label class="col-form-label">Harga Makanan Terendah</label>
                                        <div class="input-group @error('hiburan.harga_makanan_terendah') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control @error('hiburan.harga_makanan_terendah') is-invalid @enderror" name="hiburan[harga_makanan_terendah]" type="number" placeholder="Default: -}" value="{{ old('hiburan.harga_makanan_terendah', (@$hiburan->harga_makanan_terendah ?? '-')) }}">
                                        </div>
                                        @error('hiburan.harga_makanan_terendah')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-6">
                                        <label class="col-form-label">Harga Menu Favorit</label>
                                        <div class="input-group @error('hiburan.harga_menu_favorit') is-invalid @enderror">
                                            <span class="input-group-text">IDR</span>
                                            <input class="form-control @error('hiburan.harga_menu_favorit') is-invalid @enderror" name="hiburan[harga_menu_favorit]" type="number" placeholder="Default: -}" value="{{ old('hiburan.harga_menu_favorit', (@$hiburan->harga_menu_favorit ?? '-')) }}">
                                        </div>
                                        @error('hiburan.harga_menu_favorit')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            @endif
                            @if(@$jenis_hiburan->hiburan_jenis_slug&&(str_contains($jenis_hiburan->hiburan_jenis_slug,'diskotik')||str_contains($jenis_hiburan->hiburan_jenis_slug,'fitness')))
                            <div class="mb-3">
                                <label class="col-form-label">Harga Paket</label>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group @error('hiburan.harga_paket1') is-invalid @enderror">
                                            <span class="input-group-text">1 (IDR)</span>
                                        	<input class="form-control @error('hiburan.harga_paket1') is-invalid @enderror" name="hiburan[harga_paket1]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.harga_paket1', @$hiburan->harga_paket1) }}">
                                        </div>
                                        @error('hiburan.harga_paket1')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group @error('hiburan.harga_paket2') is-invalid @enderror">
                                            <span class="input-group-text">2 (IDR)</span>
                                        	<input class="form-control @error('hiburan.harga_paket2') is-invalid @enderror" name="hiburan[harga_paket2]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.harga_paket2', @$hiburan->harga_paket2) }}">
                                        </div>
                                        @error('hiburan.harga_paket2')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group @error('hiburan.harga_paket3') is-invalid @enderror">
                                            <span class="input-group-text">3 (IDR)</span>
                                        	<input class="form-control @error('hiburan.harga_paket3') is-invalid @enderror" name="hiburan[harga_paket3]" type="number" placeholder="Contoh: 50000" value="{{ old('hiburan.harga_paket3', @$hiburan->harga_paket3) }}">
                                        </div>
                                        @error('hiburan.harga_paket3')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            @endif
                            
                            {{-- Kalo jenis hiburan punya jumlah durasi --}}
                            @if(@$jenis_hiburan->hiburan_jenis_durasi_label)
                                <div class="mb-3 durasi">
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
                            
                            
                            @endif
                            </div>
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
