<?php

namespace App\Http\Controllers\Backend;

use App\Exports\HotelExport;
use App\Http\Controllers\Controller;
use App\Models\HotelKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Hotel;
use App\Models\StatusAktif;
use App\Services\HotelService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;

class HotelController extends Controller
{
    public function index()
    {
        $data['klasifikasis'] = HotelKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.hotel.index', $data);
    }

    public function show($id)
    {
        $data['hotel'] = Hotel::findOrFail($id);

        return view('backend.hotel.show', $data);
    }

    public function create()
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('hotel');

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['klasifikasis'] = HotelKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.hotel.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'hotel.hotel_npwpd' => 'nullable|unique:hotels,hotel_npwpd',
            'hotel.hotel_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hotel.hotel_pemilik' => 'required',
            'hotel.hotel_nama' => 'required',
            'hotel.hotel_klasifikasi_id' => 'required',
            'hotel.hotel_alamat' => 'required',
            'hotel.hotel_kelurahan' => 'required',
            'hotel.hotel_jumlah_pegawai' => 'nullable|numeric',
            'hotel.hotel_persentase_pajak' => 'nullable|numeric',
            'hotel.hotel_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new HotelService())->store($request);

            DB::commit();

            return redirect('hotel')->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id)
    {
        $data['title'] = 'Ubah';
        $data['url'] = url('hotel/'.$id);
        $data['hotel'] = Hotel::findOrFail($id);

        if (Gate::check('manage-hotel') && ($data['hotel']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['klasifikasis'] = HotelKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = $data['hotel']->jenis_kamar()->count() > 0 ? $data['hotel']->jenis_kamar->toArray() : [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.hotel.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'hotel.hotel_npwpd' => 'nullable|unique:hotels,hotel_npwpd,'.$id.',id,deleted_at,NULL',
            'hotel.hotel_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hotel.hotel_pemilik' => 'required',
            'hotel.hotel_nama' => 'required',
            'hotel.hotel_klasifikasi_id' => 'required',
            'hotel.hotel_alamat' => 'required',
            'hotel.hotel_kelurahan' => 'required',
            'hotel.hotel_jumlah_pegawai' => 'nullable|numeric',
            'hotel.hotel_persentase_pajak' => 'nullable|numeric',
            'hotel.hotel_status_tapping_box' => 'required',
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_sepi' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new HotelService())->update($request, $id);

            DB::commit();

            return redirect('hotel')->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            (new HotelService())->destroy($id);

            DB::commit();

            return redirect('hotel')->with('info', 'Data berhasil dihapus.');
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
            $import = (new HotelService())->import($request);

            DB::commit();

            return redirect('hotel')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $hotel = new HotelExport($input);

        return Excel::download($hotel, 'Export Hotel.xls');
    }

    public function printTingkatHunian(Request $request)
    {
        $data['hotels'] = (new HotelService())->print($request);

        $pdf = SnappyPdf::loadView('backend.hotel.print-tingkat-hunian', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Hotel.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['hotels'] = (new HotelService())->print($request);

        $pdf = SnappyPdf::loadView('backend.hotel.print-potensi-pajak', $data)
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
