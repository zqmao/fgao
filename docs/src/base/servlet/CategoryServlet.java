package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Category;
import base.dao.CategoryDAO;

import com.alibaba.fastjson.JSON;

public class CategoryServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public CategoryServlet() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {// 查询列表
			List<Category> result = CategoryDAO.getInstance().list();
			System.out.println(JSON.toJSON(result));
			responseSuccess(JSON.toJSON(result));
		} else if ("add".equals(sign)) {// 添加
			String param = (String) request.getParameter("category");
			Category category = JSON.parseObject(param, Category.class);
			if (category.getId() == 0) {
				Category dbCategory = CategoryDAO.getInstance().query(category.getName());
				if (dbCategory != null) {
					responseError("名称已经存在");
				} else {
					int userId = CategoryDAO.getInstance().saveOrUpdate(category);
					dbCategory = CategoryDAO.getInstance().load(userId);
					responseSuccess(JSON.toJSON(dbCategory));
				}
			} else {
				CategoryDAO.getInstance().saveOrUpdate(category);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String id = (String)request.getParameter("id");
			CategoryDAO.getInstance().delete(Integer.parseInt(id));
			responseSuccess("删除成功");
		}
	}

}
