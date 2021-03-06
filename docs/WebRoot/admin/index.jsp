﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%@ page language="java" import="base.api.*"%>
<%
	PermissionUtil.checkAdmin(request, response);
	User user = PermissionUtil.getCurrentUser(request, response);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>用户中心</title>
	<link href="../bootstrap-3.3.5-dist/css/bootstrap.min.css" title=""
		rel="stylesheet" />
	<link title="" href="../css/style.css" rel="stylesheet" type="text/css" />
	<link title="blue" href="../css/dermadefault.css" rel="stylesheet"
		type="text/css" />
	<link title="green" href="../css/dermagreen.css" rel="stylesheet"
		type="text/css" disabled="disabled" />
	<link title="orange" href="../css/dermaorange.css" rel="stylesheet"
		type="text/css" disabled="disabled" />
	<link href="../css/templatecss.css" rel="stylesheet" title=""
		type="text/css" />
	<script src="../script/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script src="../script/jquery.cookie.js" type="text/javascript"></script>
	<script src="../bootstrap-3.3.5-dist/js/bootstrap.min.js" type="text/javascript"></script>
		
	<script type="text/javascript">
		$(document).ready(function(){
		  $(".subNavBox a").click(function(){
		    clickLi(this);
		  })
		})
		function clickLi(dom){
			//找到所有的li，取消选中
			//找到点击的a标签，设置它对于的li选中
			var lis = $(".subNavBox li");
			for(var i = 0; i < lis.length; i++){
				var liObj = lis[i];
				$(liObj).removeClass("active");
			}
			$(dom).parent().addClass("active");
		}
		
		function logout(){
			$.ajax({
                type: "POST",
                url: "../userServlet.do?sign=logout",
                success: function(msg) {
                	alert("退出成功");
                	window.location.href="../login.jsp";
                },
                error: function(msg) {
                    alert(msg.toString());
                }
            });
		}
	</script>
</head>

