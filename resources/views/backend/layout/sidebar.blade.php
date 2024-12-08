<!-- 
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
                                <i class="fa fa-hotel"></i> <span>PBJT Jasa Perhotelan</span>
                            </a>
                        </li>
                        @endcanany
                        @canany(['manage-restoran', 'view-restoran', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('restoran*') && !request()->is('restoran-cwp*') ? 'active' : null }}" href="{{ url('restoran') }}">
                                <i data-feather="coffee"></i> <span>PBJT Makanan dan/atau Minuman</span>
                            </a>
                            <!-- href="javascript:void(0);"
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
                             --
                        </li>
                        @endcanany
                        <!-- 
                        @canany(['manage-kostan', 'view-kostan', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('kostan*') ? 'active' : null }}" href="{{ url('kostan') }}">
                                <i data-feather="home"></i> <span>PBJT Kosan</span>
                            </a>
                        </li>
                        @endcanany
                         --
                        @canany(['manage-parkir', 'view-parkir', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('parkir*') ? 'active' : null }}" href="{{ url('parkir') }}">
                                <i data-feather="truck"></i> <span>PBJT Jasa Parkir</span>
                            </a>
                        </li>
                        @endcanany
                        @canany(['manage-hiburan', 'view-hiburan', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('hiburan*') ? 'active' : null }}" href="#">
                                <i data-feather="music"></i> <span>PBJT Jasa Kesenian dan Hiburan</span>
                            </a>
                            <ul class="sidebar-submenu" style="{{ request()->is('hiburan*') ? null : 'display: none' }}">
                                <li>
                                    <a href="{{ url('hiburan') }}" class="{{ empty(@request()->hiburan_jenis_id) ? 'active' : null }}">
                                        Semua Jenis Hiburan
                                    </a>
                                </li>
                                @foreach($jenisHiburans as $jenis)
                                <li>
                                    <a href="{{ url('hiburan?hiburan_jenis_id=' . @$jenis->id) }}" class="{{ @$jenis->id == @request()->hiburan_jenis_id ? 'active' : null }}">
                                        {{ @$jenis->hiburan_jenis_deskripsi }}
                                    </a>
                                </li>
                                @endforeach
                                <li class="has_sub">
                                    <a class="sidebar-link sidebar-title link-nav {{ (8== @request()->hiburan_jenis_id||9== @request()->hiburan_jenis_id||11== @request()->hiburan_jenis_id||12== @request()->hiburan_jenis_id) ? 'active' : null }}" href="#">
                                        <i data-feather="music"></i> <span>Olahraga Permainan</span>
                                    </a>
                                    <ul class="sidebar-submenu" style="{{  (8== @request()->hiburan_jenis_id||9== @request()->hiburan_jenis_id||11== @request()->hiburan_jenis_id||12== @request()->hiburan_jenis_id) ? null : 'display: none' }}">
                                    	@foreach($jenisHiburanPermainans as $jenis)
                                        <li>
                                            <a href="{{ url('hiburan?hiburan_jenis_id=' . @$jenis->id) }}" class="{{ @$jenis->id == @request()->hiburan_jenis_id ? 'active' : null }}">
                                                {{ @$jenis->hiburan_jenis_deskripsi }}
                                            </a>
                                        </li>
                                        @endforeach
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        @endcanany
                        
                        @canany(['manage-reklame', 'view-reklame', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('reklame*') ? 'active' : null }}" href="{{ url('reklame') }}">
                                <i class="fa fa-vcard"></i> <span>Pajak Reklame</span>
                            </a>
                        </li>
                        @endcanany
                         @canany(['manage-penerangan', 'view-penerangan', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('penerangan*') ? 'active' : null }}" href="{{ url('penerangan') }}">
                                <i class="fa fa-shower"></i> <span>PBJT Penerangan Jalan</span>
                            </a>
                        </li>
                        @endcanany
                         @canany(['manage-air', 'view-air', 'admin'])
                        <li class="sidebar-list">
                            <a class="sidebar-link sidebar-title link-nav {{ request()->is('air*') ? 'active' : null }}" href="{{ url('air') }}">
                                <i class="fa fa-map-signs"></i> <span>Air Tanah</span>
                            </a>
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
                                <a class="sidebar-link sidebar-title link-nav {{ request()->is('restoran-cwp*') ? 'active' : null }}"  href="{{ url('restoran-cwp') }}">
                                    <i data-feather="coffee"></i> <span>PBJT Jasa Makanan dan/atau Minuman</span>
                                </a>
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
-->

