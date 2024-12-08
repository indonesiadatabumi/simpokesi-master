<?php

namespace App\Http\Controllers\Backend;

use App\Exports\ParkirExport;
use App\Http\Controllers\Controller;
use App\Models\ParkirKlasifikasi;
use App\Models\Kecamatan;
use App\Models\Kelurahan;
use App\Models\Parkir;
use App\Models\StatusAktif;
use App\Models\Hiburan;
use App\Models\Hotel;
use App\Models\Restoran;
use App\Models\Reklame;
use App\Models\Air;
use App\Models\Penerangan;
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

class NotaDinasContorller extends Controller
{
    public function index()
    {
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.notadinas.index', $data);
    }

    public function printPdf(Request $request)
    {
        // $data['restorans'] = (new RestoranService())->print($request);
        // $data['tipe'] = str_replace('_','/',$request->tipe);
        // $view = $request->tipe != 'online' ? 'print-potensi-pajak' : 'print-potensi-pajak-online';
        // return view('backend.restoran.' . $view, $data);

        $input = $request->all();
        $wilayah = $input['wilayah'];
        $tanggalSurat = $input['tanggalSurat'];
        $startDate = $input['startDate'];
        $endDate = $input['endDate'];
        $wilayah = Kecamatan::where('kecamatan', $wilayah)->first();
        $data = [
            'tipe' => 'UPTD PAJAK DAN RETRIBUSI DAERAH WILAYAH BANTARGEBANG',
            'startDate' => Carbon::parse($startDate)->translatedFormat('d F Y'),
            'endDate' => Carbon::parse($endDate)->translatedFormat('d F Y'),
            'tanggalSurat' => Carbon::parse($tanggalSurat)->translatedFormat('d F Y'),
            'wilayah' => $wilayah
        ];
        
        $data['hotels'] = Hotel::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakHotel')){
            $ids = $input['pajakHotel'];
            $data['hotels'] = Hotel::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['hiburans'] = Hiburan::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakHiburan')){
            $ids = $input['pajakHiburan'];
            $data['hiburans'] = Hiburan::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['reklames'] = Reklame::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakReklame')){
            $ids = $input['pajakReklame'];
            $data['reklames'] = Reklame::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['parkirs'] = Parkir::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakParkir')){
            $ids = $input['pajakParkir'];
            $data['parkirs'] = Parkir::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['airs'] = Air::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakTanahAir')){
            $ids = $input['pajakTanahAir'];
            $data['airs'] = Air::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['penerangans'] = Penerangan::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakPju')){
            $ids = $input['pajakPju'];
            $data['penerangans'] = Penerangan::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }

        $data['restorans'] = Restoran::whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        if($request->input('pajakRestoran')){
            $ids = $input['pajakRestoran'];
            $data['restorans'] = Restoran::whereIn('id', $ids)->whereBetween('updated_at', [$input['startDate'], $input['endDate']])->get();
        }
        
        // return view('backend.notadinas.print-pdf', $data);

        $pdf = SnappyPdf::loadView('backend.notadinas.print-pdf', $data)
            ->setPaper('a4')
            // ->setOrientation('portait')
            ->setOption('margin-bottom', 25)
            // ->setOption('footer-font-size', 6)
            // ->setOption('footer-spacing', 1)
            // ->setOption('footer-right', 'Halaman [page] dari [topage]')
            // ->setOption('footer-left', 'Dokumen dibuat dari Si Mpo Kesi pada '.Carbon::now()->isoFormat('D MMMM Y').', '.date('h:i:s'));
            ;
        return $pdf->stream('Nota Dinas.pdf');
    }

    public function getDataByJenis(Request $request, $jenis_pajak)
    {
        $input = $request->all();
        if($jenis_pajak == 'hiburan'){
            $query = Hiburan::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('hiburan_nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('hiburan_kecamatan', $request->wilayah);
            }
            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);
            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hiburan = $query->get(['id', 'hiburan_nama']);

            return response()->json($hiburan);
        }

        if($jenis_pajak == 'hotel'){
            $query = Hotel::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('hotel_nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('hotel_kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'hotel_nama']);

            return response()->json($hotel);
        }

        if($jenis_pajak == 'restoran'){
            $query = Restoran::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('restoran_nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('restoran_kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'restoran_nama']);

            return response()->json($hotel);
        }

        if($jenis_pajak == 'reklame'){
            $query = Reklame::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('reklame_nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('reklame_kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'reklame_nama']);

            return response()->json($hotel);
        }

        if($jenis_pajak == 'parkir'){
            $query = Parkir::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('parkir_nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('parkir_kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'parkir_nama']);

            return response()->json($hotel);
        }

        if($jenis_pajak == 'air'){
            $query = Air::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'nama']);

            return response()->json($hotel);
        }

        if($jenis_pajak == 'pju'){
            $query = Penerangan::query();

            // Jika ada query pencarian, filter berdasarkan nama
            if ($request->has('q') && !empty($request->q)) {
                $query->where('nama', 'LIKE', '%' . $request->q . '%');
            }

            // Jika ada parameter wilayah, filter berdasarkan wilayah
            if ($request->has('wilayah')) {
                $query->where('kecamatan', $request->wilayah);
            }

            $query->whereBetween('updated_at', [$input['startDate'], $input['endDate']]);

            // Ambil data yang dibutuhkan (disesuaikan dengan limit dan pagination)
            $hotel = $query->get(['id', 'nama']);

            return response()->json($hotel);
        }
    }
}
