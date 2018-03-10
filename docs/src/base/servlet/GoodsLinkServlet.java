package base.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.GoodsLink;
import base.api.vo.GoodsLinkVO;
import base.dao.GoodsLinkDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class GoodsLinkServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public GoodsLinkServlet() {
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
			
			long total = 0;
			int index = (page - 1) * rows;
			
			Map<String, String[]> paramMap = request.getParameterMap();
			String sqlStr;
			try {
				sqlStr = returnSqlstr(paramMap);
				
				List<GoodsLink> result;
				total = GoodsLinkDAO.getInstance().queryCount(sqlStr);
				result = GoodsLinkDAO.getInstance().list(index, rows,sqlStr);
				
				List<GoodsLinkVO> objs = new ArrayList<GoodsLinkVO>();
				for(GoodsLink record : result){
					GoodsLinkVO vo = new GoodsLinkVO(record);
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
			
			
			GoodsLink goodslink = null;
			if(id == null || id.length() == 0){
				goodslink = new GoodsLink();
			}else{
				goodslink = GoodsLinkDAO.getInstance().load(Integer.parseInt(id));
			}
			goodslink.setShopId(Integer.parseInt(shopId));
			goodslink.setTitle(title);
			goodslink.setTid(tid);
			goodslink.setImgLink(imgLink);
	
			if (goodslink.getId() == 0) {
				GoodsLinkDAO.getInstance().saveOrUpdate(goodslink);
				responseSuccess("添加成功");
			} else {
				GoodsLinkDAO.getInstance().saveOrUpdate(goodslink);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String goodsIds = (String) request.getParameter("id");
			for(String goodsId : goodsIds.split(",")){
				GoodsLinkDAO.getInstance().delete(Integer.parseInt(goodsId));
				//后面可能需要删除所有和货物有关的
			}
			responseSuccess("删除成功");
		} else if ("select".equals(sign)) {// 查询列表
			List<GoodsLink> result = GoodsLinkDAO.getInstance().queryForAll();
			JSONArray array = new JSONArray();
			for(GoodsLink goods : result){
				JSONObject obj = new JSONObject();
				obj.put("id", goods.getId());
				obj.put("text", goods.getTitle());
				array.add(obj);
			}
			responseSuccess(JSON.toJSON(array));
		}
	}

}
