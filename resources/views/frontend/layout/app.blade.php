
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="SI Pengelolaan Arsip Digital - Dinas Tata Ruang Kota Bekasi">
    <meta name="keywords" content="dinas tata ruang kota bekasi, pengelolaan arsip digital">
    <meta name="author" content="Dinas Tata Ruang Kota Bekasi">
    
    @if(config('app.env') === 'production')
        <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    @endif
    
    <link rel="icon" href="{{ asset('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <link rel="shortcut icon" href="{{ asset('backend') }}/assets/images/logo/logo-icon.png" type="image/x-icon">
    <title>Si Mpo Kesi | @yield('title', 'Landing')</title>
    <!-- css -->
    <link href="{{ asset('frontend' )}}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="{{ asset('frontend' )}}/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <!-- magnific pop-up -->
    <link rel="stylesheet" type="text/css" href="{{ asset('frontend' )}}/css/magnific-popup.css" />
    <!-- magnific pop-up -->
    <link rel="stylesheet" type="text/css" href="{{ asset('frontend' )}}/css/ion.rangeSlider.min.css" />
    <!-- Pe-icon-7 icon -->
    <link rel="stylesheet" type="text/css" href="{{ asset('frontend' )}}/css/pe-icon-7-stroke.css" />
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/feather-icon.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/font-awesome.css">
    <!-- Swiper CSS -->
    <link rel="stylesheet" href="{{ asset('frontend' )}}/css/swiper.min.css" />
    @stack('css')
    <link href="{{ asset('frontend' )}}/css/style.css" rel="stylesheet" type="text/css" />
    <link href="{{ asset('frontend' )}}/css/custom.css" rel="stylesheet" type="text/css" />
    @stack('styles')
</head>

<body>
<!--Navbar Start-->
<nav class="navbar navbar-expand-lg fixed-top navbar-custom sticky">
    <div class="container">
        <!-- LOGO -->
        <a class="navbar-brand logo text-uppercase" href="{{ url('/') }}">
            <img src="{{ asset('backend' )}}/assets/images/logo/logo-simpokesi-new.jpeg" alt="" height="40" />
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <i class="mdi mdi-menu"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav ml-auto navbar-center" id="mySidenav">
                <li class="nav-item {{ request()->is('/') ? 'active' : null }}">
                    <a href="{{ url('/') }}" class="nav-link">Beranda</a>
                </li>
                <li class="nav-item {{ request()->is('monitoring-peta*') ? 'active' : null }}">
                    <a href="{{ url('monitoring-peta') }}" class="nav-link">Monitoring Peta</a>
                </li>
            </ul>
            <div class="navbar-button d-none d-lg-inline-block">
                @auth
                    <a href="{{ url('dashboard') }}" class="btn btn-sm btn-primary btn-round">Ke Dashboard</a>
                @endauth
                @guest
                    <a href="{{ url('login') }}" class="btn btn-sm btn-primary btn-round">Login</a>
                @endguest
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

@yield('content')

<!-- START CONTACT -->
<section class="section bg-light" id="contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="text-center">
                    <p class="title-sub-heading text-primary f-18">Kontak Kami</p>
                    <h2 class="title-heading">Butuh informasi lebih lengkap?</h2>
                    <p class="title-desc text-muted mt-2">Silahkan hubungi kami atau datang ke kantor kami sesuai dengan informasi yang tertera dibawah.</p>
                </div>
            </div>
        </div>

        <div class="row mt-5 pt-5">
            <div class="col-lg-6">
                <div class="mt-4">
                    <img src="{{ asset('frontend' )}}/images/img-1.png" class="img-fluid" alt="" />
                </div>
            </div>

            <div class="col-lg-6">
                <div class="row mt-2">
                    <div class="col-lg-12">
                        <h5 class="f-18">Alamat Kantor</h5>
                        <p class="mb-2 mt-3 text-muted"><i class="mdi mdi-map-marker mr-2 text-primary"></i>Jl. Ir. H. Juanda No. 100 Bekasi</p>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-lg-12">
                        <h5 class="f-18">Alamat Email</h5>
                        <p class="mb-2 mt-3 text-muted"><i class="mdi mdi-email mr-2 text-primary"></i>p2dbapendabekasikota@gmail.com</p>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-lg-12">
                        <h5 class="f-18">Whatsapp</h5>
                        <p class="mb-2 mt-3 text-muted"><i class="mdi mdi-whatsapp mr-2 text-primary"></i>+6281316997502</p>
                    </div>
                </div>
            </div>
        </div>

        <hr class="my-5" />

        <div class="row">
            <div class="col-12">
                <div class="text-center">
                    <p class="text-muted mb-0">{{ date('Y') }} &copy; Si Mpo Kesi Kota Bekasi</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- END FOOTER -->

<!-- javascript -->
<script src="{{ asset('backend' )}}/assets/js/jquery-3.5.1.min.js"></script>
<script src="{{ asset('frontend' )}}/js/bootstrap.bundle.min.js"></script>
<script src="{{ asset('frontend' )}}/js/jquery.easing.min.js"></script>
<script src="{{ asset('frontend' )}}/js/scrollspy.min.js"></script>

<!-- Portfolio -->
<script src="{{ asset('frontend' )}}/js/ion.rangeSlider.min.js"></script>

<!-- Portfolio -->
<script src="{{ asset('frontend' )}}/js/jquery.magnific-popup.min.js"></script>
<script src="{{ asset('frontend' )}}/js/isotope.js"></script>

<script src="{{ asset('backend') }}/assets/js/icons/feather-icon/feather.min.js"></script>
<script src="{{ asset('backend') }}/assets/js/icons/feather-icon/feather-icon.js"></script>

<!-- Swiper JS -->
<script src="{{ asset('frontend' )}}/js/swiper.min.js"></script>

<!--flex slider plugin-->
<script src="{{ asset('frontend' )}}/js/jquery.flexslider-min.js"></script>

<!-- contact init -->
<script src="{{ asset('frontend' )}}/js/contact.init.js"></script>
@stack('js')

<!-- Main Js -->
<script src="{{ asset('frontend' )}}/js/app.js"></script>
@stack('scripts')
</body>
</html>
