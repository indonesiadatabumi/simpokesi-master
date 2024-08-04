<?php

namespace App\Http\Controllers\Backend;

use App\Exports\RusunExport;
use App\Http\Controllers\Controller;
use App\Models\RusunKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Rusun;
use App\Models\StatusAktif;
use App\Services\RusunService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use ZanySoft\Zip\Zip;

class RusunController extends Controller
{
    public function index()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.rusun.index', $data);
    }

    public function show($id)
    {
        $data['rusun'] = Rusun::findOrFail($id);

        return view('backend.rusun.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('rusun');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.rusun.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'rusun.rusun_npwpd' => 'nullable|unique:rusuns,rusun_npwpd',
            'rusun.rusun_foto' => 'nullable|mimes:png,jpg,jpeg',
            'rusun.rusun_pemilik' => 'required',
            'rusun.rusun_nama' => 'required',
            'rusun.rusun_alamat' => 'required',
            'rusun.rusun_kelurahan' => 'required',
            'rusun.rusun_jumlah_pegawai' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_tarif' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_hunian_avg' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new RusunService())->store($request);

            DB::commit();

            return redirect('rusun')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('rusun/'.$id);
        $data['rusun'] = Rusun::findOrFail($id);

        if (Gate::check('manage-rusun') && ($data['rusun']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = $data['rusun']->jenis_kamar()->count() > 0 ? $data['rusun']->jenis_kamar->toArray() : [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.rusun.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'rusun.rusun_npwpd' => 'nullable|unique:rusuns,rusun_npwpd,'.$id.',id,deleted_at,NULL',
            'rusun.rusun_foto' => 'nullable|mimes:png,jpg,jpeg',
            'rusun.rusun_pemilik' => 'required',
            'rusun.rusun_nama' => 'required',
            'rusun.rusun_alamat' => 'required',
            'rusun.rusun_kelurahan' => 'required',
            'rusun.rusun_jumlah_pegawai' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_tarif' => 'nullable|numeric',
            'jenis_kamar.*.rusun_jenis_kamar_hunian_avg' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new RusunService())->update($request, $id);

            DB::commit();

            return redirect('rusun')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new RusunService())->destroy($id);

            DB::commit();

            return redirect('rusun')->with('info', 'Data berhasil dihapus.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal dihapus. Error: '.$e->getMessage());
        }
    }

    public function import(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'file' => 'required|mimes:xls,xlsx',
            'import_tipe' => 'required'
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors());
        }

        DB::beginTransaction();

        try {
            $import = (new RusunService())->import($request);

            DB::commit();

            return redirect('rusun')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $rusun = new RusunExport($input);

        return Excel::download($rusun, 'Export Rusun.xls');
    }

    public function printRetribusiDaerah(Request $request)
    {
        $data['rusuns'] = (new RusunService())->print($request);

        $pdf = SnappyPdf::loadView('backend.rusun.print-retribusi-daerah', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('disable-javascript', true)
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Retribusi Daerah Rusun.pdf');
    }
}
