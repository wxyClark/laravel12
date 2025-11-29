<?php

namespace App\Http\Middleware;

use App\Services\PermissionService;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AdminPermission
{
    /**
     * 管理员权限校验
     * @param  Request  $request
     * @param  Closure  $next
     * @return Response
     * @author wxyClark
     * @create 2025/11/29 11:32
     *
     * @version 1.0
     */
    public function handle(Request $request, Closure $next): Response
    {
        $userId = Auth::id();

        $isAdmin = app(PermissionService::class)->getIsAdmin($userId);

        if (!$isAdmin) {
            // 如果没有权限，返回当前页面并显示错误消息
            return back()->withErrors(['permission' => '您没有权限访问此页面！']);
        }

        return $next($request);
    }
}
