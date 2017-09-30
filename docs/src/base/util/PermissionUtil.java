package base.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.User;

public class PermissionUtil {
	
	/*
	 * 获取当前登录人员
	 */
	public static User getCurrentUser(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			return new User();
		}
		return user;
	}
	/*
	 * 普通成员页面的权限
	 */
	public static int check(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return 0;
		}else{
			return user.getId();
		}
	}
	
	/*
	 * 管理员页面的权限
	 */
	public static int checkAdmin(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return 0;
		}else{
			if(user.getAdmin() != 1){
				redirectError(request, response);
			}
			return user.getId();
		}
	}
	
	/*
	 * 是否具有进货的权限
	 */
	public static boolean checkGoodsIn(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getInGoods() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	
	/*
	 * 是否具有发货的权限
	 */
	public static boolean checkGoodsOut(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getOutGoods() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	
	/*
	 * 是否具有发货的权限
	 */
	public static boolean checkCoupon(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getCoupon() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	/*
	 * 是否具有操作售后记录的权限
	 */
	public static boolean checkAfter(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getAfter() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	/*
	 * 是否具有导入csv文件的权限
	 */
	public static boolean checkExport(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getExport() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	/*
	 * 是否具有编辑知识库的权限
	 */
	public static boolean checkEditor(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			redirectLogin(request, response);
			return false;
		}else{
			if(user.getEditor()!= 1){
				return false;
			}else{
				return true;
			}
		}
	}
	/*
	 * 是否是管理员
	 */
	public static boolean isAdmin(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("loginUser");
		if(user == null){
			return false;
		}else{
			if(user.getAdmin() != 1){
				return false;
			}else{
				return true;
			}
		}
	}
	
	public static void redirectLogin(HttpServletRequest request, HttpServletResponse response){
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		try {
			String backUrl = "";
			String params = request.getQueryString();
			if(params == null || params.length() == 0){
				backUrl = basePath+request.getRequestURI();
			}else{
				backUrl = basePath+request.getRequestURI()+"?"+params;
			}
			String loginUrl = basePath + "/login.jsp?backUrl=";
			response.sendRedirect(loginUrl + backUrl);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static void redirectError(HttpServletRequest request, HttpServletResponse response){
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String errorUrl = basePath + "/error.jsp";
		try {
			response.sendRedirect(errorUrl);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
