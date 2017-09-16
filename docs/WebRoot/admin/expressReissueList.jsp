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
			var status = "";
			var expressName2 = "";
			var option_express = "0";
			var option_express2 = "0";
			var option_express3 = "0";
			var ids = "";
            $(function() {
            	/* $("#displayId").hide();  */
            	$("#addErlist").panel({
            		title: '添加需要补发记录',
            		
            		});
            	$("#searchErlist").panel({
            		title: '搜索',
            		
            	});
            	$("#courierNumAscr").panel({
            		title: '补发快递记录',
            		
            	});
            	/* 获取快递名称 */
            	 $("#option_express").combobox({
                     url:'../expressReissueServlet.do?sign=select',
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
                 });
            	 /* 添加记录时获取快递名称 */
            	 $("#option_express3").combobox({
                     url:'../expressReissueServlet.do?sign=select',
                     valueField:'text',
                     textField:'text',
                     loadFilter: function(data){
                    		if (data.data){
                    			$("#option_express3").combobox('select',"请选择:");
                    			return data.data;
                    		} else {
                    			return data;
                    		}
                    	}
                 }
                 );
            	
            	 /* 查询时获取快递名称 */
            	 $("#option_express2").combobox({
                     url:'../expressReissueServlet.do?sign=select',
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
            	
                $("#addErlist").panel("open");
                $("#grant").dialog("close");
                $("#erlistGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../expressReissueServlet.do?sign=list",
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, 
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum, status :status},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                            {title: '登记时间', field: 'entryTime', width: 130, align: 'center'},
                            {title: '补发地址', field: 'address', width: 120, align: 'center',formatter:formatCellTooltip},
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            {title: '物品名称', field: 'goodsName', width: 120, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '备注', field: 'remark', width: 120, align: 'center', formatter:formatCellTooltip},
                            
                            {title: '状态', field: 'status', width: 100, align: 'center'},
                            
                            
                            {title: '打单人员', field: 'issueDocumentor', width: 90,align: 'center'},
                            {title: '快递名称', field: 'expressName', width: 80, align: 'center'},
                            {title: '快递单号', field: 'courierNum', width: 100,align: 'center'},
                            {title: '打单时间', field: 'issuTime', width: 130, align: 'center'},
                            {title: '打单备注', field: 'issuRemark', width: 120, align: 'center', formatter:formatCellTooltip},
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
                            $("#addErlist").form("clear");
                            $("#addErlist").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            ids = getChecked("erlistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#erlistGrid").datagrid("getChecked");
                                $("#addErlist").panel("open");
                                $("#addErlist").form("load", {
                                    erlistId: row[0].id,
                                    address:row[0].address,
                                    shopName:row[0].shopName,
                                    goodsName: row[0].goodsName,
                                    wangwang: row[0].wangwang,
                                    orderNum: row[0].orderNum,
                                    courierNum: row[0].courierNum,
                                    expressName:row[0].expressName,
                                    remark:row[0].remark,
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("erlistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../expressReissueServlet.do?sign=delete",
                                            data: "erlistIds=" + ids,
                                            success: function(msg) {
                                                $("#erlistGrid").datagrid("reload");
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
            	$("#addErlistForm").form("clear");
            }
            function cancelReissue(){
            	$("#addEreissuelistForm").form("clear");
            }
            
            function searchCancel(){
            	$("#searchErlist").panel("close");
            }
            function searchClear(){
            	$("#searchErlistForm").form("clear");
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
            	courierNum = $("#courierNum").val();
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	phoneNum = $("#phoneNum").val();
            	shopName = $("#shopName").val();
            	/* var status = $('input[name="statuss"]:checked').val(); */
            	status = $("#status").val();
            	expressName2 = $("#option_express2").val();
            	var queryParams =$("#erlistGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.status = status;
            	queryParams.shopName = shopName;
            	queryParams.expressName2 = expressName2;
            	$("#searchErlistForm").form("submit",{
            		url:"../expressReissueServlet.do?sign=search",
            		success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							/* $("#searchAscrForm").form("clear"); */
        					$("#erlistGrid").datagrid("reload");
        					
				    	}
				    }		
            	});
            	
            }
            
            function submitReissue(){
         
            	var erlistId; 
            	var ids = getChecked("erlistGrid");
            	
            	var shopName=getFormDate("erlistGrid","shopName");
            	
            	var goodsName = getFormDate("erlistGrid","goodsName");
            	
            	var address = getFormDate("erlistGrid","address");
            	
            	$("#updateId").val(ids);
                var len = ids.length;
                if (len == 0) {
                    $.messager.alert('提示', '至少选择一个', 'Warning');
                } else if (len > 1) {
                    $.messager.alert('提示', '只能选择一个', 'Warning');
                } else {
                	$("#reissueInf1").html("你正在补发的是编号为"+ids+"的数据");
                	$("#reissueInf2").html("商铺名称是:"+shopName);
                	$("#reissueInf3").html("物品名称是:"+goodsName);
                	$("#reissueInf4").html("地址是:"+address);
                }      
                  
            }
            
            function getFormDate(id,valName) {
            	var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
             
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i][valName]);
                }
                return ids;
            }
           /*  function addMessage(){
            	var bounceVal = $('input[name="bounceType"]:checked').val();
            	if("换货"==bounceVal){
            		var cou = $("#courierNum3").val();
            		//var opt = $("#option_express3").val();   ||(opt==null || opt.length==0)
            		if((cou==null || cou.length==0)){
            			 $.messager.alert('提示', '当选择换货时，快递单号不能为空', 'Warning');
            			 alert("当选择换货时，快递名称和快递单号不能为空"); 
            		}else{
            			submitAdd();
            		}
            	}else{
            		submitAdd();
            	}
            } 
            */
            function submitAdd() {
				$("#addErlistForm").form("submit", {
				    url:"../expressReissueServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#displayId").hide();
							$("#addErlistForm").form("clear");
        					$("#erlistGrid").datagrid("reload");
				    	}
				    }
				});
			}
            function changeStatus(){
            	$('#courierNum3').attr("disabled","disabled"); 
            	$("#expressName3").hide();
            }
            function changeStatus2(){
            	$('#courierNum3').attr("disabled",false); 
            	$("#expressName3").show();
            }
            function submitReissueAdd(){
            	var erlistId;
            	var ids = getChecked("erlistGrid");
                $("#updateId").val(ids);
                
                var len = ids.length;
                if (len == 0) {
                    $.messager.alert('提示', '至少选择一个', 'Warning');
                } else if (len > 1) {
                    $.messager.alert('提示', '只能选择一个', 'Warning');
                } else {
                	 var value  = $('input[name="status"]:checked').val(); //获取被选中Radio的Value值
                     if(value == "待处理"){
                     	var iss = $("#issuRemark").val();
                     	if(iss==null||iss.length==0){
                     		alert( '当选择待处理时,打单备注不能为空');
                     	}else{
                     		$("#addEreissuelistForm").form("submit", {
            				    url:"../expressReissueServlet.do?sign=reissueAdd",
            				    success:function(result){
            				    	var data = eval('(' + result + ')');
            				    	if(data.result == 0){
            				    		alert(data.reason);
            				    	}else{
            							$("#addEreissuelistForm").form("clear");
                    					$("#erlistGrid").datagrid("reload");
                    					//成功时将显示数据清除
                    					$("#reissueInf1").html("");
                                    	$("#reissueInf2").html("");
                                    	$("#reissueInf3").html("");
                                    	$("#reissueInf4").html("");
            				    	}
            				    }
            				});
                     	}
                     }else{
                    	 $("#addEreissuelistForm").form("submit", {
         				    url:"../expressReissueServlet.do?sign=reissueAdd",
         				    success:function(result){
         				    	var data = eval('(' + result + ')');
         				    	if(data.result == 0){
         				    		alert(data.reason);
         				    	}else{
         							$("#addEreissuelistForm").form("clear");
                 					$("#erlistGrid").datagrid("reload");
         				    	}
         				    }
         				}); 
                     }
                }
            	
            	
            }
            function submitCourierNum() {
				$("#courierNumAscrForm").form("submit", {
				    url:"../expressReissueServlet.do?sign=addcourierNum",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#courierNumAscrForm").form("clear");
        					$("#erlistGrid").datagrid("reload");
				    	}
				    }
				});
			}
        </script>
	</head>

	<body class="easyui-layout">
		<!-- <div title="售后收货记录" class="easyui-panel" style="width: 100%">
			<table id="erlistGrid" style="height: 340px;"></table>
		</div> -->
		<table style="width:100%">
			<tr>
				<td style="width:40%">
					
					<div>
		<div id="addErlist" class="easyui-panel" title="拆包记录列表" style="width: 98%; height: 450px;padding: 10px;z-index:3">
			<form id="addErlistForm" method="post">
				<input type="hidden"  name="erlistId" value="" />
				<table style="" >
					<tr id="ershopName" >
						<td>商铺名称:</td>
						<td><select class="easyui-combobox" name="shopName"  style="width:250px;">
							<option value="" selected="selected">请选择:</option>
						    <option value="新祈源数码专营店" >新祈源数码专营店</option>
						    <option value="义吉隆数码专营店" >义吉隆数码专营店</option>
						    <option value="索爱恒先专卖店" >索爱恒先专卖店</option>
						    <option value="altay旗舰店" >altay旗舰店</option>
						</select><td>
				    </tr>
				    <tr >
						<td>补发地址:</td>
						<td><input class="easyui-validatebox" name="address" type="text" style="width: 250px;" data-options="required:true" /><td>
				    </tr>
					<tr >
						<td>补发物品:</td>
						<td><input class="easyui-validatebox" name="goodsName" type="text" style="width: 250px;" data-options="required:true" /><td>
				    </tr>
				    <tr >
						<td>订单号:</td>
						<td><input class="easyui-validatebox" name="orderNum" type="text" style="width: 250px;" data-options="required:true" /><td>
				    <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><textarea name="remark" style="width:250px;height:100px" ></textarea><td>
				    </tr>
			    </table>
			</form>
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitAdd();">确定</a>
						</td>
						<td>
							<a class="recharge" onclick="cancel();">清除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
		
					
				</td>
				<td style="width:30%">
				
				<div>
		<div id="addEreissuelist" class="easyui-panel" title="补发快递记录" style="width: 98%; height: 450px;padding: 10px;">
			<form id="addEreissuelistForm" method="post">
				<input type="hidden" id="updateId" name="updateId" value="" />
				<table>
				    <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" onclick="changeStatus()" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="status" value="已处理" onclick="changeStatus2()" checked="checked" id="overManage"/><label for="overManage">已处理</label>
						<td>
				    </tr>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum" id="courierNum3" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr id="expressName3" >
						<td><label for="option_express" style="font-size: 16px;">快递名称:</label></td>
						
				        <td><input class="easyui-combobox" id="option_express" style="width:250px;margin-left:5px;" name="expressName" /></td>
				    </tr>
				    <tr >
						<td>打单备注:</td>
						<td><textarea id="issuRemark" name="issuRemark" style="width:100%;height:100px" style="width: 400px;" ></textarea><td>
				    </tr>
			    </table>
			</form>
			
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitReissue();">补发</a>
						</td>
						<td>
							<a class="recharge" onclick="submitReissueAdd();">确定</a>
						</td>
						<td>
							<a class="recharge" onclick="cancelReissue();">清除</a>
						</td>
					</tr>
				</table>
			</div>
			
			<div>
				<div ><span id="reissueInf1" style="color: red;font-size: 19px;"></span></div>
				<div ><span id="reissueInf2" style="color: red;font-size: 19px;"></span></div>
				<div ><span id="reissueInf3" style="color: red;font-size: 19px;"></span></div>
				<div ><span id="reissueInf4" style="color: red;font-size: 19px;"></span></div>
			</div>
		</div>
		</div>
		
				
				</td>
				<td style="width:30%">
				
					 <div>
		
		<div id="searchErlist" class="easyui-panel" title="搜索" style="width: 98%; height: 450px;padding: 10px;">
			<form id="searchErlistForm" method="post">
				<table>
					<tr >
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
				    </tr>
				    <!-- <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="statuss" value="待处理" checked="checked" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="statuss" value="已处理" id="overManage"/><label for="overManage">已处理</label>
						<td>
				    </tr> -->
				     <tr >
						<td>处理状态:</td>
						<td><input class="easyui-validatebox" name="status2" id="status" type="text" style="width: 250px;"/></td>
				    </tr> 
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
				
				</td>
				
			</tr>
		</table>
	
			
		
		<div title="售后收货记录" class="easyui-panel" style="width: 100%">
			<table id="erlistGrid" style="height: 340px;"></table>
		</div>
	</body>
</html>
