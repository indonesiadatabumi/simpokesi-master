<div class="sidebar-wrapper">
    <div>
        <div class="logo-wrapper">
            <a href="{{ url('/') }}">
                <img class="img-fluid for-light" src="{{ asset('backend') }}/assets/images/logo/logo-simpokesi-new.jpeg" alt="">
            </a>
            <div class="back-btn"><i class="fa fa-angle-left"></i></div>
            <div class="toggle-sidebar"><i class="status_toggle middle sidebar-toggle" data-feather="grid"> </i></div>
        </div>
        <div class="logo-icon-wrapper">
            <a href="{{ url('/') }}">
                <img class="img-fluid" src="{{ asset('backend') }}/assets/images/logo/logo-simpokesi-icon-new.png" alt="">
            </a>
        </div>
        <nav class="sidebar-main">
            <div class="left-arrow" id="left-arrow"><i data-feather="arrow-left"></i></div>
            <div id="sidebar-menu">
                <ul class="sidebar-links" id="simple-bar">
                    <li class="back-btn">
                        <a href="{{ url('/') }}"><img class="img-fluid" src="{{ asset('backend') }}/assets/images/logo/logo-simpokesi-icon-new.png" alt=""></a>
                        <div class="mobile-back text-end"><span>Back</span><i class="fa fa-angle-right ps-2" aria-hidden="true"></i></div>
                    </li>

                    <li class="sidebar-list mt-4">
                        <a class="sidebar-link sidebar-title link-nav {{ request()->is('dashboard') ? 'active' : null }}" href="{{ url('dashboard') }}">
                            <i data-feather="layout"></i> <span>Dashboard</span>
                        </a>
                    </li>

                    @can('admin')
                    <li class="sidebar-list">
                        <a class="sidebar-link sidebar-title link-nav" data-bs-toggle="modal" data-bs-target="#persentaseModal" href="javascript:void(0);">
                            <i data-feather="percent"></i> <span>Setting Persentase Pajak</span>
                        </a>
                    </li>
                    @endcan

                    @canany(['surveyor', 'pimpinan', 'admin'])
                        <li class="sidebar-main-title">
                            <div>
                                <h6>Potensi Pajak</h6>
                                <p>Manajemen Potensi Pajak</p>
                            </div>
                        </li>
                        @canany(['manage-hotel', 'view-hotel', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('hotel*') ? 'active' : null }}" href="{{ url('hotel') }}">
                                <i class="fa fa-hotel"></i> <span>Hotel</span>
                            </a>
                        </li>
                        @endcanany
                        @canany(['manage-restoran', 'view-restoran', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('restoran*') && !request()->is('restoran-cwp*') ? 'active' : null }}" href="javascript:void(0);">
                                <i data-feather="coffee"></i> <span>Restoran</span>
                            </a>
                            <ul class="sidebar-submenu" style="{{ request()->is('restoran*') && !request()->is('restoran-cwp*') ? null : 'display: none' }}">
                                <li>
                                    <a href="{{ url('restoran?tipe=online/offline') }}" class="{{ request()->is('restoran*') && !request()->is('restoran-cwp*') && @request()->tipe == 'online/offline' ? 'active' : null }}">
                                        Online / Offline
                                    </a>
                                </li>
                                <li>
                                    <a href="{{ url('restoran?tipe=online') }}" class="{{ request()->is('restoran*') && !request()->is('restoran-cwp*') && @request()->tipe == 'online' ? 'active' : null }}">
                                        Online
                                    </a>
                                </li>
                                <li>
                                    <a href="{{ url('restoran?tipe=offline') }}" class="{{ request()->is('restoran*') && !request()->is('restoran-cwp*') && @request()->tipe == 'offline' ? 'active' : null }}">
                                        Offline
                                    </a>
                                </li>
                            </ul>
                        </li>
                        @endcanany
                        @canany(['manage-kostan', 'view-kostan', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('kostan*') ? 'active' : null }}" href="{{ url('kostan') }}">
                                <i data-feather="home"></i> <span>Kosan</span>
                            </a>
                        </li>
                        @endcanany
                        @canany(['manage-parkir', 'view-parkir', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('parkir*') ? 'active' : null }}" href="{{ url('parkir') }}">
                                <i data-feather="truck"></i> <span>Parkir</span>
                            </a>
                        </li>
                        @endcanany
                        @canany(['manage-hiburan', 'view-hiburan', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('hiburan*') ? 'active' : null }}" href="#">
                                <i data-feather="music"></i> <span>Hiburan</span>
                            </a>
                            <ul class="sidebar-submenu" style="{{ request()->is('hiburan*') ? null : 'display: none' }}">
                                @foreach($jenisHiburans as $jenis)
                                <li>
                                    <a href="{{ url('hiburan?hiburan_jenis_id=' . @$jenis->id) }}" class="{{ @$jenis->id == @request()->hiburan_jenis_id ? 'active' : null }}">
                                        {{ @$jenis->hiburan_jenis_deskripsi }}
                                    </a>
                                </li>
                                @endforeach
                            </ul>
                        </li>
                        @endcanany
                        @canany(['manage-restoran-cwp', 'view-restoran-cwp', 'admin'])
                            <li class="sidebar-main-title">
                                <div>
                                    <h6>Calon Wajib Pajak</h6>
                                    <p>Manajemen Calon Wajib Pajak</p>
                                </div>
                            </li>
                            <li class="sidebar-list">
                                <a class="sidebar-link sidebar-title link-nav {{ request()->is('restoran-cwp*') ? 'active' : null }}" href="javascript:void(0);">
                                    <i data-feather="coffee"></i> <span>Restoran</span>
                                </a>
                                <ul class="sidebar-submenu" style="{{ request()->is('restoran-cwp*') ? null : 'display: none' }}">
                                    <li>
                                        <a href="{{ url('restoran-cwp?tipe=online/offline') }}" class="{{ request()->is('restoran-cwp*') && @request()->tipe == 'online/offline' ? 'active' : null }}">
                                            Online / Offline
                                        </a>
                                    </li>
                                    <li>
                                        <a href="{{ url('restoran-cwp?tipe=online') }}" class="{{ request()->is('restoran-cwp*') && @request()->tipe == 'online' ? 'active' : null }}">
                                            Online
                                        </a>
                                    </li>
                                    <li>
                                        <a href="{{ url('restoran-cwp?tipe=offline') }}" class="{{ request()->is('restoran-cwp*') && @request()->tipe == 'offline' ? 'active' : null }}">
                                            Offline
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="sidebar-list">
                                <a class="sidebar-link sidebar-title link-nav {{ request()->is('cwp-log*') ? 'active' : null }}" href="{{ url('cwp-log') }}">
                                    <i data-feather="clock"></i> <span>Log CWP</span>
                                </a>
                            </li>
                        @endcanany
                        @canany(['manage-rusun', 'view-rusun', 'admin'])
                            <li class="sidebar-main-title">
                                <div>
                                    <h6>Retribusi Daerah</h6>
                                    <p>Manajemen Retribusi Daerah</p>
                                </div>
                            </li>
                            <li class="sidebar-list">
                                <a class="sidebar-link sidebar-title link-nav {{ request()->is('rusun*') ? 'active' : null }}" href="{{ url('rusun') }}">
                                    <i class="fa fa-building-o"></i> <span>Rusun</span>
                                </a>
                            </li>
                        @endcanany
                    @endcanany

                    @canany(['pimpinan', 'admin'])
                        <li class="sidebar-main-title">
                            <div>
                                <h6>Rekapitulasi</h6>
                                <p>Lihat Rekapitulasi</p>
                            </div>
                        </li>
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('rekapitulasi-tabular*') ? 'active' : null }}" href="{{ url('rekapitulasi-tabular') }}">
                                <i data-feather="grid"></i> <span>Tabular</span>
                            </a>
                        </li>
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('rekapitulasi-grafik*') ? 'active' : null }}" href="{{ url('rekapitulasi-grafik') }}">
                                <i data-feather="pie-chart"></i> <span>Grafik</span>
                            </a>
                        </li>
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('rekapitulasi-peta*') ? 'active' : null }}" href="{{ url('rekapitulasi-peta') }}">
                                <i data-feather="map"></i> <span>Peta</span>
                            </a>
                        </li>
                    @endcanany

                    @canany(['surveyor', 'admin'])
                        <li class="sidebar-main-title">
                            <div>
                                <h6>Pengguna</h6>
                                <p>Manajemen Data Pengguna</p>
                            </div>
                        </li>
                        @can('admin')
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('users*') ? 'active' : null }}" href="{{ url('users') }}">
                                <i data-feather="users"></i> <span>Data User</span>
                            </a>
                        </li>
                        @endcan
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('user-accesses*') ? 'active' : null }}" href="{{ url('user-accesses') }}">
                                <i data-feather="unlock"></i> <span>Hak Akses</span>
                            </a>
                        </li>
                        @can('admin')
                            <li class="sidebar-list">
                                <a class="sidebar-link sidebar-title link-nav {{ request()->is('user-log*') ? 'active' : null }}" href="{{ url('user-log') }}">
                                    <i data-feather="clock"></i> <span>Log User</span>
                                </a>
                            </li>
                        @endcan
                    @endcanany
                </ul>
            </div>
            <div class="right-arrow" id="right-arrow"><i data-feather="arrow-right"></i></div>
        </nav>
    </div>
