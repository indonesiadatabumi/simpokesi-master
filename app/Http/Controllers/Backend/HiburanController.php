<?php

namespace App\Http\Controllers\Backend;

use App\Exports\HiburanExport;
use App\Http\Controllers\Controller;
use App\Models\HiburanJenis;
use App\Models\HiburanKategori;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Hiburan;
use App\Models\StatusAktif;
use App\Services\HiburanService;
use Barryvdh\Snappy\Facades\SnappyPdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;

class HiburanController extends Controller
{
    public function checkHiburanExist(Request $request)
    {
        $jenisHiburan = HiburanJenis::all();

        if (empty($request->hiburan_jenis_id)) {
            return false;
        }

        if ($jenisHiburan->where('id', $request->hiburan_jenis_id)->count() == 0) {
            return false;
        }

        return true;
    }

    public function index(Request $request)
    {
        $data['hiburan_jenises'] = HiburanJenis::all();
        if (!$this->checkHiburanExist($request)) {
            return redirect('hiburan?hiburan_jenis_id=' . @$data['hiburan_jenises']->first()->id)->with('error', 'Jenis hiburan tidak ditemukan!');
        }

        $jenisHiburan = HiburanJenis::findOrFail($request->hiburan_jenis_id);
        $data['jenis_hiburan'] =  @$jenisHiburan;

        $data['hiburan_kategories'] = $jenisHiburan->kategori;
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.hiburan.index', $data);
    }

    public function show($id, Request $request)
    {
        $data['hiburan'] = Hiburan::findOrFail($id);

        $request->hiburan_jenis_id = $data['hiburan']->hiburan_jenis_id;
        $jenisHiburan = HiburanJenis::findOrFail($request->hiburan_jenis_id);
        $data['jenis_hiburan'] =  @$jenisHiburan;

        return view('backend.hiburan.show', $data);
    }

