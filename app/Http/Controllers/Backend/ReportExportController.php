<?php

namespace App\Http\Controllers\Backend;

use App\Exports\HotelExport;
use App\Exports\RealisasiPendapatanExport;
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
use App\Models\HotelJenisKamar;
use App\Models\HotelTingkatHunianAvg;

class ReportExportController extends Controller
{
    public function index()
    {
        $data['klasifikasis'] = HotelKlasifikasi::all();
        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')->get();

        return view('backend.hotel.index', $data);
    }

    public function show($id)
    {
        $data['hotel'] = Hotel::findOrFail($id)
        ;//->musim()->get();
        /*
        $res=[];
        for ($i=0;$i<2;$i++){
            $_res=[];
            for ($j=0;$j<2;$j++){
                $_res[]=Hotel::all()->hasOne(HotelTingkatHunianAvg::class,'hotel_id', 'id')->where('musim', $i+1)->where('category_hari', $j+1)
                ->latest();
            }
            $res[]=array("categories"=>$_res,"musim"=>($i>0?'weekday':'weekend'));
        }
*/
        
        
        return view('backend.hotel.show', $data);
    }
    
    public function showkamar($hotel_id,$id)
    {
        $data['jenis_kamar'] = HotelJenisKamar::findOrFail($id);
        $data['hotel_id'] =$hotel_id;
       // die(json_encode($data['jenis_kamar']));
        return view('backend.hotel.showkamar', $data);
    }
    
    public function showhunian($hotel_id,$id)
    {
        $data['tingkat_hunian'] = HotelTingkatHunianAvg::findOrFail($id);
        $data['hotel_id'] =$hotel_id;
        // die(json_encode($data['jenis_kamar']));
        return view('backend.hotel.showhunian', $data);
    }
    
    public function kamar($id)
    {
        $data['hotel_id'] = $id;//HotelJenisKamar::where('hotel_id',$id)->get();
        return view('backend.hotel.kamar', $data);
    }
    
    public function hunian($id)
    {
        $data['hotel_id'] = $id;
        //$data['hotelhunian'] = HotelTingkatHunianAvg::where('hotel_id',$id)->get();
        return view('backend.hotel.hunian', $data);
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
        $data['fasilitas'] = array( 1 => 'Restoran', 2 => 'Kolam Renang', 3 => 'Gym',
            4 => 'Bar', 5 => 'Spa', 6 => 'Karaoke', 7 => 'Lainnya' );
        
        $data['status_aktifs'] = StatusAktif::all();

        $data['jenis_kamars'] = [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }

        return view('backend.hotel.form', $data);
    }
    
