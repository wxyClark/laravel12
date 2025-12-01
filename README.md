# 项目介绍

## 基础环境

* laravel10.x
* php8.2
* mysql5.7 or 10.4.32-MariaDB

## 插件

* laravel/breeze 2.3.8
* kra8/laravel-snowflake 2.4.1
* mk-j/php_xlsxwriter 0.39

## 运行环境(参考)

* node 24.11.1
* npm 11.6.2

## 当前功能简介

```tips
测试数据 文件路径: database/laravex.sql
```

1. 登录注册
* 基于breeze官方套件实现

2. 开发工具
* DEV模块 使用 权限过滤中间件
* /dev 页面支持查询、展示、导出
> 对接口设置访问频次限制

> /query/list 通用查询，通过后端配置 过滤敏感表

> /query/export 通用导出 支持 Excel、JSON

## 后续计划

1. API接口调用 

## License

[CC-BY-NC-ND-4.0 中文版](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode.zh-Hans)

[CC-BY-NC-ND-4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode)
