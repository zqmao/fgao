<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean importPreSale = false;
	if(userId != 0){
		importPreSale = PermissionUtil.checkImportPreSale(request, response);
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
						if(first_user == 0){
							var queryParams =$("#preSaleRecordGrid").datagrid("options").queryParams;
							queryParams.selectUser = option_user;
							$("#preSaleRecordGrid").datagrid("reload");
						}else{
							loadTableData();
						}
						first_user = 0;
					}
                });
            	if(<%=importPreSale%> || <%=finance%>){
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
                    queryParams:{selectUser : option_user},
                    onClickCell: onClickCell,
                    onAfterEdit:function(rowIndex, rowData, changes){
                    	if(isSelfCheck){
                    		selfCheck(rowData);
                    		isSelfCheck = false;
                    	}
                    	if(isFinanceCheck){
                    		financeCheck(rowData);
                    		isFinanceCheck = false;
                    		status = "0";
                    	}
                    },
                    columns: [[
                            {field: 'ck', checkbox: true},
                            {title: '订单编号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '优惠券金额', field: 'couponQuota', width: 80, align: 'center',editor:{type:'numberbox',options:{precision:1}}},//需要编辑
                            {title: '好评返现', field: 'praiseMoney', width: 80, align: 'center'},
                            {title: '返差价', field: 'differenceMoney', width: 80, align: 'center'},
                            {title: '退款金额', field: 'returnMoney', width: 80, align: 'center',editor:{type:'numberbox',options:{precision:1}}},//需要编辑
                            {title: '特殊快递', field: 'specialExpress', width: 130, align: 'center',editor:'text'},//需要编辑
                            {title: '特殊礼物', field: 'specialGift', width: 130, align: 'center',editor:'text'},//需要编辑
                            {title: '自审备注', field: 'selfCheckRemark', width: 160, align: 'center',editor:'text'},//需要编辑
                            {title: '自审', field: 'selfCheck', width: 80, align: 'center',formatter:formatSelfCheck},
                            {title: '财审备注', field: 'financeCheckRemark', width: 160, align: 'center',editor:'text'},
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
       				opt = "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick=setSelfCheck()>"
       				+ "<span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>自审</span><span class='l-btn-icon icon-ok'>&nbsp;</span></span></a>";
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
        					$("#eolistGrid").datagrid("reload");
				    	}
				    }
				});
            }
        </script>
	</head>

	<body class="easyui-layout">
		<table style="width:100%">
			<tr>
			<td id="selectPreSaleRecord" style="width:15%">
				<div class="easyui-panel" title="筛选售前记录" style="height: 100px;">
					<div style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
						<label for="option_user">筛选:</label>
						<input id="option_user" />
				    </div>
			    </div>
		    </td>
		    <td id="uploadPreSaleRecord" style="width:85%">
				<div class="easyui-panel" title="上传售前记录" style="height: 100px;">
					<form id="uploadPreSaleRecordForm" name="orderlistId" enctype="multipart/form-data" method="post">
				        <div class="margin-tb manage-detail-con clearfix" >
							<table>
								<tr>
									<td >
										<input name="file" style="margin-left:50px;" type="file" size="20">
									</td>
									<td>
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
