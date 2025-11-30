<?php

namespace App\Http\Controllers\Dev;


use App\Services\Dev\QueryService;
use Illuminate\Http\Request;


/**
 * Created by PhpStorm
 * Author: wxyClark
 * Date: 2025/11/29
 * Time: 17:50
 * Email: C18666211369@outlook.com
 */
class QueryController
{

    protected $queryService;

    public function __construct(QueryService $queryService)
    {
        $this->queryService = $queryService;
    }

    public function list(Request $request)
    {
        // 验证请求参数
        $validated = $request->validate([
            'sql' => 'required|string|max:2000',
            'page_size' => 'required|integer|min:1|max:200',
            'page' => 'nullable|integer|min:1',
        ]);

        // 设置 page 参数的默认值为 1（如果未提供或验证失败）
        if (empty($validated['page']) || $validated['page'] < 1) {
            $validated['page'] = 1;
        }
        if ($validated['page'] > 100) {
            return [
                'status' => false,
                'msg' => 'The maximum number of pages supported is 100. Please modify the query criteria to obtain the data you need',
            ];
        }

        return $this->queryService->executeSql($validated);
    }

    public function export()
    {
        dd('export');
    }


    public function test(Request $request)
    {
        // 验证请求参数
        $validated = [
            'sql' => ' SELECT * FROM `users` WHERE id > 1 limit 5',
            'page_size' => 2,
            'page' => 2,
        ];

        // 设置 page 参数的默认值为 1（如果未提供或验证失败）
        if (empty($validated['page']) || $validated['page'] < 1) {
            $validated['page'] = 1;
        }
        if ($validated['page'] > 100) {
            return [
                'status' => false,
                'msg' => 'The maximum number of pages supported is 100. Please modify the query criteria to obtain the data you need',
            ];
        }

        return $this->queryService->executeSql($validated);
    }
}
