package base.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.User;

public class PermissionUtil {
	private static User currentUser = null;
	
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
	
	private static void redirectLogin(HttpServletRequest request, HttpServletResponse response){
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

	public static User getCurrentUser() {
		return currentUser;
	}

	public static void setCurrentUser(User user) {
		currentUser = user;
	}

}
