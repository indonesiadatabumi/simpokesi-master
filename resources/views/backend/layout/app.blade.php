<!DOCTYPE html>
<html lang="en" style="--theme-deafult:#5cb85c; --theme-secondary:#000222;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SI Pengelolaan Arsip Digital - Dinas Tata Ruang Kota Bekasi">
    <meta name="keywords" content="dinas tata ruang kota bekasi, pengelolaan arsip digital">
    <meta name="author" content="Dinas Tata Ruang Kota Bekasi">
    
    @if(config('app.env') === 'production')
        <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    @endif
    
    <link rel="icon" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <link rel="shortcut icon" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <title>Si Mpo Kesi | @yield('title', 'Dashboard')</title>
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Rubik:400,400i,500,500i,700,700i&amp;display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/font-awesome.css">
    <!-- ico-font-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/icofont.css">
    <!-- Themify icon-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/themify.css">
    <!-- Flag icon-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/flag-icon.css">
    <!-- Feather icon-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/feather-icon.css">
    @if(empty(@$export_pdf))
    <!-- Plugins css start-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/scrollbar.css">
    @endif
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendor.min.css">
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/google/app.min.css">
    @stack('css')
    <!-- Plugins css Ends-->
    <!-- Bootstrap css-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/vendors/bootstrap.css">
    <!-- App css-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/style.css">
    <link id="color" rel="stylesheet" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/color-1.css" media="screen">
    <!-- Responsive css-->
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/css/responsive.css">
    <link rel="stylesheet" type="text/css" href="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/css/custom.css">
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
    @stack('styles')
</head>
<body>
<div class="loader-wrapper">
    <div class="loader-index"><span></span></div>
    <svg>
        <defs></defs>
        <filter id="goo">
            <fegaussianblur in="SourceGraphic" stddeviation="11" result="blur"></fegaussianblur>
            <fecolormatrix in="blur" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo"> </fecolormatrix>
        </filter>
    </svg>
</div>
<!-- tap on top starts-->
<div class="tap-top"><i data-feather="chevrons-up"></i></div>
<!-- tap on tap ends-->
<!-- page-wrapper Start-->
<div class="page-wrapper compact-wrapper" id="pageWrapper">
    <!-- Page Header Start-->
    @if(empty(@$export_pdf))
    	@include('backend.layout.header')
    @endif
    <!-- Page Header Ends                              -->
    <!-- Page Body Start-->
    <div class="page-body-wrapper">
        <!-- Page Sidebar Start-->
        @if(empty(@$export_pdf))
    		@include('backend.layout.sidebar')
        @endif
        <!-- Page Sidebar Ends-->
	@if(empty(@$export_pdf))
        <div class="page-body">
            @yield('content')
			<form id="formDelete" method="post" class="d-none">
                @csrf
                @method('delete')
            </form>
        </div>
        @else
        	@yield('content')
        @endif
        <!-- footer start-->
        @if(empty(@$export_pdf))
        <footer class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12 footer-copyright text-center">
                        <p class="mb-0">Copyright {{ date('Y') }} &copy; Si Mpo Kesi Kota Bekasi</p>
                    </div>
                </div>
            </div>
        </footer>
        @endif
    </div>
</div>
<!-- latest jquery-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/jquery-3.5.1.min.js"></script>
<!-- Bootstrap js-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
<!-- feather icon js-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/icons/feather-icon/feather.min.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/icons/feather-icon/feather-icon.js"></script>
@if(empty(@$export_pdf))
<!-- scrollbar js-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/scrollbar/simplebar.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/scrollbar/custom.js"></script>
@endif
<!-- Sidebar jquery-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/config.js"></script>
<!-- Plugins JS start-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/sidebar-menu.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/sweet-alert/sweetalert.min.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/jquery-mask/jquery.mask.min.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/pdf-object/pdfobject.min.js"></script>
@stack('js')
<!-- Plugins JS Ends-->
<!-- Theme js-->
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/script.js"></script>
<script src="{{empty($export_pdf)?asset('backend'): public_path('backend') }}/assets/js/custom.js" defer></script>
<!-- login js-->
<!-- Plugin used-->
<script>
    $(document).ready(function(){
        @if(session('info'))
            swal("Berhasil!", "{{ session('info') }}", "success");
        @endif

        @if(session('error'))
            swal("Gagal!", "{{ session('error') }}", "error");
        @endif
    });
</script>

@stack('scripts')

</body>
</html>
