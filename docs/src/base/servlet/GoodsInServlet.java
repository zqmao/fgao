package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Goods;
import base.api.GoodsComeRecord;
import base.api.GoodsInRecord;
import base.api.vo.GoodsComeRecordVO;
import base.api.vo.GoodsInRecordVO;
import base.dao.GoodsComeDAO;
import base.dao.GoodsDAO;
import base.dao.GoodsInDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class GoodsInServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public GoodsInServlet() {
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
			long total = GoodsInDAO.getInstance().listCount();
			int index = (page - 1) * rows;
			List<GoodsInRecord> result = GoodsInDAO.getInstance().list(index, rows);
			List<GoodsInRecordVO> objs = new ArrayList<GoodsInRecordVO>();
			for(GoodsInRecord record : result){
				List<GoodsComeRecord> comes = GoodsComeDAO.getInstance().list(record.getId());
				record.setComes(comes);
				GoodsInRecordVO vo = new GoodsInRecordVO(record);
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
			GoodsInRecord record = null;
			if(recordId == null || recordId.length() == 0){
				record = new GoodsInRecord();
				record.setGoodsId(Integer.parseInt(goodsId));
				record.setTime(System.currentTimeMillis());
				record.setStatus(0);
			}else{
				record = GoodsInDAO.getInstance().load(Integer.parseInt(recordId));
				long comeTotal = GoodsComeDAO.getInstance().listTotal(record.getId());
				if(count > comeTotal){
					record.setStatus(0);
				}else{
					record.setStatus(1);
				}
			}
			record.setCount(count);
			record.setRemark(remark);
			GoodsInDAO.getInstance().saveOrUpdate(record);
			if (record.getId() == 0) {
				responseSuccess("添加成功");
			} else {
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String recordIds = (String) request.getParameter("recordIds");
			for(String recordId : recordIds.split(",")){
				GoodsInRecord record = GoodsInDAO.getInstance().load(Integer.parseInt(recordId));
				GoodsInDAO.getInstance().delete(record);
				//删除收货记录
				List<GoodsComeRecord> comes = GoodsComeDAO.getInstance().list(record.getId());
				int comeTotal = 0;
				if(comes != null){
					for(GoodsComeRecord come : comes){
						comeTotal += come.getCount();
						GoodsComeDAO.getInstance().delete(come);
					}
				}
				//修正库存，由删除收货记录导致
				Goods goods = GoodsDAO.getInstance().load(record.getGoodsId());
				int stock = goods.getStock();
				stock = stock - comeTotal;
				goods.setStock(stock);
				GoodsDAO.getInstance().saveOrUpdate(goods);
			}
			responseSuccess("删除成功");
		} else if ("come".equals(sign)) {// 收货
			String recordId = (String) request.getParameter("recordId");
			int count  = Integer.parseInt(request.getParameter("count"));
			String orderNum = (String) request.getParameter("orderNum");
			
			GoodsInRecord record = GoodsInDAO.getInstance().load(Integer.parseInt(recordId));
			GoodsComeRecord comeRecord = new GoodsComeRecord();
			comeRecord.setCount(count);
			comeRecord.setInRecordId(Integer.parseInt(recordId));
			comeRecord.setOrderNum(orderNum);
			comeRecord.setTime(System.currentTimeMillis());
			GoodsComeDAO.getInstance().saveOrUpdate(comeRecord);
			
			//修正进货记录的状态
			long comeTotal = GoodsComeDAO.getInstance().listTotal(record.getId());
			if(comeTotal >= record.getCount()){
				//收货完成
				record.setStatus(1);
				GoodsInDAO.getInstance().saveOrUpdate(record);
			}
			
			//修正库存，由增加收货记录导致
			Goods goods = GoodsDAO.getInstance().load(record.getGoodsId());
			int stock = goods.getStock();
			stock = stock + count;
			goods.setStock(stock);
			GoodsDAO.getInstance().saveOrUpdate(goods);
			
			responseSuccess("收货成功");
		} else if ("listComes".equals(sign)) {// 收货
			String recordId = (String) request.getParameter("recordId");
			List<GoodsComeRecord> result = GoodsComeDAO.getInstance().list(Integer.parseInt(recordId));
			List<GoodsComeRecordVO> objs = new ArrayList<GoodsComeRecordVO>();
			for(GoodsComeRecord record : result){
				GoodsComeRecordVO vo = new GoodsComeRecordVO(record);
				objs.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", objs.size());
			obj.put("rows", JSON.toJSON(objs));
			responseSuccess(JSON.toJSON(obj));
		} else if ("deleteComes".equals(sign)) {// 删除收货记录
			String recordIds = (String) request.getParameter("recordIds");
			int total = 0;
			int goodsId = 0;
			for(String recordId : recordIds.split(",")){
				GoodsComeRecord comeRecord = GoodsComeDAO.getInstance().load(Integer.parseInt(recordId));
				GoodsComeDAO.getInstance().delete(comeRecord);
				total += comeRecord.getCount();
				GoodsInRecord record = GoodsInDAO.getInstance().load(comeRecord.getInRecordId());
				//修正进货记录的状态
				long comeTotal = GoodsComeDAO.getInstance().listTotal(record.getId());
				if(comeTotal >= record.getCount()){
					//收货完成
					record.setStatus(1);
					GoodsInDAO.getInstance().saveOrUpdate(record);
				}else{
					//收货中
					record.setStatus(0);
					GoodsInDAO.getInstance().saveOrUpdate(record);
				}
				goodsId = record.getGoodsId();
			}
			//修正库存，由删除收货记录导致
			Goods goods = GoodsDAO.getInstance().load(goodsId);
			int stock = goods.getStock();
			stock = stock - total;
			goods.setStock(stock);
			GoodsDAO.getInstance().saveOrUpdate(goods);
			responseSuccess("删除成功");
		}
	}

}
