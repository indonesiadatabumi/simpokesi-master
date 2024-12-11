<a href="{{ url('/hiburan/'.$hiburan->id) }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Lihat Detail"><i data-feather="eye" class="text-primary"></i></a>

@if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hiburan') && ($hiburan->status_aktif_id == 4)))
<a href="{{ url('/hiburan/'.$hiburan->id.'/edit') }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah"><i data-feather="edit-3" class="text-warning"></i></a>
<a href="{{ url('/hiburan/'.$hiburan->id) }}" class="btn btn-sm btn-light btnDelete" data-toggle="tooltip" title="" role="button" data-bs-original-title="Hapus"><i data-feather="trash-2" class="text-danger"></i></a>
<span class="badge badge-pill badge-dark">
	<a href="{{ url('/hiburankunjungan/'.$hiburan->id.'_'.$hiburan->hiburan_jenis_id).'/create' }}" class="btn btn-sm" data-toggle="tooltip" title="pendataan" role="button"><i class="fa fa-building"  style="font-size:15px;color:white;">&nbsp;Pendataan</i></a>
	
</span>
@endif
<?php //<a href="{{ url('/hiburanrealisasi/'.$hiburan->id.'_'.$hiburan->hiburan_jenis_id) }}" class="btn btn-sm" data-toggle="tooltip" title="potensi" role="button"><i class="fa fa fa-bar-chart"  style="font-size:15px;color:yellow;"></i></a>
?>