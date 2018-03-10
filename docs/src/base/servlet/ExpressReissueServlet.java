package base.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import base.api.Express;
import base.api.ExpressReissue;
import base.api.User;
import base.api.vo.ExpressReissueVO;

import base.dao.ExpressDAO;
import base.dao.ExpressReissueDAO;
import base.dao.UserDAO;
import base.dao.core.BaseDAO;

/**
 * @author lcc 售后补发记录
 */
public class ExpressReissueServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	public ExpressReissueServlet() {
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
			String courierNum = (String) request.getParameter("courierNum");
			String expressName = (String) request.getParameter("expressName2");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String phoneNum = (String) request.getParameter("phoneNum");
			String statuss = request.getParameter("status");
			String creator = (String) request.getParameter("creator");
			String wangwang = (String) request.getParameter("wangwang");
			String afterSaTor = (String) request.getParameter("afterSaTor");
			User user = new User();
			int creatorId = 0;
			if(creator!=null && creator.length()>0){
				//creatorId = (Integer) (UserDAO.getInstance().query(creator)!=null? UserDAO.getInstance().query(creator).getId():-1);
				user = UserDAO.getInstance().query(creator);
				//System.out.println(user);
				if(user!=null){
					creatorId = user.getId();
				}
			}
			if ("已处理".equals(statuss)) {
				status = 1;
			} else {
				status = 0;
			}
			if ("全部".equals(expressName)) {
				expressName = "";
			}
			if ("全部".equals(shopName)) {
				shopName = "";
			}
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			List<ExpressReissue> result = new ArrayList<ExpressReissue>();
			
			BaseDAO<ExpressReissue>.QueryBuilder builder = ExpressReissueDAO.getInstance().new QueryBuilder();
			if ((courierNum != null && courierNum.length() != 0)) {
				builder.eq("courierNum", courierNum);
			}
			if (expressName != null && expressName.length() != 0) {
				builder.eq("expressName", expressName);
			}
			if (shopName != null && shopName.length() != 0) {
				builder.eq("shopName", shopName);
			}
			if (goodsName != null && goodsName.length() != 0) {
				builder.eq("goodsName", goodsName);
			}
			if (orderNum != null && orderNum.length() != 0) {
				builder.eq("orderNum", orderNum);
			}
			if (phoneNum != null && phoneNum.length() != 0) {
				builder.eq("phoneNum", phoneNum);
			}
			if (creator !=null && creator.length() != 0) {
				builder.eq("creatorId", creatorId);
			}
			if(wangwang !=null && wangwang.length() != 0){
				builder.eq("wangwang", wangwang);
			}
			if(status ==1||status==0){
				builder.eq("status", status);
			}
			if(afterSaTor !=null && afterSaTor.length() != 0){
				builder.eq("afterSaTor", afterSaTor);
			}
			builder.orderBy("id", true);
			builder.limit(index, rows);
			total = builder.queryCount();
			result = builder.queryList();

