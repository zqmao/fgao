package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Category;
import base.api.vo.CategoryVO;
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
			String parentId = (String) request.getParameter("parentId");
			List<Category> result = CategoryDAO.getInstance().list(Integer.parseInt(parentId));
			List<CategoryVO> temp = new ArrayList<CategoryVO>();
			for(Category category : result){
				CategoryVO vo = new CategoryVO();
				vo.setId(category.getId());
				vo.setText(category.getText());
				if(parentId.equals("0")){
					vo.setParentName("根分类");
				}else{
					Category parent = CategoryDAO.getInstance().load(Integer.parseInt(parentId));
					vo.setParentName(parent.getText());
				}
				temp.add(vo);
			}
			responseSuccess(JSON.toJSON(temp));
		} else if ("add".equals(sign)) {// 添加
			String text = (String) request.getParameter("text");
			String categoryId = (String) request.getParameter("categoryId");
			String parentId = (String) request.getParameter("parentId");
			Category category = null;
			if(categoryId == null || categoryId.length() == 0){
				category = new Category();
			}else{
				category = CategoryDAO.getInstance().load(Integer.parseInt(categoryId));
			}
			category.setText(text);
			category.setParentId(Integer.parseInt(parentId));
			if (category.getId() == 0) {
				Category dbResult = CategoryDAO.getInstance().query(text);
				if (dbResult != null) {
					responseError("名称已经存在");
				} else {
					CategoryDAO.getInstance().saveOrUpdate(category);
					responseSuccess("修改成功");
				}
			} else {
				CategoryDAO.getInstance().saveOrUpdate(category);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String categoryIds = (String)request.getParameter("categoryIds");
			for(String categoryId : categoryIds.split(",")){
				CategoryDAO.getInstance().delete(Integer.parseInt(categoryId));
			}
			responseSuccess("删除成功");
		} else if ("query".equals(sign)) {// 
			String categoryId = (String)request.getParameter("categoryId");
			Category category = CategoryDAO.getInstance().load(Integer.parseInt(categoryId));
			if(category == null){
				responseSuccess(0);
			}else{
				responseSuccess(category.getParentId());
			}
		}
	}

}
