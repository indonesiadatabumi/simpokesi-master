@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/dropzone.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/date-picker.css">
    
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
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
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
@endpush


@push('scripts')
    <script>
        var data=[];
        
        @if(!empty(old('jenis_kamar')))
            @foreach(old('jenis_kamar') as $k => $jenis_kamar)
                data.push({
              	    id:{{$k+1}},
                    musim:null,
                    category_hari:null,
                    hotel_jenis_kamar_deskripsi:'{{empty($jenis_kamar["hotel_jenis_kamar_deskripsi"])?0:$jenis_kamar["hotel_jenis_kamar_deskripsi"]}}',
                    hotel_jenis_kamar_tarif:{{empty($jenis_kamar["hotel_jenis_kamar_tarif"])?0:$jenis_kamar["hotel_jenis_kamar_tarif"]}},
                    hotel_jenis_kamar_jumlah:{{empty($jenis_kamar["hotel_jenis_kamar_jumlah"])?0:$jenis_kamar["hotel_jenis_kamar_jumlah"]}},
                    hotel_jenis_kamar_avg_penuh:{{empty($jenis_kamar["hotel_jenis_kamar_avg_penuh"])?0:$jenis_kamar["hotel_jenis_kamar_avg_penuh"]}},
                    hotel_jenis_kamar_avg_akhir_pekan:{{empty($jenis_kamar["hotel_jenis_kamar_avg_akhir_pekan"])?0:$jenis_kamar["hotel_jenis_kamar_avg_akhir_pekan"]}},
                    hotel_jenis_kamar_avg_normal:{{empty($jenis_kamar["hotel_jenis_kamar_avg_normal"])?0:$jenis_kamar["hotel_jenis_kamar_avg_normal"]}},
                    hotel_jenis_kamar_avg_sepi:{{empty($jenis_kamar["hotel_jenis_kamar_avg_sepi"])?0:$jenis_kamar["hotel_jenis_kamar_avg_sepi"]}},
                    hotel_jenis_kamar_potensi_pajak:null,
                    created_at:null,
                    action:''
                });
            @endforeach
        @endif
        
        var table;
        function showKamarForm(dt=undefined){
           typeof dt==='undefined'?$('input[name="jenis_kamar[id]"]').val(''):$('input[name="jenis_kamar[id]"]').val(dt.id);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_deskripsi]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_deskripsi]"]').val(dt.hotel_jenis_kamar_deskripsi);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_tarif]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_tarif]"]').val(dt.hotel_jenis_kamar_tarif);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_jumlah]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_jumlah]"]').val(dt.hotel_jenis_kamar_jumlah);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_avg_penuh]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_avg_penuh]"]').val(dt.hotel_jenis_kamar_avg_penuh);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_avg_akhir_pekan]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_avg_akhir_pekan]"]').val(dt.hotel_jenis_kamar_avg_akhir_pekan);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_avg_normal]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_avg_normal]"]').val(dt.hotel_jenis_kamar_avg_normal);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_avg_sepi]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_avg_sepi]"]').val(dt.hotel_jenis_kamar_avg_sepi);
           typeof dt==='undefined'?$('input[name="jenis_kamar[hotel_jenis_kamar_potensi_pajak]"]').val(''):$('input[name="jenis_kamar[hotel_jenis_kamar_potensi_pajak]"]').val(dt.hotel_jenis_kamar_potensi_pajak);
           typeof dt==='undefined'?$(".judulFormKamar").html('Tambah Kamar Hotel'):$(".judulFormKamar").html('Edit Kamar Hotel');
           $("#kamarModal").modal("show"); 
        }
        
        function runScript(){
           setTimeout(function(){
                    $('.btnEdit').on('click', function(e) {
                        e.preventDefault();
                        id=$(this).data('id');
                        idx=data.findIndex(x => x.id ===id);
                        showKamarForm(data[idx]);
                    });
                    $(".btnDelete").on('click', function(e) {
                        e.preventDefault();
                        id=$(this).data('id');
                        data=data.filter(function(el) { return el.id !== id});
                        table.clear().rows.add( data ).draw();
                        runScript();
                    });
                }, 1000);
        }
        
        
        $("#form").submit(function(){
            dt=[];
            data.filter(function(obj){
                ret=Object.keys(obj).filter((k) => k.includes('deskripsi')||k.includes('pajak')||k.includes('tarif')||k.includes('jumlah')||k.includes('avg')).reduce((cur, key) => { return Object.assign(cur, { [key]: obj[key] })}, {});
                dt.push(ret);
                return ret;
            });
            $(".data_kamar").val(JSON.stringify(dt));
        });
        
        $(document).ready(function(){
            
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
            
            $('.btnFormModal').on('click', function(e) {
                e.preventDefault();
                showKamarForm(undefined);
            });
            
            $('.btnSimpanKamar').on('click', function(e) {
                e.preventDefault();
                id=$('input[name="jenis_kamar[id]"]').val()==''?(data.length==0?1:data[data.length-1].id+1):$('input[name="jenis_kamar[id]"]').val();
                dt={
                	id:parseInt(id),
                    musim:null,
                    category_hari:null,
                    hotel_jenis_kamar_deskripsi:$('input[name="jenis_kamar[hotel_jenis_kamar_deskripsi]"]').val(),
                    hotel_jenis_kamar_tarif:$('input[name="jenis_kamar[hotel_jenis_kamar_tarif]"]').val(),
                    hotel_jenis_kamar_jumlah:$('input[name="jenis_kamar[hotel_jenis_kamar_jumlah]"]').val(),
                    hotel_jenis_kamar_avg_penuh:$('input[name="jenis_kamar[hotel_jenis_kamar_avg_penuh]"]').val(),
                    hotel_jenis_kamar_avg_akhir_pekan:$('input[name="jenis_kamar[hotel_jenis_kamar_avg_akhir_pekan]"]').val(),
                    hotel_jenis_kamar_avg_normal:$('input[name="jenis_kamar[hotel_jenis_kamar_avg_normal]"]').val(),
                    hotel_jenis_kamar_avg_sepi:$('input[name="jenis_kamar[hotel_jenis_kamar_avg_sepi]"]').val(),
                    hotel_jenis_kamar_potensi_pajak:null,
                    created_at:null,
                    action:''
                };
                
                if($('input[name="jenis_kamar[id]"]').val()==''){
                	data.push(dt);
                }else{
                    idx = data.findIndex(x => x.id ===parseInt(id));
                    data[idx]=dt;
                }    
                //console.log(data);
                $("#kamarModal").modal("hide");
                table.clear().rows.add( data ).draw();
                runScript();
            });
            
            table = $('.table-kamar').DataTable({
               // responsive: true,
                language: {
                    search: "",
                    processing:  '<div class="loading-container">\n' +
                        '<div class="spinner-border text-success" role="status">\n' +
                        '<span class="sr-only">Loading...</span>\n' +
                        '</div></div>'
                },
                data:data,
                drawCallback: function() {
                    $('[data-toggle="popover"]').popover();
                    $('[data-toggle="tooltip"]').tooltip();
                    feather.replace();
                    if (data.length == 0) {
                        $(".btnSimpanHunian").attr("disabled", true);
                    } else {
                        $(":submit").removeAttr("disabled");
                    }
                },
                columnDefs: [
                    {
                        // The `data` parameter refers to the data for the cell (defined by the
                        // `data` option, which defaults to the column being worked with, in
                        // this case `data: 0`.
                        render: (data, type, row) => parseInt(data)==1?'peak':'normal',
                        targets: 2
                    },
                    {
                        // The `data` parameter refers to the data for the cell (defined by the
                        // `data` option, which defaults to the column being worked with, in
                        // this case `data: 0`.
                        render: (data, type, row) => parseInt(data)==1?'week day':'week end',
                        targets: 3
                    },
                    {
                        // The `data` parameter refers to the data for the cell (defined by the
                        // `data` option, which defaults to the column being worked with, in
                        // this case `data: 0`.
                        render: function (data, type, row) {
                            return '<a href="#" data-id='+row.id+' class="btn btn-sm btn-light btnEdit" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah"><i data-feather="edit-3" class="text-warning"></i></a>'+
                        	'<a href="#" data-id='+row.id+' class="btn btn-sm btn-light btnDelete" data-toggle="tooltip" title="" role="button" data-bs-original-title="Hapus"><i data-feather="trash-2" class="text-danger"></i></a>';
                        },
                        targets: 12
                    },
                    { visible: false, targets: [0,1,2,3,11] }
                ],
                columns: [
                    { data: 'id', name: 'id', orderable: false, searchable: false},
                    { data: 'created_at', name: 'created_at'},
                    { data: 'musim', name: 'musim'},
                    { data: 'category_hari', name: 'category_hari'},
                    { data: 'hotel_jenis_kamar_deskripsi', name: 'hotel_jenis_kamar_deskripsi'},
                    { data: 'hotel_jenis_kamar_tarif', name: 'hotel_jenis_kamar_tarif'},
                    { data: 'hotel_jenis_kamar_jumlah', name: 'hotel_jenis_kamar_jumlah'},
                    { data: 'hotel_jenis_kamar_avg_penuh', name: 'hotel_jenis_kamar_avg_penuh'},
                    { data: 'hotel_jenis_kamar_avg_akhir_pekan', name: 'hotel_jenis_kamar_avg_akhir_pekan'},
                    { data: 'hotel_jenis_kamar_avg_normal', name: 'hotel_jenis_kamar_avg_normal'},
                    { data: 'hotel_jenis_kamar_avg_sepi', name: 'hotel_jenis_kamar_avg_sepi'},
                    { data: 'hotel_jenis_kamar_potensi_pajak', name: 'hotel_jenis_kamar_potensi_pajak'},
                    { data: 'action', name: 'action', searchable: false, width: 160}
                ]
            });
            
            runScript();
            
        })
    </script>
