@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/dropzone.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/date-picker.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/select2.css">
@endpush
@push('styles')
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/dropzone/dropzone.js"></script>
    <script src="{{ asset('backend') }}/assets/js/dropzone/dropzone-script.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.en.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datepicker/date-picker/datepicker.custom.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2.full.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/select2/select2-custom.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function () {
            $('.select2-single').select2({
                placeholder: function () {
                    return $(this).data('placeholder');
                }
            });
        });
    </script>
@endpush

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>{{ $title }} Pengguna</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}">Pengguna</a>
                        </li>
                        <li class="breadcrumb-item active">{{ $title }} Pengguna</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <form class="theme-form mega-form" action="{{ $title == 'Tambah' ? url('users') : url('users/'.request()->segment(2)) }}" method="post">
                    @csrf
                    @if ($title != 'Tambah')
                        @method('put')
                    @endif
                    <div class="card">
                        <div class="card-header">
                            <h5>{{ $title }} Pengguna</h5>
                            <span>Silahkan isi semua atribut yang dibutuhkan untuk mengelola pengguna.</span>
                        </div>
                        <div class="card-body">
                            <h6>Informasi Pribadi</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Nama</label>
                                <input class="form-control @error('name') is-invalid @enderror" type="text" name="name" placeholder="Contoh: John Doe" required value="{{ @old('name') ?? @$user->name }}">
                                @error('name')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Alamat Email</label>
                                <input class="form-control @error('email') is-invalid @enderror" type="text" name="email" placeholder="Contoh: john.doe@gmail.com" required value="{{ @old('email') ?? @$user->email }}">
                                @error('email')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Kecamatan <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                <select class="select2-single form-control @error('kecamatan_id') is-invalid @enderror" data-placeholder="Pilih Kecamatan" id="select-kecamatan" name="kecamatan_id">
                                    <option value=""></option>
                                    @foreach($kecamatans as $row)
                                        <option value="{{ $row->id }}" {{ $row->id == old('kecamatan_id', @$user->kecamatan_id) ? 'selected' : null }}>{{ $row->kecamatan }}</option>
                                    @endforeach
                                </select>
                                @error('kecamatan_id')
                                <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <hr class="mt-4 mb-4">
                            <h6 class="pb-3 mb-0">Informasi Akun</h6>
                            <div class="mb-3">
                                <label class="col-form-label">Pilih Role</label>
                                <select name="role_id" class="form-control @error('role_id') is-invalid @enderror js-example-basic-single w-100">
                                    @foreach($roles as $key => $row)
                                        <option value="{{ $row->id }}" {{ @old('role_id') == $row->id ? 'selected' : (@$user->role_id == $row->id ? 'selected' : ($key == 0 ? 'selected' : null)) }}>{{ $row->description }}</option>
                                    @endforeach
                                </select>
                                @error('role_id')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Username</label>
                                <input class="form-control @error('username') is-invalid @enderror" type="text" name="username" placeholder="Contoh: john.doe" required value="{{ @old('username') ?? @$user->username }}">
                                @error('username')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            @if($title != 'tambah')
                            <div class="alert alert-light dark alert-dismissible fade show" role="alert">
                                <i data-feather="help-circle"></i>
                                <p>Kosongkan password jika tidak ingin diubah.</p>
                            </div>
                            @endif
                            <div class="mb-3">
                                <label class="col-form-label">Password</label>
                                <input class="form-control @error('password') is-invalid @enderror" type="password" name="password" placeholder="Contoh: ********" {{ $title == 'Tambah' ? 'required' : null }}>
                                @error('password')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label">Konfirmasi Password</label>
                                <input class="form-control @error('password_confirmation') is-invalid @enderror" type="password" name="password_confirmation" placeholder="Contoh: ********" {{ $title == 'Tambah' ? 'required' : null }}>
                                @error('password_confirmation')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button class="btn btn-primary" type="submit">Simpan</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->
@endsection