			List<ExpressReissueVO> vos = new ArrayList<ExpressReissueVO>();
			for (ExpressReissue reissue : result) {
				ExpressReissueVO vo = new ExpressReissueVO(reissue);
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
			String address = (String) request.getParameter("address");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String wangwang = (String) request.getParameter("wangwang");
			String afterSaTor = (String) request.getParameter("afterSaTor");
			String remark = (String) request.getParameter("remark");
			String id = (String) request.getParameter("erlistId");
			Pattern p = Pattern.compile("^[0-9]{16,21}$");
			Matcher m = p.matcher(orderNum);
			/*if (m.find()){
				String id = (String) request.getParameter("erlistId");
				ExpressReissue express = (ExpressReissue) ExpressReissueDAO.getInstance().list(orderNum);
				if(express!=null){
					responseError("不能输入重复订单号");
				}else{*/
					ExpressReissue expressReissue = null;
					if (id == null || id.length() == 0) {
						
						if (m.find()){
							
							ExpressReissue express = (ExpressReissue) ExpressReissueDAO.getInstance().list(orderNum);
							if(express!=null){
								responseError("不能输入重复订单号");
							}else{
								expressReissue = new ExpressReissue();
								expressReissue.setCreatorId(currentUser.getId());
								expressReissue.setEntryTime(System.currentTimeMillis());
								expressReissue.setShopName(shopName);
								expressReissue.setAddress(address);
								expressReissue.setGoodsName(goodsName);
								expressReissue.setOrderNum(orderNum);
								expressReissue.setWangwang(wangwang);
								expressReissue.setAfterSaTor(afterSaTor);
								expressReissue.setRemark(remark);
								}
						}else{
							responseError("订单号格式不正确");
						}
					} else {// 修改
						
							if (m.find()){
								expressReissue = ExpressReissueDAO.getInstance().load(Integer.parseInt(id));
								expressReissue.setShopName(shopName);
								expressReissue.setAddress(address);
								expressReissue.setGoodsName(goodsName);
								expressReissue.setOrderNum(orderNum);
								expressReissue.setWangwang(wangwang);
								expressReissue.setAfterSaTor(afterSaTor);
								expressReissue.setRemark(remark);
						}else{
							responseError("订单号格式不正确");
						}
						
					}
					ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
					if (id == null || id.length() == 0) {
						responseSuccess("新建售后记录成功");
					} else {
						responseSuccess("修改售后记录成功");
					}
			//	}
				
				
			/*}else{
				responseError("输入的订单号不合法");
			}*/
			
		} else if ("reissueAdd".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			String status = (String) request.getParameter("status");
			String courierNum = (String) request.getParameter("courierNum");
			String expressName = (String) request.getParameter("expressName");
			if("请选择:".equals(expressName)){
				expressName = "";
			}
			String issuRemark = (String) request.getParameter("issuRemark");
			String id = (String) request.getParameter("updateId");

			if (id == null && id.length() == 0) {
				responseError("请选择记录");
			} else {
				ExpressReissue expressReissue = ExpressReissueDAO.getInstance().load(Integer.parseInt(id));
				// expressReissue.setStatus(Integer.parseInt(status));
				expressReissue.setCourierNum(courierNum);
				expressReissue.setExpressName(expressName);
				expressReissue.setIssuRemark(issuRemark);
				expressReissue.setIssueDocumentor(currentUser.getId());
				expressReissue.setIssuTime(System.currentTimeMillis());
				if ("已处理".equals(status)) {
					expressReissue.setStatus(1);
				} else {
					expressReissue.setStatus(0);
				}

				ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
				responseSuccess("修改售后记录成功");
			}
		} else if ("select".equals(sign)) {
			List<Express> expressResult = new ArrayList<Express>();
			expressResult = ExpressDAO.getInstance().queryForAll();
			JSONArray array = new JSONArray();
			for (Express express : expressResult) {
				JSONObject obj = new JSONObject();
				obj.put("id", express.getId());
				obj.put("text", express.getExpressName());
				array.add(obj);
			}
			//responseSuccess(JSON.toJSON(array));
			returnJson(array);
				
		} else if ("search".equals(sign)) {
			responseSuccess("查询成功");
		}else if("export".equals(sign)){//导出
			List<String> dataList=new ArrayList<String>();
			String ascrIds = (String) request.getParameter("erlistIds");
			System.out.println(ascrIds);		
			for (String ascrId : ascrIds.split(",")) {
				ExpressReissue result =	ExpressReissueDAO.getInstance().export(Integer.parseInt(ascrId));//(Integer.parseInt(ascrId));
				//StringBuffer buff = new StringBuffer();
				String wangwang = result.getWangwang();
				String address = result.getAddress();
				String goodsName = result.getGoodsName();
				//buff.append(wangwang).append(",").append(address).append(",").append(goodsName).toString();
				dataList.add(""+wangwang+","+address+","+goodsName+"");
				//System.out.println(ascrId);		
			}
			String path = "D:/test";
			path = path+"\\"+System.currentTimeMillis()+".csv";
			boolean isSuccess=ExportText.exportCsv(new File(path), dataList);
			System.out.println(isSuccess);
			responseSuccess2("导出记录成功");
		}else if("keep".equals(sign)){
			String shopNameK = (String) request.getParameter("shopNameK");
			String wangwangK = (String) request.getParameter("wangwangK");
			String idK = (String) request.getParameter("idK");
			String orderNumK = (String) request.getParameter("orderNumK");
			String goodsNameK = (String) request.getParameter("goodsNameK");
			String addressK = (String) request.getParameter("addressK");
			String remarkK = (String) request.getParameter("remarkK");
			Pattern p = Pattern.compile("^[0-9]{16,17}$");
			Matcher m = p.matcher(orderNumK);
			if(!m.find()){
				responseError("订单号格式不正确");
				return;
			}
			/*long num = ExpressReissueDAO.getInstance().checkNum(orderNumK);
			System.out.println("num++"+num);
			if(num>1){
				responseError("不能输入重复订单号");
				return;
			}*/
			ExpressReissue expressReissue = ExpressReissueDAO.getInstance().load(Integer.parseInt(idK));
			expressReissue.setShopName(shopNameK);
			expressReissue.setWangwang(wangwangK);
			expressReissue.setOrderNum(orderNumK);
			expressReissue.setGoodsName(goodsNameK);
			expressReissue.setAddress(addressK);
			expressReissue.setRemark(remarkK);
			ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
			responseSuccess2("修改记录成功");
		}

	}
}
