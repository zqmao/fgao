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
import base.api.User;
import base.api.vo.AfterSaleComeRecordVO;
import base.dao.AfterSaleComeRecordDAO;
import base.dao.UserDAO;

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
		}else if("add".equals(sign)){//新增纪录
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			String courierNum = (String) request.getParameter("courierNum");
			String goodsName = (String) request.getParameter("goodsName");
			String checkResult = (String) request.getParameter("checkResult");
			String wangwang = (String) request.getParameter("wangwang");
			String phoneNum = (String) request.getParameter("phoneNum");
			String orderNum = (String) request.getParameter("orderNum");
			String remark = (String) request.getParameter("remark");
			String status = (String) request.getParameter("status");
			String id = (String) request.getParameter("ascrId");
			AfterSaleComeRecord afterSaleComeRecord = null;
			//如果没有id是新建
			if(id == null || id.length() == 0){
				afterSaleComeRecord = new AfterSaleComeRecord();
				afterSaleComeRecord.setCreatorId(currentUser.getId());
				afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
			}else{
				afterSaleComeRecord = AfterSaleComeRecordDAO.getInstance().load(Integer.parseInt(id));
			}
			afterSaleComeRecord.setCourierNum(courierNum);
			afterSaleComeRecord.setGoodsName(goodsName);
			afterSaleComeRecord.setCheckResult(checkResult);
			afterSaleComeRecord.setWangwang(wangwang);
			afterSaleComeRecord.setPhoneNum(phoneNum);
			afterSaleComeRecord.setOrderNum(orderNum);
			afterSaleComeRecord.setRemark(remark);
			if("已处理".equals(status)){
				afterSaleComeRecord.setStatus(1);
			}else{
				afterSaleComeRecord.setStatus(0);
			}
			AfterSaleComeRecordDAO.getInstance().saveOrUpdate(afterSaleComeRecord);
			if(id == null || id.length() == 0){
				responseSuccess("新建售后记录成功");
			}else{
				responseSuccess("更新售后记录成功");
			}
		    
		}
	}
		
}


