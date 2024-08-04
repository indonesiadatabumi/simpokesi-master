<a href="{{ url('/hotel/'.$hotel->id) }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Lihat Detail"><i data-feather="eye" class="text-primary"></i></a>

@if(\Illuminate\Support\Facades\Gate::check('admin') || (\Illuminate\Support\Facades\Gate::check('manage-hotel') && ($hotel->status_aktif_id == 4)))
<a href="{{ url('/hotel/'.$hotel->id.'/edit') }}" class="btn btn-sm btn-light" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah"><i data-feather="edit-3" class="text-warning"></i></a>
<a href="{{ url('/hotel/'.$hotel->id) }}" class="btn btn-sm btn-light btnDelete" data-toggle="tooltip" title="" role="button" data-bs-original-title="Hapus"><i data-feather="trash-2" class="text-danger"></i></a>
@endif
