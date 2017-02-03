package base.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.User;

import com.alibaba.fastjson.JSONObject;

public class BaseServlet extends HttpServlet{
	
	protected String sign = "";
	protected User currentUser = null;
	protected HttpServletRequest request;
	protected HttpServletResponse response;

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		request = req;
		response = resp;
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/plain");
		sign = (String) req.getParameter("sign");
		currentUser = (User)req.getSession().getAttribute("loginUser");
	}
	
	protected void responseSuccess(Object cotent){
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(getResponseStr("1", cotent, ""));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	
	protected void responseError(String reason) {
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(getResponseStr("0", "", reason));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	
	private static String getResponseStr(String result, Object content, String reason) {
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		obj.put("data", content);
		obj.put("reason", reason);
		return obj.toString();
	}
}
