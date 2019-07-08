<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>客户管理</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!-- 导入easyui的资源文件 -->
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">


</head>

<body>
<table id="list"></table>
<!-- 工具条 -->
<div id="tb">
    <a id="addBtn" href="#" onclick="newUser()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a id="editBtn" href="#" onclick="editUser()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
    <a id="deleteBtn" href="#" onclick="destroyUser()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>


<!--接收后台数据-->
<script type="text/javascript">
    $(function () {
        $("#list").datagrid({
            //url为
            url: "listBypage",
            columns: [[
                //第一列
                {
                    field: "id",
                    title: "客户编号",
                    width: 100
                },
                //第二列
                {
                    field: "name",
                    title: "客户姓名",
                    width: 100
                },
                //第三列
                {
                    field: "gender",
                    title: "客户性别",
                    width: 100
                },
                //第四列
                {

                    field: "telephone",
                    title: "客户电话",
                    width: 100
                },
                //第五列
                {
                    field: "address",
                    title: "客户地址",
                    width: 100
                }
            ]],
            //前台
            //（1）添加pagination
            //（2）使用分页插件时需要向后台发送两个参数
            //（3）page   ：当前页码
            //（4）rows   ：每页记录数
            //后台
            //（1）需要接受page和rows参数
            //（2）根据参数分页查询
            //（3）获取结果
            //（4）返回给页面
            //（5）返回参数中包含
            // total  ：总记录数
            //rows    ：当前也数据列表
            pagination:true,
            toolbar:"#tb"  //工具条是上面的tb23行
        });
    });

</script>

<!--添加和修改事件所用的对话框-->
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">User Information</div>
    <form id="fm" method="post">
        <div class="fitem">
            <label>客户编号:</label>
            <input name="id" class="easyui-validatebox" >
        </div>
        <div class="fitem">
            <label>客户姓名:</label>
            <input name="name" class="easyui-validatebox" required="true">
        </div>
        <div class="fitem">
            <label>性别:</label>
            <input name="gender">
        </div>
        <div class="fitem">
            <label>电话:</label>
            <input name="telephone" class="easyui-validatebox" validType="true">
        </div>
        <div class="fitem">
            <label>地址:</label>
            <input name="address" class="easyui-validatebox" validType="true">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
</div>
<script>
    var url;
    //打开新窗口
    function newUser(){
        $('#dlg').dialog('open').dialog('setTitle','New User');
        $('#fm').form('clear');
        url = '/saveUser';
    }
    //编辑用户
    function editUser(){
        var row = $('#list').datagrid('getSelected');
        if (row){
            $('#dlg').dialog('open').dialog('setTitle','Edit User');
            $('#fm').form('load',row);
            //设置要更新的url ?id='+row.id
            url = '/updateUser';
        }
    }
    //向服务器保存数据
    function saveUser(){
        //根据url发出请求
        $('#fm').form('submit',{
            url: url,
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                $('#list').datagrid('reload');    // reload the user data
                $('#dlg').dialog('close');        // close the dialog
                $('#dg').datagrid('reload');    // reload the user data
                var result = eval('('+result+')');
            }
        });
        alert("保存");
    }


    //删除用户
    function destroyUser(){
        var row = $('#list').datagrid('getSelected');
        if (row){
            $.messager.confirm('Confirm','Are you sure you want to destroy this user?',function(r){
                if (r){

                    //提交删除请求
                    // $.post('/destroyUser',{id:row.id},function(result){
                    //     $('#list').datagrid('reload');    // reload the user data
                    //     if (result.success){
                    //         $('#list').datagrid('reload');    // reload the user data
                    //     } else {
                    //         $.messager.show({    // show error message
                    //             title: 'Error',
                    //             msg: result.errorMsg
                    //         });
                    //     }
                    // },'json');
                    // alert("删除成功");

                    //删减后的删除提交请求
                    $.post('/destroyUser',{id:row.id},function(data){
                        $('#list').datagrid('reload');    // reload the user data
                        alert("刷新的吗？");
                        $('#list').datagrid('reload');
                    },'text');

                }
            });
        }
    }

</script>


</body>
</html>
