@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/leaflet/leaflet.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/Leaflet.markercluster-1.4.1/MarkerCluster.css" />
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/js/Leaflet.markercluster-1.4.1/MarkerCluster.Default.css" />
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
        #map {
            width: 100%;
            height: 500px;
        }
        .marker-card .face{
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 8px;
            word-break: break-all;
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

        .marker-sudah .marker-arrow {
            border-color: #5cb85c transparent transparent;
        }
        .marker-sudah .face.front {
            border: 2px solid #5cb85c;
            color: #5cb85c;
        }
        .marker-sudah .face.back {
            background: #5cb85c;
            border-color: #5cb85c;
        }

        .leaflet-listing-img-container:before {
            background: none;
        }
        .leaflet-listing-item-content h3 {
            color: #333;
        }
        .leaflet-listing-item-content span {
            color: rgba(0,0,0,0.7)
        }
        .leaflet-listing-img-container {
            height: auto;
        }
        .leaflet-listing-item-content {
            position: relative;
            bottom: auto;
            left: auto;
            padding: 0 24px;
            width: 100%;
            z-index: 50;
            box-sizing: border-box;
        }

        .map-loading {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 999;
            background: rgba(255, 255, 255, .8);
        }

        /*Select2*/
        .select2-container--open .select2-dropdown {
            z-index: 9999;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/leaflet/leaflet.js"></script>
    <script src="{{ asset('backend') }}/assets/js/Leaflet.markercluster-1.4.1/leaflet.markercluster-src.js"></script>
    <script src="{{ asset('backend') }}/assets/js/map.js"></script>
@endpush

@push('scripts')
    <script>
        var markerCluster;
        $(document).ready(function(){
            $('.select2-single').select2();

            $('#select-kecamatan').on('select2:select', function(){
                getAllMarkers();
            });

            $('#select-tahun').on('select2:select', function(){
                getAllMarkers();
            });

            $('.btnExport').on('click', function(e) {
                e.preventDefault();
            });

            $('#check-all').on('change', function(e) {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    $('.form-check-input:not(#check-all)').each(function(k, e) {
                        if (!$(e).is(':checked')) {
                            e.checked = true;
                        }
                    });

                    $('.marker-container').removeClass('d-none');
                }

                resetMap();
                initMarker();
            });

            $('.form-check-input:not(#check-all)').on('change', function(e) {
                var isChecked = $(this).is(':checked');

                if (!isChecked) {
                    $('#check-all')[0].checked = false;
                } else if (countChecked() === 0) {
                    $('#check-all')[0].checked = true;
                }

                resetMap();
                initMarker();
            });

            initMap('{{ asset('data/kecamatanV2.json') }}');

            getAllMarkers();
        });

        function initMarker() {
            markerCluster = L.markerClusterGroup();
            var iconCategory = {
                hotel: 'hotel',
                restoran_notcwp: 'coffee',
                restoran_cwp: 'coffee',
                kostan: 'home',
                rusun: 'building-o',
                hiburan: 'ticket',
                parkir: 'car',
            }

            $.each(markers, function(k, e) {
                if ($('#check-' + k).is(':checked')) {
                    $.each(e, function (k2, e2) {
                        let tableName = k.replace('_notcwp', '').replace('_cwp', '');
                        let statusTapping = '';
                        if (k.toLowerCase() == 'restoran_notcwp' || k.toLowerCase() == 'restoran_cwp') {
                            statusTapping = (e2.restoran_status_tapping_box == 1) ? 'sudah' : 'belum';
                        }
                        if (k.toLowerCase() == 'hotel') {
                            statusTapping = (e2.hotel_status_tapping_box == 1) ? 'sudah' : 'belum';
                        }
                        marker = new L.marker([e2[tableName + '_latitude'], e2[tableName + '_longitude']], {
                            icon: L.divIcon({
                                iconAnchor: [20, 51], // point of the icon which will correspond to marker's location
                                popupAnchor: [0, -51],
                                className: 'listeo-marker-icon',
                                html: '<div class="marker-container marker-' + statusTapping + '">' +
                                    '<div class="marker-card">' +
                                    '<div class="front face"><i class="fa fa-' + iconCategory[k.toLowerCase()] + '"></i></div>' +
                                    '<div class="back face"><i class="fa fa-' + iconCategory[k.toLowerCase()] + '"></i></div>' +
                                    '<div class="marker-arrow"></div>' +
                                    '</div>' +
                                    '</div>'
                            })
                        });

                        marker.bindPopup('Loading...', {
                            'maxWidth': '270',
                            'className': 'leaflet-infoBox'
                        }).openPopup();

                        marker.on('click', function (e3) {
                            var popup = e3.target.getPopup();
                            $.get('{{ url('api/rekapitulasi-map-detail') }}/' + k + '/' + e2.id + '?private-key=91dh379821gdgu3if298f493gf34onis8fe92ffoiu4f9s87dfo23ri3', function (data) {
                                popup.setContent(data);
                                popup.update();
                            });
                        });

                        markerCluster.addLayer(marker);
                    });
                }
            });

            map.addLayer(markerCluster);

            $('.map-loading').addClass('d-none');
        }

        function getAllMarkers() {
            $.ajax({
                url: '{{ url('api/rekapitulasi-map-all') }}',
                type: 'get',
                data: {
                    tahun: $('#select-tahun').val(),
                    kecamatan: $('#select-kecamatan').val(),
                },
                beforeSend: function() {
                    resetMap();
                },
                success: function(res) {
                    $('.map-loading').addClass('d-none');
                    if (res.success) {
                        markers = res.markers;

                        $('.form-check-input').change();
                    }
                },
                error: function(e) {
                    $('.map-loading').addClass('d-none');
                    initMarker();
                }
            });
        }

        function countChecked() {
            return $('.form-check-input:not(#check-all):not(:checked)').length;
        }

        function resetMap() {
            $('.map-loading').removeClass('d-none');
            $(".leaflet-marker-icon").remove();
            $(".leaflet-popup").remove();
            if(markerCluster){
                map.removeLayer(markerCluster);
            }
        }
    </script>
@endpush

@section('title', 'Rekapitulasi Dokumen Teknis Peta')

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Rekapitulasi Peta</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Rekapitulasi Peta</li>
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
                        <h5 class="mb-3">Rekapitulasi Peta</h5>
                        <span>Berikut ini adalah peta sebaran lokasi potensi pajak.</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter Tahun</label>
                                    <select class="select2-single" id="select-tahun">
                                        @for($i = 2018; $i <= date('Y'); $i++)
                                            <option value="{{ $i }}" {{ $i == date('Y') ? 'selected' : null }}>{{ $i }}</option>
                                        @endfor
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="col-form-label">Filter Kecamatan</label>
                                    <select class="select2-single" id="select-kecamatan">
                                        <option value="">SEMUA</option>
                                        @foreach($kecamatans as $row)
                                            <option value="{{ $row->kecamatan }}">{{ $row->kecamatan }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-end mb-4">
                            <div class="col-md-12">
                                <label class="col-form-label">Filter Kategori</label>
                                <div class="mb-0">
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-all" type="checkbox">
                                        <label class="form-check-label" for="check-all">Semua</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-hotel" type="checkbox" checked>
                                        <label class="form-check-label" for="check-hotel">Hotel</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-restoran_notcwp" type="checkbox">
                                        <label class="form-check-label" for="check-restoran_notcwp">Restoran</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-restoran_cwp" type="checkbox">
                                        <label class="form-check-label" for="check-restoran_cwp">Calon Wajib Pajak Restoran</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-kostan" type="checkbox">
                                        <label class="form-check-label" for="check-kostan">Kosan</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-rusun" type="checkbox">
                                        <label class="form-check-label" for="check-rusun">Rusun</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-hiburan" type="checkbox">
                                        <label class="form-check-label" for="check-hiburan">Hiburan</label>
                                    </div>
                                    <div class="form-check form-check-inline checkbox checkbox-primary">
                                        <input class="form-check-input" id="check-parkir" type="checkbox">
                                        <label class="form-check-label" for="check-parkir">Parkir</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div id="map" data-map-scroll="true">
                                <div class="map-loading">
                                    <span>
                                        <i class="fa fa-circle-o-notch fa-spin text-primary"></i> Loading...
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
