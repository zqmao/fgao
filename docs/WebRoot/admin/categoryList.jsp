<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.checkAdmin(request, response);
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>分类管理</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../themes/icon.css" />
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
			var parentId = "0";
            $(function() {
            	$("#addCategory").panel({
            		title: '添加分类',
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
        					$("#addCategory").panel("close");
        				}
        			}]
            		});
                $("#addCategory").panel("open");
                $("#categoryGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../categoryServlet.do?sign=list",
                    queryParams:{parentId : parentId},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '名称', field: 'text', width: 120, align: 'center'},
                            {title: '父分类', field: 'parentName', width: 120, align: 'center'},
                            {title: '详情', field: 'opt', width: 100, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                                	return "<a href='categoryGrant.jsp?categoryId="+rowData.id+"' target='_blank' style='color:red'>权限管理</a>";
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
                            $("#addCategory").form("clear");
                            $("#addCategory").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("categoryGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#categoryGrid").datagrid("getChecked");
                                $("#addCategory").panel("open");
                                $("#addCategory").form("load", {
                                    categoryId: row[0].id,
                                    text: row[0].text
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("categoryGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../categoryServlet.do?sign=delete",
                                            data: "categoryIds=" + ids,
                                            success: function(msg) {
                                                $("#categoryGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-redo',
                        text: '进入',
                        handler: function() {
                            var ids = getChecked("categoryGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#categoryGrid").datagrid("getChecked");
                                parentId = row[0].id;
                                var queryParams =$("#categoryGrid").datagrid("options").queryParams;
                                queryParams.parentId = parentId;
    							$("#categoryGrid").datagrid("reload");
                            }
                        }
                    }, {
                        iconCls: 'icon-undo',
                        text: '后退',
                        handler: function() {
                        	$.ajax({
                                type: "POST",
                                url: "../categoryServlet.do?sign=query",
                                data: "categoryId=" + parentId,
                                success: function(msg) {
                                	var data = eval('('+msg+')');
                                	var queryParams =$("#categoryGrid").datagrid("options").queryParams;
                                	parentId = data.data;
                                    queryParams.parentId = parentId;
        							$("#categoryGrid").datagrid("reload");
                                },
                                error: function(msg) {
                                    alert(msg.toString());
                                }
                            });
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
				$("#addCategoryForm").form("submit", {
				    url:"../categoryServlet.do?sign=add&parentId="+parentId,
				    success:function(data){
				    	var data = eval('(' + data + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addCategoryForm").form("clear");
        					$("#categoryGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
        </script>
	</head>

	<body class="easyui-layout">
		<div title="分类管理" class="easyui-panel" style="width: 100%">
			<table id="categoryGrid" style="height: 340px;"></table>
		</div>

		<div id="addCategory" class="easyui-panel" title="添加分类" style="width: 100%; height: 200px;padding: 10px;">
			<form id="addCategoryForm" method="post">
				<input type="hidden" name="categoryId" value="" />
				<table>
					<tr >
						<td>名称:</td>
						<td><input class="easyui-validatebox" name="text" type="text"  data-options="required:true"/><td>
				    </tr>
			    </table>
			</form>
		</div>
	</body>
</html>