@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush

@push('styles')
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
    <script src="https://cdn.jsdelivr.net/npm/jquery-number@2.1.6/jquery.number.min.js"></script> 

    <script type="text/javascript">
        
        var Localization = {
            date : function(date, format) {
                var timestamp = new Date(date);
                var d = ('00'+(timestamp.getDate()+1)).substr(-2);
                var m = ('00'+(timestamp.getMonth()+1)).substr(-2);
                var Y = timestamp.getFullYear();        
                if (!format) {
                    format = bahasa['date_format'];
                }
                format = format.replace('{d}', d);
                format = format.replace('{m}', m);
                format = format.replace('{Y}', Y);
                return format;
            },
            time : function(date, format) {
                var timestamp = new Date(date);        
                var H = ('00'+timestamp.getHours()).substr(-2);
                var i = ('00'+timestamp.getMinutes()).substr(-2);
                var s = ('00'+timestamp.getSeconds()).substr(-2);        
                if (!format) {
                    format = bahasa['time_format'];
                }    
                format = format.replace('{H}', H);
                format = format.replace('{i}', i);
                format = format.replace('{s}', s);
                return format;
            },
            datetime : function(date, format) {
                var timestamp = new Date(date); 
                var d = ('00'+timestamp.getDate()).substr(-2);        
                var m = ('00'+(timestamp.getMonth()+1)).substr(-2);
                var Y = timestamp.getFullYear();        
                var H = ('00'+timestamp.getHours()).substr(-2);
                var i = ('00'+timestamp.getMinutes()).substr(-2);
                var s = ('00'+timestamp.getSeconds()).substr(-2);        
                if (!format) {
                    format = bahasa['datetime_format'];
                }
                format = format.replace('{d}', d);
                format = format.replace('{m}', m);
                format = format.replace('{Y}', Y);
                format = format.replace('{H}', H);
                format = format.replace('{i}', i);
                format = format.replace('{s}', s);
                return format;
            },
            humanDate : function(date, format) {                
                var timestamp = new Date(date);
                var d = ('00'+timestamp.getDate()).substr(-2);
                var m = bahasa['month_'+('00'+(timestamp.getMonth()+1)).substr(-2)];
                var Y = timestamp.getFullYear();      
                var H = ('00'+timestamp.getHours()).substr(-2);
                var i = ('00'+timestamp.getMinutes()).substr(-2);
                var s = ('00'+timestamp.getSeconds()).substr(-2);        
                if (!format) {                        
                    format = bahasa['human_date_format'];                    
                }        
                format = format.replace('{H}', H);
                format = format.replace('{i}', i);
                format = format.replace('{s}', s);
                format = format.replace('{d}', d);        
                format = format.replace('{Y}', Y);
                format = format.replace('{m}', m);        
                return format;
            },
            humanDatetime : function(date) {        
                var timestamp = new Date(date);
                var d = ('00'+timestamp.getDate()).substr(-2);
                var m = bahasa['month_'+('00'+(timestamp.getMonth()+1)).substr(-2)];
                var Y = timestamp.getFullYear();      
                var H = ('00'+timestamp.getHours()).substr(-2);
                var i = ('00'+timestamp.getMinutes()).substr(-2);
                var s = ('00'+timestamp.getSeconds()).substr(-2);        
                format = bahasa['human_datetime_format'];        
                format = format.replace('{H}', H);
                format = format.replace('{i}', i);
                format = format.replace('{s}', s);
                format = format.replace('{d}', d);        
                format = format.replace('{Y}', Y);
                format = format.replace('{m}', m);
                return format;
            },
            number : function(data) {
                data = parseFloat(data);        
                data = $.number(data, 2, ',', '.');
                return data;
            },
            boolean : function(data, true_result, false_result) {
                if (data == 1 || data == 'true' || data == 't') {        
                    if (true_result) {
                        return true_result;
                    } else {
                        return '<i class="fa fa-check text-success"></i>';
                    }
                }

                if (data == 0 || data == 'false' || data == 'f') {
                    if (true_result) {
                        return true_result;
                    } else {
                        return '<i class="fa fa-times text-danger"></i>';
                    }
                }
            }
        }
        
        // bahasa['decimal_separator'] = ',';
        // bahasa['thousand_separator'] = '.';
        let lineChart;
        function foreacstClick() {
            $.ajax({
                url : "<?= url('realisasi-pendapatan-forecast') ?>",
                data: $("#frm-forecast").serialize(),
                success: function(e){
                    // console.log(e)
                    if(e.data){
                        var htmlData = "";
                        let i = 1;
                        $.each(e.data, function(index, row){
                            htmlData += "<tr><td>"+index+"</td><td>"+i+"</td><td class='text-end'>"+Localization.number(row)+"</td></tr>";
                            i++;
                        });
                        $("#rs-forecast").html(htmlData);

                        // Extract years (keys) and values from the response data
                        const years = Object.keys(e.data);
                        const values = Object.values(e.data);

                        if (lineChart) {
                            lineChart.destroy();
                        }

                        // Create the chart
                        const ctx = document.getElementById('lineChart').getContext('2d');
                        lineChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: years, // X-axis (years)
                                datasets: [{
                                    label: 'Forecast Data',
                                    data: values, // Y-axis (values)
                                    borderColor: 'rgba(75, 192, 192, 1)', // Line color
                                    backgroundColor: 'rgba(75, 192, 192, 0.2)', // Fill under the line
                                    borderWidth: 2,
                                    tension: 0.4 // Smooth curve
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        display: true,
                                        position: 'top'
                                    },
                                    tooltip: {
                                        enabled: true
                                    }
                                },
                                scales: {
                                    x: {
                                        title: {
                                            display: true,
                                            text: 'Year'
                                        }
                                    },
                                    y: {
                                        title: {
                                            display: true,
                                            text: 'Value'
                                        },
                                        ticks: {
                                            beginAtZero: true,
                                            callback: function (value) {
                                                // Format y-axis values
                                                return value.toLocaleString(); // Add commas
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    }
                },
            })
        }


    </script>
@endpush

@section('title', 'Proyeksi pajak daerah')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Proyeksi pajak daerah</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Proyeksi pajak daerah</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row project-cards">
            <div class="col-md-12 project-list">
                <div class="card">
                    <div class="row">
                        <form class="form-horizontal" action="{{ url('report-export/realisasi-pendapatan') }}" method="post" target="_blank">
                            @csrf
                            <div class="form-group row">
                                <label class="col-3">
                                    Periode [Start - End]
                                </label>
                                <div class="col-2">
                                    <input type="number" value="2020" name="startYear" required min="2020" class="form-control">
                                </div>
                                <div class="col-2">
                                    <input type="number" class="form-control" value="<?= date("Y")?>" name="endYear" required min="2020">
                                </div>
                                <div class="col-2">
                                    <button class="btn btn-primary" style="width: 100%;">Export</button>
                                </div>
                            </div>
                        </form>
                        <div class="col-auto ms-auto" style="display: none;">
                            <div class="form-group mb-0 me-0"></div>
                            <a target="_blank" class="btn btn-success" href="{{ url('/report-export/realisasi-pendapatan') }}">
                                 Export
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="row">
                        <form class="form-horizontal" method="post" id="frm-forecast">
                            @csrf
                            <div class="form-group row">
                                <label class="col-3">
                                    FORECAST [Start End]
                                </label>
                                <div class="col-2">
                                    Start
                                    <input type="number" value="2020" name="startYear" required min="2020" class="form-control">
                                </div>
                                <div class="col-2">
                                    End
                                    <input type="number" class="form-control" value="<?= date("Y") -1 ?>" name="endYear" required min="2020" max="<?= date("Y") ?>">
                                </div>
                                <div class="col-2">
                                    Jenis Pajak
                                    <select class="form-control" id="jenisPajak" name="jenisPajak">
                                        <?php 
                                            foreach (jenisPajak() as $row) {
                                                echo "<option value='".$row['id']."'>".$row['name']."</option>";
                                            }
                                        ?>
                                    </select>
                                </div>
                                <div class="col-2">
                                    &nbsp; <br>
                                    <button class="btn btn-primary" type="button" onclick="foreacstClick()" style="width: 100%;">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <table class="table table-bordered">
                                <tbody id="rs-forecast">
                                    
                                </tbody>
                            </table>
                        </div>
                        <div class="col-9">
                            <div style="width: 80%; margin: auto;">
                                <canvas id="lineChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->

@endsection