</div>

@can('admin')
<div class="modal fade" id="persentaseModal" tabindex="-1" role="dialog" aria-labelledby="persentaseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="persentaseModalLabel">Setting Persentase Pajak</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" action="{{ url('setting-persentase') }}">
                    @csrf
                    <div class="alert alert-success">
                        <p>
                            <strong><em class="fa fa-info-circle"></em> Perhatian!</strong> Setting default persentase pajak dibawah hanya berlaku untuk objek <strong>Hotel, Restoran, Kosan, & Rusun</strong>
                        </p>
                    </div>
                    <div class="mb-3">
                        <label class="col-form-label">Persentase Pajak <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                        <input class="form-control @error('persentase') is-invalid @enderror" name="persentase" type="number" min="0" max="100" placeholder="10" value="{{ old('persentase', @$currentPersentasePajak) }}" required>
                        @error('persentase')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                    <button class="btn btn-secondary" type="submit">Simpan</button>
                </form>
                <hr>
                <form method="post" action="{{ url('hiburan/setting-persentase') }}">
                    @csrf
                    <div class="alert alert-success">
                        <p>
                            <strong><em class="fa fa-info-circle"></em> Perhatian!</strong> Setting default persentase pajak dibawah hanya berlaku untuk semua objek <strong>Hiburan</strong>
                        </p>
                    </div>
                    <div class="row mb-3">
                        @foreach($jenisHiburans as $jenisHiburan)
                            @if($jenisHiburan->kategori()->whereNotNull('hiburan_kategori_persentase')->count() > 0)
                                @foreach($jenisHiburan->kategori as $kategori)
                                    <div class="col-12 col-md-6">
                                        <label class="col-form-label">{{ $jenisHiburan->hiburan_jenis_deskripsi }} <small class="text-muted">({{ $kategori->hiburan_kategori_deskripsi }})</small> <span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                        <input class="form-control @error('kategori.'.$kategori->id.'.hiburan_kategori_persentase') is-invalid @enderror" name="kategori[{{ $kategori->id }}][hiburan_kategori_persentase]" type="number" min="0" max="100" placeholder="10" step=".1" value="{{ old('kategori.'.$kategori->id.'.hiburan_kategori_persentase', @$kategori->hiburan_kategori_persentase) }}" required>
                                        @error('kategori.'.$kategori->id.'.hiburan_kategori_persentase')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                @endforeach
                            @else
                                <div class="col-12 col-md-6">
                                    <label class="col-form-label">{{ $jenisHiburan->hiburan_jenis_deskripsi }}<span class="text-danger" data-toggle="tooltip" data-placement="bottom" data-bs-original-title="Harus Diisi">*</span></label>
                                    <input class="form-control @error('hiburan.'.$jenisHiburan->id.'.hiburan_jenis_persentase') is-invalid @enderror" name="hiburan[{{ $jenisHiburan->id }}][hiburan_jenis_persentase]" type="number" min="0" max="100" placeholder="10" step=".1" value="{{ old('hiburan.'.$jenisHiburan->id.'.hiburan_jenis_persentase', @$jenisHiburan->hiburan_jenis_persentase) }}" required>
                                    @error('hiburan.'.$jenisHiburan->id.'.hiburan_jenis_persentase')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            @endif
                        @endforeach
                    </div>
                    <button class="btn btn-secondary" type="submit">Simpan</button>
                </form>
            </div>
        </div>
    </div>
</div>
@endcan
