<?php

namespace App\Http\Controllers\Backend;

use App\Exports\RestoranExport;
use App\Http\Controllers\Controller;
use App\Models\RestoranKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Restoran;
use App\Models\StatusAktif;
use App\Services\RestoranService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use ZanySoft\Zip\Zip;

class RestoranController extends Controller
{
    public function index()
    {
        $tipe = ['online', 'online/offline', 'offline'];

        if (empty(request()->tipe)) {
           return redirect('restoran?tipe=online/offline'); 
        } else if(!in_array(request()->tipe, $tipe)) {
            return redirect('restoran?tipe=online/offline'); 
        }

        $data['klasifikasis'] = RestoranKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.restoran.index', $data);
    }

    public function show($id)
    {
        $data['restoran'] = Restoran::findOrFail($id);

        if ($data['restoran']->restoran_tipe === 'online') {
            $restoranVisitAvg = 'per Pesanan';
            $restoranVisitText = 'Jumlah Pesanan';
            $restoranVisitTextPrefix = 'Pesanan';
        } else if ($data['restoran']->restoran_tipe === 'offline') {
            $restoranVisitAvg = 'per Sekali Datang';
            $restoranVisitText = 'Kunjungan Tamu';
            $restoranVisitTextPrefix = 'Orang';
        } else {
            $restoranVisitAvg = 'per Pesanan / per Sekali Datang';
            $restoranVisitText = 'Jumlah Pesanan / Kunjungan Tamu';
            $restoranVisitTextPrefix = 'Orang atau Pesanan';
        }

        $data['restoranVisitAvg'] = $restoranVisitAvg;
        $data['restoranVisitText'] = $restoranVisitText;
        $data['restoranVisitTextPrefix'] = $restoranVisitTextPrefix;

        return view('backend.restoran.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('restoran');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['klasifikasis'] = RestoranKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();

        return view('backend.restoran.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'restoran.restoran_npwpd' => 'nullable|unique:restorans,restoran_npwpd',
            'restoran.restoran_foto' => 'nullable|mimes:png,jpg,jpeg',
            'restoran.restoran_pemilik' => 'required',
            'restoran.restoran_tipe' => 'required',
            'restoran.restoran_nama' => 'required',
            'restoran.restoran_klasifikasi_id' => 'required',
            'restoran.restoran_alamat' => 'required',
            'restoran.restoran_kelurahan' => 'required',
            'restoran.restoran_jumlah_pegawai' => 'nullable|numeric',
            'restoran.restoran_kapasitas_kursi' => 'nullable|numeric',
            'restoran.restoran_pengeluaran_avg' => 'nullable|numeric',
            'restoran.restoran_persentase_pajak' => 'nullable|numeric',
            'restoran.restoran_status_tapping_box' => 'required',
            'tingkat_kunjungan.situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new RestoranService())->store($request);

            DB::commit();

            return redirect('restoran?tipe='.$input['restoran']['restoran_tipe'])->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('restoran/'.$id);
        $data['restoran'] = Restoran::findOrFail($id);

        if (Gate::check('manage-restoran') && ($data['restoran']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['klasifikasis'] = RestoranKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();

        return view('backend.restoran.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'restoran.restoran_npwpd' => 'nullable|unique:restorans,restoran_npwpd,'.$id.',id,deleted_at,NULL',
            'restoran.restoran_foto' => 'nullable|mimes:png,jpg,jpeg',
            'restoran.restoran_pemilik' => 'required',
            'restoran.restoran_tipe' => 'required',
            'restoran.restoran_nama' => 'required',
            'restoran.restoran_klasifikasi_id' => 'required',
            'restoran.restoran_alamat' => 'required',
            'restoran.restoran_kelurahan' => 'required',
            'restoran.restoran_jumlah_pegawai' => 'nullable|numeric',
            'restoran.restoran_kapasitas_kursi' => 'nullable|numeric',
            'restoran.restoran_pengeluaran_avg' => 'nullable|numeric',
            'restoran.restoran_persentase_pajak' => 'nullable|numeric',
            'restoran.restoran_status_tapping_box' => 'required',
            'tingkat_kunjungan.situasi_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_sepi' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_ramai' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_normal' => 'nullable|numeric',
            'tingkat_kunjungan.avg_kunjungan_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new RestoranService())->update($request, $id);

            DB::commit();

            return redirect('restoran?tipe='.$input['restoran']['restoran_tipe'])->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new RestoranService())->destroy($id);

            DB::commit();

            return redirect()->back()->with('info', 'Data berhasil dihapus.');
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
            'restoran_tipe' => 'required',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors());
        }

        DB::beginTransaction();

        try {
            $import = (new RestoranService())->import($request);

            DB::commit();

            return redirect('restoran?tipe='.$input['restoran_tipe'])->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $restoran = new RestoranExport($input);

        return Excel::download($restoran, 'Export Restoran '.str_replace('_', ' & ', $input['tipe']).'.xls');
    }

    public function printTingkatKunjungan(Request $request)
    {
        $data['restorans'] = (new RestoranService())->print($request);

        $pdf = SnappyPdf::loadView('backend.restoran.print-tingkat-kunjungan', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Restoran.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['restorans'] = (new RestoranService())->print($request);
        $data['tipe'] = str_replace('_','/',$request->tipe);
        $view = $request->tipe != 'online' ? 'print-potensi-pajak' : 'print-potensi-pajak-online';

        $pdf = SnappyPdf::loadView('backend.restoran.' . $view, $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Restoran '.str_replace('_', ' & ', $request->tipe).'.pdf');
    }
}
