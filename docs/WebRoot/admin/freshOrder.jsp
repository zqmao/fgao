<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	String goodsId =  request.getParameter("goodsId");

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>操作管理</title>
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	</head>
	<body class="easyui-layout">

<style>
#panel_add label{display:inline-block;width:100px;line-height:30px;height:30px;}
#panel_add input,select{width:350px;height:25px;line-height:25px;}
#panel_add .deal {text-align:center;border:red solid 1px;display:block;}
#panel_add .deal a{margin:0 auto;}
</style>

<div id="panel_add" class="easyui-dialog" title="新增/编辑" style="width:700px;height:400px;padding:10px;" closed="true" buttons="#dlg-buttons">
	<form id="curForm" method="post" enctype="multipart/form-data">
			<input name="id" type="hidden">
			<input name="goodsId" type="hidden" required="true" id="add_goodsId">
			<input name="shopId" type="hidden" required="true">
			<div class="fitem">
				<label>产品:</label>
				<input name="goodsName" id="add_goodsName" class="easyui-validatebox" required="true" readonly="true" onclick="choseProduct('add_goodsId','add_goodsName')">
				<span id="cookie_list">
				</span>
				
			</div>
			<div class="fitem">
				<label>订单号:</label>
				<input name="orderSn" class="easyui-validatebox" required="true" >
			</div>
			<div class="fitem">
				<label>联系方式:</label>				
				<select name="contractType" class="easyui-validatebox">
					<option value="微信" select="selected">微信</option>
					<option value="QQ">QQ</option>
					<option value="Mobile">Mobile</option>
				</select>
			</div>
			<div class="fitem">
				<label>联系账号:</label>
				<input name="contractAccount" class="easyui-validatebox">
			</div>
			<div class="fitem">
				<label>佣金:</label>
				<input name="commision" class="easyui-validatebox">
			</div>
			<div class="fitem">
				<label>订单金额:</label>
				<input name="orderAmount" class="easyui-validatebox">
			</div>

			<div class="fitem">
				<label>关键词:</label>			
				<input name="keyWords" class="easyui-validatebox">
			</div> 
			<div class="fitem" id="fileUpload">
				<label>关键词图片:</label>
				<input type="file" name="keyImage" accept="image/jpeg,image/png" class="easyui-validatebox"/>
			</div>
			<div class="fitem">
				<label>操作人备注:</label>
				<textarea name="remark" style="width:350px;height:50px;"></textarea>
			</div>
	</form>
</div>
<div id="dlg-buttons">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#panel_add').dialog('close')">取消</a>
</div>

		
<!-- 列表 -->
	<table id="dg_query" title="操作查询" class="easyui-datagrid" style="width:1700px;height:70px"
			toolbar="#tb">
	</table>
	<div id="tb" style="padding:3px">
		<span>登记时间:</span>
		<input id="createAtStartTime" class="easyui-datetimebox"/>
		<input id="createAtEndTime" class="easyui-datetimebox"/>
								
		<span>登记人员:</span>
		<input id="searchCreateUser" class="easyui-combobox"  required="true"
				data-options="
						url:'../userServlet.do?sign=selected',
						method:'post',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				">
		<span>店铺名称:</span>
		<input id="searchShopId" class="easyui-combobox"  required="true"
				data-options="
						url:'../shopServlet.do?sign=select',
						method:'post',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				">
				
		<span>产品:</span>
		<input type="hidden" id="searchGoodsId">
		<input id="searchGoodsName" style="line-height:26px;border:1px solid #ccc" readonly="true" onclick="choseProduct('searchGoodsId','searchGoodsName')">
		<span>是否已返款:</span>
		<select id="isPay" style="line-height:26px;border:1px solid #ccc">
			<option value="">全部 </option>
			<option value="0">未返款 </option>
			<option value="1">已返款</option>
		</select>
		
		<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">搜索</a>
	</div>	
	<table id="dg" title="操作列表" class="easyui-datagrid" style="width:1700px;height:1000px"
			url="../freshOrderServlet.do?sign=list"
			toolbar="#toolbar"
			singleSelect="true"
			pagination="true">
	</table>

	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加记录</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑记录</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroy()">删除记录</a>
	</div>
	
	<div id="shade" style="display:none;background:rgba(0,0,0,0.6);width:2000px;height:800px;position:fixed;top:0px;left:1px;">
		<img src="" style="display:block;margin:100px auto;max-height:800px;"/>
	</div>
