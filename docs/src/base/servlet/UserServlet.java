package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.User;
import base.dao.UserDAO;

import com.alibaba.fastjson.JSON;

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
			User user = new User();
			user.setName(request.getParameter("name"));
			user.setPassword(request.getParameter("password"));
			// 先根据登陆名查找是否存在
			User dbUser = UserDAO.getInstance().query(user.getName());
			if (dbUser == null) {
				responseError("用户名不存在");
			} else {
				user = UserDAO.getInstance().login(user);
				if (user != null) {
					responseSuccess(JSON.toJSON(user));
				} else {
					responseError("登录失败,密码错误");
				}
			}
		} else if ("list".equals(sign)) {// 查询列表
			List<User> result = UserDAO.getInstance().list();
			System.out.println(JSON.toJSON(result));
			responseSuccess(JSON.toJSON(result));
		} else if ("add".equals(sign)) {// 注册用户
			String userStr = (String) request.getParameter("user");
			User user = JSON.parseObject(userStr, User.class);
			if (user.getId() == 0) {
				User dbUser = UserDAO.getInstance().query(user.getName());
				if (dbUser != null) {
					responseError("用户名已经存在");
				} else {
					int userId = UserDAO.getInstance().saveOrUpdate(user);
					dbUser = UserDAO.getInstance().load(userId);
					if (dbUser == null) {
						responseError("注册失败");
					} else {
						responseSuccess(JSON.toJSON(dbUser));
					}
				}
			} else {
				UserDAO.getInstance().saveOrUpdate(user);
				responseSuccess("修改成功");
			}
		}else if ("query".equals(sign)) {// 查询
			String name = (String) request.getParameter("name");
			User user = UserDAO.getInstance().query(name);
			if(user != null){
				responseSuccess(JSON.toJSON(user));
			}else{
				responseError("用户名不存在");
			}
		}
	}

}
