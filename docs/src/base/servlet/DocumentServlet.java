package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Document;
import base.dao.DocumentDAO;

import com.alibaba.fastjson.JSON;

public class DocumentServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public DocumentServlet() {
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
			String userId = (String) request.getParameter("userId");
			List<Document> result = DocumentDAO.getInstance().list(Integer.parseInt(categoryId));
			System.out.println(JSON.toJSON(result));
			responseSuccess(JSON.toJSON(result));
		} else if ("add".equals(sign)) {// 添加
			String param = (String) request.getParameter("document");
			Document document = JSON.parseObject(param, Document.class);
			if (document.getId() == 0) {
				int id = DocumentDAO.getInstance().saveOrUpdate(document);
				Document dbResult = DocumentDAO.getInstance().load(id);
				responseSuccess(JSON.toJSON(dbResult));
			} else {
				DocumentDAO.getInstance().saveOrUpdate(document);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String id = (String)request.getParameter("id");
			DocumentDAO.getInstance().delete(Integer.parseInt(id));
			responseSuccess("删除成功");
		} else if ("query".equals(sign)) {// 查询
			String id = (String) request.getParameter("id");
			Document result = DocumentDAO.getInstance().load(Integer.parseInt(id));
			if(result != null){
				responseSuccess(JSON.toJSON(result));
			}else{
				responseError("未查询到结果");
			}
		}
	}

}
