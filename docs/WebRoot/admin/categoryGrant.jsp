<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%@page language="java" import="base.api.User"%>
<%
	int userId = PermissionUtil.checkAdmin(request, response);
	String categoryId = request.getParameter("categoryId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 	<head>
  	<title>权限管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	$(function() {
        $("#option_user").combobox({
            url:'../userServlet.do?sign=select',
            valueField:'id',
            textField:'text',
            loadFilter: function(data){
           		if (data.data){
           			loadTableData();
           			$("#option_user").combobox('select', <%=userId%>);
           			return data.data;
           		} else {
           			return data;
           		}
           	}
        });
        
    });
	function loadTableData() {
		$("#userGrid").datagrid({
            selectOnCheck: false,
            checkOnSelect: false,
            pagination: true,
            url: '../userCategoryServlet.do?sign=listBySimpleCategory',
            queryParams:{categoryId : <%=categoryId%>},
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
                    {title: '操作', field: 'opt', width: 120, align: 'center',
                        formatter: function(value, rowData, rowIndex) {
                        	var content = "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='deleteUser("+rowData.id+")'><span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>删除</span><span class='l-btn-icon icon-remove'>&nbsp;</span></span></a>";
                        	return content;
                        }
                    }
                ]],
            loadFilter: function(data){
           		if (data.data){
           			return data.data;
           		} else {
           			return data;
           		}
           	}
        });
	}
	
	function add(){
		var option_user = $("#option_user").val();
		$.ajax({
            type: "POST",
            url: "../userCategoryServlet.do?sign=add&categoryId=<%=categoryId%>",
            data: "userId=" + option_user,
            success: function(msg) {
				$("#userGrid").datagrid("reload");
            },
            error: function(msg) {
                alert(msg.toString());
            }
        });
	}
	
	function deleteUser(option_user){
		$.ajax({
            type: "POST",
            url: "../userCategoryServlet.do?sign=delete&categoryId=<%=categoryId%>",
            data: "userId=" + option_user,
            success: function(msg) {
				$("#userGrid").datagrid("reload");
            },
            error: function(msg) {
                alert(msg.toString());
            }
        });
	}
	</script>
  </head>
  
  <body class="easyui-layout">
		<div class="easyui-panel" title="权限管理" style="width: 100%">
			<div style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
				<label for="option_user">筛选:</label>
				<input id="option_user" />
				<a href="javascript:;" class="l-btn l-btn-small l-btn-plain" onclick="add();">
					<span class="l-btn-left l-btn-icon-left">
						<span class="l-btn-text">增加</span>
						<span class="l-btn-icon icon-add">&nbsp;</span>
					</span>
				</a>
		    </div>
			<div class="easyui-panel" title="已选人员" style="width: 100%">
				<table id="userGrid" style="height: 340px;"></table>
			</div>
		</div>
	</body>
</html>
