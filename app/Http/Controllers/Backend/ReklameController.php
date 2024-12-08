<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Reklame;
use App\Models\ReklameKlasifikasi;
use App\Models\StatusAktif;
use App\Services\ReklameService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;

class ReklameController extends Controller
{
    public function index()
    {
        $data['klasifikasis'] = ReklameKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.reklame.index', $data);
    }

    public function show($id)
    {
        $data['reklame'] = Reklame::findOrFail($id);

        return view('backend.reklame.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('reklame');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = ReklameKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        
        return view('backend.reklame.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'reklame.reklame_npwpd' => 'nullable|unique:reklames,reklame_npwpd',
            'reklame.reklame_foto' => 'nullable|mimes:png,jpg,jpeg',
            'reklame.reklame_pemilik' => 'required',
            'reklame.reklame_nama' => 'required',
            'reklame.reklame_klasifikasi_id' => 'required',
            'reklame.reklame_alamat' => 'required',
            'reklame.reklame_kelurahan' => 'required',
            'reklame.reklame_jumlah_pegawai' => 'nullable|numeric',
            'reklame.reklame_persentase_pajak' => 'nullable|numeric',
            'reklame.reklame_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new ReklameService())->store($request);

            DB::commit();

            return redirect('reklame')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('reklame/'.$id);
        $data['reklame'] = Reklame::findOrFail($id);

        if (Gate::check('manage-reklame') && ($data['reklame']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }
        
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
        ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
            $q->where('id', auth()->user()->kecamatan_id);
        })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = ReklameKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        return view('backend.reklame.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'reklame.reklame_npwpd' => 'nullable|unique:reklames,reklame_npwpd,'.$id.',id,deleted_at,NULL',
            'reklame.reklame_foto' => 'nullable|mimes:png,jpg,jpeg',
            'reklame.reklame_pemilik' => 'required',
            'reklame.reklame_nama' => 'required',
            'reklame.reklame_klasifikasi_id' => 'required',
            'reklame.reklame_alamat' => 'required',
            'reklame.reklame_kelurahan' => 'required',
            'reklame.reklame_jumlah_pegawai' => 'nullable|numeric',
            'reklame.reklame_persentase_pajak' => 'nullable|numeric',
            'reklame.reklame_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.reklame_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new ReklameService())->update($request, $id);

            DB::commit();

            return redirect('reklame')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new ReklameService())->destroy($id);

            DB::commit();

            return redirect('reklame')->with('info', 'Data berhasil dihapus.');
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
            $import = (new ReklameService())->import($request);

            DB::commit();

            return redirect('reklame')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

   //     $reklame = new ReklameExport($input);

        return Excel::download($reklame, 'Export Reklame.xls');
    }

    public function printTingkatHunian(Request $request)
    {
        $data['reklames'] = (new ReklameService())->print($request);

        $pdf = SnappyPdf::loadView('backend.reklame.print-tingkat-hunian', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Reklame.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['reklames'] = (new ReklameService())->print($request);

        $pdf = SnappyPdf::loadView('backend.reklame.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Reklame.pdf');
    }
}
