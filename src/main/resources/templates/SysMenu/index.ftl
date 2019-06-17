<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>菜单表管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="../layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="../css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="menuName"
                               placeholder="请输入菜单名称"/>
                        </div>
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="menuUrl"
                               placeholder="请输入菜单URL"/>
                        </div>
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="paternalId"
                               placeholder="请输入父级ID"/>
                        </div>
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="menuState"
                               placeholder="请输入菜单状态 1启用 0禁用"/>
                        </div>
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="sort"
                               placeholder="请输入排序"/>
                        </div>
                <a class="layui-btn search_btn" lay-submit="" lay-filter="reloadData" data-type="reload">搜索</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal addSysMenu_btn">添加菜单表</a>
            </div>
        </form>
    </blockquote>
    <table id="sysMenuList" lay-filter="sysMenuList"></table>
    <!--操作-->

</form>
<script type="text/javascript" src="../layui/layui.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
</body>
</html>
<script type="text/html" id="sysMenuListBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</script>
    <#include "../common/common.ftl">
        <script id="menuState" type="text/html">
            {{#
            var menuState=d.menuState==1?"checked":"";
            var id=d.id;
            var content='<input type="checkbox" name="menuState" lay-filter="menuState" lay-skin="switch" lay-text="启用|禁用" '+ menuState+ ' value="'+id+'">';
            return content;
            }}
        </script>
<div class="layui-hide" id="sysMenuAddDiv">
    <form id="sysMenuAddBody" class="layui-form" lay-filter="sysMenuAddForm"
          style="margin-top: 30px;">
        <input type="text" name="id" style="display: none;" value="">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">菜单名称<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="menuName" lay-verify="required" autocomplete="off"
                                   placeholder="菜单名称" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">菜单URL<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="menuUrl" lay-verify="required" autocomplete="off"
                                   placeholder="菜单URL" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">父级ID<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="paternalId" lay-verify="required" autocomplete="off"
                                   placeholder="父级ID" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">菜单状态 1启用 0禁用<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="menuState" lay-verify="required" autocomplete="off"
                                   placeholder="菜单状态 1启用 0禁用" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">排序<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="sort" lay-verify="required" autocomplete="off"
                                   placeholder="排序" class="layui-input">
                        </div>
                    </div>
                </div>
        <div class="layui-form-item layui-hide">
            <div class="layui-input-block">
                <button class="layui-btn" id="addOrEditBtn" lay-submit lay-filter="addOrEditBtn">立即提交</button>
                <button type="reset" id="addOrEditResetBtn" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
    <#include "index.js.ftl">
