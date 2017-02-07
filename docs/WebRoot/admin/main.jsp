<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	//这个页面展示4个按钮（人员，待办，分类，文章）
	PermissionUtil.checkAdmin(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>管理员页面</title>
    <script type="text/javascript">
		function toUser(){
			window.open("/admin/userList.jsp");
		}
		function toBug(){
			window.open("/admin/bugList.jsp");
		}
		function toCategory(){
			window.open("/admin/categoryList.jsp");
		}
		function toArticle(){
			window.open("/admin/articleList.jsp");
		}
	</script>
  </head>
  
  <body>
    <div style="margin: 0 auto;width: 1000px;height: 500px;">
    	<table width="100%" height="100%" style="padding: 20px;" cellspacing="20px">
    		<tr>
    			<td bgcolor="#1169EE" style="width: 50%;cursor: pointer;" align="center" onclick="toUser();">
    				<font size="20" color="#FFFFFF">人员管理</font>
    			</td>
    			<td bgcolor="#1AE6E6" style="width: 50%;cursor: pointer;" align="center" onclick="toBug();">
    				<font size="20" color="#FFFFFF">待办管理</font>
    			</td>
    		</tr>
    		<tr>
    			<td bgcolor="#ff0000" style="width: 50%;cursor: pointer;" align="center" onclick="toCategory();">
    				<font size="20" color="#FFFFFF">分类管理</font>
    			</td>
    			<td bgcolor="#D54D2B" style="width: 50%;cursor: pointer;" align="center" onclick="toArticle();">
    				<font size="20" color="#FFFFFF">文章管理</font>
    			</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
