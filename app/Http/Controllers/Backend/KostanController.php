<?php

namespace App\Http\Controllers\Backend;

use App\Exports\KostanExport;
use App\Http\Controllers\Controller;
use App\Models\KostanKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Kostan;
use App\Models\StatusAktif;
use App\Services\KostanService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use ZanySoft\Zip\Zip;

class KostanController extends Controller
{
    public function index()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.kostan.index', $data);
    }

    public function show($id)
    {
        $data['kostan'] = Kostan::findOrFail($id);

        return view('backend.kostan.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('kostan');

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

        return view('backend.kostan.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'kostan.kostan_npwpd' => 'nullable|unique:kostans,kostan_npwpd',
            'kostan.kostan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'kostan.kostan_pemilik' => 'required',
            'kostan.kostan_nama' => 'required',
            'kostan.kostan_alamat' => 'required',
            'kostan.kostan_kelurahan' => 'required',
            'kostan.kostan_jumlah_pegawai' => 'nullable|numeric',
            'kostan.kostan_persentase_pajak' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_tarif' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_hunian_avg' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new KostanService())->store($request);

            DB::commit();

            return redirect('kostan')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('kostan/'.$id);
        $data['kostan'] = Kostan::findOrFail($id);

        if (Gate::check('manage-kostan') && ($data['kostan']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = $data['kostan']->jenis_kamar()->count() > 0 ? $data['kostan']->jenis_kamar->toArray() : [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.kostan.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'kostan.kostan_npwpd' => 'nullable|unique:kostans,kostan_npwpd,'.$id.',id,deleted_at,NULL',
            'kostan.kostan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'kostan.kostan_pemilik' => 'required',
            'kostan.kostan_nama' => 'required',
            'kostan.kostan_alamat' => 'required',
            'kostan.kostan_kelurahan' => 'required',
            'kostan.kostan_jumlah_pegawai' => 'nullable|numeric',
            'kostan.kostan_persentase_pajak' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_tarif' => 'nullable|numeric',
            'jenis_kamar.*.kostan_jenis_kamar_hunian_avg' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new KostanService())->update($request, $id);

            DB::commit();

            return redirect('kostan')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new KostanService())->destroy($id);

            DB::commit();

            return redirect('kostan')->with('info', 'Data berhasil dihapus.');
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
            $import = (new KostanService())->import($request);

            DB::commit();

            return redirect('kostan')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $kostan = new KostanExport($input);

        return Excel::download($kostan, 'Export Kostan.xls');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['kostans'] = (new KostanService())->print($request);

        $pdf = SnappyPdf::loadView('backend.kostan.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Hotel.pdf');
    }
}
