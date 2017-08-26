package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import base.api.AfterSaleComeRecord;
import base.api.vo.AfterSaleComeRecordVO;
import base.dao.AfterSaleComeRecordDAO;

public class AfterSaleComeRecordServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public AfterSaleComeRecordServlet() {
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
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = AfterSaleComeRecordDAO.getInstance().listCount();
			int index = (page - 1) * rows;
			List<AfterSaleComeRecord> result = AfterSaleComeRecordDAO.getInstance().list(index, rows);
			List<AfterSaleComeRecordVO> vos = new ArrayList<AfterSaleComeRecordVO>();
			for(AfterSaleComeRecord record : result){
				AfterSaleComeRecordVO vo = new AfterSaleComeRecordVO(record);
				vos.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(vos));
			responseSuccess(JSON.toJSON(obj));
		}
	}

}
