<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean drawBill = false;
	if(userId != 0){
		drawBill = PermissionUtil.checkDrawBill(request, response);
	}
%>
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
			var billHead = "";
			var shopName ="";
			var goodsName ="";
			var orderNum = "";
			var emailOrPhone = "";
			var status = "";
			var creatorId = "";
			var tfn = "";
			var Drawingor = "";
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
            	if(<%=drawBill%>){
            		$("#addDrawBilllist").panel("open");
            	}else{
            		$("#addDrawBilllist").panel("close");
            	}
         
                $("#addBilllist").panel("open");
                $("#grant").dialog("close");
                $("#billlistGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../drawBillServlet.do?sign=list",
                    queryParams:{billHead : billHead, Drawingor : Drawingor, creatorId:creatorId, tfn : tfn,
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, emailOrPhone : emailOrPhone, status :status},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '创建人员', field: 'creatorId', width: 90, align: 'center'},
                           
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            
                            {title: '订单编号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '客户邮箱或手机号', field: 'emailOrPhone', width: 120, align: 'center'},
                            {title: '开票明细', field: 'goodsName', width: 120, align: 'center'},
                            {title: '总金额', field: 'money', width: 100, align: 'center'},
                            {title: '数量', field: 'sum', width: 100, align: 'center'},
                            
                            {title: '状态', field: 'status', width: 100, align: 'center'},
                            
                            {title: '开票人员', field: 'drawingor', width: 90,align: 'center'},
                            {title: '登记时间', field: 'entryTime', width: 130, align: 'center'},
                            {title: '开票时间', field: 'billTime', width: 130, align: 'center'},
                            {title: '备注', field: 'remark', width: 120, align: 'center', formatter:formatCellTooltip},
                            {title: '开票备注', field: 'billRemark', width: 120, align: 'center', formatter:formatCellTooltip},
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
                                    money: row[0].money,
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
            	billHead = $("#billHead").val();
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	emailOrPhone = $("#emailOrPhone").val();
            	shopName = $("#shopName").val();
            	status = $('input[name="statuss"]:checked').val();
            	//status = $("#status").val();
            	Drawingor = $("#Drawingor").val();
            	creatorId = $("#creatorId").val();
            	tfn = $("#tfn").val();
            	var queryParams =$("#billlistGrid").datagrid("options").queryParams;
            	queryParams.billHead = billHead;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.emailOrPhone = emailOrPhone;
            	queryParams.status = status;
            	queryParams.shopName = shopName;
            	queryParams.creatorId =  creatorId;
            	queryParams.Drawingor = Drawingor;
            	queryParams.tfn = tfn;
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
				    		$("#displayId").hide();
							$("#addBilllistForm").form("clear");
        					$("#billlistGrid").datagrid("reload");
				    	}
				    }
				});
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
                     	var bil = $("#billRemark").val();
                     	if(bil==null||bil.length==0){
                     		alert( '当选择待处理时,开票备注不能为空');
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
						<td>总金额:</td>
						<td><input class="easyui-validatebox" name="money" type="text" style="width: 250px;" data-options="required:true" /></td>
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
						<td><input class="easyui-validatebox" name="tfn" type="text" style="width: 250px;" data-options="required:true" /></td>
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
				    <tr>
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="status" value="已处理" checked="checked" id="overManage"/><label for="overManage">已处理</label>
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
							<a class="custom" onclick="submitBillAdd();">开票</a>
						</td>
						<td>
							<a class="recharge" onclick="cancelReissue();">清除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
	</td>
	<td style="width:30%" id="moveLeft">
		<div>
		<div id="searchBilllist" class="easyui-panel" title="搜索" style="width: 98%; height: 450px;padding: 10px;">
			<form id="searchBilllistForm" method="post">
				<table>
					<tr >
						<td>店铺名称:</td>
						<td><input class="easyui-validatebox" name="shopName" id="shopName" type="text" style="width: 250px;" /></td>
				    </tr>
				     <tr >
						<td>订单编号:</td>
						<td><input class="easyui-validatebox" name="orderNum" id="orderNum" type="text" style="width: 250px;" /></td>
					</tr>
				    <tr >
						<td>发票抬头:</td>
						<td><input class="easyui-validatebox" name="billHead" id="billHead" type="text" style="width: 250px;" /></td>
				    </tr>
					<tr >
						<td>开票明细:</td>
						<td><input class="easyui-validatebox" name="goodsName" id="goodsName" type="text" style="width: 250px;" /></td>
				    </tr>
				    <tr >
						<td>客户邮箱或手机号:</td>
						<td><input class="easyui-validatebox" name="emailOrPhone" id="emailOrPhone" type="text" style="width: 250px;"/></td>
				    </tr>
				    <tr >
						<td>税号:</td>
						<td><input class="easyui-validatebox" name="tfn" id="tfn" type="text" style="width: 250px;"/></td>
				    </tr>
				     <tr >
						<td>登记人员:</td>
						<td><input class="easyui-validatebox" name="creatorId" id="creatorId" type="text" style="width: 250px;" /></td>
				    </tr>
				     <tr >
						<td>开票人员:</td>
						<td><input class="easyui-validatebox" name="Drawingor" id="Drawingor" type="text" style="width: 250px;"/></td>
				    </tr>
				     <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="statuss" value="待处理" checked="checked" id="waitManage2" /><label for="waitManage2">待处理</label>
							<input type="radio" name="statuss" value="已处理" id="overManage2"/><label for="overManage2">已处理</label>
						<td>
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
		<div title="开票记录" class="easyui-panel" style="width: 100%">
			<table id="billlistGrid" style="height: 600px;"></table>
		</div>
	</body>
</html>