    public function createkamar($hotel_id)
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('hotelkamar/'.$hotel_id);
        $data['hotel_id'] =$hotel_id;
        return view('backend.hotel.formkamar', $data);
    }
    
    public function createhunian($hotel_id)
    {
        $data['title'] = 'Tambah';
        $data['url'] = url('hotelhunian/'.$hotel_id);
        $data['hotel_id'] =$hotel_id;
        return view('backend.hotel.formhunian', $data);
    }

    public function store(Request $request)
    {
        $input = $request->all();
        //return redirect()->back()->with('error', 'Data gagal ditambah');
        //return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.json_encode($input['hotel']['fasilitas']).'|'.json_encode($input['hotel']['fasilitas_umum']))->withInput($input);
        $validate = Validator::make($input, [
            'hotel.hotel_npwpd' => 'nullable|unique:hotels,hotel_npwpd',
            'hotel.nib_nik_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hotel.hotel_foto' => 'nullable|mimes:png,jpg,jpeg',
            'hotel.hotel_pemilik' => 'required',
            'hotel.hotel_nama' => 'required',
            'hotel.hotel_klasifikasi_id' => 'required',
            'hotel.hotel_alamat' => 'required',
            'hotel.hotel_kelurahan' => 'required',
            'hotel.hotel_jumlah_pegawai' => 'nullable|numeric',
            'hotel.hotel_persentase_pajak' => 'nullable|numeric',
        //    'hotel.hotel_status_tapping_box' => 'required',
        /*
            'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_sepi' => 'nullable|numeric',*/
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
    
    public function storehunian($id,Request $request)
    {
        //die($id." ".json_encode($request));
        $input = $request->all();
        $input['jenis_kamar']=json_decode($input['data'],true);
        unset($input["data"]);
        
        //return redirect()->back()->with('error', 'Data gagal ditambah. Error: '.json_encode($input))->withInput($input);
        
        $validate = Validator::make($input, [
             'tingkat_hunian.musim' => 'nullable|numeric',
             'tingkat_hunian.category_hari' => 'nullable|numeric',
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
            (new HotelService())->storehunian($id,$request);
            
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
        $data['hotel']->fasilitas=explode(' ', $data['hotel']->fasilitas);
        $data['hotel']->fasilitas_umum=explode(' ', $data['hotel']->fasilitas_umum);
        if (Gate::check('manage-hotel') && ($data['hotel']->status_aktif_id != 4)) {
            return redirect()->back()->with('error', 'Data sudah terverifikasi, hubungi admin dinas untuk melakukan perubahan.');
        }

        $data['kecamatans'] = Kecamatan::orderBy('kecamatan', 'asc')
            ->when(auth()->user()->role_id == 2 && @auth()->user()->kecamatan, function($q){
                $q->where('id', auth()->user()->kecamatan_id);
            })->with('kelurahan')->get();
        $data['kelurahans'] = Kelurahan::orderBy('kelurahan', 'asc')->get();
        $data['fasilitas'] = array( 1 => 'Restoran', 2 => 'Kolam Renang', 3 => 'Gym',
            4 => 'Bar', 5 => 'Spa', 6 => 'Karaoke', 7 => 'Lainnya' );
        $data['klasifikasis'] = HotelKlasifikasi::all();
        $data['status_aktifs'] = StatusAktif::all();

       /* $data['jenis_kamars'] = $data['hotel']->jenis_kamar()->count() > 0 ? $data['hotel']->jenis_kamar->toArray() : [0];

        if (@old('jenis_kamar')) {
            $data['jenis_kamars'] = @old('jenis_kamar');
        }
*/
        return view('backend.hotel.form', $data);
    }
    
    public function editkamar($hotel_id,$id)
    {
        $data['title'] = 'Ubah';
        $data['hotel_id'] =$hotel_id;
        $data['url'] = url('hotelkamar/'.$hotel_id.'/'.$id);
        $data['jenis_kamar'] = HotelJenisKamar::findOrFail($id);
        return view('backend.hotel.formkamar', $data);
    }
    
    public function edithunian($hotel_id,$id)
    {
        $data['title'] = 'Ubah';
        $data['hotel_id'] =$hotel_id;
        $data['url'] = url('hotelhunian/'.$hotel_id.'/'.$id);
        $data['tingkat_hunian'] = HotelTingkatHunianAvg::findOrFail($id);
       // die(json_encode($data['tingkat_hunian']));
        return view('backend.hotel.formhunian', $data);
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
        //    'hotel.hotel_status_tapping_box' => 'required',
      /*      'tingkat_hunian.kunjungan_penuh' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_akhir_pekan' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_normal' => 'nullable|numeric',
            'tingkat_hunian.kunjungan_sepi' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_jumlah' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_penuh' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_akhir_pekan' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_normal' => 'nullable|numeric',
            'jenis_kamar.*.hotel_jenis_kamar_avg_sepi' => 'nullable|numeric',*/
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

    public function jenisPajak()
    {
        return jenisPajak();
        $jenisPajak = [
            ['id' => 1, 'code' => '4.1.01.06', 'name' => 'Pajak Hotel'],
            ['id' => 2, 'code' => '4.1.01.07', 'name' => 'Pajak Restoran'],
            ['id' => 3, 'code' => '4.1.01.08', 'name' => 'Pajak Hiburan'],
            ['id' => 4, 'code' => '4.1.01.09', 'name' => 'Pajak Reklame'],
            ['id' => 6, 'code' => '4.1.01.10', 'name' => 'Pajak Penerangan Jalan'],
            ['id' => 7, 'code' => '4.1.01.11', 'name' => 'Pajak Parkir'],
            ['id' => 8, 'code' => '4.1.01.12', 'name' => 'Pajak Air Tanah'],
        ];
        return $jenisPajak;
    }

    public function executeCurlRealisasi($value='')
    {
        $jenisPajak = $this->jenisPajak();

        foreach ($jenisPajak as &$r) {
            $idPajak = $r['id'];
            $curl = curl_init();

            $postData = json_encode([
                "jenis_pajak" => $idPajak,
                "periode" => ""
            ]);

            curl_setopt_array($curl, array(
              CURLOPT_URL => 'http://sipdah.bekasikota.go.id/api/simpokesi/data_realisasi_jenis_pajak',
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS => $postData,
              CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
              ),
            ));

            $response = curl_exec($curl);

            curl_close($curl);
            $r['realisasi'] = $response;
        }

        return $jenisPajak;
    }

    public function target($value='')
    {
        /*hotel*/
        $hotel = DB::table('hotels_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $hiburan = DB::table('hiburans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $restorans = DB::table('restorans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $reklames = DB::table('reklames_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $penerangans = DB::table('penerangans_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $parkirs = DB::table('parkirs_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();
        $airs = DB::table('airs_potensi_log')->selectRaw('SUM(target) as target, tahun')->orderBy('tahun', 'asc')->groupBy('tahun')->get();

        $a =[];
        foreach ($hotel as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[1] = $a;

        $a =[];
        foreach ($restorans as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[2] = $a;

        $a =[];
        foreach ($hiburan as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[3] = $a;

        $a =[];
        foreach ($reklames as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[4] = $a;

        $a =[];
        foreach ($penerangans as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[6] = $a;

        $a =[];
        foreach ($parkirs as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[7] = $a;

        $a =[];
        foreach ($airs as $r) {
            $a[$r->tahun] = $r->target;
        }
        $jenisPajak[8] = $a;

        return $jenisPajak;

    }

    public function realisasiPendapatan(Request $request)
    {
        $input = $request->all();

        $service = new RealisasiPendapatanExport($input);

        $data = [];

        $data['jenisPajak'] = $this->jenisPajak();
        $data['realisasi'] = $this->executeCurlRealisasi();
        $data['target'] = $this->target();
        $data['startYear'] = $input['startYear'];
        $data['endYear'] = $input['endYear'];

        // return view('backend.exports.realisasiPendapatan', $data);

        return Excel::download($service, 'RealisasiPendapatan.xls');
    }
}
