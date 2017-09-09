package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Goods;
import base.api.GoodsOutRecord;
import base.api.vo.GoodsOutRecordVO;
import base.dao.GoodsDAO;
import base.dao.GoodsOutDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class GoodsOutServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public GoodsOutServlet() {
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
			long total = GoodsOutDAO.getInstance().queryCount();
			int index = (page - 1) * rows;
			List<GoodsOutRecord> result = GoodsOutDAO.getInstance().list(index, rows);
			List<GoodsOutRecordVO> objs = new ArrayList<GoodsOutRecordVO>();
			for(GoodsOutRecord record : result){
				GoodsOutRecordVO vo = new GoodsOutRecordVO(record);
				objs.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(objs));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {// 增加
			int count = Integer.parseInt(request.getParameter("count"));
			String goodsId = (String) request.getParameter("goodsId");
			String recordId = (String) request.getParameter("recordId");
			String remark = (String) request.getParameter("remark");
			GoodsOutRecord record = null;
			if(recordId == null || recordId.length() == 0){
				record = new GoodsOutRecord();
			}else{
				record = GoodsOutDAO.getInstance().load(Integer.parseInt(recordId));
			}
			int dex = record.getCount() - count;
			record.setCount(count);
			record.setTime(System.currentTimeMillis());
			record.setGoodsId(Integer.parseInt(goodsId));
			record.setRemark(remark);
			GoodsOutDAO.getInstance().saveOrUpdate(record);
			if (record.getId() == 0) {
				responseSuccess("添加成功");
			} else {
				responseSuccess("修改成功");
			}
			//修正库存
			Goods goods = GoodsDAO.getInstance().load(Integer.parseInt(goodsId));
			int stock = goods.getStock();
			stock = stock + dex;
			goods.setStock(stock);
			GoodsDAO.getInstance().saveOrUpdate(goods);
		} else if ("delete".equals(sign)) {// 删除
			String recordIds = (String) request.getParameter("recordIds");
			for(String recordId : recordIds.split(",")){
				GoodsOutRecord record = GoodsOutDAO.getInstance().load(Integer.parseInt(recordId));
				//修正库存
				Goods goods = GoodsDAO.getInstance().load(record.getGoodsId());
				int stock = goods.getStock();
				stock = stock + record.getCount();
				goods.setStock(stock);
				GoodsDAO.getInstance().saveOrUpdate(goods);
				GoodsOutDAO.getInstance().delete(record);
			}
			responseSuccess("删除成功");
		}
	}

}