</body>
<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
<jsp:include page="popProduct.jsp" flush="true"/>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#dg').datagrid({
		columns:[[
			{field:'id',title:'编号', width:50,align:'center'},
			{field:'createUserName',title:'操作人', width:60,align:'left'},
			{field:'orderSn',title:'订单号', width:180,align:'left'},
			{field:'shopName',title:'店铺', width:120,align:'left'},
			{field:'goodsName',title:'商品', width:120,align:'left'},
			{field:'contractType',title:'联系方式', width:80,align:'left'},
			{field:'contractAccount',title:'联系账号', width:120,align:'left'},
			{field:'commision',title:'佣金', width:50,align:'left'},
			{field:'orderAmount',title:'订单金额', width:80,align:'left'},
			{field:'keyWords',title:'关键词', width:100,align:'left'},
			{field:'keyImage',title:'关键图片', width:80,align:'center',
				formatter: function(value,row,index){
				if (row.id){
					return "<a href='javascript:showBig(\""+value+"\")'>查看</a>";
				} else {
					return value;
				}
			}},
			{field:'createAt',title:'登记时间', width:150,align:'left'},
			{field:'remark',title:'操作员备注', width:150,align:'left'},
			
		]]
	});
	
	//显示常用产品
	if(getCookie('product1')){
		var ht = "<a href='' data-pid='"+getCookie('product1')+"' data-sid='"+getCookie('shopId')+"' class='normal'>"+getCookie('product1_name')+"</a>";
		$('#cookie_list').append(ht);
	}
	
	$('.normal').click(function(e){
		console.log($(this).attr('data-pid'));
		console.log($(this).text());
		$('#curForm input[name=goodsId]').val($(this).attr('data-pid'));
		$('#curForm input[name=shopId]').val($(this).attr('data-sid'));
     	$('#curForm input[name=goodsName]').val($(this).text());
     	
     	e.preventDefault();
	})
	
	$('#shade').click(function(){
		$(this).hide();
	})
	
	var goodsId = <%=goodsId%>;
	if(goodsId){
		$('#dg').datagrid('load',{
     		eq_goodsId: goodsId
     	});
	}
});
	function showBig(img){
		console.log(img);
		$('#shade img').attr('src',img);
		$('#shade').show(1000);
	}

     function add(){
        $('#panel_add').dialog('open').dialog('setTitle','新增记录');
     	$('#curForm').form('clear');
     	url = '../freshOrderServlet.do?sign=add';
     }
     
     function edit(){
    	 
    	//$('#fileUpload').remove();
    	$('#panel_add').dialog('open').dialog('setTitle','编辑记录');
     	var row = $('#dg').datagrid('getSelected');
     	console.log(row);
     	if(row == null){            		
     		$.messager.show({
				title: '提示',
				msg: '请选择以一条记录~'
			});
     	}
     	if (row){            		
     		$('#curForm').form('load',row);
     		url = '../freshOrderServlet.do?sign=edit&id='+row.id;
     	}
     }
     function doSearch(){
     	$('#dg').datagrid('load',{
     		eq_shopId: $('#searchShopId').val(),
     		eq_createUser:$('#searchCreateUser').val(),
     		eq_goodsId: $('#searchGoodsId').val(),
     		eq_isPay: $('#isPay').val(),
     		be_start_createAt:$('#createAtStartTime').val(),
     		be_end_createAt:$('#createAtEndTime').val(),
     	});
     }
     
     function save(){
     	$('#curForm').form('submit',{
     		url: '../freshOrderServlet.do?sign=add',
     		onSubmit: function(){
     			return $(this).form('validate');
     		},
     		success: function(result){
     			var result = eval('('+result+')');
     			$.messager.show({
 					title: '消息',
 					msg: result.data
 				});
     			
     			if (result.result){

     				$('#dg').datagrid('reload');	// reload the user data
     				//window.location.reload();
     				$('#curForm input[name=contractAccount]').val('');
     				$('#curForm input[name=commision]').val('');
     				$('#curForm input[name=orderAmount]').val('');
     				$('#curForm input[name=keyWords]').val('');
     				$('#curForm input[name=remark]').val('');
     				$('#curForm input[name=keyImage]').val('');
     			}
     		}
     	});
     }
     
     function destroy(){

 			var row = $('#dg').datagrid('getSelected');
 			if (row){
 				$.messager.confirm('Confirm','确定删除吗?',function(r){
 					if (r){
 						$.post('../freshOrderServlet.do?sign=delete',{id:row.id},function(result){
 							if (result.result){
 								$('#dg').datagrid('reload');	// reload the user data
 							} else {
 								$.messager.show({	// show error message
 									title: 'Error',
 									msg: result.errorMsg
 								});
 							}
 						},'json');
 					}
 				});
 			}
    		
     }
     
     function choseProduct(query_id,query_name){
     	$('#query_id').val(query_id);
     	$('#query_name').val(query_name);
     	$('#product_win').dialog('open');
     }
     
    function okWin(){
		 var row = $('#product_result').datagrid('getSelected');
     	console.log(row);
     	
     	console.log();
     	$('#'+$('#query_id').val()).val(row.tid);
     	$('#'+$('#query_name').val()).val(row.title);
     	$("#curForm input[name=shopId]").val(row.shopId);

     	setCookie('product1',row.tid);
     	setCookie('product1_name',row.title);
     	setCookie('shopId',row.shopId);
     	
     	$('#product_win').dialog('close');
	}
    
    
function setCookie(name,value,days){
        var exp=new Date();
        exp.setTime(exp.getTime() + days*24*60*60*1000);
        var arr=document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
        document.cookie=name+"="+escape(value)+";expires="+exp.toGMTString();
}
    
function getCookie(name){
        var arr=document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
        if(arr!=null){
                return unescape(arr[2]);
                return null;
        }
}
</script>    
</html>
