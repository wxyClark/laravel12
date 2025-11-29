<?php

namespace App\Services\Dev;


use App\Repositories\Dev\QueryRepository;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;

/**
 * Created by PhpStorm
 * Author: wxyClark
 * Date: 2025/11/29
 * Time: 16:21
 * Email: C18666211369@outlook.com
 */
class QueryService
{

    /** @var QueryRepository */
    protected $queryRepository;

    public function __construct(
        QueryRepository $queryRepository
    ) {
        $this->queryRepository = $queryRepository;
    }

    public function executeSql($params)
    {
        try {
            $sql = trim($params['sql']);
            // 安全检查：确保只执行SELECT语句
            if (!$this->isSafeSelectQuery($sql)) {
                throw new \InvalidArgumentException('Only "SELECT" query is supported.');
            }

            //  TODO  怎样解析sql，替换或加入分页数据

            // 执行查询（使用只读连接增强安全性）
            $results = DB::connection('read-only')->select(DB::raw($sql));

        } catch (QueryException $e) {
            // 捕获数据库查询异常
            $error = "SQL执行错误: " . $e->getMessage();
        } catch (\InvalidArgumentException $e) {
            // 捕获自定义验证异常
            $error = $e->getMessage();
        } catch (\Exception $e) {
            // 捕获其他异常
            $error = "系统错误: " . $e->getMessage();
        }

        if (isset($data)) {
            $data['status'] = true;
            return $data;
        } else {
            return [
                'status' => false,
                'error' => $error,
            ];
        }
    }

    public function isSafeSelectQuery($sql)
    {
        // 移除SQL注释以防止隐藏危险操作
        $sql = $this->removeSqlComments($sql);

        // 转换为大写以便统一检查
        $sql = strtoupper(trim($sql));

        // 检查是否以SELECT开头
        if (strpos($sql, 'SELECT') !== 0) {
            return false;
        }

        // 检查是否包含危险关键字,防止多语句执行
        $dangerousPatterns = [
            '/\b(DROP|DELETE|UPDATE|INSERT|ALTER|TRUNCATE|RENAME|CREATE|GRANT|REVOKE)\b/i',
            '/\b(EXEC|CALL|DECLARE|FETCH|MERGE|HANDLER|REPLACE)\b/i',
            '/\b(LOAD\s+DATA|LOCK\s+TABLES|UNLOCK\s+TABLES)\b/i',
            '/;\s*[A-Za-z]/'
        ];
        foreach ($dangerousPatterns as $pattern) {
            if (preg_match($pattern, $sql)) {
                return false;
            }
        }

        return true;
    }

    /**
     * 移除SQL注释
     * @param $sql
     * @return array|string|string[]|null
     * @author wxyClark
     * @create 2025/11/29 22:19
     *
     * @version 1.0
     */
    private function removeSqlComments($sql)
    {
        // 移除/* */风格的注释
        $sql = preg_replace('/\/\*[\s\S]*?\*\//', '', $sql);

        // 移除--风格的注释
        $sql = preg_replace('/--.*$/m', '', $sql);

        // 移除#风格的注释
        $sql = preg_replace('/#.*$/m', '', $sql);

        return $sql;
    }
}
