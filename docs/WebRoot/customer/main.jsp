<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	//这个页面展示2个按钮（待办，文章）
	PermissionUtil.check(request, response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>我的地盘</title>
    <script type="text/javascript">
		function toBug(){
			window.open("/customer/bugList.jsp");
		}
		function toArticle(){
			window.open("/customer/articleList.jsp");
		}
		function toArrange(){
			window.open("/customer/arrange.jsp");
		}
		function toGoods(){
			window.open("/admin/goods.jsp");
		}
		function toComments(){
			window.open("/customer/commentList.jsp");
		}
		function toCoupons(){
			window.open("/customer/couponList.jsp");
		}
		function toUserEdit(){
			window.open("/customer/userEdit.jsp");
		}
		function toAfterSale(){
			window.open("/customer/afterSaleComeRecordList.jsp");
		}
	</script>
  </head>
  
  <body>
  	<div style="float: right;">
  		<div style="cursor: pointer; background-color: #000000;padding:20px;margin:  40px;" align="center" onclick="toUserEdit();">
			<font size="4" color="#FFFFFF">个人信息修改</font>
		</div>
  	</div>
    <div style="margin: 0 auto;width: 1000px;">
    	<table width="100%" height="100%" style="padding: 20px;" cellspacing="20px">
    		<tr>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toBug();">
    				<font size="20" color="#FFFFFF">待办管理</font>
    			</td>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toArticle();">
    				<font size="20" color="#FFFFFF">文章管理</font>
    			</td>
    		</tr>
    		<tr>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toArrange();">
    				<font size="20" color="#FFFFFF">排班情况</font>
    			</td>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toGoods();">
    				<font size="20" color="#FFFFFF">进销存系统</font>
    			</td>
    		</tr>
    		<tr>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toComments();">
    				<font size="20" color="#FFFFFF">录入评论</font>
    			</td>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toCoupons();">
    				<font size="20" color="#FFFFFF">优惠券管理</font>
    			</td>
    		</tr>
    		<tr>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="toAfterSale();">
    				<font size="20" color="#FFFFFF">售后收货记录</font>
    			</td>
    			<td bgcolor="#000000" style="width: 50%;cursor: pointer;" align="center" onclick="">
    				<font size="20" color="#FFFFFF">建设中</font>
    			</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
