<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.checkAdmin(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>个人排班情况</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript">
            $(function() {
                $("#arrangeGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: '../arrangeServlet.do?sign=list',
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '时间', field: 'day', width: 220, align: 'center'},
                            {title: '排班', field: 'status', width: 400, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	}
                });
            });
            
            function uploadExcel() {
				$("#uploadExcel").form('submit', {
				    url:"../uploadExcelServlet.do",
				    success:function(data){
				    	var data = eval('(' + data + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#uploadExcel").form('clear');
        					$("#arrangeGrid").datagrid("reload");
				    	}
				    }
				});
			}
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="个人排班情况" style="width: 100%">
			<table id="arrangeGrid" style="height: 340px;"></table>
		</div>
		<div id="uploadExcelLayout" class="easyui-panel" data-options="modal:true"
			title="导入排班信息" style="width: 100%; height: 200px;padding: 10px;">
			<form id="uploadExcel" method="post" enctype="multipart/form-data">
			    <input type="file" name="fileUpload" />
			    <a href="javascript:;" onclick="uploadExcel();" class="l-btn l-btn-small l-btn-plain">
			    	<span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">导入排班信息</span><span class="l-btn-icon icon-redo">&nbsp;</span></span>
			    </a>
		    </form>
		</div>
	</body>
</html>
