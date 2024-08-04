<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\UserLog;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    public function username()
    {
        return 'username';
    }

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login(Request $request)
    {
        $input = $request->all();
        $validate = Validator::make($input, [
            'username' => 'required',
            'password' => 'required'
        ]);

        if($validate->fails()){
            return redirect()->back()->with('error', 'Input tidak valid.')->withErrors($validate->errors())->withInput($input);
        }

        $user = User::where('username', $input['username'])
            ->orWhere('email', $input['username']);

        // if username tidak terdaftar
        if($user->count() == 0){
            return redirect()->back()->with('error', 'Username tidak ditemukan.')->withInput($input);
        }

        // if password salah
        if(!Hash::check( $input['password'], $user->first()->password)){
            return redirect()->back()->with('error', 'Password salah.')->withInput($input);
        }

        auth()->login($user->first());

        UserLog::create([
            'user_id' => $user->first()->id
        ]);

        return redirect()->intended('/dashboard');
    }
}
