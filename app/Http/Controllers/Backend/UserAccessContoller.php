<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Access;
use App\Services\UserAccessService;
use App\Services\UserService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class UserAccessContoller extends Controller
{
    public function index()
    {
        $data['users'] = (new UserAccessService)->getUser();
        $data['accesses'] = Access::all();

        return view('backend.user-access.index', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        DB::beginTransaction();

        try {
            (new UserAccessService())->update($input, $id);

            DB::commit();

            return redirect('user-accesses')->with('info', 'Ubah data berhasil.');
        } catch(\Exception $e) {
            return redirect()->back()->with('error', 'Ubah data gagal. Error: '.$e->getMessage())->withInput($input);
        }
    }
}
