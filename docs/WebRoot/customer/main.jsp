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
	</script>
  </head>
  
  <body>
    <div style="margin: 0 auto;width: 1000px;height: 250px;">
    	<table width="100%" height="100%" style="padding: 20px;" cellspacing="20px">
    		<tr>
    			<td bgcolor="#1AE6E6" style="width: 50%;cursor: pointer;" align="center" onclick="toBug();">
    				<font size="20" color="#FFFFFF">待办管理</font>
    			</td>
    			<td bgcolor="#D54D2B" style="width: 50%;cursor: pointer;" align="center" onclick="toArticle();">
    				<font size="20" color="#FFFFFF">文章管理</font>
    			</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
