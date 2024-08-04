@extends('auth.layout')

@push('styles')
<style>
    .login-card .login-main .theme-form .link {
        position: relative;
        left: auto;
        top: auto;
        right: auto;
        text-align: right;
        display: block;
    }
    .img-fluid {
        width: 400px;
    }
</style>
@endpush

@section('content')
<div class="row m-0">
    <div class="col-12 p-0">
        <div class="login-card">
            <div>
                <div>
                    <a class="logo" href="{{ url('/') }}">
                        <img class="img-fluid for-light" src="{{ asset('backend' )}}/assets/images/logo/logo-simpokesi-new.jpeg" alt="looginpage">
                    </a>
                </div>
                <div class="login-main">
                    <form class="theme-form" action="{{ url('/login') }}" method="post">
                        @csrf
                        <h4>Masuk ke Dashboard</h4>
                        <p>Masukkan email dan password Anda untuk melakukan login.</p>
                        <div class="form-group">
                            <label class="col-form-label">Username / Email</label>
                            <input class="form-control" type="text" name="username" required placeholder="Contoh: admin@gmail.com" autofocus value="{{ @old('username') }}">
                        </div>
                        <div class="form-group mb-3">
                            <label class="col-form-label">Password</label>
                            <div class="form-input position-relative">
                                <input class="form-control input-password" type="password" name="password" required placeholder="*********">
                                <div class="show-hide">
                                    <span class="show"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-5">
{{--                            <div class="checkbox p-0">--}}
{{--                                <input id="checkbox1" type="checkbox">--}}
{{--                                <label class="text-muted" for="checkbox1">Ingat Password</label>--}}
{{--                            </div>--}}
                            <a class="link" href="{{ url('/password/reset') }}">Lupa Password?</a>
                        </div>
                        <div class="form-group mb-0">
                            <div class="text-end mt-3">
                                <button class="btn btn-primary btn-block w-100" type="submit">Masuk</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
