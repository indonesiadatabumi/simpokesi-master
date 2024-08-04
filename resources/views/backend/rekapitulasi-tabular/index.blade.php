@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush

@push('styles')
    <style>
        .btnExport svg {
            vertical-align: middle;
            height: 16px;
        }
        .btnExport {
            margin-right: 5px;
            vertical-align: -12px;
            float: right;
        }
    </style>
@endpush

@push('js')
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
        $(document).ready(function(){
            $('.select2-single').select2();

            $('#select-dokumen-teknis').on('select2:select', function(){
                var jenis = $(this).val();
                window.location.replace('{{ url('/rekapitulasi-tabular') }}/'+jenis);
            });
        })
    </script>
@endpush

@section('title', 'Rekapitulasi Dokumen Teknis Tabular')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Rekapitulasi Tabular</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Rekapitulasi Tabular</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row project-cards">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Rekapitulasi Tabular</h5>
                        <span>Berikut ini adalah rekapitulasi tabular potensi pajak & retribusi daerah.</span>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-end mb-4">
                            <div class="col-md-4">
                                <label class="col-form-label">Potensi Pajak & Retribusi Daerah</label>
                                <select class="select2-single" id="select-dokumen-teknis">
                                    @foreach($potensi_pajak as $key => $row)
                                        <option value="{{ $key }}" {{ $key === $jenis ? 'selected' : null }}>{{ $row[0] }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col col-auto ms-auto">
                                <a class="btn btn-success btnExport" target="_blank" href="{{ url('rekapitulasi-tabular/'.$jenis.'/export') }}">
                                    <i data-feather="download"></i> Export
                                </a>
                            </div>
                        </div>

                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Kecamatan</th>
                                @for($i = 2018; $i <= date('Y'); $i++)
                                <th class="text-center">{{ $i }}</th>
                                @endfor
                                <th class="text-center">Jumlah</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                                $rowCount = [];
                                $totalCount = 0;
                            ?>
                            @foreach($recapitulations as $kecamatan)
                                <?php $colCount = 0; ?>
                                <tr>
                                    <td>{{ $kecamatan['kecamatan'] }}</td>
                                    @for($i = 2018; $i <= date('Y'); $i++)
                                        <?php
                                            $rekapitulasiKey = array_search($i, array_column($kecamatan['rekapitulasi'], 'tahun'));
                                            $jumlah = (@$rekapitulasiKey || $rekapitulasiKey === 0) ? $kecamatan['rekapitulasi'][$rekapitulasiKey]->jumlah : 0;
                                            $rowCount[$i] = (@$rowCount[$i] ?? 0) + $jumlah;
                                            $colCount += $jumlah;
                                        ?>
                                        <td class="text-center">
                                            {{ generateRupiah(@$jumlah) }} 
                                            @if((@$rekapitulasiKey || $rekapitulasiKey === 0) && @$jumlah > 0)
                                            <br><small class="text-muted">[Wajib Pajak: {{ @$kecamatan['rekapitulasi'][$rekapitulasiKey]->jumlah_wp ?? 0 }}]</small>
                                            @endif
                                        </td>
                                    @endfor
                                    <?php
                                        $nullKey = array_search(null, array_column($kecamatan['rekapitulasi'], 'tahun'));
                                        $jumlah = (@$nullKey || $nullKey === 0) ? $kecamatan['rekapitulasi'][$nullKey]->jumlah_null : 0;
                                        $rowCount[0] = (@$rowCount[0] ?? 0) + $jumlah;
                                        $colCount += $jumlah;
                                    ?>

                                    <td class="text-center">
                                        {{ generateRupiah($colCount) }} 
                                        @if((@$nullKey || $nullKey === 0) && @$jumlah > 0)
                                        <br><small class="text-muted">[Wajib Pajak: {{ @$kecamatan['rekapitulasi'][$nullKey]->jumlah_wp ?? 0 }}]</small>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                            <tfoot>
                            <tr>
                                <th>Total</th>
                                @for($i = 2018; $i <= date('Y'); $i++)
                                    <th class="text-center">{{ generateRupiah($rowCount[$i]) }}</th>
                                    <?php $totalCount += $rowCount[$i]; ?>
                                @endfor
                                <th class="text-center">{{ generateRupiah($totalCount + $rowCount[0]) }}</th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
