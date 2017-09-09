package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Arrange;
import base.api.User;
import base.api.vo.ArrangeVO;
import base.dao.ArrangeDAO;
import base.dao.core.BaseDAO;
import base.dao.core.BaseDAO.QueryBuilder;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class ArrangeServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public ArrangeServlet() {
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
			List<Arrange> result = ArrangeDAO.getInstance().list(currentUser.getId());
			List<ArrangeVO> objs = new ArrayList<ArrangeVO>();
			for(Arrange arrange : result){
				ArrangeVO vo = new ArrangeVO(arrange);
				objs.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", objs.size());
			obj.put("rows", JSON.toJSON(objs));
			responseSuccess(JSON.toJSON(obj));
			BaseDAO<Arrange>.QueryBuilder builder = ArrangeDAO.getInstance().new QueryBuilder();
		}
	}

}
