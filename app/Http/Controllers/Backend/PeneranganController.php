<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Penerangan;
use App\Models\PeneranganKlasifikasi;
use App\Models\StatusAktif;
use App\Services\PeneranganService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;

class PeneranganController extends Controller
{
    public function index()
    {
        $data['klasifikasis'] = PeneranganKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.penerangan.index', $data);
    }

    public function show($id)
    {
        $data['penerangan'] = Penerangan::findOrFail($id);

        return view('backend.penerangan.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('penerangan');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = PeneranganKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        
        return view('backend.penerangan.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'penerangan.penerangan_npwpd' => 'nullable|unique:penerangans,penerangan_npwpd',
            'penerangan.penerangan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'penerangan.penerangan_pemilik' => 'required',
            'penerangan.penerangan_nama' => 'required',
            'penerangan.penerangan_klasifikasi_id' => 'required',
            'penerangan.penerangan_alamat' => 'required',
            'penerangan.penerangan_kelurahan' => 'required',
            'penerangan.penerangan_jumlah_pegawai' => 'nullable|numeric',
            'penerangan.penerangan_persentase_pajak' => 'nullable|numeric',
            'penerangan.penerangan_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new PeneranganService())->store($request);

            DB::commit();

            return redirect('penerangan')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('penerangan/'.$id);
        $data['penerangan'] = Penerangan::findOrFail($id);

        if (Gate::check('manage-penerangan') && ($data['penerangan']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }
        
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
        ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
            $q->where('id', auth()->user()->kecamatan_id);
        })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = PeneranganKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        return view('backend.penerangan.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'penerangan.penerangan_npwpd' => 'nullable|unique:penerangans,penerangan_npwpd,'.$id.',id,deleted_at,NULL',
            'penerangan.penerangan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'penerangan.penerangan_pemilik' => 'required',
            'penerangan.penerangan_nama' => 'required',
            'penerangan.penerangan_klasifikasi_id' => 'required',
            'penerangan.penerangan_alamat' => 'required',
            'penerangan.penerangan_kelurahan' => 'required',
            'penerangan.penerangan_jumlah_pegawai' => 'nullable|numeric',
            'penerangan.penerangan_persentase_pajak' => 'nullable|numeric',
            'penerangan.penerangan_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.penerangan_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new PeneranganService())->update($request, $id);

            DB::commit();

            return redirect('penerangan')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new PeneranganService())->destroy($id);

            DB::commit();

            return redirect('penerangan')->with('info', 'Data berhasil dihapus.');
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
            $import = (new PeneranganService())->import($request);

            DB::commit();

            return redirect('penerangan')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

   //     $penerangan = new PeneranganExport($input);

        return Excel::download($penerangan, 'Export Penerangan.xls');
    }

    public function printTingkatHunian(Request $request)
    {
        $data['penerangans'] = (new PeneranganService())->print($request);

        $pdf = SnappyPdf::loadView('backend.penerangan.print-tingkat-hunian', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Penerangan.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['penerangans'] = (new PeneranganService())->print($request);

        $pdf = SnappyPdf::loadView('backend.penerangan.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Penerangan.pdf');
    }
}
