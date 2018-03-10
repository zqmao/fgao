package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Goods;
import base.api.Shop;
import base.api.User;
import base.dao.ShopDAO;
import base.dao.UserDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class ShopServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public ShopServlet() {
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
			
			int index = (page - 1) * rows;
			
			long total = ShopDAO.getInstance().queryCount();
			List<Shop> result = ShopDAO.getInstance().list(index, rows);
		
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", result);
			
			returnJson(obj);
		
		} else if ("add".equals(sign)) {// 增加
			String shopName = (String) request.getParameter("shopName");
			String id = (String) request.getParameter("id");
			String remark = (String) request.getParameter("remark");
			

			Shop shop = null;
			if(id == null || id.length() == 0){
				shop = new Shop();
			}else{
				shop = ShopDAO.getInstance().load(Integer.parseInt(id));
			}
			
			shop.setShopName(shopName);
			shop.setRemark(remark);
			
			System.out.println(JSON.toJSON(shop).toString());
	
			if (shop.getId() == 0) {
				ShopDAO.getInstance().saveOrUpdate(shop);
				responseSuccess("添加成功");
			} else {
				ShopDAO.getInstance().saveOrUpdate(shop);
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String id = (String) request.getParameter("id");
			
			Shop shop = ShopDAO.getInstance().load(Integer.parseInt(id));
			
			ShopDAO.getInstance().delete(shop);
			
			responseSuccess("删除成功");
		} else if("select".equals(sign)){
			
			List<Shop> result = ShopDAO.getInstance().queryForAll();
			
			JSONArray array = new JSONArray();
			for(Shop shop : result){
				JSONObject obj = new JSONObject();
				obj.put("id", shop.getId());
				obj.put("text", shop.getShopName());
				array.add(obj);
			}
			returnJson(JSON.toJSON(array));
		}
	}

}
