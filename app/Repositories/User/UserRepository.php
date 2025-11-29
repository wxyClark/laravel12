<?php

namespace App\Repositories\User;

use App\Models\User\user;
use App\Repositories\BaseRepository;
use App\Repositories\Contracts\BaseRepositoryInterface;

/**
 * Created by PhpStorm
 * Author: wxyClark
 * Date: 2025/11/29
 * Time: 11:29
 * Email: C18666211369@outlook.com
 */
class UserRepository extends BaseRepository implements BaseRepositoryInterface
{
    protected $inTermFields = [
        'id', 'name', 'status', 'email'
    ];
    protected $timeRangeFields = [
        'created_at', 'updated_at'
    ];

    protected function model(): string
    {
        return User::class;
    }

}
