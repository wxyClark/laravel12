<?php

namespace App\Services\Dev;


use App\Enums\ErrorCodeEnums;
use App\Repositories\Dev\QueryRepository;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

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

    //  禁止访问的表的
    private $exceptTables = [
        'users', 'sessions', 'migrations', 'personal_access_tokens', 'password_reset_tokens'
    ];

    // 禁止的关键字和操作
    private $dangerousKeywords = [
        'INSERT', 'UPDATE', 'DELETE', 'DROP', 'ALTER', 'CREATE', 'TRUNCATE',
        'EXEC', 'EXECUTE', 'GRANT', 'REVOKE', 'MERGE', 'CALL', 'DESCRIBE',
        'SHOW', 'USE', 'SET', 'BEGIN', 'COMMIT', 'ROLLBACK', 'SAVEPOINT',
        'LOCK', 'UNLOCK', 'LOAD', 'COPY', 'REPLACE', 'DELIMITER'
    ];

    public function __construct(
        QueryRepository $queryRepository
    ) {
        $this->queryRepository = $queryRepository;
    }

    /**
     * 执行SQL查询，强制分页
     * @param $params
     * @return array
     * @author wxyClark
     * @create 2025/11/30 11:42
     *
     * @version 1.0
     */
    public function executeSql($params)
    {
        try {
            $sql = strtoupper(trim($params['sql']));
            // 安全检查：确保只执行SELECT语句
            $result = $this->checkQueryIsSafeSelect($sql);
            if (!$result['status']) {
                return $result;
            }

            //  检查表名是否运行访问
            $tables = $this->extractTables($sql);
            $intersect = array_intersect($this->exceptTables, $tables);

            if ($intersect) {
                return [
                    'status' => false,
                    'msg' => 'The following data table does not support access :'.implode(', ', $intersect),
                ];
            }

            $pdo = DB::connection()->getPdo();

            $totalSql = "SELECT COUNT(1) as total FROM ({$sql}) as a;";
            $total = $pdo->query($totalSql)->fetchColumn(0);
            if (empty($total)) {
                return [
                    'status' => true,
                    'list' => [],
                    'total' => $total,
                    'page' => $params['page'],
                    'page_size' => $params['page_size'],
                ];
            }

            $offset = $params['page_size'] * ($params['page'] - 1);
            $paginationSql = "SELECT * FROM ({$sql}) as a LIMIT {$offset}, {$params['page_size']};";

            $list = $pdo->query($paginationSql)->fetchAll(\PDO::FETCH_OBJ);

            $data = [
                'status' => true,
                'list' => $list,
                'total' => $total,
                'page' => $params['page'],
                'page_size' => $params['page_size'],
            ];

        } catch (QueryException $e) {
            // 捕获数据库查询异常
            $error = "SQL execution error: " . $e->getMessage();
        } catch (\Exception $e) {
            // 捕获其他异常
            $error = "System Error: " . $e->getMessage();
        }
        return $data ?? [
            'status' => false,
            'error' => $error ?? '',
        ];
    }

    /**
     * 校验SQL是否安全
     * @param $sql
     * @return array
     * @author wxyClark
     * @create 2025/11/30 11:00
     *
     * @version 1.0
     */
    public function checkQueryIsSafeSelect($sql)
    {
        // 移除SQL注释以防止隐藏危险操作
        $sql = $this->removeSqlComments($sql);

        // 转换为大写以便统一检查
        $sql = strtoupper(trim($sql));

        // 检查是否以SELECT开头
        if (strpos($sql, 'SELECT') !== 0) {
            return [
                'status' => false,
                'msg' => '"SELECT" keyword is not found!',
            ];
        }

        // 检查是否包含危险关键字
        foreach ($this->dangerousKeywords as $keyword) {
            // 使用单词边界匹配，避免误判
            if (preg_match('/\b' . $keyword . '\b/i', $sql)) {
                return [
                    'status' => false,
                    'msg' => 'Sql statement has not supported keyword: '.$keyword.'! Only supports "SELECT" statements.',
                ];
            }
        }

        // 检查是否有分号连接多个查询
        if (substr_count($sql, ';') > 1) {
            return [
                'status' => false,
                'msg' => 'More than 1 sql statement!',
            ];
        }

        return [
            'status' => true,
            'msg' => '',
        ];
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

    /**
     * 解析表名
     * @param $sql
     * @return array
     * @author wxyClark
     * @create 2025/11/30 09:22
     *
     * @version 1.0
     */
    private function extractTables($sql)
    {
        $tables = [];
        $sql = strtoupper($sql);

        //  TODO  校验有问题，拟引入组件

        // 简单的表名提取（适用于大多数 SELECT 语句）
        if (preg_match_all('/FROM\s+([a-zA-Z_][a-zA-Z0-9_]*)/i', $sql, $matches)) {
            $tables = array_merge($tables, $matches[1]);
        }

        if (preg_match_all('/JOIN\s+([a-zA-Z_][a-zA-Z0-9_]*)/i', $sql, $matches)) {
            $tables = array_merge($tables, $matches[1]);
        }

        $tables = array_unique($tables);
        array_map('strtolower', $tables);
        return $tables;
    }
}
