<script type="text/javascript">
    layui.use(['form','layer','table','laytpl'],function(){
        var form = layui.form,
            layer = layui.layer ,
            $ = layui.jquery,
            laytpl=layui.laytpl,
            table = layui.table;

        var tableIns = table.render({
            elem: '#${entity?uncap_first}List',
            url : '../${entity?uncap_first}/list',
            page : true,
            limit : 10,
            limits : [10,15,20,25],
            id : "${entity?uncap_first}ListTable",
            cols : [[
                <#list table.fields as field>
                <#if field.propertyName?contains("Time") || field.propertyName?contains("State")>
                {field: '${field.propertyName}', title: '${field.comment}', align:'center', templet:'#${field.propertyName}'},
                <#else>
                <#if field.propertyName!="id" && field.propertyName!=("isDel")>
                {field: '${field.propertyName}', title: '${field.comment}', align:'center'},
                </#if>
                </#if>
                </#list>
                {title: '操作',toolbar:'#${entity?uncap_first}ListBar',fixed:"right",width:120,align:"center"}
            ]]
        });

        var formData;
        form.on('submit(reloadData)', function (data) {
            formData=data.field;
            tableIns.reload({
                where: data.field
                , page: {
                    curr: 1 //重新从第 1 页开始
                },done: function(res, curr, count){
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });


        var reloadTable=function () {
            tableIns.reload('${entity?uncap_first}ListTable', {
                where: formData
            });
        };

        function add${entity}(edit,title){
            $('#${entity?uncap_first}AddDiv').removeClass("layui-hide");
            layer.open({
                type: 1,
                title: title,
                area: ['450px', '50%'],
                btnAlign: 'c',
                anim: 1,
                content : $('#${entity?uncap_first}AddDiv'), //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                btn: ['保存', '取消'],
                success : function(layero, index){
                    form.val("${entity?uncap_first}AddForm", edit);
                },
                yes: function (index, layero) {
                    $('#addOrEditBtn').click();
                },
                btn2: function (index, layero) {
                    $('#${entity?uncap_first}AddDiv').addClass("layui-hide");
                    $('#addOrEditResetBtn').click();
                }, cancel: function () {
                    $('#${entity?uncap_first}AddDiv').addClass("layui-hide");
                    $('#addOrEditResetBtn').click();
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
        }

        form.on('submit(addOrEditBtn)', function (data) {
            var datas = data.field;
            layer.load();
            saveOrUpdate(datas);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        var saveOrUpdate=function (datas) {
            $.ajax({//异步请求返回给后台
                url: '../${entity?uncap_first}/saveOrUpdate',
                type: 'POST',
                data: datas,
                dataType: 'json',
                success: function (datas) {
                    layer.closeAll('loading');
                    if (datas.code == 0) {
                        layer.open({
                            content: datas.msg,
                            yes: function (index, layero) {
                                reloadTable();
                                layer.closeAll();
                            }
                        });
                        $('#${entity?uncap_first}AddDiv').addClass("layui-hide");
                    } else {
                        layer.msg(datas.msg);
                    }
                },error:function(){
                    layer.closeAll('loading');
                    layer.msg('操作失败，请重试');
                }
            });
        };


        <#list table.fields as field>
        <#if field.propertyName?contains("State")>
        form.on('switch(${field.propertyName})', function(data){
            var x=data.elem.checked;
            layer.open({
                content: '确认修改吗'
                ,btn: ['确定', '取消']
                ,yes: function(index, layero){
                    data.elem.checked=x;
                    layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
                    var tableData={"id":data.value,"${field.propertyName}":data.elem.checked?"1":0};
                    saveOrUpdate(tableData);
                    //按钮【按钮一】的回调
                }
                ,btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    data.elem.checked=!x;
                    layer.close(index);
                    form.render();
                    //return false 开启该代码可禁止点击该按钮关闭
                }
                ,cancel: function(){
                    //右上角关闭回调
                    data.elem.checked=!x;
                    form.render();
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
            return false;
        });
        </#if>
        </#list>

        var del=function(${entity?uncap_first}InfoId){
            layer.confirm('确定删除吗？', {
                btn: ['确定', '取消'] //可以无限个按钮
            }, function(index, layero){
                $.ajax({//异步请求返回给后台
                    url: '../${entity?uncap_first}/del',
                    type: 'POST',
                    data: {"id":${entity?uncap_first}InfoId},
                    dataType: 'json',
                    success: function (datas) {
                        layer.closeAll('loading');
                        if (datas.code == 0) {
                            layer.open({
                                content: datas.msg,
                                yes: function (index, layero) {
                                    reloadTable();
                                    layer.closeAll();
                                }
                            });
                        } else {
                            layer.msg('操作失败，请重试');
                        }
                    },error:function(){
                        layer.closeAll('loading');
                        layer.msg('操作失败，请重试');
                    }
                });
            }, function(index){
                //按钮【按钮二】的回调
            });
        };

        $(".add${entity}_btn").click(function(){
            $('#addOrEditResetBtn').click();
            add${entity}(null,"添加${table.comment!}");
        });

        //列表操作
        table.on('tool(${entity?uncap_first}List)', function(obj){
            var layEvent = obj.event,
                data = obj.data;
            if(layEvent === 'edit'){ //编辑
                add${entity}(data,"编辑${table.comment!}");
            }else if(layEvent === 'del'){
                del(data.id);
            }
        });

    })
</script>