@endpush

@section('title', $title.' Hotel')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Potensi Pajak Hunian Hotel</h3>
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
                            <a href="{{ url('/hotelkamar/'.$hotel_id) }}">Data Hunian</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Hunian Hotel</li>
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
                <form class="theme-form mega-form" id="form" method="post" enctype="multipart/form-data" action="{{ $url }}">
                    @csrf
                    @if($title !== 'Tambah')
                        @method('put')
                    @endif
                    <div class="card">
                        <div class="card-header">
                            <h5>{{ $title }} Hunian Hotel</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Hunian Hotel</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6 class="pb-3 mb-0">Informasi Situasi Kunjungan Tamu Dalam Setahun (FJH)</h6>
                            <input type="hidden" name="data" class="data_kamar">
                            <div class="mb-3">
                                <label class="col-form-label">Kategori Hari?</label>
                                
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="kat_hari_bu" type="radio" name="tingkat_hunian[category_hari]" value="1" {{ @old('tingkat_hunian.category_hari', @$tingkat_hunian->category_hari) ? (@old('tingkat_hunian.category_hari', @$tingkat_hunian->category_hari) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="kat_hari_bu">Week Day</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="kat_hari_normal" type="radio" name="tingkat_hunian[category_hari]" value="2" {{ @old('tingkat_hunian.category_hari', @$tingkat_hunian->category_hari) == 2 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="kat_hari_normal">Week End</label>
                                    </div>
                                </div>
                                @error('tingkat_hunian.category_hari')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Jenis Musim?</label>
                                
                                <div class="my-2 m-checkbox-inline custom-radio-ml">
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="kat_musim_peak" type="radio" name="tingkat_hunian[musim]" value="1" {{ @old('tingkat_hunian.musim', @$tingkat_hunian->musim) ? (@old('tingkat_hunian.musim', @$tingkat_hunian->musim) == 1 ? 'checked' : null) : 'checked' }}>
                                        <label class="form-check-label mb-0" for="kat_musim_peak">Peak Season</label>
                                    </div>
                                    <div class="form-check form-check-inline radio radio-primary">
                                        <input class="form-check-input" id="kat_musim_normal" type="radio" name="tingkat_hunian[musim]" value="2" {{ @old('tingkat_hunian.musim', @$tingkat_hunian->musim) == 2 ? 'checked' : null }}>
                                        <label class="form-check-label mb-0" for="kat_musim_normal">Normal</label>
                                    </div>
                                </div>
                                @error('tingkat_hunian.musim')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Penuh</label>
                                    <div class="input-group @error('tingkat_hunian.kunjungan_penuh') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_hunian.kunjungan_penuh') is-invalid @enderror" name="tingkat_hunian[kunjungan_penuh]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_hunian.kunjungan_penuh', @$tingkat_hunian->kunjungan_penuh) }}">
                                    </div>
                                    @error('tingkat_hunian.kunjungan_penuh')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Akhir Pekan</label>
                                    <div class="input-group @error('tingkat_hunian.kunjungan_akhir_pekan') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_hunian.kunjungan_akhir_pekan') is-invalid @enderror" name="tingkat_hunian[kunjungan_akhir_pekan]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_hunian.kunjungan_akhir_pekan', @$tingkat_hunian->kunjungan_akhir_pekan) }}">
                                    </div>
                                    @error('tingkat_hunian.kunjungan_akhir_pekan')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group @error('tingkat_hunian.kunjungan_normal') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_hunian.kunjungan_normal') is-invalid @enderror" name="tingkat_hunian[kunjungan_normal]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_hunian.kunjungan_normal', @$tingkat_hunian->kunjungan_normal) }}">
                                    </div>
                                    @error('tingkat_hunian.kunjungan_normal')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('tingkat_hunian.kunjungan_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Hari</span>
                                        <input class="form-control inputFJH @error('tingkat_hunian.kunjungan_sepi') is-invalid @enderror" name="tingkat_hunian[kunjungan_sepi]" type="number" min="0" placeholder="Contoh: 50" value="{{ old('tingkat_hunian.kunjungan_sepi', @$tingkat_hunian->kunjungan_sepi) }}">
                                    </div>
                                    @error('tingkat_hunian.kunjungan_sepi')
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
                                           value="{{ (@$tingkat_hunian->created_at ? date('m/d/Y @ h:i:s', strtotime($tingkat_hunian->created_at)) : null) }}" disabled>
                                </div>
                            @endif
                            <h6 class="pb-3 mb-0">Informasi Jenis Kamar</h6>
                            <div class="row">
                                @canany(['manage-hotel', 'admin'])
                            
                                <div class="col-auto ms-auto">
                                    <a class="btn btn-outline-info btn-sm mt-2 btnFormModal" href="#">
                                        <i data-feather="plus-square"></i> Tambah Kamar Hotel
                                    </a>
                                </div>
                                @endcanany
                            </div>
                            <div class="dt-ext table-responsive">
                                <table class="table-kamar">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Tanggal</th>
                                        <th>Musim</th>
                                        <th>Category</th>
                                        <th>Keterangan</th>
                                        <th>Tarif</th>
                                        <th>Jumlah</th>
                                        <th>Penuh</th>
                                        <th>Akhir Pekan</th>
                                        <th>Normal</th>
                                        <th>Sepi</th>
                                        <th>Potensi Pajak</th>
                                        <th>Opsi</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th></th>
                                        <th>Tanggal</th>
                                        <th>Musim</th>
                                        <th>Category</th>
                                        <th>Keterangan</th>
                                        <th>Tarif</th>
                                        <th>Jumlah</th>
                                        <th>Penuh</th>
                                        <th>Akhir Pekan</th>
                                        <th>Normal</th>
                                        <th>Sepi</th>
                                        <th>Potensi Pajak</th>
                                        <th>Opsi</th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="submit" class="btn btn-primary btnSimpanHunian">Simpan</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
    <div class="modal fade" id="kamarModal" tabindex="-1" role="dialog" aria-labelledby="kamarModal" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="judulFormKamar"></h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola data <b>Kamar Hotel</b>.</span>
                        </div>
                        <div class="card-body">
                            <h6 class="pb-3 mb-0">Informasi Jenis Kamar</h6>
                            <input type="hidden" name="jenis_kamar[id]" class="id-jenis_kamar" value="">
                            <div class="mb-3">
                                <label class="col-form-label">Deskripsi Jenis Kamar</label>
                                <input class="form-control" name="jenis_kamar[hotel_jenis_kamar_deskripsi]" type="text" placeholder="Contoh: Standar" value="">
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Tarif Resmi Hotel</label>
                                <div class="input-group">
                                    <span class="input-group-text">IDR</span>
                                    <input class="form-control hotel_jenis_kamar_tarif" name="jenis_kamar[hotel_jenis_kamar_tarif]" type="number" min="0" placeholder="Contoh: 500000" value="">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Jumlah Seluruh Kamar</label>
                                <div class="input-group">
                                    <span class="input-group-text">Kamar</span>
                                    <input class="form-control hotel_jenis_kamar_jumlah" name="jenis_kamar[hotel_jenis_kamar_jumlah]" type="number" min="0" placeholder="Contoh: 50" value="">
                                </div>
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Rata - rata Tingkat Hunian Hotel</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Penuh</label>
                                    <div class="input-group">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_penuh" name="jenis_kamar[hotel_jenis_kamar_avg_penuh]" type="number" min="0" placeholder="Contoh: 50" value="">
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Ramai Akhir Pekan</label>
                                    <div class="input-group">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_akhir_pekan" name="jenis_kamar[hotel_jenis_kamar_avg_akhir_pekan]" type="number" min="0" placeholder="Contoh: 50" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Normal</label>
                                    <div class="input-group">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_normal" name="jenis_kamar[hotel_jenis_kamar_avg_normal]" type="number" min="0" placeholder="Contoh: 50" value="">
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="col-form-label">Sepi</label>
                                    <div class="input-group @error('jenis_kamar.hotel_jenis_kamar_avg_sepi') is-invalid @enderror">
                                        <span class="input-group-text">Kamar</span>
                                        <input class="form-control hotel_jenis_kamar_avg_sepi" name="jenis_kamar[hotel_jenis_kamar_avg_sepi]" type="number" min="0" placeholder="Contoh: 50" value="">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="submit" class="btn btn-primary btnSimpanKamar">Simpan</button>
                        </div>
                     </div> 
            </div>
        </div>
    </div>
@endsection
