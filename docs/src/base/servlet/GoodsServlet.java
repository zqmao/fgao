package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Goods;
import base.api.vo.GoodsVO;
import base.dao.GoodsDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class GoodsServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public GoodsServlet() {
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
			long total = GoodsDAO.getInstance().listCount();
			int index = (page - 1) * rows;
			List<Goods> result = GoodsDAO.getInstance().list(index, rows);
			List<GoodsVO> objs = new ArrayList<GoodsVO>();
			for(Goods goods : result){
				GoodsVO vo = new GoodsVO(goods);
				objs.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(objs));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {// 增加
			String name = (String) request.getParameter("name");
			String goodsId = (String) request.getParameter("goodsId");
			Goods goods = null;
			if(goodsId == null || goodsId.length() == 0){
				goods = new Goods();
				goods.setStock(0);
			}else{
				goods = GoodsDAO.getInstance().load(Integer.parseInt(goodsId));
			}
			goods.setName(name);
			if (goods.getId() == 0) {
				GoodsDAO.getInstance().saveOrUpdate(goods);
				responseSuccess("添加成功");
			} else {
				GoodsDAO.getInstance().saveOrUpdate(goods);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String goodsIds = (String) request.getParameter("goodsIds");
			for(String goodsId : goodsIds.split(",")){
				GoodsDAO.getInstance().delete(Integer.parseInt(goodsId));
				//后面可能需要删除所有和货物有关的
			}
			responseSuccess("删除成功");
		} else if ("select".equals(sign)) {// 查询列表
			List<Goods> result = GoodsDAO.getInstance().list();
			JSONArray array = new JSONArray();
			for(Goods goods : result){
				JSONObject obj = new JSONObject();
				obj.put("id", goods.getId());
				obj.put("text", goods.getName());
				array.add(obj);
			}
			responseSuccess(JSON.toJSON(array));
		}
	}

}
