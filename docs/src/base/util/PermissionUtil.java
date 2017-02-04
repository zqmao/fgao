package base.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.User;

public class PermissionUtil {
	
	/*
	 * 普通成员页面的权限
	 */
	public static void check(HttpServletRequest request, HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("loginUser");
		if(currentUser == null){
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
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
		}else{
			
		}
	}
	
	/*
	 * 管理员页面的权限
	 */
	public static void checkAdmin(HttpServletRequest request, HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("loginUser");
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		if(currentUser == null){
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
		}else{
			if(currentUser.getAdmin() != 1){
				String loginUrl = basePath + "/error.jsp";
				try {
					response.sendRedirect(loginUrl);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