    public function create(Request $request)
    {
        $data['hiburan_jenises'] = HiburanJenis::all();
        if (!$this->checkHiburanExist($request)) {
            return redirect('hiburan?hiburan_jenis_id=' . @$data['hiburan_jenises']->first()->id)->with('error', 'Jenis hiburan tidak ditemukan!');
        }

        $jenisHiburan = HiburanJenis::findOrFail($request->hiburan_jenis_id);
        $data['jenis_hiburan'] =  @$jenisHiburan;

        $data['title'] = 'Tambah';
        $data['url'] = url('hiburan');

        $data['jenis_hiburan_tarifs'] = $jenisHiburan->tarif;
        $data['jenis_hiburan_kunjungans'] = $jenisHiburan->kunjungan;
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['hiburan_kategories'] = $jenisHiburan->kategori;
        $data['status_aktifs'] = StatusAktif::all();

        if ($jenisHiburan->hiburan_jenis_have_ruangan) {
            $data['jenis_ruangans'] = [0];

            if (@old('jenis_ruangan')) {
                $data['jenis_ruangans'] = @old('jenis_ruangan');
            }
        }

        return view('backend.hiburan.form', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'hiburan.hiburan_npwpd' => 'nullable|unique:hiburans,hiburan_npwpd',
            'hiburan.hiburan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hiburan.hiburan_pemilik' => 'required',
            'hiburan.hiburan_nama' => 'required',
            'hiburan.hiburan_jenis_id' => 'required',
            'hiburan.hiburan_alamat' => 'required',
            'hiburan.hiburan_kelurahan' => 'required',
            'hiburan.hiburan_tarif' => 'nullable|numeric',
            'hiburan.hiburan_jumlah' => 'nullable|numeric',
            'hiburan.hiburan_durasi' => 'nullable|numeric',
            'hiburan.hiburan_kapasitas' => 'nullable|numeric',
            'hiburan.hiburan_persentase_pajak' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_weekends' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_weekdays' => 'nullable|numeric',
            'tingkat_kunjungan.tingkat_kunjungan_weekends' => 'nullable|numeric',
            'tingkat_kunjungan.tingkat_kunjungan_weekdays' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_kapasitas' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_jumlah' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_avg_weekends' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_avg_weekdays' => 'nullable|numeric',
            'hiburan_tarif_value.*.hiburan_tarif_id' => 'nullable|numeric',
            'hiburan_tarif_value.*.hiburan_tarif_value' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_id' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_weekends_value' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_weekdays_value' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new HiburanService())->store($request);

            DB::commit();

            return redirect('hiburan?hiburan_jenis_id=' . $input['hiburan']['hiburan_jenis_id'])->with('info', 'Data berhasil ditambah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function edit($id, Request $request)
    {
        $data['hiburan'] = Hiburan::with(['tarif', 'tarif.hiburan_tarif'])->findOrFail($id);
        $data['hiburan_jenises'] = HiburanJenis::all();

        $request->hiburan_jenis_id = $data['hiburan']->hiburan_jenis_id;
        if (!$this->checkHiburanExist($request)) {
            return redirect('hiburan?hiburan_jenis_id=' . @$data['hiburan_jenises']->first()->id)->with('error', 'Jenis hiburan tidak ditemukan!');
        }

        $data['title'] = 'Ubah';
        $data['url'] = url('hiburan/'.$id);

        if (Gate::check('manage-hiburan') && ($data['hiburan']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }
        
        $jenisHiburan = HiburanJenis::findOrFail($request->hiburan_jenis_id);
        $data['jenis_hiburan'] =  @$jenisHiburan;

        $data['jenis_hiburan_tarifs'] = $data['hiburan']->tarif->count() > 0 ? $data['hiburan']->tarif : $jenisHiburan->tarif;
        $data['jenis_hiburan_kunjungans'] = $data['hiburan']->kunjungan->count() > 0 ? $data['hiburan']->kunjungan : $jenisHiburan->kunjungan;
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['hiburan_kategories'] = $jenisHiburan->kategori;
        $data['status_aktifs'] = StatusAktif::all();

        if ($jenisHiburan->hiburan_jenis_have_ruangan) {
            $data['jenis_ruangans'] = $data['hiburan']->jenis_ruangan()->count() > 0 ? $data['hiburan']->jenis_ruangan->toArray() : [0];

            if (@old('jenis_ruangan')) {
                $data['jenis_ruangans'] = @old('jenis_ruangan');
            }
        }

        return view('backend.hiburan.form', $data);
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();

        $validate = Validator::make($input, [
            'hiburan.hiburan_npwpd' => 'nullable|unique:hiburans,hiburan_npwpd,'.$id.',id,deleted_at,NULL',
            'hiburan.hiburan_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hiburan.hiburan_pemilik' => 'required',
            'hiburan.hiburan_nama' => 'required',
            'hiburan.hiburan_jenis_id' => 'required',
            'hiburan.hiburan_alamat' => 'required',
            'hiburan.hiburan_kelurahan' => 'required',
            'hiburan.hiburan_jumlah' => 'nullable|numeric',
            'hiburan.hiburan_durasi' => 'nullable|numeric',
            'hiburan.hiburan_kapasitas' => 'nullable|numeric',
            'hiburan.hiburan_persentase_pajak' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_weekends' => 'nullable|numeric',
            'tingkat_kunjungan.situasi_kunjungan_weekdays' => 'nullable|numeric',
            'tingkat_kunjungan.tingkat_kunjungan_weekends' => 'nullable|numeric',
            'tingkat_kunjungan.tingkat_kunjungan_weekdays' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_jumlah' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_avg_weekends' => 'nullable|numeric',
            'jenis_ruangan.*.hiburan_jenis_ruangan_avg_weekdays' => 'nullable|numeric',
            'hiburan_tarif_value.*.hiburan_tarif_id' => 'nullable|numeric',
            'hiburan_tarif_value.*.hiburan_tarif_value' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_id' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_weekends_value' => 'nullable|numeric',
            'hiburan_kunjungan_value.*.hiburan_kunjungan_weekdays_value' => 'nullable|numeric',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new HiburanService())->update($request, $id);

            DB::commit();

            return redirect('hiburan?hiburan_jenis_id=' . $input['hiburan']['hiburan_jenis_id'])->with('info', 'Data berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diubah. Error: '.$e->getMessage())->withInput($input);
        }
    }

    public function destroy(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            $hiburanJenisId = (new HiburanService())->destroy($id);

            DB::commit();

            return redirect('hiburan?hiburan_jenis_id=' . $hiburanJenisId)->with('info', 'Data berhasil dihapus.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal dihapus. Error: '.$e->getMessage());
        }
    }

    public function settingPersentase(Request $request)
    {
        $input = $request->all();
        
        $validate = Validator::make($input, [
            'hiburan.*.hiburan_jenis_persentase' => 'required',
            'kategori.*.hiburan_kategori_persentase' => 'required_with:kategori',
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        DB::beginTransaction();

        try {
            (new HiburanService())->settingPersentase($request);

            DB::commit();

            return redirect()->back()->with('info', 'Data persentase berhasil diubah.');
        } catch(\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal dihapus. Error: '.$e->getMessage());
        }
        dd($input);
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
            $import = (new HiburanService())->import($request);

            DB::commit();

            return redirect('hiburan')->with('info', 'Data berhasil diimport.')->with('failures', $import->failures());
        } catch(ValidationException $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Data gagal diimport.')->with('failures', $e->failures());
        }
    }

    public function export(Request $request)
    {
        $input = $request->all();

        $jenisHiburan = HiburanJenis::findOrFail($input['hiburan_jenis_id']);

        $hiburan = new HiburanExport($input, $jenisHiburan);

        return Excel::download($hiburan, 'Export ' . $jenisHiburan->hiburan_jenis_deskripsi . '.xls');
    }

    public function printTingkatHunian(Request $request)
    {
        $data['hiburans'] = (new HiburanService())->print($request);

        $pdf = SnappyPdf::loadView('backend.hiburan.print-tingkat-kunjungan', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Hiburan.pdf');
    }

    public function printPotensiPajak(Request $request)
    {
        $data['hiburans'] = (new HiburanService())->print($request);
        $data['jenis_hiburan'] = HiburanJenis::findOrFail($request->hiburan_jenis_id);

        $data['col'] = [
            'hiburan' => 4,
            'ruangan' => 3,
        ];

        if (@$data['jenis_hiburan']->hiburan_jenis_jumlah_label)
            $data['col']['hiburan'] += 1;
        
        if (@$data['jenis_hiburan']->hiburan_jenis_kapasitas_label && !$data['jenis_hiburan']->hiburan_jenis_have_ruangan)
            $data['col']['hiburan'] += 1;

        if (!$data['jenis_hiburan']->hiburan_jenis_have_ruangan && !$data['jenis_hiburan']->hiburan_jenis_have_multiple_tarif)
            $data['col']['hiburan'] += 1;

        if (!$data['jenis_hiburan']->hiburan_jenis_have_ruangan && $data['jenis_hiburan']->hiburan_jenis_have_multiple_tarif)
            $data['col']['hiburan'] += $data['jenis_hiburan']->tarif->count();

        if (@$data['jenis_hiburan']->hiburan_jenis_kapasitas_label && $data['jenis_hiburan']->hiburan_jenis_have_ruangan)
            $data['col']['ruangan'] += 1;

        if ($data['jenis_hiburan']->hiburan_jenis_have_ruangan) {
            $data['col']['hiburan'] += (4 + $data['col']['ruangan']);
        } else {
            $data['col']['hiburan'] += 3;

            if (!@$data['jenis_hiburan']->hiburan_jenis_have_multiple_kunjungan) {
                $data['col']['hiburan'] += 2;
            } else {
                $data['col']['hiburan'] += ($data['jenis_hiburan']->kunjungan->count() * 2);
            }
        }

        $pdf = SnappyPdf::loadView('backend.hiburan.print-potensi-pajak', $data)
            ->setPaper('a4')
            ->setOrientation('landscape')
            ->setOption('margin-bottom', 25)
            ->setOption('footer-font-size', 6)
            ->setOption('footer-spacing', 1)
            ->setOption('footer-right', 'Halaman [page] dari [topage]')
            ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
        return $pdf->stream('Rekapitulasi Potensi Pajak Hiburan.pdf');
    }
}
