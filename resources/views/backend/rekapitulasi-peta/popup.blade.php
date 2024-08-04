<a href="{{ url($jenis.'/'.$dokumen['id']) }}" target="_blank" class="leaflet-listing-img-container">
    <div class="leaflet-listing-item-content">
        <h3>{{ strtoupper($jenis) }}</h3>
        <span><u>{{ @$dokumen[$jenis_nomor[$jenis]] ?? '-' }}</u></span>
        @if($private)
            @if($jenis === 'rusun')
                <small class="d-block">Retribusi Daerah: {{ generateRupiah($dokumen[$jenis.'_potensi_pajak']) }}</small>
            @else
                <small class="d-block">Potensi Pajak: {{ generateRupiah($dokumen[$jenis.'_potensi_pajak']) }}</small>
            @endif
        @endif

        @if($jenis === 'restoran')
            <div class="mt-2">
                <small><span style="font-size: 10px; color: #fff;" class="badge d-inline badge-{{ $dokumen['restoran_status_tapping_box'] == 1 ? 'success' : 'danger' }}">Tapping Box {{ $dokumen['restoran_status_tapping_box'] == 1 ? 'Sudah Tersedia' : 'Belum Tersedia' }}</span></small>
            </div>
        @endif

        @if($jenis === 'hotel')
            <div class="mt-2">
                <small><span style="font-size: 10px; color: #fff;" class="badge d-inline badge-{{ $dokumen['hotel_status_tapping_box'] == 1 ? 'success' : 'danger' }}">Tapping Box {{ $dokumen['hotel_status_tapping_box'] == 1 ? 'Sudah Tersedia' : 'Belum Tersedia' }}</span></small>
            </div>
        @endif
    </div>
</a>
@if($dokumen[$jenis.'_kecamatan'] || $dokumen[$jenis.'_kelurahan'])
    <div class="leaflet-listing-content">
        <div class="leaflet-listing-title mb-1">
            {{ $jenis != 'psu' ? @$dokumen['pemohon_nama'] : (@$dokumen['psu_perumahan'] ?? '-') }}
        </div>
        <div class="leaflet-listing-title">
            {{ @$dokumen[$jenis.'_kelurahan'] ? 'KEL. '.$dokumen[$jenis.'_kelurahan'].', ' : '' }} {{ @$dokumen[$jenis.'_kecamatan'] ? 'KEC. '.$dokumen[$jenis.'_kecamatan'] : '' }}
        </div>
    </div>
@endif
