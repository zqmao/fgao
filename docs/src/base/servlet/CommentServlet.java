package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Comment;
import base.dao.CommentDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class CommentServlet extends BaseServlet{
	
	private static final long serialVersionUID = 1L;

	public CommentServlet() {
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
			int goodsId = Integer.parseInt(request.getParameter("goodsId"));
			List<Comment> result = CommentDAO.getInstance().list(goodsId);
			JSONObject obj = new JSONObject();
			obj.put("total", result.size());
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		}
	}

}
