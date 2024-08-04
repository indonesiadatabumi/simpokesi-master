<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Role;
use App\Models\User;
use App\Models\Kecamatan;
use App\Services\UserService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class UserContoller extends Controller
{
    public function index()
    {
        $data['users'] = User::all();
        return view('backend.user.index', $data);
    }

    public function show($type)
    {
        return abort(404);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['roles'] = Role::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.user.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'name' => 'required',
            'email' => 'required|email',
            'username' => 'required|min:6',
            'password' => 'required|min:6|confirmed',
            'role_id' => 'required',
        ]);

        if ($validate->fails()) {
            return redirect()->back()->withErrors($validate->errors())->withInput($input)->with('error', 'Tambah data gagal. Input tidak valid.');
        }

        DB::beginTransaction();

        try {
            (new UserService())->store($input);

            DB::commit();

            return redirect('users')->with('info', 'Tambah data berhasil.');
        } catch(\Exception $e) {
            return redirect()->back()->with('error', 'Tambah data gagal. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit(Request $request, $id)
    {
        $data['title'] = 'Ubah';
        $data['roles'] = Role::all();
        $data['user'] = User::findOrFail($id);
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.user.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'name' => 'required',
            'email' => 'required|email',
            'username' => 'required|min:6',
            'password' => 'nullable|min:6|confirmed',
            'role_id' => 'required',
        ]);

        if ($validate->fails()) {
            return redirect()->back()->withErrors($validate->errors())->withInput($input)->with('error', 'Ubah data gagal. Input tidak valid.');
        }

        DB::beginTransaction();

        try {
            (new UserService())->update($input, $id);

            DB::commit();

            return redirect('users')->with('info', 'Ubah data berhasil.');
        } catch(\Exception $e) {
            return redirect()->back()->with('error', 'Ubah data gagal. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        $input = $request->all();

        DB::beginTransaction();

        try {
            (new UserService())->destroy($id);

            DB::commit();

            return redirect('users')->with('info', 'Hapus data berhasil.');
        } catch(\Exception $e) {
            return redirect()->back()->with('error', 'Hapus data gagal. Error: '.$e->getMessage())->withInput($input);
        }
    }
}
