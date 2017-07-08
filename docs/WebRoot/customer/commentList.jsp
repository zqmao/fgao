<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.check(request, response);
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
                    url:'../commentServlet.do?sign=select',
                    valueField:'id',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_goods").combobox('select', data.data[0].id);
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                	onSelect: function(record){
                		option = record.id + "";
						if(first == 0){
							var queryParams =$("#commentGrid").datagrid("options").queryParams;
							queryParams.goodsId = option;
							$("#addCommentForm").form('clear');
							$("#timeDes").combobox('select', "不限时间");
							$("#commentGrid").datagrid("load");
						}else{
							loadTableData();
						}
						$("#addComment").form('load', {
                        	goodsId: option
                        });
						first = 0;
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
                    queryParams:{goodsId : option},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '首评', field: 'firstComment', width: 400, align: 'center'},
                            {title: '', field: 'firstCommentPic', width: 400, align: 'center',hidden:'true'},
                            {title: '首评图片', field: 'left', width: 300, align: 'center', formatter:leftFormatter },
                            {title: '追评论天数', field: 'timeDes', width: 80, align: 'center'},
                            {title: '追评', field: 'secondComment', width: 400, align: 'center'},
                            {title: '', field: 'secondCommentPic', width: 400, align: 'center',hidden:'true'},
                            {title: '追评图片', field: 'right', width: 300, align: 'center', formatter:rightFormatter }
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
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
                            	goodsId: option
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
                                	goodsId: option
                                });
                            }
                        }
                    }, {
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
                    }]
                });
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
            			var pic = "<img src='"+array[i]+"' style='width:60px; height:60px;' border='1'/>";
                		pics += pic;
            		}
            	}
            	return pics;
        	}
            
            function rightFormatter(value, rowData, rowIndex) {
            	var pics = "";
            	var urls = rowData.secondCommentPic;
            	if(!urls){
            		return "";
            	}
            	var array = rowData.secondCommentPic.split(",");
            	for(var i = 0; i < array.length; i++){
            		if(array[i] != ""){
            			var pic = "<img src='"+array[i]+"' style='width:60px; height:60px;' border='1'/>";
                		pics += pic;
            		}
            	}
            	return pics;
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
                            	goodsId: option
                            });
				    	}
				    }
				});
			}
            
        </script>
	</head>

	<body class="easyui-layout">
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
				<input type="hidden" name="goodsId" value="" />
				<input type="hidden" name="commentId" value="" />
			    <br/>
			    <div >
					<label for="firstComment">首评内容:</label>
					<input class="easyui-textbox" type="text" name="firstComment" style="width:80%;height:50px;" data-options="multiline:true" />
			    </div>
			    <div >
					<label for="firstComment">首评图片:</label>
					<input type="file" name="first_pic_1" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_2" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_3" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_4" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="first_pic_5" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
			    </div>
			    <br/>
			    <div >
					<label for="timeDes">追评时间:</label>
					<select class="easyui-combobox" id="timeDes" name="timeDes" style="width:40%;">
					    <option value="不限时间" checked="true">不限时间</option>
					    <option value="1天后">1天后</option>
					    <option value="2天后">2天后</option>
					    <option value="3天后">3天后</option>
					    <option value="4天后">4天后</option>
					    <option value="5天后">5天后</option>
					    <option value="6天后">6天后</option>
					    <option value="7天后">7天后</option>
					</select>
			    </div>
			    <br/>
			    <div >
					<label for="secondComment">追评内容:</label>
					<input class="easyui-textbox" type="text" name="secondComment" style="width:80%;height:50px;" data-options="multiline:true" />
			    </div>
			    <div >
					<label for="firstComment">追评图片:</label>
					<input type="file" name="second_pic_1" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_2" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_3" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_4" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
				    <input type="file" name="second_pic_5" enctype="multipart/form-data" accept="image/jpeg,image/png"/>
			    </div>
			</form>
			<br/>
		</div>
	</body>
</html>
