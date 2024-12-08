<!DOCTYPE html>
<html lang="en" style="--theme-deafult:#5cb85c; --theme-secondary:#000222;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SI Pengelolaan Arsip Digital - Dinas Tata Ruang Kota Bekasi">
    <meta name="keywords" content="dinas tata ruang kota bekasi, pengelolaan arsip digital">
    <meta name="author" content="Dinas Tata Ruang Kota Bekasi">
    <link rel="icon" href="{{ asset('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <link rel="shortcut icon" href="{{ asset('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <title>Si Mpo Kesi | @yield('title', 'Dashboard')</title>
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/bootstrap.css">
    <!-- App css-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/style.css">
    <link id="color" rel="stylesheet" href="{{ asset('backend') }}/assets/css/color-1.css" media="screen">
    <!-- Responsive css-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/responsive.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/css/custom.css">
    <style>
        .listeo-marker-icon .marker-arrow {
            border-color: #000222 transparent transparent;
        }
        .listeo-marker-icon .face.front {
            border: 2px solid #000222;
            color: #000222;
        }
        .listeo-marker-icon .face.back {
            background: #000222;
            border-color: #000222;
        }
    </style>
    </head>
<body>
<div class="loader-wrapper">
    <div class="page-wrapper compact-wrapper" id="pageWrapper">
    	<div class="page-body-wrapper">


    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/leaflet/leaflet.css">



    <style>
        hr {
            background: #bdbdbd;
        }
        .text-black-50 {
            color: rgba(0, 0, 0, 0.25) !important;
        }
        .img-preview {
            width: 100%;
        }
        .img-thumbnail {
            width: 100%;
            object-fit: cover;
        }
        .marker-belum .marker-arrow {
            border-color: #dc3545 transparent transparent;
        }
        .marker-belum .face.front {
            border: 2px solid #dc3545;
            color: #dc3545;
        }
        .marker-belum .face.back {
            background: #dc3545;
            border-color: #dc3545;
        }

        .marker-hiburan .marker-arrow {
            border-color: #3949ab transparent transparent;
        }
        .marker-hiburan .face.front {
            border: 2px solid #3949ab;
            color: #3949ab;
        }
        .marker-hiburan .face.back {
            background: #3949ab;
            border-color: #3949ab;
        }
    </style>
    
    <!-- latest jquery-->
    <script src="{{ asset('backend') }}/assets/js/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap js-->
    <script src="{{ asset('backend') }}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
    <script src="{{ asset('backend') }}/assets/js/map.js"></script>


    <script>
        $(document).ready(function(){

            initMap('{{ asset('data/kecamatanV2.json') }}');

            @if (@$hiburan->hiburan_latitude && @$hiburan->hiburan_longitude)
                marker = new L.marker([{!! $hiburan->hiburan_latitude !!}, {!! $hiburan->hiburan_longitude !!}], {
                    icon: L.divIcon({
                            iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                            popupAnchor: [0, -51],
                            className: 'listeo-marker-icon',
                            html: '<div class="marker-container marker-hiburan">' +
                                '<div class="marker-card">' +
                                '<div class="front face"><i class="fa fa-{{ $jenis_hiburan->hiburan_jenis_icon }}"></i></div>' +
                                '<div class="back face"><i class="fa fa-{{ $jenis_hiburan->hiburan_jenis_icon }}"></i></div>' +
                                '<div class="marker-arrow"></div>' +
                                '</div>' +
                                '</div>'
                        }
                    )
                });
                map.addLayer(marker);
            @endif

        })
    </script>

    
    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row">
            
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col{{empty(@$export_pdf)?'-md':''}}-7">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Peta Lokasi Hiburan</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        @if (@$hiburan->hiburan_latitude && @$hiburan->hiburan_longitude)
                                            <div class="map-container">
                                                <div id="map">
                                                </div>
                                            </div>
                                        @else
                                            <div class="alert alert-light dark" role="alert">
                                                <i data-feather="alert-circle"></i>
                                                <p>Peta lokasi belum dilengkapi.</p>
                                            </div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                            <div class="col{{empty(@$export_pdf)?'-md':''}}-5">
                                <div class="card">
                                    <div class="card-header px-4 py-3">
                                        <h5>Data Pemilik</h5>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
</div>
</div>

</body>
</html>
