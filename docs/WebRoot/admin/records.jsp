<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>统计报表</title>
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
	
	<!-- 列表 -->
	<table id="dg_query" title="产品查询" class="easyui-datagrid" style="width:1500px;height:70px"
			toolbar="#tb">
	</table>
	<div id="tb" style="padding:3px">
		<span>登记时间:</span>
		<input id="createAtStartTime" class="easyui-datetimebox"/>
		<input id="createAtEndTime" class="easyui-datetimebox"/>
		
		<!-- <span>产品标题:</span>
		<input id="searchTitle" style="line-height:26px;border:1px solid #ccc"> -->
		<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">搜索</a>
	</div>
	<table id="dg" title="产品列表" class="easyui-datagrid" style="width:1500px;height:600px"
			url="../freshOrderServlet.do?sign=record"
			toolbar="#toolbar"
			singleSelect="true"
			pagination="true">
	</table>

	</body>
<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

$('#dg').datagrid({
	columns:[[
		{field:'title',title:'标题', width:300,align:'left'},
		{field:'goodsId',title:'天猫产品ID', width:100,align:'center'},
		{field:'imgLink',title:'图片', width:70,align:'center',
			formatter: function(value,row,index){
				if (row.goodsId){
					return "<img src='"+value+"' width='60'/>";
				} else {
					return value;
				}
			}
		},
		{field:'totalNum',title:'刷单数量', width:100,align:'center'},
		{field:'totalAmount',title:'刷单金额', width:100,align:'center'},
		{field:'totalCommission',title:'佣金总额', width:100,align:'center'},
		{field:'op',title:'操作', width:120,align:'center',
			formatter: function(value,row,index){
				if (row.goodsId){
					return "<a href='https://detail.tmall.com/item.htm?id="+row.goodsId+"' target='_blank'>查看产品</a><br/>"+
						   "<a href='/admin/freshOrder.jsp?goodsId="+row.goodsId+"' target='_blank'>查看所有记录</a>";;
				} else {
					return value;
				}
			}
		}
		
	]]
});
	
 function doSearch(){
 	$('#dg').datagrid('load',{
 		start_createAt: $('#createAtStartTime').val(),
 		end_createAt: $('#createAtEndTime').val()            		
 	});
 }
 
</script>
</html>
