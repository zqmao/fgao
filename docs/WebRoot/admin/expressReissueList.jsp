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
            	$("#addErlist").panel({
            		title: '添加需要补发记录'
            		
            		});
            	$("#searchErlist").panel({
            		title: '搜索'
            		
            	});
            	$("#courierNumAscr").panel({
            		title: '补发快递记录'
            		
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
            	 
            	 
          	 
           /*  	 //可编辑列表
            var datagrid; //定义全局变量datagrid
            var editRow = undefined; //定义全局变量：当前编辑的行
            datagrid = $("#erlistGrid").datagrid({
            	selectOnCheck: true,
                checkOnSelect: true,
                pagination: true,
                url: '../expressReissueServlet.do?sign=list',
                	columns: [[
                                     {field: 'ck', checkbox: true},
                                     {title: '编号', field: 'id', width: 60},
                                     {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                                    
                                    
                                     {title: '店铺名称', field: 'shopName', width: 120, align: 'center',
                                    	 editor: { type: 'validatebox', options: { } }},
                                     {title: '旺旺', field: 'wangwang', width: 120, align: 'center',
                                    	 editor: { type: 'validatebox', options: { } }},
                                     {title: '订单号', field: 'orderNum', width: 120, align: 'center',
                                    	 editor: { type: 'validatebox', options: { required: true} }},
                                     {title: '物品名称', field: 'goodsName', width: 120, align: 'center',
                                    	 editor: { type: 'validatebox', options: { required: true} }},
                                    
                                     {title: '快递单号', field: 'courierNum', width: 100,align: 'center'},
                                     {title: '补发地址', field: 'address', width: 120, align: 'center',
                                    		 editor: { type: 'validatebox', options: { required: true} },formatter:formatCellTooltip},
                                     {title: '备注', field: 'remark', width: 120, align: 'center',
                                    			 editor: { type: 'validatebox', options: {} }, formatter:formatCellTooltip},
                                     
                                     {title: '状态', field: 'status', width: 100, align: 'center'},
                                     
                                     
                                     {title: '打单人员', field: 'issueDocumentor', width: 90,align: 'center'},
                                     {title: '快递名称', field: 'expressName', width: 80, align: 'center'},
                                     {title: '登记时间', field: 'entryTime', width: 130, align: 'center'},
                                     {title: '打单时间', field: 'issuTime', width: 130, align: 'center'},
                                     {title: '打单备注', field: 'issuRemark', width: 120, align: 'center', formatter:formatCellTooltip},
                                 ]],
                                 queryParams:{selectExpress : expressName2, courierNum : courierNum, creator:creator,
                                 	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum, status :status},
                                 	loadFilter: function(data){
                                   		if (data.data){
                                   			return data.data;
                                   		} else {
                                   			return data;
                                   		}
                                   	},
                toolbar: [
                       
                 { text: '修改', iconCls: 'icon-edit', handler: function () {
                     //修改时要获取选择到的行
                     var rows = datagrid.datagrid("getSelections");
                     //如果只选择了一行则可以进行修改，否则不操作
                     if (rows.length == 1) {
                         //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
                         if (editRow != undefined) {
                             datagrid.datagrid("endEdit", editRow);
                         }
                         //当无编辑行时
                         if (editRow == undefined) {
                             //获取到当前选择行的下标
                             var index = datagrid.datagrid("getRowIndex", rows[0]);
                             //开启编辑
                             datagrid.datagrid("beginEdit", index);
                             //把当前开启编辑的行赋值给全局变量editRow
                             editRow = index;
                             //当开启了当前选择行的编辑状态之后，
                             //应该取消当前列表的所有选择行，要不然双击之后无法再选择其他行进行编辑
                             datagrid.datagrid("unselectAll");
                         }
                     }
                 }
                 }, '-',
                 { text: '保存', iconCls: 'icon-save', handler: function () {
                     //保存时结束当前编辑的行，自动触发onAfterEdit事件如果要与后台交互可将数据通过Ajax提交后台
                     datagrid.datagrid("endEdit", editRow);
                 }
                 }, '-',
                 { text: '取消编辑', iconCls: 'icon-redo', handler: function () {
                     //取消当前编辑行把当前编辑行罢undefined回滚改变的数据,取消选择的行
                     editRow = undefined;
                     datagrid.datagrid("rejectChanges");
                     datagrid.datagrid("unselectAll");
                 }
                 }, '-'],
                onAfterEdit: function (rowIndex, rowData, changes) {
                    //endEdit该方法触发此事件
                    console.info(rowData);
                    var idK = rowData.id;
                    var shopNameK = rowData.shopName;
                    var wangwangK = rowData.wangwang;
                    var orderNumK = rowData.orderNum;
                    var goodsNameK = rowData.goodsName;
                    var addressK = rowData.address;
                    var remarkK = rowData.remark;
                    $.messager.confirm('Confirm', '确定要提交修改的数据吗？', function(r) {
                        if (r) {
                            $.ajax({
                                type: "POST",
                                url: "../expressReissueServlet.do?sign=keep",
                                data: "shopNameK=" + shopNameK +"&wangwangK="+ wangwangK +"&idK="+ idK +"&orderNumK="+ orderNumK +
                                "&goodsNameK="+ goodsNameK +"&addressK="+ addressK +"&remarkK="+ remarkK,
                                success: function(msg) {
                                	var data = eval('(' + msg + ')');
                                	alert(data.reason);
                                	//alert(msg.toString());
                                    $("#erlistGrid").datagrid("reload");
                                },
                                error: function(msg) {
                                    alert(msg.toString());
                                }
                            });
                        }
                    });
                    
                    
                    
                    editRow = undefined;
                },
                onDblClickRow: function (rowIndex, rowData) {
                //双击开启编辑行
                    if (editRow != undefined) {
                        datagrid.datagrid("endEdit", editRow);
                    }
                    if (editRow == undefined) {
                        datagrid.datagrid("beginEdit", rowIndex);
                        editRow = rowIndex;
                    }
                }
            });
            	  
            	 
            	  */
                $("#addErlist").panel("open");
                $("#grant").dialog("close");
                $("#erlistGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../expressReissueServlet.do?sign=list",
                    queryParams:{selectExpress : expressName2, courierNum : courierNum, creator:creator,afterSaTor:afterSaTor, wangwang : wangwang,
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum, status :status},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                           
                           
                            {title: '店铺名称', field: 'shopName', width: 120, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '物品名称', field: 'goodsName', width: 120, align: 'center'},
                           
                            {title: '快递单号', field: 'courierNum', width: 100,align: 'center'},
                            {title: '补发地址', field: 'address', width: 120, align: 'center',formatter:formatCellTooltip},
                            {title: '备注', field: 'remark', width: 120, align: 'center', formatter:formatCellTooltip},
                            
                            {title: '状态', field: 'status', width: 100, align: 'center'},
                            
                            
                            {title: '打单人员', field: 'issueDocumentor', width: 90,align: 'center'},
                            {title: '售后人员', field: 'afterSaTor', width: 90,align: 'center'},
                            {title: '快递名称', field: 'expressName', width: 80, align: 'center'},
                            {title: '登记时间', field: 'entryTime', width: 130, align: 'center'},
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
                                    afterSaTor:row[0].afterSaTor,
                                    orderNum: row[0].orderNum,
                                    courierNum: row[0].courierNum,
                                    expressName:row[0].expressName,
                                    remark:row[0].remark
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
                    },
                    ]
                }); 
                    /* {
                        iconCls: 'icon-add',
                        text: '导出',
                        handler: function() {
                            ids = getChecked("erlistGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            }else {
                               
                                $.messager.confirm('Confirm', '确定要导出选中的数据吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../expressReissueServlet.do?sign=export",
                                            data: "erlistIds=" + ids,
                                            success: function(msg) {
                                            	alert("导出数据成功");
                                            	//alert(msg.toString());
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
                    } */
              
            });
            
            
           /*  function copyit()
            {
            var v=$("#t").val()
            alert(v);
            window.clipboardData.setData("text",v);
            }
 */
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
            	status = $('input[name="statuss"]:checked').val();
            	//status = $("#status").val();
            	expressName2 = $("#option_express2").val();
            	creator = $("#creator").val();
            	afterSaTor = $("#afterSaTor").val();
            	wangwang = $("#wangwang").val();
            	var queryParams =$("#erlistGrid").datagrid("options").queryParams;
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
            	
            	var shopName = getFormDate("erlistGrid","shopName");
            	
            	var goodsName = getFormDate("erlistGrid","goodsName");
            	
            	var address = getFormDate("erlistGrid","address");
            	
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
           /*  //alert自动消失
            function alert_autoClose(title,msg,icon){ 
            	 var interval; 
            	 var time=1000; 
            	 var x=1;  //设置时间1s
            	$.messager.alert(title,msg,icon,function(){}); 
            	 interval=setInterval(fun,time); 
            	    function fun(){ 
            	   --x; 
            	   if(x==0){ 
            	     clearInterval(interval); 
            	 $(".messager-body").window('close');  
            	    } 
            	}; 
            	} */
            
            function copyToClipboard(elementId) {
            	// 创建元素用于复制
            	var aux = document.createElement("input");
            	//var aux = document.createElement("span");
            	// 获取复制内容
            	var content = document.getElementById(elementId).value;
            	//var content = $("#elementId").html();
            	// 设置元素内容
            	aux.setAttribute("value",content); 
            	// 将元素插入页面进行调用
            	document.body.appendChild(aux);
            	// 复制内容
            	aux.select(); 
            	//复制选中的文字到剪贴板; 
//            		document.execCommand('copy');

            	try{
            	document.execCommand('copy');
            	// // 删除创建元素
            	document.body.removeChild(aux);
            	$("#copySuccess").show();
            	$("#copySuccess").hide(2000);
            	}catch(exception){
            	alert("复制失败")
            	}
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
						<td>售后人员:</td>
						<td><input class="easyui-validatebox" name="afterSaTor" type="text" style="width: 250px;"/><td>
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
			
			<div id="reissueId" style="color: red;font-size: 19px;">
				<div ><span>你正在补发的是编号为:</span><span id="reissueInf1" style="color: red;font-size: 19px;width: 160px"></span></div>
				
				<div ><span>商铺名称是:</span><span id="reissueInf2" style="color: red;font-size: 19px;width: 255px"></span></div>
				<div ><span>物品名称是:</span><input id="reissueInf3" value="" style="color: red;font-size: 19px;width: 255px">
				<span onclick="copyToClipboard('reissueInf3')"style="background-color: #9FBEF1;width: 35px;cursor: pointer;" >复制</span></div>
				<div ><span>地址是:</span><input id="reissueInf4" value="" style="color: red;font-size: 19px;width: 293px">
				<span onclick="copyToClipboard('reissueInf4')"style="background-color: #9FBEF1;width: 35px;cursor: pointer;" >复制</span></div>
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
				     <tr >
						<td>创建人:</td>
						<td><input class="easyui-validatebox" name="creator" id="creator" type="text" style="width: 250px;"/></td>
				    </tr>
				    <tr >
						<td>售后人员:</td>
						<td><input class="easyui-validatebox" name="afterSaTor" id="afterSaTor" type="text" style="width: 250px;"/><td>
				    </tr>
				     <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang2" id="wangwang" type="text" style="width: 250px;"/></td>
				    </tr>
				     <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="statuss" value="待处理" checked="checked" id="waitManage2" /><label for="waitManage2">待处理</label>
							<input type="radio" name="statuss" value="已处理" id="overManage2"/><label for="overManage2">已处理</label>
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
			<table id="erlistGrid" style="height: 600px;"></table>
		</div>
		
<!-- 		
		<div>我的邀请码<input id="invite_code" value="567w899"/></div>
<div onclick="copyToClipboard('invite_code')"style="background-color: #9FBEF1;width: 35px;cursor: pointer;" >复制</div> -->
		<div id="copySuccess" style="z-index: 99999;
    margin-top: -47%;
    width: 200px;
    height: 200px;
    margin-left: 30%;
    background-color: #e0ecff;position:absolute;text-align:center;border-radius: 42px;"><p>复制成功</p></div>
		
	</body>
</html>
