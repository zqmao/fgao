package base.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Document;
import base.api.vo.DocumentVO;
import base.dao.DocumentDAO;
import base.dao.UserCategoryDAO;

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
				List<DocumentVO> temp = new ArrayList<DocumentVO>();
				JSONObject obj = new JSONObject();
				obj.put("total", 0);
				obj.put("rows", JSON.toJSON(temp));
				responseSuccess(JSON.toJSON(obj));
			}else{
				String key = request.getParameter("key");
				int page = Integer.parseInt(request.getParameter("page"));
				int rows = Integer.parseInt(request.getParameter("rows"));
				long total = DocumentDAO.getInstance().listCount(Integer.parseInt(categoryId), currentUser.getId(), key);
				int index = (page - 1) * rows;
				List<Document> result = DocumentDAO.getInstance().list(Integer.parseInt(categoryId), currentUser.getId(), key, index, rows);
				List<DocumentVO> temp = new ArrayList<DocumentVO>();
				for(Document document : result){
					DocumentVO vo = new DocumentVO(document);
					temp.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", total);
				obj.put("rows", JSON.toJSON(temp));
				responseSuccess(JSON.toJSON(obj));
			}
		} else if ("add".equals(sign)) {// 添加
			String articleId = (String) request.getParameter("articleId");
			String categoryId = (String) request.getParameter("categoryId");
			String title = (String) request.getParameter("title");
			String content = (String) request.getParameter("content");
			content = URLDecoder.decode(content,"UTF-8");
			System.out.println(title+content);
			Document document = null;
			if(articleId == null || articleId.length() == 0){
				document = new Document();
			}else{
				document = DocumentDAO.getInstance().load(Integer.parseInt(articleId));
			}
			document.setTitle(title);
			document.setContent(content);
			document.setTime(System.currentTimeMillis());
			document.setUserId(currentUser.getId());
			document.setCategoryId(Integer.parseInt(categoryId));
			DocumentDAO.getInstance().saveOrUpdate(document);
			if(articleId == null || articleId.length() == 0){
				responseSuccess("增加成功");
			}else{
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
			DocumentVO vo = new DocumentVO(result);
			responseSuccess(JSON.toJSON(vo));
		}
	}

}
