<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${table.comment!}管理</title>
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
                <#list table.fields as field>
                    <#if !field.propertyName?contains("Time") && !field.propertyName?contains("User") && !field.propertyName?contains("id") && field.propertyName!=("isDel")>
                        <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="${field.propertyName}"
                               placeholder="请输入${field.comment!}"/>
                        </div>
                    </#if>
                </#list>
                <a class="layui-btn search_btn" lay-submit="" lay-filter="reloadData" data-type="reload">搜索</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal add${entity}_btn">添加${table.comment!}</a>
            </div>
        </form>
    </blockquote>
    <table id="${entity?uncap_first}List" lay-filter="${entity?uncap_first}List"></table>
    <!--操作-->

</form>
<script type="text/javascript" src="../layui/layui.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
</body>
</html>
<script type="text/html" id="${entity?uncap_first}ListBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</script>
<#noparse>
    <#include "../common/common.ftl">
</#noparse>
<#list table.fields as field>
    <#if field.propertyName?contains("State")>
        <script id="${field.propertyName}" type="text/html">
            {{#
            var ${field.propertyName}=d.${field.propertyName}==1?"checked":"";
            var id=d.id;
            var content='<input type="checkbox" name="${field.propertyName}" lay-filter="${field.propertyName}" lay-skin="switch" lay-text="启用|禁用" '+ ${field.propertyName}+ ' value="'+id+'">';
            return content;
            }}
        </script>
    </#if>
</#list>
<div class="layui-hide" id="${entity?uncap_first}AddDiv">
    <form id="${entity?uncap_first}AddBody" class="layui-form" lay-filter="${entity?uncap_first}AddForm"
          style="margin-top: 30px;">
        <input type="text" name="id" style="display: none;" value="">
        <#list table.fields as field>
            <#if !field.propertyName?contains("Time") && !field.propertyName?contains("User") && !field.propertyName?contains("id") && field.propertyName!=("isDel")>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px;">${field.comment!}<span
                                    class="layui-badge-dot"></span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="${field.propertyName}" lay-verify="required" autocomplete="off"
                                   placeholder="${field.comment!}" class="layui-input">
                        </div>
                    </div>
                </div>
            </#if>
        </#list>
        <div class="layui-form-item layui-hide">
            <div class="layui-input-block">
                <button class="layui-btn" id="addOrEditBtn" lay-submit lay-filter="addOrEditBtn">立即提交</button>
                <button type="reset" id="addOrEditResetBtn" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<#noparse>
    <#include "index.js.ftl">
</#noparse>
