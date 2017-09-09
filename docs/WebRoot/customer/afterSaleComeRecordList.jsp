<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
     PermissionUtil.check(request, response);
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>售后管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
			var courierNum = "";
			var shopName ="";
			var goodsName ="";
			var orderNum = "";
			var phoneNum = "";
			var expressName2 = "";
			var first_express = 1;
			var option_express = "0";
			var second_express = 1;
			var option_express2 = "0";
            $(function() {
            	$("#addAscr").panel({
            		title: '添加售后收货记录',
            		});
            	$("#searchAscr").panel({
            		title: '售后收货记录搜索',
            	});
            	/* 获取快递名称 */
           	 $("#option_express").combobox({
                    url:'../afterSaleComeRecordServlet.do?sign=select',
                    valueField:'text',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_express").combobox('select',"请选择:");
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	}
                }
                );
           	 /* 查询时获取快递名称 */
           	 $("#option_express2").combobox({
                    url:'../afterSaleComeRecordServlet.do?sign=select',
                    valueField:'text',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_express2").combobox('select',"全部");
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	}
                }
                );
            	
                $("#addAscr").panel("open");
                $("#grant").dialog("close");
                $("#ascrGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, 
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum},
                    url: "../afterSaleComeRecordServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '快递单号', field: 'courierNum', width: 120},
                            {title: '物品名称', field: 'goodsName', width: 120, align: 'center'},
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            {title: '快递名称', field: 'expressName', width: 120, align: 'center'},
                            {title: '检查结果', field: 'checkResult', width: 120, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '手机号', field: 'phoneNum', width: 120, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '创建人员', field: 'creator', width: 100, align: 'center'},
                            {title: '创建时间', field: 'createTime', width: 180, align: 'center'},
                            {title: '收件时间', field: 'entryTime', width: 180, align: 'center'},
                            {title: '备注', field: 'remark', width: 100, align: 'center', formatter:formatCellTooltip},
                            {title: '状态', field: 'status', width: 100, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                   
                });
            });

            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
            function cancel(){
            	$("#addAscr").panel("close");
            }
            function searchCancel(){
            	$("#searchAscr").panel("close");
            }
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            //查询
            function submitSearch(){
            	courierNum = $("#courierNum").val();
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	phoneNum = $("#phoneNum").val();
            	shopName = $("#shopName").val();
            	expressName2 = $("#option_express2").val();
            	var queryParams =$("#ascrGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.shopName = shopName;
            	queryParams.expressName2 = expressName2;
            	$("#searchAscrForm").form("submit",{
            		url:"../afterSaleComeRecordServlet.do?sign=search",
            		success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							/* $("#searchAscrForm").form("clear"); */
        					$("#ascrGrid").datagrid("reload");
        					
				    	}
				    }		
            	});
            	
            }
            function submitAdd() {
				$("#addAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addAscrForm").form("clear");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				});
			}
			
        </script>
	</head>

	<body class="easyui-layout">
	
		<div title="售后收货记录列表" class="easyui-panel" style="width: 100%">
			<table id="ascrGrid" style="height: 340px;"></table>
		</div>
	<div style="width:48%; position:relative">
		<div id="addAscr" class="easyui-panel" title="添加售后收货记录" style="width: 98%; height: 500px;padding: 10px;">
			<form id="addAscrForm" method="post">
				<input type="hidden" name="ascrId" value="" />
				<table>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum" type="text" style="width: 250px;" data-options="required:true"/><td>
				    </tr>
				   <tr >
						<label for="option_express" style="font-size: 16px;margin-left: 3px;margin-right:3px">快递名称:</label>
				        <input class="easyui-combobox" id="option_express" style="width:250px;margin-left:5px;" name="expressName" />
				    </tr>
				    </tr>
				    <tr >
						<td>商铺名称:</td>
						<td><select class="easyui-combobox" name="shopName" id="" style="width:250px;">
							<option value="" selected="selected">请选择:</option>
						    <option value="新祈源数码专营店" >新祈源数码专营店</option>
						    <option value="义吉隆数码专营店" >义吉隆数码专营店</option>
						    <option value="索爱恒先专卖店" >索爱恒先专卖店</option>
						    <option value="altay旗舰店" >altay旗舰店</option>
						</select><td>
				    </tr>
				 	<tr >
						<td>物品名称:</td>
						<td><input class="easyui-validatebox" name="goodsName" type="text" style="width: 250px;" data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>检测结果:</td>
						<td><input class="easyui-validatebox" name="checkResult" type="text" style="width: 250px;" data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>订单号:</td>
						<td><input class="easyui-validatebox" name="orderNum" type="text" style="width: 250px;"/><td>
				    </tr>
					
				   
				    <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>手机号:</td>
						<td><input class="easyui-validatebox" name="phoneNum" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><textarea name="remark" style="width:100%;height:100px" style="width: 400px;" ></textarea><td>
				    </tr>
				    <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" checked="checked" />待处理
							<input type="radio" name="status" value="已处理" />已处理
						<td>
						
				    </tr>
			    </table>
			</form>
			<button style="margin: 30px 50px;font-size: 24px;border-radius: 9px;background-color: #b7d2ff;" onclick="submitAdd();">
			确定
			</button>
			<button style="margin: 30px 50px;font-size: 24px;border-radius: 9px;background-color: #b7d2ff;" onclick="cancel();">
			取消
			</button>
		</div>
		</div>
		<div style="width:48%;position:absolute;right:1px;top:368px">
		
		<div id="searchAscr" class="easyui-panel" title="售后收货记录搜索" style="width: 98%; height: 500px;padding: 10px;">
			<form id="searchAscrForm" method="post">
				<table>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum2" type="text" style="width: 250px;" id="courierNum"/><td>
				    </tr>
				    <tr >
				        <label for="option_express2" style="font-size: 16px;margin-left: 3px;margin-right:3px">快递名称:</label>
				        <input class="easyui-combobox" id="option_express2" style="width:250px;margin-left:5px;" name="expressName2" />
				    </tr>
				    <tr >
						<td>商铺名称:</td>
						<td><select class="easyui-combobox" name="shopName2" id="shopName" style="width:250px;">
							<option value="" selected="selected" >全部</option>
						    <option value="新祈源数码专营店" >新祈源数码专营店</option>
						    <option value="义吉隆数码专营店" >义吉隆数码专营店</option>
						    <option value="索爱恒先专卖店" >索爱恒先专卖店</option>
						    <option value="altay旗舰店" >altay旗舰店</option>
						</select><td>
				    </tr>
				 	<tr >
						<td>物品名称:</td>
						<td><input class="easyui-validatebox" name="goodsName2" id="goodsName" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>订单号:</td>
						<td><input class="easyui-validatebox" name="orderNum2" id="orderNum" type="text" style="width: 250px;" /><td>
				    </tr>
				    <tr >
						<td>手机号:</td>
						<td><input class="easyui-validatebox" name="phoneNum2" id="phoneNum" type="text" style="width: 250px;"/><td>
				    </tr>
			    </table>
			</form>
			<button style="margin: 40px 60px;font-size: 24px;border-radius: 9px;background-color: #b7d2ff;" onclick="submitSearch();">
			确定
			</button>
			<button style="margin: 30px 50px;font-size: 24px;border-radius: 9px;background-color: #b7d2ff;" onclick="searchClear();">
			清除
			</button>
			<button style="margin: 30px 50px;font-size: 24px;border-radius: 9px;background-color: #b7d2ff;" onclick="searchCancel();">
			取消
			</button>
		</div>
		</div>
	</body>
</html>
