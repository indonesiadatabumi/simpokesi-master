<?php

namespace App\Http\Controllers\Backend;

use App\Exports\ParkirExport;
use App\Http\Controllers\Controller;
use App\Models\ParkirKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Parkir;
use App\Models\StatusAktif;
use App\Services\ParkirService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use ZanySoft\Zip\Zip;

class ParkirController extends Controller
{
    public function index()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.parkir.index', $data);
    }

    public function show($id)
    {
        $data['parkir'] = Parkir::findOrFail($id);

        return view('backend.parkir.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('parkir');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['status_aktifs'] = StatusAktif::all();

        return view('backend.parkir.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'parkir.parkir_npwpd' => 'nullable|unique:parkirs,parkir_npwpd',
            'parkir.parkir_foto' => 'nullable|mimes:png,jpg,jpeg',
            'parkir.parkir_pemilik' => 'required',
            'parkir.parkir_nama' => 'required',
            'parkir.parkir_alamat' => 'required',
            'parkir.parkir_kelurahan' => 'required',
            'parkir.parkir_srp_motor' => 'nullable|numeric',
            'parkir.parkir_srp_mobil' => 'nullable|numeric',
            'parkir.parkir_tarif_motor' => 'nullable|numeric',
            'parkir.parkir_tarif_mobil' => 'nullable|numeric',
            'parkir.parkir_durasi_avg' => 'nullable|numeric',
            'parkir.parkir_persentase_pajak' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new ParkirService())->store($request);

            DB::commit();

            return redirect('parkir')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('parkir/'.$id);
        $data['parkir'] = Parkir::findOrFail($id);

        if (Gate::check('manage-parkir') && ($data['parkir']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['status_aktifs'] = StatusAktif::all();

        return view('backend.parkir.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'parkir.parkir_npwpd' => 'nullable|unique:parkirs,parkir_npwpd,'.$id.',id,deleted_at,NULL',
            'parkir.parkir_foto' => 'nullable|mimes:png,jpg,jpeg',
            'parkir.parkir_pemilik' => 'required',
            'parkir.parkir_nama' => 'required',
            'parkir.parkir_alamat' => 'required',
            'parkir.parkir_kelurahan' => 'required',
            'parkir.parkir_srp_motor' => 'nullable|numeric',
            'parkir.parkir_srp_mobil' => 'nullable|numeric',
            'parkir.parkir_tarif_motor' => 'nullable|numeric',
            'parkir.parkir_tarif_mobil' => 'nullable|numeric',
            'parkir.parkir_durasi_avg' => 'nullable|numeric',
            'parkir.parkir_persentase_pajak' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.motor_situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.motor_avg_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.mobil_avg_kunjungan_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new ParkirService())->update($request, $id);

            DB::commit();

            return redirect('parkir')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new ParkirService())->destroy($id);

            DB::commit();

            return redirect('parkir')->with('info', 'Data berhasil dihapus.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal dihapus. Error: '.$e->getMessage());
        }
    }

    public function import(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'file' => 'required|mimes:xls,xlsx'
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors());
        }

        DB::beginTransaction();

        try {
            $import = (new ParkirService())->import($request);

            DB::commit();

            return redirect('parkir')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $parkir = new ParkirExport($input);

        return Excel::download($parkir, 'Export Parkir.xls');
    }

    public function printTingkatKunjungan(Request $request)
    {
        $data['parkirs'] = (new ParkirService())->print($request);

        $pdf = SnappyPdf::loadView('backend.parkir.print-tingkat-kunjungan', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Parkir.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['parkirs'] = (new ParkirService())->print($request);

        $pdf = SnappyPdf::loadView('backend.parkir.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Parkir.pdf');
    }
}
