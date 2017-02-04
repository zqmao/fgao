<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	String bugId = (String)request.getParameter("bugId");
	PermissionUtil.check(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>待办事项</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="themes/icon.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
            $(function() {
            	$.ajax({
                    type: "POST",
                    url: "bugServlet.do?sign=detail",
                    data: "bugId=<%=bugId%>",
                    success: function(msg) {
                    	var data = eval('('+msg+')');
                        $("#category").val(data.data.category);
                        $("#title").val(data.data.title);
                        $("#createRemark").textbox("setValue", data.data.createRemark);
                        $("#createInfo").val(data.data.createInfo);
                        $("#finishInfo").val(data.data.finishInfo);
                        
                        $("#bugOperationGrid").datagrid({
                            selectOnCheck: true,
                            checkOnSelect: true,
                            pagination: true,
                            url: 'bugServlet.do?sign=listOperation&bugId=<%=bugId%>',
                            frozenColumns: [[
                                    {title: '指派人', field: 'operater', width: 100, align: 'center'},
                                    {title: '被指派人', field: 'target', width: 100, align: 'center'},
                                    {title: '时间', field: 'time', width: 150, align: 'center'},
                                    {title: '备注', field: 'remark', width: 400, align: 'center'}
                                ]],
                            loadFilter: function(data){
                           		if (data.data){
                           			return data.data;
                           		} else {
                           			return data;
                           		}
                           	}
                        });
                    },
                    error: function(msg) {
                        alert(msg.toString());
                    }
                });
            });

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
		<div class="easyui-panel" title="待办详情" style="width: 100%;padding: 10px;">
			<div >
				<div>类别:</div>
				<input class="easyui-validatebox" type="text" id="category" disabled="disabled" style="width:30%;padding: 5px;"/>
		    </div>
		    <br/>
			<div >
				<div>标题:</div>
				<input class="easyui-validatebox" type="text" id="title" disabled="disabled" style="width:80%;padding: 5px;" />
		    </div>
		    <br/>
		    <div >
				<div>描述:</div>
				<input class="easyui-textbox" type="text" id="createRemark" disabled="disabled" style="width:80%;height:100px" data-options="multiline:true" />
		    </div>
		    <br/>
		    <div>
				<div>创建情况:</div>
				<input class="easyui-validatebox" type="text" id="createInfo" disabled="disabled" style="width:80%;padding: 5px;" />
		    </div>
		    <br/>
		    <div >
				<div>完成情况:</div>
				<input class="easyui-validatebox" type="text" id="finishInfo" disabled="disabled" style="width:80%;padding: 5px;" />
		    </div>
		</div>
		<div class="easyui-panel" title="指派记录" style="width: 100%;padding: 10px;">
			<table id="bugOperationGrid"></table>
		</div>
		
	</body>
</html>