<body>
	<nav class="nav navbar-default navbar-mystyle navbar-fixed-top">
	<div class="navbar-header">
		<a class="navbar-brand"><span class="glyphicon glyphicon-home"></span></a>
	</div>
	<div class="collapse navbar-collapse">
		<ul class="nav navbar-nav">
			<li class="li-border"><a class="mystyle-color" href="../default.jsp" target="content">管理控制台</a></li>
		</ul>
		<ul class="nav navbar-nav pull-right">
			<li class="dropdown li-border">
				<a href="#" class="dropdown-toggle mystyle-color" data-toggle="dropdown"><%=user.getName()%><span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="#" onclick="logout();">退出</a></li>
				</ul>
			</li>
			<li class="dropdown">
				<a href="#" class="dropdown-toggle mystyle-color" data-toggle="dropdown">换肤<span class="caret"></span></a>
				<ul class="dropdown-menu changecolor">
					<li id="blue"><a href="#">蓝色</a></li>
					<li class="divider"></li>
					<li id="green"><a href="#">绿色</a></li>
					<li class="divider"></li>
					<li id="orange"><a href="#">橙色</a></li>
				</ul>
			</li>
		</ul>
	</div>
	</nav>
	<div class="down-main">
		<div class="left-main left-full">
			<div class="sidebar-fold">
				<span class="glyphicon glyphicon-menu-hamburger"></span>
			</div>
			<div class="subNavBox">
				<div class="sBox">
					<div class="subNav sublist-down">
						<span class="title-icon glyphicon glyphicon-chevron-down"></span><span class="sublist-title">工作相关</span>
					</div>
					<ul class="navContent" style="display: block">
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />
							</div> 
							<a href="/customer/commentList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">评论搜集</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />
							</div> 
							<a href="/admin/bugList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">待办管理</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />知识库
							</div> 
							<a href="/admin/articleList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">知识库</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />优惠券管理
							</div> 
							<a href="/customer/couponList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">优惠券管理</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />补发快递
							</div> 
							<a href="/admin/expressReissueList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">补发快递</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />售后收货
							</div> 
							<a href="/customer/afterSaleComeRecordList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">售后收货</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />订单查询
							</div> 
							<a href="/admin/exportOrderList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">订单查询</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />开票处理
							</div> 
							<a href="/admin/drawBill.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">开票处理</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />售前考核
							</div> 
							<a href="/admin/preSaleReocrdList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-credit-card"></span>
								<span class="sub-title">售前考核</span>
							</a>
						</li>
						<li>
							<a href="/admin/freshOrder.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-inbox"></span>
								<span class="sub-title">操作管理</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="sBox">
					<div class="subNav sublist-up">
						<span class="title-icon glyphicon glyphicon-chevron-up"></span><span
							class="sublist-title">管理相关</span>
					</div>
					<ul class="navContent" style="display: none">
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />人员管理
							</div> 
							<a href="/admin/userList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-user"></span>
								<span class="sub-title">人员管理</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />分类管理
							</div> 
							<a href="/admin/categoryList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-user"></span>
								<span class="sub-title">分类管理</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />排班情况
							</div> 
							<a href="/admin/arrange.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-user"></span>
								<span class="sub-title">排班情况</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />修改个人信息
							</div> 
							<a href="/customer/userEdit.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-user"></span>
								<span class="sub-title">修改个人信息</span>
							</a>
						</li>
						<li>
							<div class="showtitle" style="width: 100px;">
								<img src="../img/leftimg.png" />考勤情况
							</div> 
							<a href="/customer/signList.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-user"></span>
								<span class="sub-title">考勤情况</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="sBox">
				<div class="subNav sublist-up">
						<span class="title-icon glyphicon glyphicon-chevron-up"></span><span
							class="sublist-title">进销存系统</span>
					</div>
					<ul class="navContent" style="display:none;">
						<li>
							<a href="/admin/shop.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-compressed"></span>
								<span class="sub-title">店铺管理</span>
							</a>
						</li>
						<li>
							<a href="/admin/goods.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-subtitles"></span>
								<span class="sub-title">产品管理</span>
							</a>
						</li>
						<li>
							<a href="/admin/records.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-subtitles"></span>
								<span class="sub-title">统计报表</span>
							</a>
						</li>
						<li>
							<a href="/admin/goods.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-shopping-cart"></span>
								<span class="sub-title">采购管理</span>
							</a>
						</li>
						<li>
							<a href="/admin/goods.jsp" target="content">
								<span class="sublist-icon glyphicon glyphicon-eye-open"></span>
								<span class="sub-title">盘点管理</span>
							</a>
						</li>
					</ul>
				</div>
							
			</div>
		</div>
		<div class="right-product my-index right-full">
			<div class="container-fluid" style="padding:0px;">
				<iframe id="content" name="content" src="../default.jsp"
					style="width: 100%;height: 1500px;border: none;padding:0px;" >
				</iframe>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			/*换肤*/
			$(".dropdown .changecolor li").click(function() {
				var style = $(this).attr("id");
				$("link[title!='']").attr("disabled", "disabled");
				$("link[title='" + style + "']").removeAttr("disabled");

				$.cookie('mystyle', style, {
					expires : 7
				}); // 存储一个带7天期限的 cookie 
			})
			var cookie_style = $.cookie("mystyle");
			if (cookie_style != null) {
				$("link[title!='']").attr("disabled", "disabled");
				$("link[title='" + cookie_style + "']").removeAttr("disabled");
			}
			/*左侧导航栏显示隐藏功能*/
			$(".subNav")
					.click(
							function() {
								/*显示*/
								if ($(this).find("span:first-child").attr(
										'class') == "title-icon glyphicon glyphicon-chevron-down") {
									$(this).find("span:first-child")
											.removeClass(
													"glyphicon-chevron-down");
									$(this).find("span:first-child").addClass(
											"glyphicon-chevron-up");
									$(this).removeClass("sublist-down");
									$(this).addClass("sublist-up");
								}
								/*隐藏*/
								else {
									$(this)
											.find("span:first-child")
											.removeClass("glyphicon-chevron-up");
									$(this).find("span:first-child").addClass(
											"glyphicon-chevron-down");
									$(this).removeClass("sublist-up");
									$(this).addClass("sublist-down");
								}
								// 修改数字控制速度， slideUp(500)控制卷起速度
								$(this).next(".navContent").slideToggle(300)
										.siblings(".navContent").slideUp(300);
							})
			/*左侧导航栏缩进功能*/
			$(".left-main .sidebar-fold")
					.click(
							function() {

								if ($(this).parent().attr('class') == "left-main left-full") {
									$(this).parent().removeClass("left-full");
									$(this).parent().addClass("left-off");

									$(this).parent().parent().find(
											".right-product").removeClass(
											"right-full");
									$(this).parent().parent().find(
											".right-product").addClass(
											"right-off");

								} else {
									$(this).parent().removeClass("left-off");
									$(this).parent().addClass("left-full");

									$(this).parent().parent().find(
											".right-product").removeClass(
											"right-off");
									$(this).parent().parent().find(
											".right-product").addClass(
											"right-full");

								}
							})

			/*左侧鼠标移入提示功能*/
			$(".sBox ul li").mouseenter(function() {
				if ($(this).find("span:last-child").css("display") == "none") {
					$(this).find("div").show();
				}
			}).mouseleave(function() {
				$(this).find("div").hide();
			})
		})
	</script>
</body>
</html>
