<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean importPreSale = false;
	if(userId != 0){
		importPreSale = PermissionUtil.checkImportPreSale(request, response);
	}
	boolean instead = false;
	if(userId != 0){
		instead = PermissionUtil.checkInstead(request, response);
	}
	boolean finance = false;
	if(userId != 0){
		finance = PermissionUtil.checkFinance(request, response);
	}
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>售前考核</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/commons.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/templatecss.css"/>
	<script type="text/javascript">
			var first_user = 1;
			var option_user = "0";
			var isSelfCheck = false;
			var isFinanceCheck = false;
			var status = "0";
            $(function() {
            	$("#option_user").combobox({
                    url:'../userServlet.do?sign=select',
                    valueField:'id',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_user").combobox('select', <%=userId%>);
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                	onSelect: function(record){
						option_user = record.id + "";
						if(first_user == 1){
							loadTableData();
						}
						first_user = 0;
					}
                });
            	if(<%=importPreSale%> || <%=finance%> || <%=instead%>){
            		$("#selectPreSaleRecord").show();
            	}else{
            		$("#selectPreSaleRecord").hide();
            	}
            	if(<%=importPreSale%>){
            		$("#uploadPreSaleRecord").show();
            	}else{
            		$("#uploadPreSaleRecord").hide();
            	}
            });
            
            function loadTableData(){
            	$("#preSaleRecordGrid").datagrid({
                    singleSelect: true,
                    pagination: true,
                    url: "../preSaleRecordServlet.do?sign=list",
                    queryParams:{selectUser : option_user, selfCheck : 0},
                    onClickCell: onClickCell,
                    onAfterEdit:function(rowIndex, rowData, changes){
                    	if(isSelfCheck){
                    		selfCheck(rowData);
                    		isSelfCheck = false;
                    	}
                    	if(isFinanceCheck){
                    		if(rowData.selfCheck == "0"){
                    			alert("未自审，无法财审");
                    		}else{
                    			financeCheck(rowData);
                    		}
                    		isFinanceCheck = false;
                    		status = "0";
                    	}
                    },
                    columns: [[
                            {field: 'ck', checkbox: true},
                            {title: '订单编号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '旺旺号', field: 'wangWang', width: 120, align: 'center',formatter:formatWangWang},
                            {title: '优惠券金额', field: 'couponQuota', width: 80, align: 'center',editor:{type:'numberbox',options:{precision:1}},formatter:formatSelf},//需要编辑
                            {title: '好评返现', field: 'praiseMoney', width: 80, align: 'center'},
                            {title: '返差价', field: 'differenceMoney', width: 80, align: 'center'},
                            {title: '退款金额', field: 'returnMoney', width: 80, align: 'center',editor:{type:'numberbox',options:{precision:1}},formatter:formatSelf},//需要编辑
                            {title: '特殊快递', field: 'specialExpress', width: 130, align: 'center',editor:'text',formatter:formatSelf},//需要编辑
                            {title: '特殊礼物', field: 'specialGift', width: 130, align: 'center',editor:'text',formatter:formatSelf},//需要编辑
                            {title: '自审备注', field: 'selfCheckRemark', width: 160, align: 'center',editor:'text',formatter:formatSelf},//需要编辑
                            {title: '自审', field: 'selfCheck', width: 80, align: 'center',formatter:formatSelfCheck},
                            {title: '财审备注', field: 'financeCheckRemark', width: 160, align: 'center',editor:'text',formatter:formatFinance},//需要编辑
                            {title: '财审', field: 'financeCheck', width: 160, align: 'center',formatter:formatFinanceCheck},
                            {title: '备注', field: 'remark', width: 100, align: 'center', formatter:formatTip}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    toolbar: []
                }); 
            }
      
            function formatTip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
      
            function formatWangWang(value){  
            	return "<a href='https://amos.alicdn.com/getcid.aw?spm=a1z09.1.0.0.7ebc34ecA22n0T&amp;v=3&amp;groupid=0&amp;s=1&amp;charset=utf-8&amp;uid="+value+"&amp;site=cntaobao&amp;' target='_blank' >"+value+"</a>";
	        } 
            function formatSelf(value, rowData, rowIndex){
            	//自审过的
            	if(rowData.selfCheck == "0"){
            		if(<%=instead%> || <%=userId%> == rowData.donePayUserId){
	            		if(!value || value == ""){
	            			return "点击输入";
	            		}
            		}
            	}
            	return value;
            }
            
          //财审按钮
            function formatFinance(value, rowData, rowIndex) {
       			if(rowData.financeCheck == "0"){
       				if(<%=finance%> && rowData.selfCheck == "1"){
       					return "点击输入";
       				}
       			}
            	return value;
            }
            //自审按钮
            function formatSelfCheck(value, rowData, rowIndex) {
            	var id = rowData.id;
            	var couponQuota = rowData.couponQuota;
            	var returnMoney = rowData.returnMoney;
            	var specialExpress = rowData.specialExpress;
            	var specialGift = rowData.specialGift;
            	var selfCheckRemark = rowData.selfCheckRemark;
            	var onclick = 'selfCheck('+rowData+')';
        		var opt = "";
       			if(value == "0"){
       				if(<%=instead%> || <%=userId%> == rowData.donePayUserId){
       					opt = "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick=setSelfCheck()>"
       	       				+ "<span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>自审</span><span class='l-btn-icon icon-ok'>&nbsp;</span></span></a>";
       				}else{
       					opt = "<span><font color='green'>未自审</font></span>";
       				}
       			}else if(value == "1"){
       				opt = "<span><font color='green'>自审完成</font></span>";
       			}
            	return opt;
            }
            //财审按钮
            function formatFinanceCheck(value, rowData, rowIndex) {
            	var opt = "";
       			if(value == "0"){
       				if(<%=finance%>){
	       				opt = "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick=setFinanceCheck('1')>"
	       				+ "<span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>通过</span><span class='l-btn-icon icon-ok'>&nbsp;</span></span></a>"
	       				+ "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick=setFinanceCheck('2')>"
	       				+ "<span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>不通过</span><span class='l-btn-icon icon-no'>&nbsp;</span></span></a>";
       				}else{
       					opt = "<span><font color='green'>财务未检查，请稍等</font></span>";
       				}
       			}else if(value == "1"){
       				opt = "<span><font color='green'>财审通过</font></span>";
       			}else if(value == "2"){
       				opt = "<span><font color='red'>财审未通过</font></span>";
       			}
            	return opt;
            }
            function setSelfCheck(){
            	isSelfCheck = true;
            }
            function setFinanceCheck(check){
            	isFinanceCheck = true;
            	status = check;
            }
            function selfCheck(rowData){
            	var id = rowData.id;
            	var couponQuota = rowData.couponQuota;
            	if(!couponQuota){
            		couponQuota = "";
            	}
            	var returnMoney = rowData.returnMoney;
            	if(!returnMoney){
            		returnMoney = "";
            	}
            	var specialExpress = rowData.specialExpress;
            	if(!specialExpress){
            		specialExpress = "";
            	}
            	var specialGift = rowData.specialGift;
            	if(!specialGift){
            		specialGift = "";
            	}
            	var selfCheckRemark = rowData.selfCheckRemark;
            	if(!selfCheckRemark){
            		selfCheckRemark = "";
            	}
            	$.ajax({
                    type: "POST",
                    url: "../preSaleRecordServlet.do?sign=selfCheck",
                    data: "id=" + id + "&couponQuota=" + couponQuota + "&returnMoney=" + returnMoney + "&specialExpress=" + specialExpress + "&specialGift=" + specialGift + "&selfCheckRemark=" + selfCheckRemark,
                    success: function(msg) {
                        $("#preSaleRecordGrid").datagrid("reload");
                    },
                    error: function(msg) {
                        alert(msg.toString());
                    }
                });
            }
            function financeCheck(rowData){
            	var id = rowData.id;
            	var check = status;
            	var financeCheckRemark = rowData.financeCheckRemark;
            	if(!financeCheckRemark){
            		financeCheckRemark = "";
            	}
            	$.ajax({
                    type: "POST",
                    url: "../preSaleRecordServlet.do?sign=financeCheck",
                    data: "id=" + id + "&financeCheck=" + check + "&financeCheckRemark=" + financeCheckRemark,
                    success: function(msg) {
                        $("#preSaleRecordGrid").datagrid("reload");
                    },
                    error: function(msg) {
                        alert(msg.toString());
                    }
                });
            }
          	//搜索
            function submitSearch(){
            	var queryParams =$("#preSaleRecordGrid").datagrid("options").queryParams;
            	queryParams.selectUser = $("#option_user").val();
            	queryParams.selfCheck = $("#option_status").val();
            	queryParams.orderNum = $("#orderNum").val();
            	queryParams.orderCreateStartTime = $("#orderCreateStartTime").val();
            	queryParams.orderCreateEndTime = $("#orderCreateEndTime").val();
            	queryParams.orderPayStartTime = $("#orderPayStartTime").val();
            	queryParams.orderPayEndTime = $("#orderPayEndTime").val();
            	$("#preSaleRecordGrid").datagrid("reload");
            }
          	
            function submitUpload(){
            	MaskUtil.mask();
				$("#uploadPreSaleRecordForm").form("submit", {
				    url:"../preSaleRecordServlet.do?sign=uploadPreSaleRecord",
				    success:function(result){
				    	MaskUtil.unmask(); 
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		alert("上传成功");
							$("#uploadPreSaleRecordForm").form("clear");
        					$("#preSaleRecordGrid").datagrid("reload");
				    	}
				    }
				});
            }
        </script>
	</head>

	<body class="easyui-layout">
		<table style="width:100%">
			<tr>
			<td id="selectPreSaleRecord" style="width:75%">
				<div class="easyui-panel" title="筛选售前记录" style="height: 130px;">
					<div style="padding-left: 5px;padding-top: 20px;padding-bottom: 10px;">
					<table>
						<tr>
							<td align="right">
								<label for="option_user">筛选:</label>
							</td>
							<td>
								<input id="option_user" type="text"/>
							</td>
							<td align="right" style="padding-left: 20px;">
								<label for="option_status">自审状态:</label>
							</td>
							<td>
								<select class="easyui-combobox" name="option_status" id="option_status" style="width:100px;">
								    <option value="0" selected="selected">未自审</option>
								    <option value="1">已完成</option>
								</select>
							</td>
							<td align="right" style="padding-left: 20px;">
								<label for="orderNum">订单号:</label>
							</td>
							<td>
								<input id="orderNum" />
							</td>
						</tr>
					</table>
					<table>
						<tr>
							<td align="right">
								<label for="orderCreateTime">订单创建时间:</label>
							</td>
							<td>
								<input id="orderCreateStartTime" class="easyui-datetimebox"/>
								<input id="orderCreateEndTime" class="easyui-datetimebox"/>
							</td>
							<td align="right">
								<label for="orderPayTime">订单付款时间:</label>
							</td>
							<td>
								<input id="orderPayStartTime" class="easyui-datetimebox"/>
								<input id="orderPayEndTime" class="easyui-datetimebox"/>
							</td>
							<td class="manage-detail-con" >
								<a class="custom" onclick="submitSearch();">搜索</a>
							</td>
						</tr>
					</table>
				    </div>
			    </div>
		    </td>
		    <td id="uploadPreSaleRecord" style="width:25%">
				<div class="easyui-panel" title="上传售前记录" style="height: 130px;">
					<form id="uploadPreSaleRecordForm" name="orderlistId" enctype="multipart/form-data" method="post">
				        <div align="center" style="padding-top:30px;padding-right: 30px">
							<table>
								<tr>
									<td >
										<input name="file" style="margin-left:50px;" type="file" size="20">
									</td>
									<td class="manage-detail-con" >
										<a class="custom" onclick="submitUpload();">确定</a>
									</td>
								</tr>
							</table>
						</div>
		    		</form>
				</div> 
			</td>
			
			</tr>
		</table>
		<div title="售前记录" class="easyui-panel" style="width: 100%">
			<table id="preSaleRecordGrid" style="height: 600px;"></table>
		</div>
	</body>
	<script type="text/javascript">
		$.extend($.fn.datagrid.methods, {
			editCell: function(jq,param){
				return jq.each(function(){
					var opts = $(this).datagrid('options');
					var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor1 = col.editor;
						if (fields[i] != param.field){
							col.editor = null;
						}
					}
					$(this).datagrid('beginEdit', param.index);
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor = col.editor1;
					}
				});
			}
		});
		
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#preSaleRecordGrid').datagrid('validateRow', editIndex)){
				$('#preSaleRecordGrid').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell(index, field){
			if (endEditing()){
				$('#preSaleRecordGrid').datagrid('selectRow', index)
						.datagrid('editCell', {index:index,field:field});
				editIndex = index;
			}
		}
	</script>
</html>
