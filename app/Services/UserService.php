<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Http\Request;

class UserService
{
    public function store($data)
    {
        $data['password'] = bcrypt($data['password']);

        return User::create($data);
    }

    public function update($data, $id)
    {
        if ($data['password'] != null) {
            $data['password'] = bcrypt($data['password']);
        } else {
            unset($data['password']);
            unset($data['password_confirmation']);
        }

        unset($data['_token']);
        unset($data['_method']);

        $user = User::findOrFail($id);

        return $user->update($data);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);

        $user->accesses()->delete();

        return $user->delete();
    }
}
