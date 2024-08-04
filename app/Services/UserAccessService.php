<?php

namespace App\Services;

use App\Models\User;
use App\Models\UserAccess;
use Illuminate\Http\Request;

class UserAccessService
{
    public function getUser()
    {
        $roleId = auth()->user()->role_id;
        $user = null;

        if ($roleId == 1) {
            $user = User::where('role_id', '2')->orWhere('role_id', '3')->with('role')->get();
        } elseif($roleId == 2) {
            $user = User::where('role_id', '3')->with('role')->get();
        }

        return $user;
    }

    public function update($data, $id)
    {
        unset($data['_token']);
        unset($data['_method']);

        $addedAccess = [];
        foreach($data['access_id'] as $key => $row){
            $addedAccess[] = [
                'user_id' => $id,
                'access_id' => $row
            ];
        }

        $deletedAccess = UserAccess::where('user_id', $id)->whereNotIn('access_id', $data['access_id']);
        $deletedAccess->delete();

        return UserAccess::upsert($addedAccess, ['user_id', 'access_id'], ['user_id', 'access_id']);
    }
}
