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
use Illuminate\Support\Facades\Storage;

class FileController extends Controller
{
    public function index()
    {
        // Get all files in the directory
        $files = Storage::files('public/formulir-pendataan'); // Replace 'your-folder' with your actual folder name
        // dd($files);

        // Extract file names without the 'public/' prefix
        $fileNames = collect($files)->map(function ($file) {
            return basename($file);
        });

        return view('backend.other.formulir-pendaftaran', compact('fileNames'));
    }

    // Handle file download
    public function download($fileName)
    {
        // Build the file path
        $filePath = "public/formulir-pendataan/$fileName"; // Replace 'your-folder' with your actual folder name

        // Check if the file exists
        if (!Storage::exists($filePath)) {
            abort(404, "File not found.");
        }

        // Return the file as a download
        return Storage::download($filePath, $fileName);
    }

}
