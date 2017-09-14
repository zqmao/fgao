<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%-- <%
	//管理员展示有增删改的按钮
	PermissionUtil.checkAdmin(request, response);
%> --%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>售后管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/templatecss.css"/>
	<script type="text/javascript">
			var courierNum = "";
			var shopName ="";
			var goodsName ="";
			var orderNum = "";
			var phoneNum = "";
			var allSearch = "";
			var expressName2 = "";
			var option_express = "0";
			var option_express2 = "0";
			var option_express3 = "0";
			var ids = "";
            $(function() {
            	/* $("#displayId").hide();  */
            	$("#addOrderlist").panel({
            		title: '添加需要补发记录',
            		
            		});
            	$("#searchOrderlist").panel({
            		title: '搜索',
            		
            	});
            	$("#courierNumAscr").panel({
            		title: '补发快递记录',
            		
            	});
            	
            	 /* 查询时获取快递名称 */
            	 $("#option_express2").combobox({
                     url:'../exportOrderListServlet.do?sign=select',
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
            	
                $("#addOrderlist").panel("open");
                $("#grant").dialog("close");
                $("#eolistGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../exportOrderListServlet.do?sign=list",
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, 
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum,allSearch : allSearch},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '数据导入者', field: 'exportor', width: 90, align: 'center'},
                           
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            {title: '订单编号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '收货地址', field: 'address', width: 120, align: 'center', formatter:formatCellTooltip},
                            {title: '手机号码', field: 'phoneNum', width: 120, align: 'center'},
                            {title: '宝贝标题', field: 'goodsHeadline', width: 120, align: 'center'},
                            
                            {title: '支付宝账号', field: 'alipayNum', width: 90,align: 'center'},
                            {title: '实际金额', field: 'actualMoney', width: 80, align: 'center'},
                            {title: '收货人姓名', field: 'consigneeName', width: 100,align: 'center'},
                            {title: '导入时间', field: 'exportTime', width: 130, align: 'center'},
                            {title: '订单创建时间', field: 'orderCreateTime', width: 120, align: 'center'},
                            {title: '订单付款时间', field: 'orderTime', width: 120, align: 'center'},
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    toolbar: [{
                        iconCls: 'icon-add',
                        text: '增加',
                        handler: function() {
                            $("#addOrderlist").form("clear");
                            $("#addOrderlist").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            ids = getChecked("eolistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#eolistGrid").datagrid("getChecked");
                                $("#addOrderlist").panel("open");
                                $("#addOrderlist").form("load", {
                                	orderlistId: row[0].id,
                                    address:row[0].address,
                                    shopName:row[0].shopName,
                                    goodsName: row[0].goodsName,
                                    wangwang: row[0].wangwang,
                                    orderNum: row[0].orderNum,
                                    courierNum: row[0].courierNum,
                                    expressName:row[0].expressName,
                                    remark:row[0].remark,
                                    /* bounceType:row[0].bounceType
                                    status: row[0].status,
                                    issueDocumentor:row[0].issueDocumentor,
                                    expressName:row[0].expressName,
                                    courierNum: row[0].courierNum,
                                    issuRemark:row[0].issuRemark, */
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("eolistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../exportOrderListServlet.do?sign=delete",
                                            data: "orderlistIds=" + ids,
                                            success: function(msg) {
                                                $("#eolistGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }]
                });
            });

            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
            function cancel(){
            	$("#addOrderlistForm").form("clear");
            }
            function cancelReissue(){
            	$("#addEreissuelistForm").form("clear");
            }
            
            function searchCancel(){
            	$("#searchOrderlist").panel("close");
            }
            function searchClear(){
            	$("#searchOrderlistForm").form("clear");
            }
            //
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
             
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
           /*  function changeGoods(){
            	//var value  = $('input[name="bounceType"]:checked').val(); //获取被选中Radio的Value值
            	$("#displayId").show();
            	//$('#courierNum3').attr("disabled",true); 
            	//var Num3 = $('#courierNum3').html();
            }
            function changeDisplay(){
            	$("#displayId").hide();
            	$("#displayId").form("clear");
            } */
            //查询
            function submitSearch(){
            	
            	allSearch = $("#allSearch").val();
            	
            	var queryParams =$("#eolistGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.shopName = shopName;
            	queryParams.allSearch = allSearch;
            	queryParams.expressName2 = expressName2;
            	$("#searchOrderlistForm").form("submit",{
            		url:"../exportOrderListServlet.do?sign=search",
            		success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							/* $("#searchAscrForm").form("clear"); */
        					$("#eolistGrid").datagrid("reload");
        					
				    	}
				    }		
            	});
            	
            }
            
         
            function submitAdd() {
				$("#addOrderlistForm").form("submit", {
				    url:"../exportOrderListServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		alert(data.reason);
							$("#addOrderlistForm").form("clear");
        					$("#eolistGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
            function submitCourierNum() {
				$("#courierNumAscrForm").form("submit", {
				    url:"../exportOrderListServlet.do?sign=addcourierNum",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#courierNumAscrForm").form("clear");
        					$("#eolistGrid").datagrid("reload");
				    	}
				    }
				});
			}
        </script>
	</head>

	<body class="easyui-layout">
		<div title="excle表记录" class="easyui-panel" style="width: 100%">
			<table id="eolistGrid" style="height: 340px;"></table>
		</div>
	<div style="width:40%; position:relative">
		<div id="addOrderlist" class="easyui-panel" title="拆包记录列表" style="width: 98%; height: 500px;padding: 10px;z-index:3">
			 <!-- <form id="addOrderlistForm" method="post">
				<input type="hidden"  name="orderlistId" value="" />
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitAdd();">确定</a>
						</td>
					</tr>
				</table>
				<input type="file">
			</form> -->
			<form id="addOrderlistForm" name="orderlistId" enctype="multipart/form-data" method="post">
		        <!-- <table border="0" align="center">
		            <tr>
		                <td>上传文件：</td>
		                <td><input name="file" type="file" size="20"></td>
		            </tr>
		            <tr>
		                <td></td>
		                <a class="custom" onclick="submitAdd();">确定</a>
		                <td><input type="submit" onclick="submitAdd();" name="submit" value="确定"></td>
		            </tr>
		        </table> -->
		        <div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td >
							<input name="file" style="margin-left:50px;margin-top:20px;" type="file" size="20">
						</td>
					</tr>
					<tr>
						<td>
							<a style="margin-left:50px;margin-top:20px;" class="custom" onclick="submitAdd();">确定</a>
						</td>
					</tr>
				</table>
			</div>
		        
		        
    </form>
		</div> 
		
		</div>
		
		 <div style="width:40%;position:absolute;right:1px;top:368px;">
		
		<div id="searchOrderlist" class="easyui-panel" title="搜索" style="width: 98%; height: 500px;padding: 10px;">
			<form id="searchOrderlistForm" method="post">
				<table>
				
					<tr >
						<td>全文搜索:</td>
						<td><input class="easyui-validatebox" name="allSearch" id="allSearch" type="text" style="width: 250px;"/><td>
				    </tr>
					<!-- <tr >
				        <td>快递名称:</td>
				        <td><input class="easyui-combobox" id="option_express2" style="width:250px;margin-left:5px;" name="expressName2" /></td>
				    </tr>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum2" type="text" style="width: 250px;" id="courierNum"/></td>
				    </tr>
				    <tr >
						<td>商铺名称:</td>
						<td>
							<select class="easyui-combobox" name="shopName2" id="shopName" style="width:250px;">
								<option value="" selected="selected" >全部</option>
							    <option value="新祈源数码专营店" >新祈源数码专营店</option>
							    <option value="义吉隆数码专营店" >义吉隆数码专营店</option>
							    <option value="索爱恒先专卖店" >索爱恒先专卖店</option>
							    <option value="altay旗舰店" >altay旗舰店</option>
							</select>
						</td>
				    </tr>
				 	<tr >
						<td>补发物品:</td>
						<td><input class="easyui-validatebox" name="goodsName2" id="goodsName" type="text" style="width: 250px;"/></td>
				    </tr>
				    <tr >
						<td>订单号:</td>
						<td><input class="easyui-validatebox" name="orderNum2" id="orderNum" type="text" style="width: 250px;" /></td>
				    </tr>
				    <tr >
						<td>手机号:</td>
						<td><input class="easyui-validatebox" name="phoneNum2" id="phoneNum" type="text" style="width: 250px;"/></td>
				    </tr> -->
			    </table>
			</form>
			
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitSearch();">确定</a>
						</td>
						<td>
							<a class="recharge" onclick="searchClear();">清除</a>
						</td>
						<td>
							<a class="recharge" onclick="searchCancel();">取消</a>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
		</div> 
	</body>
</html>
