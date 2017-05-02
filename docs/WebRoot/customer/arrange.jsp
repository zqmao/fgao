<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.check(request, response);
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
            
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="个人排班情况" style="width: 100%">
			<table id="arrangeGrid" style="height: 340px;"></table>
		</div>
	</body>
</html>
