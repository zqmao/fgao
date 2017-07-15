package base.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Coupon;
import base.dao.CouponDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class CouponServlet extends BaseServlet{
	
	private static final long serialVersionUID = 1L;

	public CouponServlet() {
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
			List<Coupon> result = CouponDAO.getInstance().list();
			JSONObject obj = new JSONObject();
			obj.put("total", CouponDAO.getInstance().listCount());
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {// 查询评论货物列表
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			if(currentUser.getCoupon() != 1){
				responseError("没有权限添加优惠券");
				return;
			}
			String couponId = request.getParameter("couponId");
			String shopName = request.getParameter("shopName");
			String category = request.getParameter("category");
			String goodsName = request.getParameter("goodsName");
			String content = request.getParameter("content");
			String deadLine = request.getParameter("deadLine");
			String remark = request.getParameter("remark");
			String link = request.getParameter("link");
			
			Coupon coupon = null;
			if(couponId == null || couponId.length() == 0){
				coupon = new Coupon();
			}else{
				coupon = CouponDAO.getInstance().load(Integer.parseInt(couponId));
			}
			coupon.setUserId(currentUser.getId());
			coupon.setCreator(currentUser.getName());
			coupon.setTime(System.currentTimeMillis());
			coupon.setShopName(shopName);
			coupon.setCategory(category);
			coupon.setGoodsName(goodsName);
			coupon.setContent(content);
			coupon.setDeadLine(deadLine);
			coupon.setRemark(remark);
			coupon.setLink(link);
			CouponDAO.getInstance().saveOrUpdate(coupon);
			if(couponId == null || couponId.length() == 0){
				responseSuccess("增加成功");
			}else{
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			if(currentUser.getCoupon() != 1){
				responseError("没有权限删除优惠券");
				return;
			}
			String couponIds = (String) request.getParameter("couponIds");
			for(String couponId : couponIds.split(",")){
				CouponDAO.getInstance().delete(Integer.parseInt(couponId));
			}
			responseSuccess("删除成功");
		}
	}
}
