<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%@page import="java.sql.*"%>
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
	<style type="text/css">
				.mask{ 
				background: #000;
				opacity: .6;
				filter:alpha(opacity=60);
				position:absolute;
				left:0;
				top:0;
				width:100%;
				height:100%;/*动态获取，这里设置高度是为了测试*/
				z-index:1000;
				}
</style>
	<link rel="stylesheet" type="text/css" href="../css/templatecss.css"/>
	<script type="text/javascript">
			var courierNumA = "";
			var courierNum = "";
			var shopName ="";
			var goodsName ="";
			var orderNum = "";
			var phoneNum = "";
			var wangwang = "";
			var afterSaTor = "";
			var bounceType = "";
			var creator = "";
			var allSearch="";
			var expressName2 = "";
			var option_express = "0";
			var option_express2 = "0";
			var option_express3 = "0";
			var option_express4 = "0";
			
			var totalE = "";
			var addressE = "";
			var goodsHeadlineE = "";
			var wangwangE = "";
			
            $(function() {
            	$("p").css("line-height", "15px");
            	$("#mask").hide();//隐藏遮蔽层
            	$("#searchId").hide();
            	
            	$("#displayId").hide();
            	$("#handleSelf").hide();
            	$("#handleOth").hide();
            	
            	//回车事件
            	 $('#courierNumA').bind('keypress',function(event){  
            		  
                     if(event.keyCode == "13")      
           
                     {  
                    	 var courierNum = $('#courierNumA').val();
           				$("#courierNum").val(courierNum);
                         /* alert('你输入的内容为：' + $('#courierNumA').val());   */
           				submitSearch();
                     }  
           
                 });
            	
            	
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
            	
            	 /* 查询时获取快递名称*/
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
                    queryParams:{selectExpress : expressName2, courierNum : courierNum,courierNumA:courierNumA, bounceType:bounceType,afterSaTor:afterSaTor,
                    	shopName : shopName, goodsName : goodsName, orderNum : orderNum, phoneNum : phoneNum,wangwang :wangwang,creator : creator,allSearch : allSearch},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 50},
                            {title: '快递单号', field: 'courierNum', width: 100},
                            {title: '物品名称', field: 'goodsName', width: 100, align: 'center'},
                            {title: '店铺名称', field: 'shopName', width: 100, align: 'center'},
                            {title: '快递名称', field: 'expressName', width: 50, align: 'center'},
                            {title: '检查结果', field: 'checkResult', width: 100, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 100, align: 'center'},
                            {title: '售后人员', field: 'afterSaTor', width: 100, align: 'center'},
                            {title: '手机号', field: 'phoneNum', width: 90, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 100, align: 'center'},
                            {title: '创建人员', field: 'creator', width: 90, align: 'center'},
                            {title: '退件类型', field: 'bounceType', width: 90, align: 'center'},
                            
                            {title: '拆包人员', field: 'unpackor', width: 90, align: 'center'},
                            {title: '拆包时间', field: 'createTime', width: 130, align: 'center'},
                            {title: '收件时间', field: 'entryTime', width: 130, align: 'center'},
                            {title: '备注', field: 'remark', width: 100, align: 'center', formatter:formatCellTooltip},
                            //{title: '状态', field: 'status', width: 80, align: 'center'}
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
                    },
                     {
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
                                    afterSaTor: row[0].afterSaTor,
                                    phoneNum: row[0].phoneNum,
                                    orderNum: row[0].orderNum,
                                    remark: row[0].remark,
                                   // status: row[0].status,
                                    bounceType: row[0].bounceType,
                                });
                               /*  $('#courierNumA').attr("disabled",true); 
                            	$('#orderNO').attr("disabled",true);  */
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
                    },{
                    	id:'toolbar-remove-after-search',
                        iconCls: 'icon-search',
                        text: '搜索',
                        handler: function() {
                        	$("#searchId").show();
                        	$("#mask").show();
                        	/* 
                            $("#addAscrForm").form("clear");
                            $("#addAscr").panel("open");  */
                        }
                    }]
                });
            });
            /* $("#courierNumA").keydown(function() {
                if (event.keyCode == "13") {//keyCode=13是回车键
                    var vale = $('#courierNumA').val();
                alert(vale);
                }
            }); */
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
            	$("#handleSelf").show();
            	//$('input:radio').eq(6).attr('checked', 'true');
            	
            	//$('#courierNum3').attr("disabled",true); 
            	//var Num3 = $('#courierNum3').html();
            }
            //自己发货
            function handleSf(){
            	$("#handleOth").hide();
            	$("#handleSelf").show();
            }
            //他人发货
            function handleOr(){
            	$("#handleSelf").hide();
            	$("#handleOth").show();
            }
            //不处理
            function untreated(){
            	$("#handleSelf").hide();
            	$("#handleOth").hide();
            }
            function changeDisplay(){
            	$("#displayId").hide();
            	$("#displayId").form("clear");
            	$("#handleSelf").hide();
            	$("#handleOth").hide();
            	$("#handleSelf").form("clear");
            	$("#handleOth").form("clear");
            }
            //查询
            function submitSearch(){
            	//$("#courierNumA").val("");
            	courierNum = $("#courierNum").val();
            	
            	goodsName = $("#goodsName").val();
            	orderNum = $("#orderNum").val();
            	phoneNum = $("#phoneNum").val();
            	wangwang = $("#wangwang").val();
            	afterSaTor = $("#afterSaTor").val();
            	bounceType = $("#bounceType").val();
            	creator = $("#creator").val();
            	shopName = $("#shopName").val();
            	allSearch = $("#allSearch").val();
            	expressName2 = $("#option_express2").val();
            	var queryParams =$("#ascrGrid").datagrid("options").queryParams;
            	queryParams.courierNum = courierNum;
            	queryParams.goodsName = goodsName;
            	queryParams.orderNum = orderNum;
            	queryParams.phoneNum = phoneNum;
            	queryParams.wangwang = wangwang;
            	queryParams.afterSaTor = afterSaTor;
            	queryParams.bounceType = bounceType;
            	queryParams.creator = creator;
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
            	
            	courierNumA = $("#courierNumA").val();
            	var queryParams =$("#ascrGrid").datagrid("options").queryParams;
            	queryParams.courierNumA = courierNumA;
            	var bounceVal = $('input[name="bounceType"]:checked').val();
            	var changeStatus = $('input[name="changeStatus"]:checked').val();
            	var orderNOM = $("#orderNO").val(); 
            	if("退货"==bounceVal || "换货"==bounceVal ||"拦截件"==bounceVal){
            		if(orderNOM==null||orderNOM==""){
            			$.messager.alert('提示', '请填写订单号', 'Warning');
            			//$("#ascrGrid").datagrid("reload");
            		}else {
            			if("换货"==bounceVal){
            				
            			
            			if("自己发货"==changeStatus){
            				var reissueCourierNum = $("#reissueCourierNum").val();
            				var reissueExpressName = $("#reissueExpressName").val();
            				if("请选择:"==reissueExpressName){
            					reissueExpressName=="";
            				}
            				var reissueGoodsName = $("#reissueGoodsName").val();
            				if((reissueCourierNum==null||reissueCourierNum.length==0) || (reissueExpressName==null||reissueExpressName.length==0) 
            						||(reissueGoodsName==null||reissueGoodsName.length==0)){
            					$.messager.alert('提示', '选择自己发货时，补发快递单号,补发快递名称,补发货物名称均不能为空', 'Warning');
            					//alert("选择自己发货时，补发快递单号,补发快递名称,补发货物名称均不能为空")
            				}else {
            					
            					submitAddMethod();
            				}
            			
            			}else if("他人发货"==changeStatus){
            				var reissueAddress = $("#reissueAddress").val();
            				var reissueGood = $("#reissueGood").val();
            				if((reissueAddress==null || reissueAddress.length==0) || (reissueGood==null || reissueGood.length==0)){
            					//alert("当选择他人发货时，不发货物及补发货物名称不能为空");
            					$.messager.alert('提示', '当选择他人发货时，补发货物地址及补发货物名称不能为空', 'Warning');
            				}else{
            					
            					submitAddMethod();
            				}
            				
            			}else{
            				
            				submitAddMethod();
            			}
            		}else{
            			
            			submitAddMethod();
            		}
            			
            		}
            		
            	}else{
            	
				/* $("#addAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=add",
				    success:function(result){
				    	courierNumA = "";
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#handleSelf").hide();
			            	$("#handleOth").hide();
				    		$("#displayId").hide();
				    		$("#courierNumA").val("");
							$("#addAscrForm").form("clear");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				}); */
            		submitAddMethod();
            	}
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
            function clearX(){
            	$("#mask").hide();//隐藏遮蔽层
            	$("#searchId").hide();
            }
            //提交方法
            function submitAddMethod(){
            	$("#addAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#handleSelf").hide();
			            	$("#handleOth").hide();
				    		$("#displayId").hide();
							$("#addAscrForm").form("clear");
							$("#courierNumA").val("");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				});
            }
            
            function searchList(){
            	$("#serverResponse").form("clear");
            	var orderNumE = $("#orderNumE").val();
            	$.ajax({
            		type:"POST",
            		url:"../afterSaleComeRecordServlet.do?sign=SearchExportList",
            		data:"orderNumE="+orderNumE,
            		success:function(result){
						var data=eval('('+result+')');   
            			var row = data.rows;
            			totalE = data.total;
            			if(totalE==0){
			    			$("#serverResponse").hide();
			    			alert("没有查到数据");	
			    		}else{
			    			$("#serverResponse").show();
			    		}
			    		addressE = row[0].address;
			    		exportorE = row[0].exportor;
			    		shopNameE = row[0].shopName;
			    		orderNumE = row[0].orderNum;
			    		goodsHeadlineE = row[0].goodsHeadline;
			    		wangwangE = row[0].wangwang;
			    		phoneNumE = row[0].phoneNum;
			    		consigneeNameE = row[0].consigneeName;
			    		
			    		$("#total").html("共搜到"+totalE+"条数据");
            			//document.getElementById("total").innerHTML="共搜到"+totalE+"条数据";
            			$("#addressE").html("地址为:"+addressE);
            			$("#goodsHeadlineE").html("宝贝标题为:"+goodsHeadlineE);
            			$("#wangwangE").html("旺旺号为:"+wangwangE);
            			$("#exportorE").html("数据导入者为:"+exportorE);
            			$("#shopNameE").html("商店名称为:"+shopNameE);
            			$("#orderNumE").html("订单编号为:"+orderNumE);
            			$("#phoneNumE").html("手机号码为:"+phoneNumE);
            			$("#consigneeNameE").html("收货人姓名:"+consigneeNameE);
            		}
            	});
            	
            	
            	 //xmlhttp=new XMLHttpRequest();
    /*         	  if(window.ActiveXOject)  
    {  
     xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");  
    }  
    else if(window.XMLHttpRequest)  
    {  
      xmlhttp = new XMLHttpRequest();  
    }  
            	 var orderNumE = $("#orderNumE").val();
            	 orderNumE = encodeURI(orderNumE);  //需要通过两次编码
            	xmlhttp.onreadystatechange=function()
            	{	
            		//alert("111"+xmlhttp.readyState);
            		if (xmlhttp.readyState==4 && xmlhttp.status==200)
            		{
            			//alert("222"+xmlhttp.readyState);
            			var result = xmlhttp.responseText;
            			//alert(xmlhttp.responseText+"--");
            			var data=eval('('+result+')');   
            			
            			var row = data.rows;
            			totalE = data.total;
			    		
			    		if(totalE==0){
			    			$("#serverResponse").hide();
			    			alert("没有查到数据");	
			    		}else{
			    			$("#serverResponse").show();
			    		}
			    		addressE = row[0].address;
			    		exportorE = row[0].exportor;
			    		shopNameE = row[0].shopName;
			    		orderNumE = row[0].orderNum;
			    		goodsHeadlineE = row[0].goodsHeadline;
			    		wangwangE = row[0].wangwang;
			    		phoneNumE = row[0].phoneNum;
			    		consigneeNameE = row[0].consigneeName;
			    		
			    		$("#total").html("共搜到"+totalE+"条数据");
            			//document.getElementById("total").innerHTML="共搜到"+totalE+"条数据";
            			$("#addressE").html("地址为:"+addressE);
            			$("#goodsHeadlineE").html("宝贝标题为:"+goodsHeadlineE);
            			$("#wangwangE").html("旺旺号为:"+wangwangE);
            			$("#exportorE").html("数据导入者为:"+exportorE);
            			$("#shopNameE").html("商店名称为:"+shopNameE);
            			$("#orderNumE").html("订单编号为:"+orderNumE);
            			$("#phoneNumE").html("手机号码为:"+phoneNumE);
            			$("#consigneeNameE").html("收货人姓名:"+consigneeNameE);
            			//var cow = xmlhttp.responseText.cows;exportorshopNameEorderNumEphoneNumE
            			
            			//alert(xmlhttp.responseText+"写入成功");
            		} else{
            			//alert("333"+xmlhttp.readyState);
            		}
            	}
            	xmlhttp.open("GET","../afterSaleComeRecordServlet.do?sign=SearchExportList&orderNumE="+encodeURI(orderNumE),false);
            	xmlhttp.send();  */
            	 
            }
            
        </script>
	</head>

	<body class="easyui-layout">
		<div id="mask" class="mask"></div>
		<table style="width:100%">
			<tr>
				<td style="width:46%;">
					
		<div id="addAscr" class="easyui-panel" title="添加拆包记录" style="width: 98%; height: 500px;padding: 10px;">
			<form id="addAscrForm" method="post">
				<input type="hidden" name="ascrId" value="" />
				<table>
					<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" id="courierNumA" name="courierNum" type="text" style="width: 250px;" data-options="required:true"/></td>
				    </tr>
				    <tr >
						<td>快递名称:</td>
				        <td><input class="easyui-combobox" id="option_express" style="width:250px;margin-left:5px;" name="expressName" /></td>
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
						<td><input class="easyui-validatebox" name="orderNum" id="orderNO" type="text" style="width: 250px;" /><td>
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
						<td>售后人员:</td>
						<td><input class="easyui-validatebox" name="afterSaTor" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><textarea name="remark" style="width:250px;height:100px" style="width: 400px;" ></textarea><td>
				    </tr>
				    <!-- <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" checked="checked" id="waitManage" /><label for="waitManage">待处理</label>
							<input type="radio" name="status" value="已处理" id="overManage"/><label for="overManage">已处理</label>
						<td>
				    </tr> -->
			    </table>
			    <table id="displayId" style="position:absolute;margin-top: -307px;margin-left: 340px; background-color: #eeeeee;">
			    	  <tr >
						<td>处理方式:</td>
						<td>
							<input type="radio" name="changeStatus" value="自己发货" checked="checked" id="handle" onclick="handleSf();" /><label for="handle">自己发货</label>
							<input type="radio" name="changeStatus" value="他人发货" id="handleOther" onclick="handleOr()"/><label for="handleOther">他人发货</label>
							<input type="radio" name="changeStatus" value="不处理"  id="handleNo" onclick="untreated()" /><label for="handleNo">不处理</label>
						<td>
				    </tr>
				   </table>
				   
				   <table id="handleSelf" style="position:absolute;margin-top: -282px;margin-left: 340px; background-color: #eeeeee;"> 
			    	<tr>
						<td>补发快递单号:</td>
						<td><input class="easyui-validatebox" id="reissueCourierNum" name="reissueCourierNum" type="text" style="width: 223px;" /><td>
				    </tr>
				     <tr >
						<td><label for="reissueExpressName" style="font-size: 16px;">补发快递名称:</label></td>
						
				        <td><input class="easyui-combobox" id="reissueExpressName" style="width:223px;margin-left:5px;" name="reissueExpressName" /></td>
				    </tr>
				    <tr >
						<td>补发货物名称:</td>
						<td><input class="easyui-validatebox" id="reissueGoodsName" name="reissueGoodsName" type="text" style="width: 223px;" /><td>
				    </tr>
				    
					<!-- <tr >
						<td>快递名称:</td>
						<td><input class="easyui-validatebox" name="expressName3" type="text" style="width: 250px;" data-options="required:true" /><td>
				    </tr> -->
			    </table>
			    <table id="handleOth" style="position:absolute;margin-top: -282px;margin-left: 340px; background-color: #eeeeee;">
			    	<tr >
						<td>补发货物地址:</td>
						<td><input class="easyui-validatebox" id="reissueAddress" name="reissueAddress" type="text" style="width: 223px;" /><td>
				    </tr>
				    <tr >
						<td>补发货物名称:</td>
						<td><input class="easyui-validatebox" id="reissueGood" name="reissueGood" type="text" style="width: 223px;" /><td>
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
							<a class="recharge" onclick="allClear();">清除</a>
						</td>
						<td>
							<a class="recharge" onclick="cancel();">取消</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
				
				</td>
				<td style="width:27%;">
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
				    <tr >
						<td>售后人员:</td>
						<td><input class="easyui-validatebox" name="afterSaTor" id="afterSaTor" type="text" style="width: 250px;"/><td>
				    </tr>
				     <tr >
						<td>退件类型:</td>
						<td><input class="easyui-validatebox" name="bounceType2" id="bounceType" type="text" style="width: 250px;"/><td>
				    </tr>
				    <tr >
						<td>创建人:</td>
						<td><input class="easyui-validatebox" name="creator" id="creator" type="text" style="width: 250px;"/><td>
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
				
				</td>
				<td style="width:27%;" >
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
				
				</td>
			</tr>
		</table>	
	
		 <div title="搜索" id="searchId" class=""  style="width: 40%;margin-left:30%;z-index: 1001;height:400px;background-color:#e0ecff;position:absolute;top:400px;">
				
				<div style="margin-left:96%;"><p style="font-size:30px;margin-top: 10px;color: #68dfe0;" onclick="clearX()">X</p></div>
				<form action="#" style="margin-top: -55px;">  
					  请输入搜索内容:  
					  <input type="text" id="orderNumE" style="margin-left: 10px; margin-top:10px;"/>  
					  <br>  
					   
					  <input type="button" id="submission" value="确定" onclick="searchList();" style="padding: 5px; width: 50px;margin-left: 10px; margin-top: 10px;color: #253B8A;background-color: #E4E1E1;border-radius: 5px;"/>  
					  </form>  
					 
					  <h3>查询结果:</h3>  
					  <div style="color:red;" id="serverResponse">
					  	<p id="total"> </p>
					  	<p id="exportorE" ></p>
					  	<p id="shopNameE" ></p>
					  	<p id="orderNumE"></p>
					  	<p id="wangwangE"></p>
					  	<p id="addressE"></p>
					  	<p id="phoneNumE"></p>
					  	<p id="goodsHeadlineE"></p>
					  	<p id="consigneeNameE"></p>
					  </div> 
			</div>
	<div title="售后收货记录" class="easyui-panel" style="width: 100%;position:relative">
			<table id="ascrGrid" style="height: 600px;"></table>
		</div>	
		
	</body>
</html>
