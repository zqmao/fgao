<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.checkAdmin(request, response);
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>人员管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
            $(function() {
            	$("#addUser").panel({
            		title: '添加人员',
            		tools:[{
        				text:'保存',
        				iconCls:'icon-ok',
        				handler:function(){
        					submitAdd();
        				}
        			},{
           				text:'-',
           				iconCls:'icon-blank',
           				handler:function(){}
           			},{
        				text:'取消',
        				iconCls:'icon-cancel',
        				handler:function(){
        					$("#addUser").panel("close");
        				}
        			}]
            		});
                $("#addUser").panel("open");
                $("#grant").dialog("close");
                $("#userGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../userServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '姓名', field: 'name', width: 120, align: 'center'},
                            {title: '帐号', field: 'loginName', width: 120, align: 'center'},
                            {title: '手机号码', field: 'phone', width: 120, align: 'center'},
                            {title: '备注', field: 'info', width: 240, align: 'center'},
                            {title: '身份', field: 'admin', width: 120, align: 'center',
                                formatter: function(value, rec) {
                                	if(value == 1){
	                                    return "管理员";
                                	}else{
                                		return "普通成员";
                                	}
                                }
                            },
                            {title: '详情', field: 'opt', width: 100, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                                	return "<a href='#' style='color:red' onclick='openGrant("+rowData.id+")'>权限查看</a>";
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
                    toolbar: [{
                        iconCls: 'icon-add',
                        text: '增加',
                        handler: function() {
                            $("#addUser").form("clear");
                            $("#addUser").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("userGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#userGrid").datagrid("getChecked");
                                $("#addUser").panel("open");
                                $("#addUser").form("load", {
                                    userId: row[0].id,
                                    name: row[0].name,
                                    loginName: row[0].loginName,
                                    phone: row[0].phone,
                                    info: row[0].info
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("userGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../userServlet.do?sign=delete",
                                            data: "userIds=" + ids,
                                            success: function(msg) {
                                                $("#userGrid").datagrid("reload");
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
            });

            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
            function submitAdd() {
				$("#addUserForm").form("submit", {
				    url:"../userServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addUserForm").form("clear");
        					$("#userGrid").datagrid("reload");
				    	}
				    }
				});
			}
			
			function openGrant(userId){
				$("#grant").dialog("open");
				$('#tt').tree({
					checkbox:true,
					cascadeCheck:false,
					url: '../userCategoryServlet.do?sign=listBySimpleUser&userId='+userId,
					loadFilter: function(data){
						return data.data;
					},
					formatter:function(node){
						if(node.checked){
							return node.text+"<font color='red'>  (有权限)</font>";
						}else{
							return node.text;
						}
						
					},
					onBeforeCheck: function(node, checked){
						return false;
					}
				});
			}
            
        </script>
	</head>


	<body class="easyui-layout">
		<div title="人员列表" class="easyui-panel" style="width: 100%">
			<table id="userGrid" style="height: 340px;"></table>
		</div>

		<div id="addUser" class="easyui-panel" title="添加人员" style="width: 100%; height: 200px;padding: 10px;">
			<form id="addUserForm" method="post">
				<input type="hidden" name="userId" value="" />
				<table>
					<tr >
						<td>姓名:</td>
						<td><input class="easyui-validatebox" name="name" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>登录帐号:</td>
						<td><input class="easyui-validatebox" name="loginName" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>手机号:</td>
						<td><input class="easyui-validatebox" name="phone" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><input class="easyui-validatebox" name="info" type="text" style="width: 400px;"/><td>
				    </tr>
			    </table>
			</form>
		</div>
		
		<div id="grant" class="easyui-dialog" title="权限查看" style="width:300px; height: 340px;" >
			<div title="分类" style="width: 100%;height: 100%;" >
			    <ul id="tt" class="easyui-tree">
				</ul>
			</div>
		</div>
	</body>
</html>
