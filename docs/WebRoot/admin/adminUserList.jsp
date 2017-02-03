<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>layout</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../themes/icon.css" />
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
            $(function() {
                //取消显示的添加人员弹出框
                $("#addUser").dialog("close");
                //取消左边展开按钮
                $(".layout-button-left").css("display", "none");
                //当页面加载完成后加后左边人员列表
                $("#userGrid").datagrid({
                    selectOnCheck: false,
                    checkOnSelect: false,
                    pagination: true,
                    url: '../userServlet.do?sign=list',
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '姓名', field: 'name', width: 80},
                            {title: '城市', field: 'loginName', width: 120},
                            {title: '操作', field: 'admin', width: 100, align: 'center',
                                formatter: function(value, rec) {
                                    return "<a href='javascript:void(0)' style='color:red'>通讯录</a>";
                                }
                            }
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    onClickRow: function() {
                        $("#userGrid").datagrid('clearSelections');
                    },
                    onClickCell: function(index, field, value) {
                        if (field == 'opt') {
                            $("#right").css("display", "");
                        }
                    },
                    toolbar: [{
                        iconCls: 'icon-add',
                        handler: function() {
                            $("#addUser").form('clear');
                            $("#addUser").dialog({title: '添加人员'});
                            $("#addUser").dialog('open');
                        }
                    }, {
                        iconCls: 'icon-edit',
                        handler: function() {
                            var ids = getChecked("userGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个要修改的项。', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个要修改的项。', 'Warning');
                            } else {
                                var row = $("#userGrid").datagrid('getChecked');
                                $("#addUser").dialog({title: '修改人员-' + row[0].name + ''});
                                $("#addUser").dialog('open');
                                $("#addUser").form('load', {
                                    name: row[0].name,
                                    city: row[0].cityId,
                                    userId: row[0].opt
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        handler: function() {
                            var ids = getChecked("userGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个要删除的项。', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "delUser.action",
                                            data: "ids=" + ids,
                                            success: function(msg) {
                                                //重新加载左边人员列表数据
                                                $("#userGrid").datagrid('reload');
                                                $("#right").css("display", "none");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }]
                });
                //ajax提交添加人员表单
                $('#addUserForm').form({
                    success: function(data) {
                        //关闭添加人员弹出框
                        $("#addUser").dialog("close");
                        //重新加载左边人员列表数据
                        $("#userGrid").datagrid('reload');
                    },
                    onSubmit: function() {
                        var userName = $("#userName").val();
                        if (userName == "") {
                            $.messager.alert("提示", "请输入姓名", "Info");
                            return false;
                        }
                        var str = $("#city").combobox('getValue');
                        if (str == "") {
                            $.messager.alert("提示", "请选择城市", "Info");
                            return false;
                        }
                        return true;
                    }
                });
            });

            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].opt);
                }
                return ids;
            }
            
        </script>
	</head>

	<body class="easyui-layout">
		<div data-options="region:'west'" title="人员列表" style="width: 100%">
			<table id="userGrid"></table>
		</div>

		<!--左边人员添加-->
		<div id="addUser" class="easyui-dialog" data-options="modal:true"
			title="添加人员" style="width: 40%; height: 20%;">
			<form id="addUserForm" action="saveOrEdit.action" method="post">
				<input type="hidden" name="userId" value="" />
				<table>
					<tr>
						<td>
							姓名:
						</td>
						<td>
							<input name="name" id="userName" type="text" />
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input type="submit" value="提交"></input>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
