<script type="text/javascript">
    layui.use(['form','layer','table','laytpl'],function(){
        var form = layui.form,
            layer = layui.layer ,
            $ = layui.jquery,
            laytpl=layui.laytpl,
            table = layui.table;

        var tableIns = table.render({
            elem: '#sysMenuList',
            url : '../sysMenu/list',
            page : true,
            limit : 10,
            limits : [10,15,20,25],
            id : "sysMenuListTable",
            cols : [[
                {field: 'menuName', title: '菜单名称', align:'center'},
                {field: 'menuUrl', title: '菜单URL', align:'center'},
                {field: 'paternalId', title: '父级ID', align:'center'},
                {field: 'menuState', title: '菜单状态 1启用 0禁用', align:'center', templet:'#menuState'},
                {field: 'sort', title: '排序', align:'center'},
                {field: 'createUser', title: '创建人', align:'center'},
                {field: 'createTime', title: '创建时间', align:'center', templet:'#createTime'},
                {field: 'updateUser', title: '更新人', align:'center'},
                {field: 'updateTime', title: '更新时间', align:'center', templet:'#updateTime'},
                {title: '操作',toolbar:'#sysMenuListBar',fixed:"right",width:120,align:"center"}
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
            tableIns.reload('sysMenuListTable', {
                where: formData
            });
        };

        function addSysMenu(edit,title){
            $('#sysMenuAddDiv').removeClass("layui-hide");
            layer.open({
                type: 1,
                title: title,
                area: ['450px', '50%'],
                btnAlign: 'c',
                anim: 1,
                content : $('#sysMenuAddDiv'), //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                btn: ['保存', '取消'],
                success : function(layero, index){
                    form.val("sysMenuAddForm", edit);
                },
                yes: function (index, layero) {
                    $('#addOrEditBtn').click();
                },
                btn2: function (index, layero) {
                    $('#sysMenuAddDiv').addClass("layui-hide");
                    $('#addOrEditResetBtn').click();
                }, cancel: function () {
                    $('#sysMenuAddDiv').addClass("layui-hide");
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
                url: '../sysMenu/saveOrUpdate',
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
                        $('#sysMenuAddDiv').addClass("layui-hide");
                    } else {
                        layer.msg(datas.msg);
                    }
                },error:function(){
                    layer.closeAll('loading');
                    layer.msg('操作失败，请重试');
                }
            });
        };


        form.on('switch(menuState)', function(data){
            var x=data.elem.checked;
            layer.open({
                content: '确认修改吗'
                ,btn: ['确定', '取消']
                ,yes: function(index, layero){
                    data.elem.checked=x;
                    layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
                    var tableData={"id":data.value,"menuState":data.elem.checked?"1":0};
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

        var del=function(sysMenuInfoId){
            layer.confirm('确定删除吗？', {
                btn: ['确定', '取消'] //可以无限个按钮
            }, function(index, layero){
                $.ajax({//异步请求返回给后台
                    url: '../sysMenu/del',
                    type: 'POST',
                    data: {"id":sysMenuInfoId},
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

        $(".addSysMenu_btn").click(function(){
            $('#addOrEditResetBtn').click();
            addSysMenu(null,"添加菜单表");
        });

        //列表操作
        table.on('tool(sysMenuList)', function(obj){
            var layEvent = obj.event,
                data = obj.data;
            if(layEvent === 'edit'){ //编辑
                addSysMenu(data,"编辑菜单表");
            }else if(layEvent === 'del'){
                del(data.id);
            }
        });

    })
</script>