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

@section('title', 'Download Formulir Pendataaan')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Download Formulir Pendataaan</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Download Formulir Pendataaan</li>
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
                        <div class="col-12">
                        	<table class="table table-bordered table-sm">
						        <thead>
						            <tr>
						                <th>File Name</th>
						                <th>Action</th>
						            </tr>
						        </thead>
						        <tbody>
						            @foreach ($fileNames as $fileName)
						                <tr>
						                    <td>{{ $fileName }}</td>
						                    <td>
						                        <a class="btn btn-info" href="{{ route('files.download', $fileName) }}" target="_blank"> Download</a>
						                    </td>
						                </tr>
						            @endforeach
						        </tbody>
						    </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->

@endsection