package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Category;
import base.api.User;
import base.dao.UserCategoryDAO;


public class UserCategoryServlet extends BaseServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doPost(req, resp);
		if ("listByUser".equals(sign)) {// 根据人员查询有权限的类别
			String userId = (String) req.getParameter("userId");
			List<Category> result = UserCategoryDAO.getInstance().listByUser(Integer.parseInt(userId));
			responseSuccess(result);
		}else if ("listByCategory".equals(sign)) {// 根据类别查询有权限的人员
			String categoryId = (String) req.getParameter("categoryId");
			List<User> result = UserCategoryDAO.getInstance().listByCategory(Integer.parseInt(categoryId));
			responseSuccess(result);
		}
	}

}
