<?php

namespace App\Http\Controllers\Dev;


use App\Services\Dev\QueryService;

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
        $params = $request->input();

        // 验证请求参数
        $validated = $request->validate([
            'sql' => 'required|string', // sql 参数必须存在且为字符串类型
            'page_size' => 'required|integer|min:1|max:200',  // page_size 参数必须存在
            'page' => 'nullable|integer|min:1', // page 参数可选，为整数且至少为1
        ]);

        // 设置 page 参数的默认值为 1（如果未提供或验证失败）
        $page = $validated['page'] ?? 1;

        // 获取经过验证的参数
        $sqlString = $validated['sql'];
        $pageSize = $validated['page_size'];

        $list = $this->queryService->executeSql($params);
    }

    public function export()
    {
        dd('export');
    }
}
