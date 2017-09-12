<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean after = false;
	if(userId != 0){
		after = PermissionUtil.checkAfter(request, response);
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
	
			var courierNum = "";
			var shopName ="";
			var goodsName ="";
			var orderNum = "";
			var phoneNum = "";
			var wangwang = "";
			var allSearch="";
			var expressName2 = "";
			var option_express = "0";
			var option_express2 = "0";
			var option_express3 = "0";
			var option_express4 = "0";
            $(function() {
            	$("#displayId").hide(); 
            	$("#addAscr").panel({
            		title: '添加拆包记录',
            		
            		});
            	$("#searchAscr").panel({
            		title: '搜索',
            		
            	});
            	$("#courierNumAscr").panel({
            		title: '收货记录',
            		
            	});
            	 if(<%=after%>){
                 	$("#courierNumAscr").panel("open");
             	}else{
             		$("#courierNumAscr").panel("close");
             		$("#moveLeft").css("right","35%");
             	}
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
                 }
                 );
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
            	 /* 查询时获取快递名称 */
            	 $("#reissueExpressName").combobox({
                     url:'../expressReissueServlet.do?sign=select',
                     valueField:'text',
                     textField:'text',
                     loadFilter: function(data){
                    		if (data.data){
                    			$("#reissueExpressName").combobox('select',"请选择:");
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
                    url: "../afterSaleComeRecordServlet.do?sign=list",
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, 
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum,wangwang :wangwang,allSearch : allSearch},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 50},
                            {title: '快递单号', field: 'courierNum', width: 100},
                            {title: '物品名称', field: 'goodsName', width: 100, align: 'center'},
                            {title: '店铺名称', field: 'shopName', width: 100, align: 'center'},
                            {title: '快递名称', field: 'expressName', width: 50, align: 'center'},
                            {title: '检查结果', field: 'checkResult', width: 100, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 100, align: 'center'},
                            {title: '手机号', field: 'phoneNum', width: 90, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 100, align: 'center'},
                            {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                            {title: '退件类型', field: 'bounceType', width: 90, align: 'center'},
                            {title: '补发快递单号', field: 'reissueCourierNum', width: 100, align: 'center'},
                            {title: '补发快递名称', field: 'reissueExpressName', width: 80, align: 'center'},
                            {title: '补发物品名称', field: 'reissueGoodsName', width: 100, align: 'center'},
                            
                            {title: '拆包时间', field: 'createTime', width: 130, align: 'center'},
                            {title: '收件时间', field: 'entryTime', width: 130, align: 'center'},
                            {title: '备注', field: 'remark', width: 100, align: 'center', formatter:formatCellTooltip},
                            {title: '状态', field: 'status', width: 80, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                   	onBeforeLoad: function(data){
                    	if(<%=after%>){
                    		$("#toolbar-remove-after-add").show();
                    		$("#toolbar-remove-after-edit").show();
                    		$("#toolbar-remove-after-delete").show();
                    	}else{
                    		$("#toolbar-remove-after-add").hide();
                    		$("#toolbar-remove-after-edit").hide();
                    		$("#toolbar-remove-after-delete").hide();
                    		cancel();
                    	}
                    },
                    toolbar: [{
                    	id:'toolbar-remove-after-add',
                        iconCls: 'icon-add',
                        text: '增加',
                        handler: function() {
                            $("#addAscrForm").form("clear");
                            $("#addAscr").panel("open");
                        }
                    }, {
                    	id:'toolbar-remove-after-edit',
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("ascrGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#ascrGrid").datagrid("getChecked");
                                $("#addAscr").panel("open");
                                $("#addAscrForm").form("load", {
                                    ascrId: row[0].id,
                                    courierNum: row[0].courierNum,
                                    expressName:row[0].expressName,
                                    shopName:row[0].shopName,
                                    goodsName: row[0].goodsName,
                                    checkResult: row[0].checkResult,
                                    wangwang: row[0].wangwang,
                                    phoneNum: row[0].phoneNum,
                                    orderNum: row[0].orderNum,
                                    remark: row[0].remark,
                                    status: row[0].status,
                                    bounceType: row[0].bounceType,
                                    reissueCourierNum:row[0].reissueCourierNum,
                                    reissueExpressName:row[0].reissueExpressName,
                                    reissueGoodsName:row[0].reissueGoodsName
                                });
                            }
                        }
                    }, {
                    	id:'toolbar-remove-after-delete',
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("ascrGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../afterSaleComeRecordServlet.do?sign=delete",
                                            data: "ascrIds=" + ids,
                                            success: function(msg) {
                                                $("#ascrGrid").datagrid("reload");
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
            	$("#addAscr").panel("close");
            }
            function allClear(){
            	//$("#addAscr").form("clear");
            	 $("#addAscrForm").form("clear");
            }
            function searchCancel(){
            	$("#searchAscr").panel("close");
            }
            function searchClear(){
            	$("#searchAscrForm").form("clear");
            }
            function courierNumCancel(){
            	$("#courierNumAscr").panel("close");
            }
            function courierNumClear(){
            	$("#courierNumAscrForm").form("clear");
            }
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            function changeGoods(){
            	//var value  = $('input[name="bounceType"]:checked').val(); //获取被选中Radio的Value值
            	$("#displayId").show();
            	//$('#courierNum3').attr("disabled",true); 
            	//var Num3 = $('#courierNum3').html();
            }
            function changeDisplay(){
            	$("#displayId").hide();
            	$("#displayId").form("clear");
            }
            //查询
            function submitSearch(){
            	courierNum = $("#courierNum").val();
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	phoneNum = $("#phoneNum").val();
            	wangwang = $("#wangwang").val();
            	shopName = $("#shopName").val();
            	allSearch = $("#allSearch").val();
            	expressName2 = $("#option_express2").val();
            	var queryParams =$("#ascrGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.wangwang = wangwang;
            	queryParams.shopName = shopName;
            	queryParams.allSearch = allSearch;
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
           /*  function addMessage(){
            	var bounceVal = $('input[name="bounceType"]:checked').val();
            	if("换货"==bounceVal){
            		var rcn = $("#reissueCourierNum").val();
            		var rgn = $("#reissueGoodsName").val();
            		//var opt = $("#option_express3").val();   ||(opt==null || opt.length==0)
            		if((rcn==null || rcn.length==0) || (rgn==null || rgn.length==0)){
            			 $.messager.alert('提示', '当选择换货时，快递单号和货品名称不能为空', 'Warning');
            			/*  alert("当选择换货时，快递名称和快递单号不能为空"); 
            		}else{
            			submitAdd();
            		}
            	}else{
            		submitAdd();
            	}
            } */
              
            function submitAdd() {
				$("#addAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#displayId").hide();
							$("#addAscrForm").form("clear");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				});
			}
            function submitCourierNum() {
				$("#courierNumAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=addCourierNum",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		alert(data.reason);
							$("#courierNumAscrForm").form("clear");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
        </script>
	</head>

	<body class="easyui-layout">
		<div title="售后收货记录" class="easyui-panel" style="width: 100%">
			<table id="ascrGrid" style="height: 340px;"></table>
		</div>
	<div style="width:44%; position:relative">
		<div id="addAscr" class="easyui-panel" title="添加拆包记录" style="width: 98%; height: 500px;padding: 10px;">
			<form id="addAscrForm" method="post">
				<input type="hidden" name="ascrId" value="" />
				<table>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum" type="text" style="width: 250px;" data-options="required:true"/></td>
				    </tr>
				    <tr >
						<td>快递名称:</td>
				        <td><input class="easyui-combobox" id="option_express" style="width:250px;margin-left:5px;" name="expressName" /></td>
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
						<td><input class="easyui-validatebox" name="orderNum" type="text" style="width: 250px;" /><td>
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
						<td><textarea name="remark" style="width:250px;height:100px" style="width: 400px;" ></textarea><td>
				    </tr>
				     <tr >
						<td>退件类型:</td>
						<td>
							<input type="radio" name="bounceType" value="退货" id="returnGood" onclick="changeDisplay()" /><label for="returnGood">退货</label>
							<input type="radio" name="bounceType" value="换货" id="changeGood" onclick="changeGoods()" /><label for="changeGood">换货</label>
							<input type="radio" name="bounceType" value="拦截件" id="intercept" onclick="changeDisplay()" /><label for="intercept">拦截件</label>
							<input type="radio" name="bounceType" value="无信息" id="noMessage" onclick="changeDisplay()" checked="checked"/><label for="noMessage">无信息</label> 
							<!-- <input type="radio" name="status" value="已处理" />已处理
							<input type="radio" name="status" value="待处理" checked="checked" />待处理 -->
						<td>
				    </tr>
				    <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" checked="checked" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="status" value="已处理" id="overManage"/><label for="overManage">已处理</label>
						<td>
				    </tr>
			    </table>
			    <table id="displayId" style="position:absolute;margin-top: -307px;margin-left: 350px;">
			    	<tr >
						<td>补发快递单号:</td>
						<td><input class="easyui-validatebox" id="reissueCourierNum" name="reissueCourierNum" type="text" style="width: 150px;" /><td>
				    </tr>
				     <tr >
						<td><label for="reissueExpressName" style="font-size: 16px;">补发快递名称:</label></td>
						
				        <td><input class="easyui-combobox" id="reissueExpressName" style="width:150px;margin-left:5px;" name="reissueExpressName" /></td>
				    </tr>
				    <tr >
						<td>补发货物名称:</td>
						<td><input class="easyui-validatebox" id="reissueGoodsName" name="reissueGoodsName" type="text" style="width: 150px;" /><td>
				    </tr>
					<!-- <tr >
						<td>快递名称:</td>
						<td><input class="easyui-validatebox" name="expressName3" type="text" style="width: 250px;" data-options="required:true" /><td>
				    </tr> -->
			    </table>
			</form>
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitAdd();">确定</a>
						</td>
						<td>
							<a class="recharge" onclick="allClear();">清除</a>
						</td>
						<td>
							<a class="recharge" onclick="cancel();">取消</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
		
		<div id="moveLeft" style="width:28%;position:absolute;right:1px;top:368px">
		<div id="searchAscr" class="easyui-panel" title="搜索" style="width: 98%; height: 500px;padding: 10px;">
			<form id="searchAscrForm" method="post">
				<table>
					<tr >
						<td>全文搜索:</td>
						<td><input class="easyui-validatebox" name="allSearch" id="allSearch" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
				    	<td><br/><br/></td>
				    </tr>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum2" type="text" style="width: 250px;" id="courierNum"/><td>
				    </tr>
				    <tr >
				        <td><label for="option_express2" style="font-size: 16px;">快递名称:</label></td>
				        <td><input class="easyui-combobox" id="option_express2" style="width:250px;margin-left:5px;" name="expressName2" /></td>
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
				    <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang2" id="wangwang" type="text" style="width: 250px;"/><td>
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
		
	<div style="width:28%;position:absolute;left:44%;top:368px">
		<div id="courierNumAscr" class="easyui-panel" title="添加扫码记录" style="width: 98%; height: 500px;padding: 10px;">
			<form id="courierNumAscrForm" method="post">
				<input type="hidden" name="courierNumId" value="" />
				<table>
					<tr>
				        <td>快递名称:</td>
				        <td><input class="easyui-combobox" id="option_express3" style="width:250px;margin-left:5px;" name="expressName3" /></td>
				    </tr>
					<tr>
						<td>快递单号:</td>
						<td><textarea name="courierNums" style="width:250px;height:100px" style="width: 400px;" ></textarea></td>
				    </tr>
			    </table>
			</form>
			
			<div class="margin-tb manage-detail-con clearfix" >
				<table>
					<tr>
						<td>
							<a class="custom" onclick="submitCourierNum();">确定</a>
						</td>
						<td>
							<a class="recharge" onclick="courierNumClear();">清除</a>
						</td>
						<td>
							<a class="recharge" onclick="courierNumCancel();">取消</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>	
		
	</body>
</html>
