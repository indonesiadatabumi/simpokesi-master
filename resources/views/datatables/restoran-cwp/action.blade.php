<a href="{{ url('/restoran-cwp/'.$restoran->id) }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Lihat Detail"><i data-feather="eye" class="text-primary"></i></a>
<a href="{{ url('/restoran-cwp/'.$restoran->id.'/convert') }}" class="btn btn-sm btn-light btnConvert" data-toggle="tooltip" title="" role="button" data-bs-original-title="Jadikan Wajib Pajak"><i data-feather="check-square" class="text-success"></i></a>

@if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-restoran') && ($restoran->status_aktif_id == 4)))
<a href="{{ url('/restoran-cwp/'.$restoran->id.'/edit') }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah"><i data-feather="edit-3" class="text-warning"></i></a>
<a href="{{ url('/restoran-cwp/'.$restoran->id) }}" class="btn btn-sm btn-light btnDelete" data-toggle="tooltip" title="" role="button" data-bs-original-title="Hapus"><i data-feather="trash-2" class="text-danger"></i></a>
<span class="badge badge-pill badge-dark">
	<a href="{{ url('/restokunjungan/'.$restoran->id.'_'.(@str_contains($restoran->restoran_tipe,'online/offline')?'onoff':$restoran->restoran_tipe)).'/create' }}" class="btn btn-sm" data-toggle="tooltip" title="pendataan" role="button"><i class="fa fa-building"  style="font-size:15px;color:white;">&nbsp;Pendataan</i></a>
	
</span>
@endif
