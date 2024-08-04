<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\PersentasePajak;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PersentasePajakController extends Controller
{
    public function update(Request $request) {
        $input = $request->all();

        $validate = Validator::make($input, [
            'persentase' => 'required|numeric'
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            $persentasePajak = PersentasePajak::where('id', 1);
            $persentasePajak->update([
                'persentase' => $input['persentase']
            ]);

            DB::commit();

            return redirect()->back()->with('info', 'Persentase pajak berhasil diubah.');
        } catch (\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }
}
