package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import base.api.User;
import base.dao.UserDAO;
import base.listener.OnlineUserBindingListener;

public class UserServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		super.doPost(request, response);
		if ("login".equals(sign)) {// 登陆
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			if(password == null || password.length() == 0){
				responseError("请输入密码");
				return;
			}
			//password = MdUtil.MD5(password);
			// 先根据登陆名查找是否存在
			User dbUser = UserDAO.getInstance().query(name);
			
			if (dbUser == null) {
				responseError("用户名不存在");
			} else {
				String dbPassword = dbUser.getPassword();
				request.getSession().setAttribute("loginUser", dbUser);
				if(dbPassword.equals(password)){
					responseSuccess(JSON.toJSON(dbUser));
					request.getSession().setAttribute("loginUser", dbUser);
					
					// 把用户名放入在线列表
					request.getSession().setAttribute("onlineUserBindingListener", new OnlineUserBindingListener(dbUser.getLoginName()));
					
				}else{
					responseError("登录失败,密码错误");
				}
			}
		} else if ("list".equals(sign)) {// 查询列表
			
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = UserDAO.getInstance().queryCount();
			int index = (page - 1) * rows;
			List<User> result = UserDAO.getInstance().list(index, rows);
			
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
			
		} else if ("add".equals(sign)) {// 注册用户
			String name = (String) request.getParameter("name");
			String loginName = (String) request.getParameter("loginName");
			String phone = (String) request.getParameter("phone");
			String info = (String) request.getParameter("info");
			String userId = (String) request.getParameter("userId");
			int incumbency = Integer.parseInt(request.getParameter("incumbency"));
			User user = null;
			if(userId == null || userId.length() == 0){
				user = new User();
			}else{
				user = UserDAO.getInstance().load(Integer.parseInt(userId));
			}
			user.setPassword("123456");
			user.setAdmin(0);
			user.setName(name);
			user.setLoginName(loginName);
			user.setPhone(phone);
			user.setInfo(info);
			user.setIncumbency(incumbency);
			if (user.getId() == 0) {
				User dbUser = UserDAO.getInstance().query(loginName);
				if (dbUser != null) {
					responseError("用户名已经存在");
				} else {
					UserDAO.getInstance().saveOrUpdate(user);
					responseSuccess("注册成功");
				}
			} else {
				UserDAO.getInstance().saveOrUpdate(user);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String userIds = (String) request.getParameter("userIds");
			for(String userId : userIds.split(",")){
				UserDAO.getInstance().delete(Integer.parseInt(userId));
				//后面可能需要删除所有和人员有关的
			}
			responseSuccess("删除成功");
		} else if ("select".equals(sign)) {// 查询列表
			List<User> result = UserDAO.getInstance().queryForAll();
			JSONArray array = new JSONArray();
			for(User user : result){
				JSONObject obj = new JSONObject();
				obj.put("id", user.getId());
				obj.put("text", user.getName());
				array.add(obj);
			}
			responseSuccess(JSON.toJSON(array));
		} else if ("selected".equals(sign)) {// 查询列表
			List<User> result = UserDAO.getInstance().queryForAll();
			JSONArray array = new JSONArray();
			for(User user : result){
				JSONObject obj = new JSONObject();
				obj.put("id", user.getId());
				obj.put("text", user.getName());
				array.add(obj);
			}
			returnJson(JSON.toJSON(array));
		}else if ("edit".equals(sign)) {// 查询列表
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			String originPassword = (String) request.getParameter("originPassword");
			String newPassword = (String) request.getParameter("newPassword");
			String confirmPassword = (String) request.getParameter("confirmPassword");
			String phone = (String) request.getParameter("phone");
			if(newPassword != null && newPassword.length() > 0 && confirmPassword != null && confirmPassword.length() > 0){
				//想要修改密码
				if(originPassword.equals(currentUser.getPassword())){
					if(newPassword.equals(confirmPassword)){
						currentUser.setPassword(newPassword);
					}else{
						responseError("新密码确认错误,修改密码失败");
					}
				}else{
					responseError("原密码错误,修改密码失败");
				}
			}
			if(phone != null && phone.length() > 0){
				//想要手机号
				currentUser.setPhone(phone);
			}
			UserDAO.getInstance().saveOrUpdate(currentUser);
			responseSuccess("修改成功");
		} else if ("logout".equals(sign)) {// 退出登录
			request.getSession().setAttribute("loginUser", null);
			responseSuccess("退出成功");
		}
	}

}
