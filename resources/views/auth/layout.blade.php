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
    <title>Si Mpo Kesi | @yield('title', 'Login')</title>
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Rubik:400,400i,500,500i,700,700i&amp;display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/font-awesome.css">
    <!-- ico-font-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/vendors/icofont.css">
    <!-- Themify icon-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/vendors/themify.css">
    <!-- Flag icon-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/vendors/flag-icon.css">
    <!-- Feather icon-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/vendors/feather-icon.css">
    <!-- Plugins css start-->
    <!-- Plugins css Ends-->
    <!-- Bootstrap css-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/vendors/bootstrap.css">
    <!-- App css-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/style.css">
    <link id="color" rel="stylesheet" href="{{ asset('backend' )}}/assets/css/color-1.css" media="screen">
    <!-- Responsive css-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend' )}}/assets/css/responsive.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/css/custom.css">
    @stack('styles')
</head>
<body>
<!-- login page start-->
<div class="container-fluid p-0">
    @yield('content')

    <!-- latest jquery-->
    <script src="{{ asset('backend' )}}/assets/js/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap js-->
    <script src="{{ asset('backend' )}}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    <!-- feather icon js-->
    <script src="{{ asset('backend' )}}/assets/js/icons/feather-icon/feather.min.js"></script>
    <script src="{{ asset('backend' )}}/assets/js/icons/feather-icon/feather-icon.js"></script>
    <script src="{{ asset('backend' )}}/assets/js/sweet-alert/sweetalert.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/jquery-mask/jquery.mask.min.js"></script>
    <!-- scrollbar js-->
    <!-- Sidebar jquery-->
    <script src="{{ asset('backend' )}}/assets/js/config.js"></script>
    <!-- Plugins JS start-->
    <!-- Plugins JS Ends-->
    <!-- Theme js-->
    <script src="{{ asset('backend' )}}/assets/js/script.js"></script>
    <script src="{{ asset('backend' )}}/assets/js/custom.js"></script>
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

            $('form').on('submit', function(){
                const button = $(this).find('[type="submit"]');

                button.attr('disabled', 'disabled');
                button.html('<i class="fa fa-circle-o-notch fa-spin"></i>');
            });
        });
    </script>
</div>
</body>
</html>