<div id="header" class="app-header">
	<!-- BEGIN navbar-header -->
	<div class="navbar-header">
		<button type="button" class="navbar-desktop-toggler" data-toggle="app-sidebar-minify">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a href="{{ url('/') }}" class="navbar-brand">
            <img class="img-fluid for-light" src="{{ asset('backend') }}/assets/images/logo/logo-simpokesi-new.jpeg" alt="">
		</a>
		<button type="button" class="navbar-mobile-toggler" data-toggle="app-sidebar-mobile">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	</div>
	<!-- END navbar-header -->
	<!-- BEGIN header-nav -->
	<div class="navbar-nav">
		<div class="navbar-item navbar-form">
		</div>
		<div class="navbar-item navbar-user dropdown">
			<ul class="nav-menus">
                <li class="profile-nav onhover-dropdown p-0 me-0">
                    <div class="media profile-media"><img class="b-r-10" src="{{ asset('backend') }}/assets/images/dashboard/profile.jpg" alt="">
                        <div class="media-body"><span>{{ auth()->user()->name}}</span>
                            <p class="mb-0 font-roboto">{{ auth()->user()->role->description }} <i class="middle fa fa-angle-down"></i></p>
                        </div>
                    </div>
                    <ul class="profile-dropdown onhover-show-div">
                        <li><a href="#"><i data-feather="settings"></i><span>Settings</span></a></li>
                        <li><a href="javascript:void(0);" class="btnLogout"><i data-feather="log-in"> </i><span>Log out</span></a></li>
                    </ul>
                    <form id="formLogout" method="post" action="{{ url('logout') }}">
                        @csrf
                    </form>
                </li>
            </ul>
		</div>
	</div>
	<!-- END header-nav -->
</div>
<!-- END #header -->

