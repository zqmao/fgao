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
			String categoryId = (String) request.getParameter("categoryId");
			List<Category> result = CategoryDAO.getInstance().list(Integer.parseInt(categoryId));
			System.out.println(JSON.toJSON(result));
			responseSuccess(JSON.toJSON(result));
		} else if ("add".equals(sign)) {// 添加
			String param = (String) request.getParameter("category");
			Category category = JSON.parseObject(param, Category.class);
			if (category.getId() == 0) {
				Category dbResult = CategoryDAO.getInstance().query(category.getName());
				if (dbResult != null) {
					responseError("名称已经存在");
				} else {
					int id = CategoryDAO.getInstance().saveOrUpdate(category);
					dbResult = CategoryDAO.getInstance().load(id);
					responseSuccess(JSON.toJSON(dbResult));
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
