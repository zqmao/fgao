<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>产品管理</title>
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
		<style>
			#panel_add label{display:inline-block;width:100px;line-height:30px;height:30px;}
			#panel_add input,select{width:300px;height:25px;line-height:25px;}
			#panel_add .deal {text-align:center;border:red solid 1px;display:block;}
			#panel_add .deal a{margin:0 auto;}
		</style>
	</head>
	
	<body class="easyui-layout">
	
	<div class="easyui-panel" style="width: 100%; height: 100%;">
	
	<!-- 列表 -->
	<table id="dg_query" title="产品查询" class="easyui-datagrid" style="width:1500px;height:70px"
			toolbar="#tb">
	</table>
	<div id="tb" style="padding:3px">
		<span>所属店铺:</span>
		<input id="searchShopId" class="easyui-combobox"  required="true"
				data-options="
						url:'../shopServlet.do?sign=select',
						method:'post',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				">
		<span>产品标题:</span>
		<input id="searchTitle" style="line-height:26px;border:1px solid #ccc">
		<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">搜索</a>
	</div>	
	<table id="dg" title="产品列表" class="easyui-datagrid" style="width:1500px;height:600px"
			url="../goodsServlet.do?sign=list"
			toolbar="#toolbar"
			singleSelect="true"
			pagination="true">
	</table>

	
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newProduct()">添加产品</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editProduct()">编辑产品</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyProduct()">删除产品</a>
	</div>
	
	
	<!-- 弹出框 -->
	<div id="panel_add" class="easyui-dialog" style="width:600px;height:280px;padding:10px 20px"
		closed="true" buttons="#dlg-buttons">
	<div class="ftitle">产品信息</div>
		<form id="product_fm" method="post">
			<input type="hidden" name="id">
			<input type="hidden" name="shopId">
			<div class="fitem">
				<label>所属店铺:</label>
				<input id="shopName" name="shopName" class="easyui-combobox"  required="true"
				data-options="
						url:'../shopServlet.do?sign=select',
						method:'post',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				">
			</div>
			<div class="fitem">
				<label>产品标题:</label>
				<input name="title" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>天猫产品ID:</label>
				<input name="tid" class="easyui-validatebox" required="true">
			</div>
			
			<div class="fitem">
				<label>图片地址:</label>
				<input name="imgLink" class="easyui-validatebox" >
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveProduct()">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#panel_add').dialog('close')">取消</a>
	</div>
	</div>

	</body>
<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#shopName').combobox({
		onSelect: function(param){
			console.log(param);
			$('#product_fm input[name=shopId]').val(param.id);
		}
	});
});

$('#dg').datagrid({
	columns:[[
		{field:'id',title:'编号', width:50,align:'center'},
		{field:'title',title:'标题', width:300,align:'left',
			styler: function(value,row,index){
		
					return 'word-wrap: break-word;';
					// the function can return predefined css class and inline style
					// return {class:'c1',style:'color:red'}
			}
		},
		{field:'shopName',title:'所属店铺', width:150,align:'center'},
		{field:'tid',title:'天猫产品ID', width:100,align:'center'},
		{field:'imgLink',title:'图片', width:70,align:'center',
			formatter: function(value,row,index){
				if (row.tid){
					return "<img src='"+value+"'/>";
				} else {
					return value;
				}
			}
		},
		{field:'op',title:'操作', width:50,align:'center',
			formatter: function(value,row,index){
				if (row.tid){
					return "<a href='https://detail.tmall.com/item.htm?id="+row.tid+"' target='_blank'>查看</a>";
				} else {
					return value;
				}
			}
		}
		
	]]
});
	
 function newProduct(){
 	$('#panel_add').dialog('open').dialog('setTitle','新增产品');
 	$('#product_fm').form('clear');
 	url = '../goodsServlet.do?sign=add';
 }
 
 function editProduct(){
 	var row = $('#dg').datagrid('getSelected');
 	if(row == null){            		
  		$.messager.show({
			title: '提示',
			msg: '请选择以一条记录~'
		});
  	}
 	console.log(row);
 	if (row){
 		$('#panel_add').dialog('open').dialog('setTitle','编辑产品');
 		$('#product_fm').form('load',row);
 		url = '../goodsServlet.do?sign=edit&id='+row.id;
 	}
 }
 function doSearch(){
 	$('#dg').datagrid('load',{
 		eq_shopId: $('#searchShopId').val(),
 		li_title: $('#searchTitle').val()            		
 	});
 }
 
 function saveProduct(){
 	$('#product_fm').form('submit',{
 		url: '../goodsServlet.do?sign=add',
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
 				$('#panel_add').dialog('close');		// close the dialog
 				$('#dg').datagrid('reload');	// reload the user data
 			}
 		}
 	});
 }
</script>
<jsp:include page="popProduct.jsp" flush="true"/>
</html>
