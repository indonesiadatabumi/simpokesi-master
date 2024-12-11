<a href="{{ url('/hotel/'.$hotel->id) }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Lihat Detail"><i data-feather="eye" class="text-primary"></i></a>

@if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hotel') && ($hotel->status_aktif_id == 4)))
<a href="{{ url('/hotel/'.$hotel->id.'/edit') }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah"><i data-feather="edit-3" class="text-warning"></i></a>
<a href="{{ url('/hotel/'.$hotel->id) }}" class="btn btn-sm btn-light btnDelete" data-toggle="tooltip" title="" role="button" data-bs-original-title="Hapus"><i data-feather="trash-2" class="text-danger"></i></a>
<span class="badge badge-pill badge-dark">
	<a href="{{ url('/hotelhunian/'.$hotel->id).'/create' }}" class="btn btn-sm" data-toggle="tooltip" title="pendataan" role="button"><i class="fa fa-building"  style="font-size:15px;color:white;"></i></a>
	<a href="','{{$hotel->hotel_npwpd}}');" data-potensi="{{$hotel->hotel_potensi_pajak}}" data-npwpd="{{$hotel->hotel_npwpd}}" class="btn btn-sm realisasi" data-toggle="tooltip" title="potensi" data-bs-toggle="modal" data-original-title="Realisasi" data-bs-target="#realisasi-modal" role="button"><i class="fa fa fa-bar-chart"  style="font-size:15px;color:yellow;"></i></a>
</span>
@endif
<?php 
//	<a href="{{ url('/hotelrealisasi/'.$hotel->id) }}" class="btn btn-sm" data-toggle="tooltip" title="potensi" role="button"><i class="fa fa fa-bar-chart"  style="font-size:15px;color:yellow;"></i></a>
?>