package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import base.api.DrawBill;
import base.api.User;
import base.api.vo.DrawBillVO;
import base.dao.DrawBillDAO;
import base.dao.UserDAO;
import base.dao.core.BaseDAO;

/**开票处理
 * @author lcc 
 */
public class DrawBillServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	public DrawBillServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	@SuppressWarnings("null")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(request, response);
		if ("list".equals(sign)) {
			int status= 0 ;
			String billHead = (String) request.getParameter("billHead");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String emailOrPhone = (String) request.getParameter("emailOrPhone");
			String statuss = request.getParameter("status");
			String creatorId = (String) request.getParameter("creatorId");
			String Drawingor = (String) request.getParameter("Drawingor");
			String tfn = (String) request.getParameter("tfn");
			User user = new User();
			int creatorIds = 0;
			int DrawingorId = 0;
			if(creatorId!=null && creatorId.length()>0){
				user = UserDAO.getInstance().query(creatorId);
				if(user!=null){
					creatorIds = user.getId();
				}
			}
			if(Drawingor!=null && Drawingor.length()>0){
				user = UserDAO.getInstance().query(Drawingor);
				if(user!=null){
					DrawingorId = user.getId();
				}
			}
			if ("已处理".equals(statuss)) {
				status = 1;
			} else {
				status = 0;
			}
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			List<DrawBill> result = new ArrayList<DrawBill>();
			
			BaseDAO<DrawBill>.QueryBuilder builder = DrawBillDAO.getInstance().new QueryBuilder();
			
			if (shopName != null && shopName.length() != 0) {
				builder.eq("shopName", shopName);
			}
			if (goodsName != null && goodsName.length() != 0) {
				builder.eq("goodsName", goodsName);
			}
			if (orderNum != null && orderNum.length() != 0) {
				builder.eq("orderNum", orderNum);
			}
			if (emailOrPhone != null && emailOrPhone.length() != 0) {
				builder.eq("emailOrPhone", emailOrPhone);
			}
			if (creatorId !=null && creatorId.length() != 0) {
				builder.eq("creatorId", creatorIds);
			}
			if (Drawingor !=null && Drawingor.length() != 0) {
				builder.eq("Drawingor", DrawingorId);
			}
			if(billHead !=null && billHead.length() != 0){
				builder.eq("billHead", billHead);
			}
			if(status ==1||status==0){
				builder.eq("status", status);
			}
			if(tfn !=null && tfn.length() != 0){
				builder.eq("tfn", tfn);
			}
			builder.orderBy("id", true);
			builder.limit(index, rows);
			total = builder.queryCount();
			result = builder.queryList();
			List<DrawBillVO> vos = new ArrayList<DrawBillVO>();
			for (DrawBill bill : result) {
				DrawBillVO vo = new DrawBillVO(bill);
				vos.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", JSON.toJSON(total));
			obj.put("rows", JSON.toJSON(vos));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			String shopName = (String) request.getParameter("shopName");
			String billHead = (String) request.getParameter("billHead");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String sum = (String) request.getParameter("sum");
			String money = (String) request.getParameter("money");
			String emailOrPhone = (String) request.getParameter("emailOrPhone");
			String remark = (String) request.getParameter("remark");
			String tfn = (String) request.getParameter("tfn");
			String id = (String) request.getParameter("drawBillId");
			Pattern p = Pattern.compile("^[0-9]{16,21}$");
			Matcher m = p.matcher(orderNum);
					DrawBill drawBill = null;
					if (id == null || id.length() == 0) {
						
						if (m.find()){
							DrawBill bill = (DrawBill) DrawBillDAO.getInstance().list(orderNum);
							if(bill!=null){
								responseError("不能输入重复订单号");
								return;
							}else{
								drawBill = new DrawBill();
								drawBill.setCreatorId(currentUser.getId());
								drawBill.setEntryTime(System.currentTimeMillis());
								drawBill.setShopName(shopName);
								drawBill.setBillHead(billHead);
								drawBill.setGoodsName(goodsName);
								drawBill.setOrderNum(orderNum);
								drawBill.setMoney(money);
								drawBill.setSum(sum);
								drawBill.setTfn(tfn);
								drawBill.setEmailOrPhone(emailOrPhone);
								drawBill.setRemark(remark);
								}
						}else{
							responseError("订单号格式不正确");
						}
					} else {// 修改
							if (m.find()){
								drawBill = DrawBillDAO.getInstance().load(Integer.parseInt(id));
								drawBill.setShopName(shopName);
								drawBill.setBillHead(billHead);
								drawBill.setGoodsName(goodsName);
								drawBill.setOrderNum(orderNum);
								drawBill.setEmailOrPhone(emailOrPhone);
								drawBill.setSum(sum);
								drawBill.setTfn(tfn);
								drawBill.setMoney(money);
								drawBill.setRemark(remark);
						}else{
							responseError("订单号格式不正确");
						}
					}
					DrawBillDAO.getInstance().saveOrUpdate(drawBill);
					if (id == null || id.length() == 0) {
						responseSuccess("新建售后记录成功");
					} else {
						responseSuccess("修改售后记录成功");
					}
		} else if ("reissueAdd".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			String status = (String) request.getParameter("status");
			String billRemark = (String) request.getParameter("billRemark");
			String id = (String) request.getParameter("updateId");

			if (id == null && id.length() == 0) {
				responseError("请选择记录");
			} else {
				DrawBill drawBill = DrawBillDAO.getInstance().load(Integer.parseInt(id));
				// expressReissue.setStatus(Integer.parseInt(status));
				drawBill.setBillRemark(billRemark);
				
				drawBill.setDrawingor(currentUser.getId());
				drawBill.setBillTime(System.currentTimeMillis());
				if ("已处理".equals(status)) {
					drawBill.setStatus(1);
				} else {
					drawBill.setStatus(0);
				}

				DrawBillDAO.getInstance().saveOrUpdate(drawBill);
				responseSuccess("修改售后记录成功");
			}
		} else if ("search".equals(sign)) {
			responseSuccess("查询成功");
		}

	}
}
