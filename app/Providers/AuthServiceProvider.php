<?php

namespace App\Providers;

use App\Models\UserAccess;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        Gate::define('admin', function ($user) {
            return $user->role_id == 1;
        });

        Gate::define('surveyor', function ($user) {
            return $user->role_id == 2;
        });

        Gate::define('pimpinan', function ($user) {
            return $user->role_id == 3;
        });

        Gate::define('user-access', function ($user) {
            return ($user->role_id == 1) || ($user->role_id == 2);
        });

        // OPERATOR ACCESS
        Gate::define('manage-hotel', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_HOTEL');
            })->count() > 0);
        });

        Gate::define('manage-restoran', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RESTORAN');
            })->count() > 0);
        });

        Gate::define('manage-restoran-cwp', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RESTORAN_CWP');
            })->count() > 0);
        });

        Gate::define('manage-parkir', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_PARKIR');
            })->count() > 0);
        });

        Gate::define('manage-kostan', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_KOSTAN');
            })->count() > 0);
        });

        Gate::define('manage-rusun', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RUSUN');
            })->count() > 0);
        });

        Gate::define('manage-reklame', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_REKLAME');
            })->count() > 0);
        });

        Gate::define('manage-hiburan', function ($user) {
            return $user->role_id == 2 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_HIBURAN');
            })->count() > 0);
        });

        // VIEWER ACCESS
        Gate::define('view-hotel', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_HOTEL');
            })->count() > 0);
        });

        Gate::define('view-restoran', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RESTORAN');
            })->count() > 0);
        });

        Gate::define('view-restoran-cwp', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RESTORAN_CWP');
            })->count() > 0);
        });

        Gate::define('view-parkir', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_PARKIR');
            })->count() > 0);
        });

        Gate::define('view-kostan', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_KOSTAN');
            })->count() > 0);
        });

        Gate::define('view-rusun', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_RUSUN');
            })->count() > 0);
        });

        Gate::define('view-reklame', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_REKLAME');
            })->count() > 0);
        });

        Gate::define('view-hiburan', function ($user) {
            return $user->role_id == 3 && (UserAccess::where('user_id', $user->id)->whereHas('access', function($q) {
                $q->where('access_code', 'ACCESS_HIBURAN');
            })->count() > 0);
        });
    }
}
