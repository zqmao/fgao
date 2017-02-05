package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Document;
import base.api.User;
import base.api.vo.DocumentVO;
import base.dao.DocumentDAO;
import base.dao.UserCategoryDAO;
import base.dao.UserDAO;
import base.util.DateUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

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
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			if(currentUser.getAdmin() != 1 && !UserCategoryDAO.getInstance().checkPermission(Integer.parseInt(categoryId), currentUser.getId())){
				responseError("无权限");
			}else{
				int page = Integer.parseInt(request.getParameter("page"));
				int rows = Integer.parseInt(request.getParameter("rows"));
				long total = DocumentDAO.getInstance().listCount(Integer.parseInt(categoryId));
				int index = (page - 1) * rows;
				List<Document> result = DocumentDAO.getInstance().list(Integer.parseInt(categoryId), index, rows);
				List<DocumentVO> temp = new ArrayList<DocumentVO>();
				for(Document document : result){
					DocumentVO vo = new DocumentVO();
					vo.setId(document.getId());
					User user = UserDAO.getInstance().load(document.getUserId());
					vo.setUserName(user.getName());
					vo.setTitle(document.getTitle());
					vo.setContent(document.getContent());
					vo.setTime(DateUtil.toString(document.getTime()));
					temp.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", total);
				obj.put("rows", JSON.toJSON(temp));
				responseSuccess(JSON.toJSON(obj));
			}
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
			String articleIds = (String)request.getParameter("articleIds");
			for(String articleId : articleIds.split(",")){
				DocumentDAO.getInstance().delete(Integer.parseInt(articleId));
			}
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