<div id="sidebar" class="app-sidebar">
	<!-- BEGIN scrollbar -->
	<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
		<!-- BEGIN menu -->
		<div class="menu">
			<!-- 
			<div class="menu-profile" style="background-color:unset">
			    
			    <a href="{{ url('/') }}">
                    <img class="img-fluid for-light" src="{{ asset('backend') }}/assets/images/logo/logo-simpokesi-new.jpeg" alt="">
                </a>
                 
			</div>
			 -->
			<div class="pt-3 menu-item {{ request()->is('dashboard') ? 'active' : null }}">
				<a href="{{ url('dashboard') }}" class="menu-link">
					<div class="menu-icon">
						 <i class="material-icons">dashboard</i>
					</div>
					<div class="menu-text">Dashboard</div>
				</a>
			</div>
			@can('admin')
			<div class="menu-item">
				<a class="menu-link" data-bs-toggle="modal" data-bs-target="#persentaseModal" href="javascript:void(0);">
					<div class="menu-icon" class="menu-link">
						 <i class="material-icons">percent</i>
					</div>
					<div class="menu-text">Setting Persentase Pajak</div>
				</a>
			</div>
            @endcan
            @canany(['surveyor', 'pimpinan', 'admin'])
			<div class="menu-header">
				<div class="sidebar-main-title">
                    <h6>Potensi Pajak</h6>
                    <p>Manajemen Potensi Pajak</p>
                </div>
            </div>
                @canany(['manage-hotel', 'view-hotel', 'admin'])
    			<div class="menu-item {{ request()->is('hotel*') ? 'active' : null }}">
    				<a href="{{ url('hotel') }}" class="menu-link">
    					<div class="menu-icon">
    						 <i class="material-icons">hotel</i>
    					</div>
    					<div class="menu-text">PBJT Jasa Perhotelan</div>
    				</a>
    			</div>
    			@endcanany
                @canany(['manage-restoran', 'view-restoran', 'admin'])
                <div class="menu-item {{ request()->is('restoran*') && !request()->is('restoran-cwp*') ? 'active' : null }}">
    				<a href="{{ url('restoran') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">fastfood</i>
    					</div>
    					<div class="menu-text">PBJT Makanan dan/atau Minuman</div>
    				</a>
    			</div>
    			@endcanany
    			@canany(['manage-parkir', 'view-parkir', 'admin'])
    			<div class="menu-item {{ request()->is('parkir*') ? 'active' : null }}">
    				<a href="{{ url('parkir') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">local_parking</i>
    					</div>
    					<div class="menu-text">PBJT Jasa Parkir</div>
    				</a>
    			</div>
    			@endcanany
    			@canany(['manage-hiburan', 'view-hiburan', 'admin'])
    			<div class="menu-item has-sub {{ request()->is('hiburan*') ? 'active' : null }}">
    				<a href="javascript:;" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">library_music</i>
    					</div>
    					<div class="menu-text">PBJT Jasa Kesenian dan Hiburan</div>
						<div class="menu-caret"></div>
    				</a>
    				<div class="menu-submenu">
        				<div class="menu-item {{ request()->is('hiburan*')&&empty(@request()->hiburan_jenis_id) ? 'active' : null }}">
            				<a href="{{ url('hiburan') }}" class="menu-link">
            					<div class="menu-text">Semua Jenis Hiburan</div>
            				</a>
            			</div>
            			@foreach($jenisHiburans as $jenis)
        				<div class="menu-item {{ request()->is('hiburan*')&&@$jenis->id == @request()->hiburan_jenis_id ? 'active' : null }}">
            				<a href="{{ url('hiburan?hiburan_jenis_id=' . @$jenis->id) }}" class="menu-link">
            					<div class="menu-text">{{ @$jenis->hiburan_jenis_deskripsi }}</div>
            				</a>
            			</div>
                    	@endforeach
                    	<div class="menu-item has-sub {{ request()->is('hiburan*')&&(8== @request()->hiburan_jenis_id||9== @request()->hiburan_jenis_id||11== @request()->hiburan_jenis_id||12== @request()->hiburan_jenis_id)? 'active' : null }}">
            				<a href="javascript:;" class="menu-link">
            					<div class="menu-text">Olahraga Permainan</div>
        						<div class="menu-caret"></div>
            				</a>
            				<div class="menu-submenu">
                				@foreach($jenisHiburanPermainans as $jenis)
                				<div class="menu-item {{ request()->is('hiburan*')&&(8== @request()->hiburan_jenis_id||9== @request()->hiburan_jenis_id||11== @request()->hiburan_jenis_id||12== @request()->hiburan_jenis_id)&&@$jenis->id == @request()->hiburan_jenis_id ? 'active' : null }}">
                    				<a href="{{ url('hiburan?hiburan_jenis_id=' . @$jenis->id) }}" class="menu-link">
                    					<div class="menu-text">{{ @$jenis->hiburan_jenis_deskripsi }}</div>
                    				</a>
                    			</div>
                                @endforeach
                			</div>
                		</div>
        			</div>
    			</div>
    			@endcanany
    			@canany(['manage-reklame', 'view-reklame', 'admin'])
    			<div class="menu-item {{ request()->is('reklame*') ? 'active' : null }}">
    				<a href="{{ url('reklame') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">wallpaper</i>
    					</div>
    					<div class="menu-text">Pajak Reklame</div>
    				</a>
    			</div>
                @endcanany
                @canany(['manage-penerangan', 'view-penerangan', 'admin'])
                <div class="menu-item {{ request()->is('penerangan*') ? 'active' : null }}">
    				<a href="{{ url('penerangan') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">light</i>
    					</div>
    					<div class="menu-text">PBJT Penerangan Jalan</div>
    				</a>
    			</div>
                @endcanany
                @canany(['manage-air', 'view-air', 'admin'])
                <div class="menu-item {{ request()->is('air*') ? 'active' : null }}">
    				<a href="{{ url('air') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">water</i>
    					</div>
    					<div class="menu-text">Air Tanah</div>
    				</a>
    			</div>
                @endcanany
                @canany(['manage-restoran-cwp', 'view-restoran-cwp', 'admin'])
    			<div class="menu-header">
    				<div class="sidebar-main-title">
                        <h6>Calon Wajib Pajak</h6>
                        <p>Manajemen Calon Wajib Pajak</p>
                    </div>
                </div>
                <div class="menu-item {{ request()->is('restoran-cwp*') ? 'active' : null }}">
    				<a href="{{ url('restoran-cwp') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">fastfood</i>
    					</div>
    					<div class="menu-text">PBJT Jasa Makanan dan/atau Minuman</div>
    				</a>
    			</div>
    			<div class="menu-item {{ request()->is('cwp-log*') ? 'active' : null }}">
    				<a href="{{ url('cwp-log') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">manage_search</i>
    					</div>
    					<div class="menu-text">Log CWP</div>
    				</a>
    			</div>
                @endcanany
                @canany(['manage-rusun', 'view-rusun', 'admin'])
                <div class="menu-header">
    				<div class="sidebar-main-title">
                        <h6>Retribusi Daerah</h6>
                        <p>Manajemen Retribusi Daerah</p>
                    </div>
                </div>
                <div class="menu-item {{ request()->is('rusun*') ? 'active' : null }}">
    				<a href="{{ url('rusun') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">apartment</i>
    					</div>
    					<div class="menu-text">Rusun</div>
    				</a>
    			</div>
                @endcanany
                @canany(['pimpinan', 'admin'])
                <div class="menu-header">
    				<div class="sidebar-main-title">
                        <h6>Rekapitulasi</h6>
                        <p>Lihat Rekapitulasi</p>
                    </div>
                </div>
                <div class="menu-item {{ request()->is('rekapitulasi-tabular*') ? 'active' : null }}">
    				<a href="{{ url('rekapitulasi-tabular') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">compare</i>
    					</div>
    					<div class="menu-text">Tabular</div>
    				</a>
    			</div>
                <div class="menu-item {{ request()->is('rekapitulasi-grafik*') ? 'active' : null }}">
    				<a href="{{ url('rekapitulasi-grafik') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">area_chart</i>
    					</div>
    					<div class="menu-text">Grafik</div>
    				</a>
    			</div>
                <div class="menu-item {{ request()->is('rekapitulasi-peta*') ? 'active' : null }}">
    				<a href="{{ url('rekapitulasi-peta') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">map</i>
    					</div>
    					<div class="menu-text">Peta</div>
    				</a>
    			</div>
                @endcanany

                @canany(['surveyor', 'admin'])
                <div class="menu-header">
                    <div class="sidebar-main-title">
                        <h6>Lainnya</h6>
                        <p>Fitur Lainnya</p>
                    </div>
                </div>
                <div class="menu-item {{ request()->is('realisasi-pendapatan*') ? 'active' : null }}">
                    <a href="{{ url('realisasi-pendapatan') }}" class="menu-link">
                        
                        <div class="menu-text">Proyeksi pajak daerah</div>
                    </a>
                </div>
                <div class="menu-item {{ request()->is('notadinas*') ? 'active' : null }}">
                    <a href="{{ url('notadinas') }}" class="menu-link">
                        
                        <div class="menu-text">Nota Dinas</div>
                    </a>
                </div>
                <div class="menu-item {{ request()->is('files*') ? 'active' : null }}">
                    <a href="{{ url('files') }}" class="menu-link">
                        
                        <div class="menu-text">Formulir Pendataan</div>
                    </a>
                </div>
                @endcanany

                @canany(['surveyor', 'admin'])
                <div class="menu-header">
    				<div class="sidebar-main-title">
                        <h6>Pengguna</h6>
                        <p>Manajemen Data Pengguna</p>
                    </div>
                </div>
                    @can('admin')
                    <div class="menu-item {{ request()->is('users*') ? 'active' : null }}">
        				<a href="{{ url('users') }}" class="menu-link">
        					<div class="menu-icon">
        						<i class="material-icons">manage_accounts</i>
        					</div>
        					<div class="menu-text">Data User</div>
        				</a>
        			</div>
                    @endcan
                <div class="menu-item {{ request()->is('user-accesses*') ? 'active' : null }}">
    				<a href="{{ url('user-accesses') }}" class="menu-link">
    					<div class="menu-icon">
    						<i class="material-icons">key</i>
    					</div>
    					<div class="menu-text">Hak Akses</div>
    				</a>
    			</div>
                    @can('admin')
                    <div class="pb-5 menu-item {{ request()->is('user-log*') ? 'active' : null }}">
        				<a href="{{ url('user-log') }}" class="menu-link">
        					<div class="menu-icon">
        						<i class="material-icons">history</i>
        					</div>
        					<div class="menu-text">Log User</div>
        				</a>
        			</div>
                    @endcan
                @endcanany
			@endcanany
		</div>
		<!-- END menu -->
	</div>
	<!-- END scrollbar -->
</div>

<div class="app-sidebar-bg"></div>
<div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a></div>		

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
