<?php

namespace App\Traits;

use Monolog\Handler\StreamHandler;
use Monolog\Logger;

trait LoggerTrait
{
    /**
     * [函数功能描述]
     * @param $msg
     * @param $logName
     * @return void
     * @author wxyClark
     * @create 2025/11/29 22:22
     *
     * @version 1.0
     */
    public static function logger($msg, $logName = '')
    {
        if ($logName && $msg) {
            $path = 'logs/' . $logName . '_' . date('Y-m-d') . '.log';
            $log = new Logger($logName);
            $log->pushHandler(new StreamHandler(storage_path($path)));
            $log->addInfo($msg);
        }
    }

    /**
     * 异常日志 格式化
     * @param  \Throwable  $exception
     * @param  array  $params
     * @param  string  $title
     * @return false|string
     * @author wxyClark
     * @create 2025/11/29 22:27
     *
     * @version 1.0
     */
    public function formatExceptionLog(\Throwable $exception, array $params, string $title = '')
    {
        $data = [
            'title' => $title,
            '$params' => $params,
            'code' => $exception->getCode(),
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
            'msg' => $exception->getMessage(),
        ];

        return json_encode($data);
    }
}
