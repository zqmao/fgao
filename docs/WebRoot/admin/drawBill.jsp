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
			var creator = "";
			var afterSaTor = "";
			var wangwang = "";
			var expressName2 = "";
			var option_express = "0";
			var option_express2 = "0";
			var option_express3 = "0";
			var ids = "";
            $(function() {
            	$("#reissueId").hide();
            	$("#copySuccess").hide();
            	/* $("#displayId").hide();  */
            	$("#addBilllist").panel({
            		title: '添加发票记录',
            		
            		});
            	$("#searchBilllist").panel({
            		title: '搜索',
            		
            	});
            	$("#courierNumAscr").panel({
            		title: '处理发票记录',
            		
            	});
         
                $("#addBilllist").panel("open");
                $("#grant").dialog("close");
                $("#billlistGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../drawBillServlet.do?sign=list",
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, creator:creator,afterSaTor:afterSaTor, wangwang : wangwang,
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum, status :status},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                           
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            
                            {title: '订单编号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '客户邮箱或手机号', field: 'emailOrPhone', width: 120, align: 'center'},
                            {title: '开票明细', field: 'goodsName', width: 120, align: 'center'},
                            {title: '总金额', field: 'money', width: 100, align: 'center'},
                            {title: '数量', field: 'sum', width: 100, align: 'center'},
                            
                            {title: '状态', field: 'status', width: 100, align: 'center'},
                            
                            
                            {title: '开票人员', field: 'issueDocumentor', width: 90,align: 'center'},
                            {title: '登记时间', field: 'entryTime', width: 130, align: 'center'},
                            {title: '打单时间', field: 'issuTime', width: 130, align: 'center'},
                            {title: '备注', field: 'remark', width: 120, align: 'center', formatter:formatCellTooltip},
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
                            $("#addBilllist").form("clear");
                            $("#addBilllist").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            ids = getChecked("billlistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#billlistGrid").datagrid("getChecked");
                                $("#addBilllist").panel("open");
                                $("#addBilllist").form("load", {
                                	drawBillId: row[0].id,
                                    shopName:row[0].shopName,
                                    goodsName: row[0].goodsName,
                                    billHead: row[0].billHead,
                                    sum: row[0].sum,
                                    orderNum: row[0].orderNum,
                                    emailOrPhone: row[0].emailOrPhone,
                                    tfn: row[0].tfn,
                                    remark:row[0].remark,
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("billlistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../drawBillServlet.do?sign=delete",
                                            data: "drawBillIds=" + ids,
                                            success: function(msg) {
                                                $("#billlistGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    },
                    ]
                }); 
              
            });
      
            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
            function cancel(){
            	$("#addBilllistForm").form("clear");
            }
            function cancelReissue(){
            	$("#addDrawBilllistForm").form("clear");
            }
            
            function searchCancel(){
            	$("#searchBilllist").panel("close");
            }
            function searchClear(){
            	$("#searchBilllistForm").form("clear");
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
        
            //查询
            function submitSearch(){
            	courierNum = $("#courierNum").val();
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	phoneNum = $("#phoneNum").val();
            	shopName = $("#shopName").val();
            	var status = $('input[name="statuss"]:checked').val();
            	//status = $("#status").val();
            	expressName2 = $("#option_express2").val();
            	creator = $("#creator").val();
            	afterSaTor = $("#afterSaTor").val();
            	wangwang = $("#wangwang").val();
            	var queryParams =$("#billlistGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.status = status;
            	queryParams.shopName = shopName;
            	queryParams.expressName2 = expressName2;
            	queryParams.creator =  creator;
            	queryParams.afterSaTor = afterSaTor;
            	queryParams.wangwang = wangwang;
            	$("#searchBilllistForm").form("submit",{
            		url:"../drawBillServlet.do?sign=search",
            		success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							/* $("#searchAscrForm").form("clear"); */
        					$("#billlistGrid").datagrid("reload");
        					
				    	}
				    }		
            	});
            	
            }
            
            function submitReissue(){
         
            	var drawBillId; 
            	var ids = getChecked("billlistGrid");
            	
            	var shopName = getFormDate("billlistGrid","shopName");
            	
            	var goodsName = getFormDate("billlistGrid","goodsName");
            	
            	var address = getFormDate("billlistGrid","address");
            	
            	$("#updateId").val(ids);
                var len = ids.length;
                if (len == 0) {
                    $.messager.alert('提示', '至少选择一个', 'Warning');
                } else if (len > 1) {
                    $.messager.alert('提示', '只能选择一个', 'Warning');
                } else {
                	$("#reissueId").show(300);
                	$("#reissueInf1").html(ids);
                	
                	$("#reissueInf2").html(shopName);
                	$("#reissueInf3").val(goodsName);
                	$("#reissueInf4").val(address);
                	//$("#reissueInf1").html("<a>你正在补发的是编号为"+ids+ "</a>")你正在补发的是编号为"+ids
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
          
            function submitAdd() {
				$("#addBilllistForm").form("submit", {
				    url:"../drawBillServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		alert("122");
				    		$("#displayId").hide();
							$("#addBilllistForm").form("clear");
        					$("#billlistGrid").datagrid("reload");
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
            function submitBillAdd(){
            	var drawBillId;
            	var ids = getChecked("billlistGrid");
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
                     		$("#addDrawBilllistForm").form("submit", {
            				    url:"../drawBillServlet.do?sign=reissueAdd",
            				    success:function(result){
            				    	var data = eval('(' + result + ')');
            				    	if(data.result == 0){
            				    		alert(data.reason);
            				    	}else{
            							$("#addDrawBilllistForm").form("clear");
                    					$("#billlistGrid").datagrid("reload");
                    					//成功时将显示数据清除
                    					$("#reissueId").hide();
                    					$("#reissueInf1").html("");
                                    	$("#reissueInf2").html("");
                                    	$("#reissueInf3").html("");
                                    	$("#reissueInf4").html("");
            				    	}
            				    }
            				});
                     	}
                     }else{
                    	 $("#addDrawBilllistForm").form("submit", {
         				    url:"../drawBillServlet.do?sign=reissueAdd",
         				    success:function(result){
         				    	var data = eval('(' + result + ')');
         				    	if(data.result == 0){
         				    		alert(data.reason);
         				    	}else{
         							$("#addDrawBilllistForm").form("clear");
                 					$("#billlistGrid").datagrid("reload");
         				    	}
         				    }
         				}); 
                     }
                }
            	
            	
            }
            function submitCourierNum() {
				$("#courierNumAscrForm").form("submit", {
				    url:"../drawBillServlet.do?sign=addcourierNum",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#courierNumAscrForm").form("clear");
        					$("#billlistGrid").datagrid("reload");
				    	}
				    }
				});
			}
          
        </script>
	</head>

	<body class="easyui-layout">
		
		<table style="width:100%">
			<tr>
				<td style="width:40%">
					
					<div>
		<div id="addBilllist" class="easyui-panel" title="添加发票记录列表" style="width: 98%; height: 450px;padding: 10px;z-index:3">
			<form id="addBilllistForm" method="post">
				<input type="hidden"  name="drawBillId" value="" />
				<table style="" >
					<!-- <tr id="ershopName" >
						<td>商铺名称:</td>
						<td><select class="easyui-combobox" name="shopName"  style="width:250px;">
							<option value="" selected="selected">请选择:</option>
						    <option value="新祈源数码专营店" >新祈源数码专营店</option>
						    <option value="义吉隆数码专营店" >义吉隆数码专营店</option>
						    <option value="索爱恒先专卖店" >索爱恒先专卖店</option>
						    <option value="altay旗舰店" >altay旗舰店</option>
						</select><td>
				    </tr> -->
				    <tr >
						<td>店铺名称:</td>
						<td><input class="easyui-validatebox" name="shopName" type="text" style="width: 250px;" data-options="required:true" /></td>
				    </tr>
				     <tr >
						<td>订单编号:</td>
						<td><input class="easyui-validatebox" name="orderNum" type="text" style="width: 250px;" data-options="required:true" /></td>
					</tr>
				    <tr >
						<td>发票抬头:</td>
						<td><input class="easyui-validatebox" name="billHead" type="text" style="width: 250px;" data-options="required:true" /></td>
				    </tr>
					<tr >
						<td>开票明细:</td>
						<td><input class="easyui-validatebox" name="goodsName" type="text" style="width: 250px;" data-options="required:true" /></td>
				    </tr>
				    <tr >
						<td>数量:</td>
						<td><input class="easyui-validatebox" name="sum" type="text" style="width: 250px;" data-options="required:true"/></td>
				    </tr>
				    <tr >
						<td>客户邮箱或手机号:</td>
						<td><input class="easyui-validatebox" name="emailOrPhone" type="text" style="width: 250px;" data-options="required:true"/></td>
				    </tr>
				    <tr >
						<td>税号:</td>
						<td><input class="easyui-validatebox" name="tfn" type="text" style="width: 250px;"/></td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><textarea name="remark" style="width:250px;height:100px" ></textarea></td>
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
		<div id="addDrawBilllist" class="easyui-panel" title="开票处理记录" style="width: 98%; height: 450px;padding: 10px;">
			<form id="addDrawBilllistForm" method="post">
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
						<td>开票备注:</td>
						<td><textarea id="billRemark" name="billRemark" style="width:100%;height:100px" style="width: 400px;" ></textarea></td>
				    </tr>
			    </table>
			</form>
			
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="recharge" onclick="submitBillAdd();">开票</a>
						</td>
						<td>
							<a class="recharge" onclick="cancelReissue();">清除</a>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- <div id="reissueId" style="color: red;font-size: 19px;">
				<div ><span>你正在补发的是编号为:</span><span id="reissueInf1" style="color: red;font-size: 19px;width: 160px"></span></div>
				
				<div ><span>商铺名称是:</span><span id="reissueInf2" style="color: red;font-size: 19px;width: 255px"></span></div>
				<div ><span>物品名称是:</span><input id="reissueInf3" value="" style="color: red;font-size: 19px;width: 255px">
				<span onclick="copyToClipboard('reissueInf3')"style="background-color: #9FBEF1;width: 35px;cursor: pointer;" >复制</span></div>
				<div ><span>地址是:</span><input id="reissueInf4" value="" style="color: red;font-size: 19px;width: 293px">
				<span onclick="copyToClipboard('reissueInf4')"style="background-color: #9FBEF1;width: 35px;cursor: pointer;" >复制</span></div>
			</div> -->
		</div>
		</div>
		
				
				</td>
				<td style="width:30%">
				
					 <div>
		
		<div id="searchBilllist" class="easyui-panel" title="搜索" style="width: 98%; height: 450px;padding: 10px;">
			<form id="searchBilllistForm" method="post">
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
				     <tr >
						<td>创建人:</td>
						<td><input class="easyui-validatebox" name="creator" id="creator" type="text" style="width: 250px;"/></td>
				    </tr>
				    <tr >
						<td>售后人员:</td>
						<td><input class="easyui-validatebox" name="afterSaTor" id="afterSaTor" type="text" style="width: 250px;"/></td>
				    </tr>
				     <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang2" id="wangwang" type="text" style="width: 250px;"/></td>
				    </tr>
				     <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="statuss" value="待处理" checked="checked" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="statuss" value="已处理" id="overManage"/><label for="overManage">已处理</label>
						<td>
				    </tr> 
				     <!-- <tr >
						<td>处理状态:</td>
						<td><input class="easyui-validatebox" name="status2" id="status" type="text" style="width: 250px;"/></td>
				    </tr>  -->
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
		<div title="补发快递记录" class="easyui-panel" style="width: 100%">
			<table id="billlistGrid" style="height: 600px;"></table>
		</div>
		
		<div id="copySuccess" style="z-index: 99999;
    margin-top: -47%;
    width: 200px;
    height: 200px;
    margin-left: 30%;
    background-color: #e0ecff;position:absolute;text-align:center;border-radius: 42px;"><p>复制成功</p></div>
		
	</body>
</html>
