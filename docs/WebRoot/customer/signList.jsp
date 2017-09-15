<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean isAdmin = PermissionUtil.isAdmin(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>考勤信息</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
			var first_user = 1;
			var option_user = "0";
            $(function() {
                $("#option_user").combobox({
                    url:'../userServlet.do?sign=select',
                    valueField:'id',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_user").combobox('select', <%=userId%>);
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                	onSelect: function(record){
						option_user = record.id + "";
						if(first_user == 0){
							var queryParams =$("#signGrid").datagrid("options").queryParams;
							queryParams.selectUser = option_user;
							$("#signGrid").datagrid("reload");
						}else{
							loadTableData();
						}
						first_user = 0;
					}
                }
                );
            });

			function loadTableData() {
				$("#signGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    url: '../signRecordServlet.do?sign=list',
                    queryParams:{selectUser : option_user},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 30, hidden:true},
                            {title: '考勤日期', field: 'dayTime', width: 150, align: 'center'},
                            {title: '签到时间', field: 'signInTime', width: 200, align: 'center'},
                            {title: '签退时间', field: 'signOutTime', width: 200, align: 'center',formatter:formatCellTooltip},
                            {title: '考勤人员', field: 'userName', width: 120, align: 'center'},
                            {title: '是否管理员维护', field: 'adminHandle', width: 120, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                   	onBeforeLoad: function(data){
                    	if(<%=isAdmin%>){
                    		$("#toolbar-sign-handle").show();
                    		$("#option_user_div").show();
                    	}else{
                    		$("#toolbar-sign-handle").hide();
                    		$("#option_user_div").hide();
                    	}
                    },
                    toolbar: [{
                    	id:'toolbar-sign-handle',
                    	text:'管理员维护',
                        iconCls: 'icon-ok',
                        handler: function() {
                        	alert("还在开发");
                        	/*var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../bugServlet.do?sign=handle",
                                            data: "signDays=" + ids + "selectUser="+option_user,
                                            success: function(msg) {
                                                $("#bugGrid").datagrid('reload');
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }*/
                        }
                    }]
                });
			}
			function formatCellTooltip(value, rowData, rowIndex){  
				if(rowData.signOutException == 1){
					return "<span title='" + value + "' style='background-color:#ea544a;display:inline-block;padding:5px'>" + value + "</span>";  
				}else{
					if(value){
						return "<span title='" + value + "'>" + value + "</span>";  
					}else{
						return "";
					}
				}
	        } 
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="考勤列表" style="width: 100%">
			<div id="option_user_div"  style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
				<label for="option_user">筛选:</label>
				<input id="option_user" />
		    </div>
			<table id="signGrid" style="height: 900px;"></table>
		</div>
	</body>
</html>
