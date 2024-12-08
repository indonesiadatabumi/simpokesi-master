<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Air;
use App\Models\AirKlasifikasi; 
use App\Models\StatusAktif;
use App\Services\AirService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;

class AirController extends Controller
{
    public function index()
    {
        $data['klasifikasis'] = AirKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.air.index', $data);
    }

    public function show($id)
    {
        $data['air'] = Air::findOrFail($id);

        return view('backend.air.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('air');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = AirKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        
        return view('backend.air.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'air.air_npwpd' => 'nullable|unique:airs,air_npwpd',
            'air.air_foto' => 'nullable|mimes:png,jpg,jpeg',
            'air.air_pemilik' => 'required',
            'air.air_nama' => 'required',
            'air.air_klasifikasi_id' => 'required',
            'air.air_alamat' => 'required',
            'air.air_kelurahan' => 'required',
            'air.air_jumlah_pegawai' => 'nullable|numeric',
            'air.air_persentase_pajak' => 'nullable|numeric',
            'air.air_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new AirService())->store($request);

            DB::commit();

            return redirect('air')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('air/'.$id);
        $data['air'] = Air::findOrFail($id);

        if (Gate::check('manage-air') && ($data['air']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }
        
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
        ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
            $q->where('id', auth()->user()->kecamatan_id);
        })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        
        $data['klasifikasis'] = AirKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();
        return view('backend.air.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'air.air_npwpd' => 'nullable|unique:airs,air_npwpd,'.$id.',id,deleted_at,NULL',
            'air.air_foto' => 'nullable|mimes:png,jpg,jpeg',
            'air.air_pemilik' => 'required',
            'air.air_nama' => 'required',
            'air.air_klasifikasi_id' => 'required',
            'air.air_alamat' => 'required',
            'air.air_kelurahan' => 'required',
            'air.air_jumlah_pegawai' => 'nullable|numeric',
            'air.air_persentase_pajak' => 'nullable|numeric',
            'air.air_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.air_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new AirService())->update($request, $id);

            DB::commit();

            return redirect('air')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new AirService())->destroy($id);

            DB::commit();

            return redirect('air')->with('info', 'Data berhasil dihapus.');
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
            $import = (new AirService())->import($request);

            DB::commit();

            return redirect('air')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

   //     $air = new AirExport($input);

        return Excel::download($air, 'Export Air.xls');
    }

    public function printTingkatHunian(Request $request)
    {
        $data['airs'] = (new AirService())->print($request);

        $pdf = SnappyPdf::loadView('backend.air.print-tingkat-hunian', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Air.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['airs'] = (new AirService())->print($request);

        $pdf = SnappyPdf::loadView('backend.air.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Air.pdf');
    }
}
