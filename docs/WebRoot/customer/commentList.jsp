<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.check(request, response);
	boolean isAdmin = PermissionUtil.isAdmin(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>评论列表</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	
	<script type="text/javascript">
			var first = 1;
			var option = "";
			var isopen = false; 
			var newImg; 
			var w = 500; //将图片宽度+500 
			var h = 500; // 将图片高度 +500 
            $(function() {
                $("#addComment").panel({
                	title: '添加',
                	tools:[{
        				text:'保存',
        				iconCls:'icon-ok',
        				handler:function(){
        					submitAdd();
        				}
        			},{
           				text:'-',
           				iconCls:'icon-blank',
           				handler:function(){}
           			},{
        				text:'取消',
        				iconCls:'icon-cancel',
        				handler:function(){
        					$("#addComment").panel("close");
        				}
        			}]
                });
                $("#addComment").panel("open");
                $("#option_goods").combobox({
                    url:'../commentServlet.do?sign=selectAll',
                    //valueField:'id',
                    valueField:'text',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_goods").combobox('select', data.data[0].text);//data.data[0].text
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                	onSelect: function(record){
                		/* option = record.id + ""; */
                		
                		option = record.text;
                		//alert(option);
						if(first == 0){
							var queryParams =$("#commentGrid").datagrid("options").queryParams;
							//queryParams.goodsId = option;
							queryParams.goodsName = option;
							$("#addCommentForm").form('clear');
							$("#timeDes").combobox('select', "不限时间");
							$("#commentGrid").datagrid("load");
						}else{
							loadTableData();
						}
						$("#addComment").form('load', {
                        	//goodsId: "-2"
							goodsName: "请选择商品"
                        });
						first = 0;
					}
                });
                $("#searchId").hide();
                /* $("#goodsId").combobox({ */
                	$("#goodsName").combobox({
                    url:'../commentServlet.do?sign=select',
                    /* valueField:'id', */
                    valueField:'text',
                    textField:'text',
                    editable:false,
                    loadFilter: function(data){
                   		if (data.data){
                   			/* $("#goodsId").combobox('select', -3); */
                   			$("#goodsName").combobox('select', "请选择商品");
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	}
                });
                
            });
            
            function loadTableData(){
            	
            	$("#commentGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    nowrap: false,
                    fit: false,
                    url: '../commentServlet.do?sign=list',
                    /* queryParams:{goodsId : option}, */
                    queryParams:{goodsName : option},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60, hidden:true},
                            {title: '录入者', field: 'creator', width: 100, align: 'center'},
                            /* {title: '商品', field: 'goodsId', width: 100, align: 'center'}, */
                            {title: '商品', field: 'goodsName', width: 100, align: 'center'},
                            {title: '首评', field: 'firstComment', width: 300, align: 'center',formatter:formatCellTooltip},
                            {title: '', field: 'firstCommentPic', width: 400, align: 'center',hidden:'true'},
                            {title: '首评图片', field: 'left', width: 300, align: 'center', formatter:leftFormatter },
                            {title: '追评论天数', field: 'timeDes', width: 80, align: 'center'},
                            {title: '追评', field: 'secondComment', width: 300, align: 'center'},
                            {title: '', field: 'secondCommentPic', width: 400, align: 'center',hidden:'true'},
                            {title: '追评图片', field: 'right', width: 300, align: 'center', formatter:rightFormatter },
                            {title: '备注', field: 'remark', width: 100, align: 'center',formatter:formatCellTooltip},
                            {title: '审核状态', field: 'isVerify', width: 100, align: 'center', formatter:verifyFormatter}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                   	onBeforeLoad: function(data){
                    	if(<%=isAdmin%>){
                    		$("#toolbar-comment-verify").show();
                    		$("#toolbar-comment-delete").show();
                    	}else{
                    		$("#toolbar-comment-verify").hide();
                    		$("#toolbar-comment-delete").hide();
                    		
                    	}
                    },
                    toolbar: [{
                    	text:'增加',
                        iconCls: 'icon-add',
                        handler: function() {
                            $("#addCommentForm").form('clear');
                            $("#timeDes").combobox('select', "不限时间");
                            $("#addComment").panel('open');
                            $("#addComment").form('load', {
                            	/* goodsId: "-2" */
                            	goodsName: "请选择商品"
                            });
                        }
                    }, {
                    	text:'修改',
                        iconCls: 'icon-edit',
                        handler: function() {
                            var ids = getChecked("commentGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#commentGrid").datagrid('getChecked');
                                $("#addComment").panel('open');
                                $("#addComment").form('load', {
                                	firstComment: row[0].firstComment,
                                	timeDes: row[0].timeDes,
                                	secondComment: row[0].secondComment,
                                	commentId: row[0].id,
                                	remark: row[0].remark,
                                	/* goodsId: row[0].goodsId */
                                	goodsName: row[0].goodsName
                                });
                            }
                        }
                    }, {
                    	id: 'toolbar-comment-delete',
                    	text:'删除',
                        iconCls: 'icon-remove',
                        handler: function() {
                            var ids = getChecked("commentGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../commentServlet.do?sign=delete",
                                            data: "commentIds=" + ids,
                                            success: function(msg) {
                                                $("#commentGrid").datagrid('reload');
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }, {
                    	id: 'toolbar-comment-verify',
                    	text:'审核',
                        iconCls: 'icon-ok',
                        handler: function() {
                            var ids = getChecked("commentGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要审核选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../commentServlet.do?sign=verify",
                                            data: "commentIds=" + ids,
                                            success: function(msg) {
                                                $("#commentGrid").datagrid('reload');
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
            }
            
            
            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
            
            function leftFormatter(value, rowData, rowIndex) {
            	var pics = "";
            	var urls = rowData.firstCommentPic;
            	if(!urls){
            		return "";
            	}
            	var array = rowData.firstCommentPic.split(",");
            	for(var i = 0; i < array.length; i++){
            		if(array[i] != ""){
            			var pic = "<img src='"+array[i]+"' onclick='changeSize(this)' style='width:60px; height:60px;' border='1'/>";
            			pics += pic;
            		}
            	}
            	return pics;
        	}
            
            function changeSize(obj){
            		 var src = "";
            		 $("img").click(function(){
            			  
            			 src = $(obj).attr("src");
                 		 $("#searchId").show();
                 		 var html = "<img style='height:100%;width:100%;' onclick='changeHide(this)' src='"+src+"'>";
                 		 $("#searchId").html(html);
            		 }); 
            }
            function changeHide(obj){
            	$("#searchId").hide();
            }
          
           /*  function moveImg(left,top) 
            { 
            var i = 0; 
            var offset = $(newImg).offset(); 
            $(newImg).offset({ top: offset.top + top, left: offset.left + left}); 
            if (i == 10) 
            { 
            i =0; 
            return; 
            } 
            setTimeout("moveImg("+left+","+top+")", 10); 
            i++; 
            }  */
            function rightFormatter(value, rowData, rowIndex) {
            	var pics = "";
            	var urls = rowData.secondCommentPic;
            	if(!urls){
            		return "";
            	}
            	var array = rowData.secondCommentPic.split(",");
            	for(var i = 0; i < array.length; i++){
            		if(array[i] != ""){
            			var pic = "<img src='"+array[i]+"' onclick='changeSizeS(this)' style='width:60px;height:60px;' border='1'/>";
                		pics += pic;
            		}
            	}
            	return pics;
        	}
            function changeSizeS(obj){
            		 var src = "";
            		 $("img").click(function(){
            			  
            			 src = $(obj).attr("src");
                 		 $("#searchId").show();
                 		 var html = "<img style='height:100%;width:100%;' onclick='changeHideS(this)' src='"+src+"'>";
                 		 $("#searchId").html(html);
            		 }); 
            }
            function changeHideS(obj){
            	$("#searchId").hide();
            }
            function verifyFormatter(value, rowData, rowIndex){
            	if(value == 1){
            		return "审核通过";
            	}else{
            		return "未审核";
            	}
            }

            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
            document.onkeydown = function(event_e){
				if(window.event) {
					event_e = window.event;
				}
				var int_keycode = event_e.charCode||event_e.keyCode;
				if( int_keycode == '13' ) {
					submitAdd();
					return false;
				}
			};
            
            function submitAdd() {
            	/* var goodsId = $("#goodsId").val(); */
            	var goodsName = $("#goodsName").val();
            	/* if(goodsId == -3){
            		alert("请选择商品");
            		return;
            	} */
            	if(goodsName == "请选择商品"){
            		alert("请选择商品");
            		return;
            	} 
				$("#addCommentForm").form('submit', {
				    url:"../commentServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addCommentForm").form('clear');
							$("#timeDes").combobox('select', "不限时间");
        					$("#commentGrid").datagrid("reload");
        					$("#addComment").form('load', {
                            	//goodsId: "-2"
                            	goodsName: "请选择商品"
                            });
				    	}
				    }
				});
			}
        </script>
	</head>

	<body class="easyui-layout" style="width: 100%">
		<div style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
			<label for="option_goods">筛选商品:</label>
			<input id="option_goods" />
	    </div>
		<div class="easyui-panel" title="评论列表" style="width: 100%">
			<table id="commentGrid" style="height: 500px;"></table>
		</div>
		<div id="addComment" class="easyui-panel" data-options="modal:true"
			title="添加评论" style="width: 100%; height: 400px;padding: 10px;">
			<form id="addCommentForm" method="post" enctype="multipart/form-data">
				<!-- input type="hidden" name="goodsId" value="" /> -->
				<input type="hidden" name="commentId" value="" />
				<div>
					<!-- <label for="goodsId">选择商品:</label>
					<input id="goodsId" name="goodsId"/> -->
					<label for="goodsName">选择商品:</label>
					<input id="goodsName" name="goodsName"/>
			    </div>
			    <div >
					<label for="firstComment">首评内容:</label>
					<input class="easyui-textbox" type="text" name="firstComment" style="width:80%;height:50px;" data-options="multiline:true" />
			    </div>
			    <div >
					<label for="firstComment">首评图片:</label>
					<input type="file" name="first_pic_1" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_2" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_3" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_4" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_5" accept="image/jpeg,image/png"/>
			    </div>
			    <br/>
			    <div >
					<label for="timeDes">追评时间:</label>
					<input class="easyui-numberbox" type="text" name="timeDes" style="width:100px;height:30px;" value="7" data-options="min:0,precision:0"/> 天后    <font style="color: red;">&nbsp;&nbsp;*请输入数字，如果不输入，默认7天后</font>
			    </div>
			    <br/>
			    <div >
					<label for="secondComment">追评内容:</label>
					<input class="easyui-textbox" type="text" name="secondComment" style="width:80%;height:50px;" data-options="multiline:true" />
			    </div>
			    <div >
					<label for="firstComment">追评图片:</label>
					<input type="file" name="second_pic_1" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_2" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_3" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_4" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_5" accept="image/jpeg,image/png"/>
			    </div>
			    <br/>
			    <div >
					<label for="remark">录入备注:</label>
					<input class="easyui-textbox" type="text" name="remark" style="width:80%;height:30px;"/>
			    </div>
			</form>
			<br/>
		</div>
		<!-- <div href="" class="avatar"><img style="height:100px;width:100px;" onclick="changBig()" src="../image/login_bg.jpg" /></div>  -->
		 <div title="搜索" id="searchId" class=""  style="width: 600px;margin-left:30%;z-index: 1001;height:450px;background-color:#e0ecff;position:absolute;top:127px;">
				
				<!-- <img style="height:400px;width:400px;" src="../image/login_bg.jpg" onclick="changBig()"> -->
				
					 
			</div>
	</body>
</html>
