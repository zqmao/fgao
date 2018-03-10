<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>店铺管理</title>
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	</head>
	<body class="easyui-layout">
	
	<div class="easyui-panel" style="width: 100%; height: 100%;">
	
	<!-- 列表 -->
	<table id="dg" title="店铺列表" class="easyui-datagrid" style="width:652px;height:600px"
			url="../shopServlet.do?sign=list"
			toolbar="#toolbar"
			singleSelect="true"
			pagination="true">
		<thead>
			<tr>
				<th field="id" width="50">店铺ID</th>
				<th field="shopName" width="200">店铺名称</th>
				<th field="remark" width="400">店铺备注</th>
			</tr>
		</thead>
	</table>

	
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroy()">删除</a>
	</div>
	
	
	<!-- 弹出框 -->
	<div id="dlg" class="easyui-dialog" style="width:600px;height:280px;padding:10px 20px"
		closed="true" buttons="#dlg-buttons">
	<div class="ftitle">店铺</div>
		<form id="product_fm" method="post">
			<input type="hidden" name="id">
			<div class="fitem">
				<label>店铺名称:</label>
				<input name="shopName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>备&nbsp;&nbsp;注:</label>
				<input name="remark" class="easyui-validatebox">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	</div>
	
	


	</body>
<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

function add(){
	$('#dlg').dialog('open').dialog('setTitle','新增店铺');
	$('#product_fm').form('clear');
	url = '../shopServlet.do?sign=add';
}

function edit(){
	var row = $('#dg').datagrid('getSelected');
	console.log(row);
	if (row){
		$('#dlg').dialog('open').dialog('setTitle','编辑店铺');
		$('#product_fm').form('load',row);
		url = '../shopServlet.do?sign=edit&id='+row.id;
	}
}

function destroy(){
	
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$.messager.confirm('Confirm','删除不可以恢复了，确定这样搞?',function(r){
			if (r){
				$.post('../shopServlet.do?sign=delete',{sign:'delete',id:row.id},function(result){
					if (result){
						$('#dg').datagrid('reload');	// reload the user data
					} else {
						$.messager.show({	// show error message
							title: 'Error',
							msg: data
						});
					}
				},'json');
			}
		});
	}
}

function save(){
	$('#product_fm').form('submit',{
		url: '../shopServlet.do?sign=add',
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			var result = eval('('+result+')');
			if (result.errorMsg){
				$.messager.show({
					title: 'Error',
					msg: result.errorMsg
				});
			} else {
				$('#dlg').dialog('close');		// close the dialog
				$('#dg').datagrid('reload');	// reload the user data
			}
		}
	});
}
</script>    
</html>
