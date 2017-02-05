package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Category;
import base.api.User;
import base.api.UserCategory;
import base.dao.UserCategoryDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


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
		}else if ("listBySimpleCategory".equals(sign)) {// 根据类别查询有权限的人员
			String categoryId = (String) req.getParameter("categoryId");
			int page = Integer.parseInt(req.getParameter("page"));
			int rows = Integer.parseInt(req.getParameter("rows"));
			long total = UserCategoryDAO.getInstance().listBySimpleCategoryCount(Integer.parseInt(categoryId));
			int index = (page - 1) * rows;
			List<User> result = UserCategoryDAO.getInstance().listBySimpleCategory(Integer.parseInt(categoryId), index, rows);
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {// 添加
			String categoryId = (String) request.getParameter("categoryId");
			String userId = (String) request.getParameter("userId");
			UserCategory uc = UserCategoryDAO.getInstance().query(Integer.parseInt(categoryId), Integer.parseInt(userId));
			if(uc == null){
				uc = new UserCategory();
			}else{
				responseSuccess("保存成功");
				return;
			}
			uc.setUserId(Integer.parseInt(userId));
			uc.setCategoryId(Integer.parseInt(categoryId));
			UserCategoryDAO.getInstance().saveOrUpdate(uc);
			responseSuccess("保存成功");
		} else if ("delete".equals(sign)) {// 添加
			String categoryId = (String) request.getParameter("categoryId");
			String userId = (String) request.getParameter("userId");
			UserCategory uc = UserCategoryDAO.getInstance().query(Integer.parseInt(categoryId), Integer.parseInt(userId));
			if(uc != null){
				UserCategoryDAO.getInstance().delete(uc);
				responseSuccess("保存成功");
			}
		}
	}

}
