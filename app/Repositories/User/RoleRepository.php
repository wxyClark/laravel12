<?php

namespace App\Repositories\User;


use App\Models\User\Role;
use App\Repositories\BaseRepository;
use App\Repositories\Contracts\BaseRepositoryInterface;

/**
 * Created by PhpStorm
 * Author: wxyClark
 * Date: 2025/11/29
 * Time: 11:29
 * Email: C18666211369@outlook.com
 */
class RoleRepository extends BaseRepository implements BaseRepositoryInterface
{
    protected $inTermFields = [
        'id', 'name', 'status'
    ];
    protected $timeRangeFields = [
        'created_at', 'updated_at'
    ];

    protected function model(): string
    {
        return Role::class;
    }

}
