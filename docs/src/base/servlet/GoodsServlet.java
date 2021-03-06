package base.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.FreshOrder;
import base.api.Goods;
import base.api.vo.FreshOrderVO;
import base.api.vo.GoodsVO;
import base.dao.FreshOrderDAO;
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
			String bm = request.getParameter("bm");
			String name = request.getParameter("name");
			String specName = request.getParameter("specName");
			
			
			long total = 0;
			int index = (page - 1) * rows;
			
			Map<String, String[]> paramMap = request.getParameterMap();
			String sqlStr;
			try {
				sqlStr = returnSqlstr(paramMap);
				
	
				List<Goods> result;
				total = GoodsDAO.getInstance().queryCount(sqlStr);
				result = GoodsDAO.getInstance().list(index, rows,sqlStr);
				
				List<GoodsVO> objs = new ArrayList<GoodsVO>();
				for(Goods record : result){
					GoodsVO vo = new GoodsVO(record);
					objs.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", total);
				obj.put("rows", objs);
				
				returnJson(obj);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
				
		} else if ("add".equals(sign)) {// 增加
			String id = (String) request.getParameter("id");
			String shopId = (String) request.getParameter("shopId");
			String title = (String) request.getParameter("title");
			String tid = (String) request.getParameter("tid");
			String imgLink = (String) request.getParameter("imgLink");
			
			
			Goods goods = null;
			if(id == null || id.length() == 0){
				goods = new Goods();
				goods.setStock(0);
			}else{
				goods = GoodsDAO.getInstance().load(Integer.parseInt(id));
			}
			goods.setShopId(Integer.parseInt(shopId));
			goods.setTitle(title);
			goods.setTid(tid);
			goods.setImgLink(imgLink);
	
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
			List<Goods> result = GoodsDAO.getInstance().queryForAll();
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
