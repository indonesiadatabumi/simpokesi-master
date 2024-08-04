@extends('backend.layout.app')

@push('css')
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatables.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend') }}/assets/css/vendors/datatable-extension.css">
@endpush

@push('styles')
    <style>
        .input-checkbox:hover {
            cursor: pointer;
        }
    </style>
@endpush

@push('js')
    <script src="{{ asset('backend') }}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/jszip.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.colVis.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/pdfmake.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/vfs_fonts.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.autoFill.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.select.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.html5.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/buttons.print.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.keyTable.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.colReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.fixedHeader.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.rowReorder.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/dataTables.scroller.min.js"></script>
    <script src="{{ asset('backend') }}/assets/js/datatable/datatable-extension/custom.js"></script>
@endpush

@push('scripts')
    <script>
        $(document).ready(function(){
            $('body').on('click', '.btnAccess', function (e){
                e.preventDefault();
                const url = $(this).attr('href');
                const accesses = $(this).data('accesses');
                const user = $(this).data('user');

                // SET USER
                $('#access-name').text(user.name);
                $('#access-email').text(user.email);
                $('#access-username').text(user.username);
                $('#access-role').text(user.role.description);
                $('#access-role').attr('class', 'badge badge-' + user.role.color);

                // SET USER ACCESS
                $('.checkbox-access').each(function(k, v) {
                    $(v).removeAttr('checked');
                });
                $.each(accesses, function(k, v) {
                    $('#checkbox-access-' + v.access_id).attr('checked', 'checked');
                });

                $('#formAccess').attr('action', url);
                $('#accessModal').modal('show');
            });
        })
    </script>
@endpush

@section('content')
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Hak Akses Pengguna</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="{{ url('/') }}"><i data-feather="home"></i></a>
                        </li>
                        <li class="breadcrumb-item active">Hak Akses Pengguna</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Container-fluid starts-->
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-3">Daftar Pengguna</h5>
                        <span>Berikut ini adalah daftar pengguna yang dapat diatur hak aksesnya.</span>
                    </div>
                    <div class="card-body">
                        <div class="dt-ext table-responsive">
                            <table class="display" id="responsive">
                                <thead>
                                <tr>
                                    <th>Nama</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach($users as $user)
                                <tr>
                                    <td>{{ $user->name }}</td>
                                    <td>{{ $user->username }}</td>
                                    <td>{{ $user->email }}</td>
                                    <td>
                                        <div class="badge badge-{{ $user->role->color }}">
                                            {{ $user->role->description }}
                                        </div>
                                    </td>
                                    <td>
                                        <a href="{{ url('/user-accesses/'.$user->id) }}" class="btn btn-sm btn-light btnAccess" data-accesses="{{ $user->accesses }}" data-user="{{ $user }}" data-toggle="tooltip" title="" role="button" data-bs-original-title="Ubah Hak Akses">
                                            <i data-feather="{{ $user->accesses->count() > 0 ? 'unlock' : 'lock' }}" class="text-{{ $user->accesses->count() > 0 ? 'info' : 'danger' }}"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>Nama</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th></th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Container-fluid Ends-->

    <div class="modal fade" id="accessModal" tabindex="-1" role="dialog" aria-labelledby="accessModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" id="formAccess">
                    @csrf
                    @method('put')
                    <div class="modal-header">
                        <h5 class="modal-title" id="accessModalLabel">Atur Hak Akses User</h5>
                        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h6>Detail User</h6>
                        <div class="row mb-3">
                            <div class="col-6">
                                Nama
                            </div>
                            <div class="col-6">
                                : <span id="access-name">Muhammad Ilham Hidayat</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                Username
                            </div>
                            <div class="col-6">
                                : <span id="access-username">hamayat</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                Email
                            </div>
                            <div class="col-6">
                                : <span id="access-email">hamayat123@gmail.com</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                Role
                            </div>
                            <div class="col-6">
                                : <span id="access-role" class="badge badge-warning">Operator</span>
                            </div>
                        </div>
                        <hr class="mt-4 mb-4">
                        <h6 class="mb-3">Hak Akses</h6>
                        <div class="row">
                            <div class="col ps-4">
                                @foreach($accesses as $row)
                                <label class="d-block mb-3 input-checkbox" for="checkbox-access-{{ $row->id }}">
                                    <input class="checkbox_animated checkbox-access" id="checkbox-access-{{ $row->id }}" name="access_id[]" value="{{ $row->id }}" type="checkbox"> {{ $row->description }}
                                </label>
                                @endforeach
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="submit">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
