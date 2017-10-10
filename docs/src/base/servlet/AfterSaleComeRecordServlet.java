package base.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import base.api.AfterSaleComeRecord;
import base.api.ExportOrderList;
import base.api.ExpressReissue;
import base.api.User;
import base.api.vo.AfterSaleComeRecordVO;
import base.api.vo.ExportOrderListVO;
import base.dao.AfterSaleComeRecordDAO;
import base.dao.ExportOrderListDAO;
import base.dao.ExpressReissueDAO;
import base.dao.UserDAO;
import base.dao.core.BaseDAO;

public class AfterSaleComeRecordServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public AfterSaleComeRecordServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@SuppressWarnings("null")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {// 查询列表
			String allSearch = (String) request.getParameter("allSearch");
			String wangwang = (String) request.getParameter("wangwang");
			String bounceType = (String) request.getParameter("bounceType");
			String courierNum = (String) request.getParameter("courierNum");
			String expressName = (String) request.getParameter("expressName2");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String phoneNum = (String) request.getParameter("phoneNum");
			String creator = (String) request.getParameter("creator");
			
			/*String courierNumA = (String) request.getParameter("courierNumA");
			System.out.println("courierNumA"+courierNumA);
			if(courierNumA!=null&&courierNumA.length()!=0){
			List<AfterSaleComeRecord> ascr = AfterSaleComeRecordDAO.getInstance().queryList(courierNumA);
			System.out.println("ascr"+ascr);
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			if(ascr!=null){
			
			}else{
				
				List<AfterSaleComeRecord> result = new ArrayList<AfterSaleComeRecord>();
				total = AfterSaleComeRecordDAO.getInstance().count(allSearch);
				result = AfterSaleComeRecordDAO.getInstance().list(allSearch,index,rows);
				
				List<AfterSaleComeRecordVO> vos = new ArrayList<AfterSaleComeRecordVO>();
				for (AfterSaleComeRecord record : result) {
					AfterSaleComeRecordVO vo = new AfterSaleComeRecordVO(record);
					vos.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", total);
				obj.put("rows", JSON.toJSON(vos));
	
				responseSuccess(JSON.toJSON(obj));
			}
			
			}else{
			*/
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
					List<AfterSaleComeRecord> result = new ArrayList<AfterSaleComeRecord>();
					if (allSearch == null || allSearch.length() == 0) {
						User user = new User();
						int creatorId = 0;
						if(creator!=null && creator.length()>0){
							//creatorId = (Integer) (UserDAO.getInstance().query(creator)!=null? UserDAO.getInstance().query(creator).getId():-1);
							user = UserDAO.getInstance().query(creator);
							System.out.println(user);
							if(user!=null){
								creatorId = user.getId();
							}
						}
						
						BaseDAO<AfterSaleComeRecord>.QueryBuilder builder = AfterSaleComeRecordDAO
								.getInstance().new QueryBuilder();
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
						if (wangwang != null && wangwang.length() != 0){
							builder.eq("wangwang", wangwang);
						}
						if (bounceType != null && bounceType.length() != 0){
							builder.eq("bounceType", bounceType);
						}
						if (creator !=null && creator.length() != 0) {
							builder.eq("creatorId", creatorId);
						}
						builder.orderBy("id", true);
						builder.limit(index, rows);
						total = builder.queryCount();
						result = builder.queryList();
					} else {
						total = AfterSaleComeRecordDAO.getInstance().count(allSearch);
						result = AfterSaleComeRecordDAO.getInstance().list(allSearch,index,rows);
					}
					List<AfterSaleComeRecordVO> vos = new ArrayList<AfterSaleComeRecordVO>();
					for (AfterSaleComeRecord record : result) {
						AfterSaleComeRecordVO vo = new AfterSaleComeRecordVO(record);
						vos.add(vo);
					}
					JSONObject obj = new JSONObject();
					obj.put("total", total);
					obj.put("rows", JSON.toJSON(vos));
		
					responseSuccess(JSON.toJSON(obj));
		//}
			} else if ("add".equals(sign)) {// 新增纪录
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			String courierNum = (String) request.getParameter("courierNum");
			AfterSaleComeRecord couesult = null;
			//System.out.println(couesult);
			if(courierNum!=null && courierNum.length()>0){
				couesult = AfterSaleComeRecordDAO.getInstance().query(courierNum);
			}
			String expressName = (String) request.getParameter("expressName");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String checkResult = (String) request.getParameter("checkResult");
			String wangwang = (String) request.getParameter("wangwang");
			String phoneNum = (String) request.getParameter("phoneNum");
			String orderNum = (String) request.getParameter("orderNum");
			/*AfterSaleComeRecord ordersult = null;
			if(orderNum!=null && orderNum.length()>0){
				ordersult = AfterSaleComeRecordDAO.getInstance().orderNO(orderNum);
			}*/
			
			String remark = (String) request.getParameter("remark");
			//String status = (String) request.getParameter("status");
			
			String bounceType = (String) request.getParameter("bounceType");
			String reissueCourierNum = (String) request.getParameter("reissueCourierNum");
			String reissueExpressName = (String) request.getParameter("reissueExpressName");
			String reissueGoodsName = (String) request.getParameter("reissueGoodsName");
			String reissueAddress = (String) request.getParameter("reissueAddress");
			
			if("请选择:".equals(expressName)){
				expressName = "";
			}
			if("请选择:".equals(reissueExpressName)){
				reissueExpressName="";
			}
			String changeStatus = (String) request.getParameter("changeStatus");
			//System.out.println(changeStatus);
			AfterSaleComeRecord afterSaleComeRecord = new AfterSaleComeRecord();
			
			String id = (String) request.getParameter("ascrId");
			/*if (id == null || id.length() == 0) {
				if (couesult != null) {
					responseError("该快递单号已存在");
					return;
					id = "" + couesult.getId();
					long time = couesult.getCreateTime();
					long eTime = couesult.getEntryTime();
					afterSaleComeRecord.setUnpackId(currentUser.getId());
					if ((System.currentTimeMillis() >= (time + 1000 * 60 * 60 * 24 * 21))
							&& (System.currentTimeMillis() >= (eTime + 1000 * 60 * 60 * 24 * 21))) {
						responseError("此账单创建时间过久，不许修改");
						return;
					}
				}
				if(ordersult!=null){
					responseError("该订单号已存在");
					return;
				}
			}
			*/
			// 如果没有id是新建
			if (id == null || id.length() == 0) {
				if (couesult != null) {
					responseError("该快递单号已存在");
					return;
				}
			
				afterSaleComeRecord = new AfterSaleComeRecord();
				afterSaleComeRecord.setCourierNum(courierNum);
				afterSaleComeRecord.setCreatorId(currentUser.getId());//创建人
				afterSaleComeRecord.setUnpackId(currentUser.getId());//拆包人
				afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
			} else {
				afterSaleComeRecord = AfterSaleComeRecordDAO.getInstance().load(Integer.parseInt(id));
				afterSaleComeRecord.setCourierNum(afterSaleComeRecord.getCourierNum());
				afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
				afterSaleComeRecord.setUnpackId(currentUser.getId());
			}
			afterSaleComeRecord.setBounceType(bounceType);
			if("换货".equals(bounceType)){
				ExpressReissue expressReissue = new ExpressReissue();
				
				if("自己发货".equals(changeStatus)){
					expressReissue.setShopName(shopName);
					expressReissue.setOrderNum(orderNum);
					expressReissue.setWangwang(wangwang);
					expressReissue.setExpressName(reissueExpressName);
					expressReissue.setCourierNum(reissueCourierNum);
					expressReissue.setGoodsName(reissueGoodsName);
					expressReissue.setRemark(remark);
					expressReissue.setStatus(1);
					/*System.out.println(status);
					if ("已处理".equals(status)) {
						expressReissue.setStatus(1);
					} else {
						expressReissue.setStatus(0);
					}*/
					expressReissue.setCreatorId(currentUser.getId());
					expressReissue.setIssueDocumentor(currentUser.getId());
					expressReissue.setEntryTime(System.currentTimeMillis());
					expressReissue.setIssuTime(System.currentTimeMillis());
					ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
				}else if("他人发货".equals(changeStatus)){
					/*//如果补发快递已经生成了数据，就不能再次添加他人发货了。
					ExpressReissue orderExpress =  ExpressReissueDAO.getInstance().list(orderNum);
					if(orderExpress!=null){
						responseError("该订单号已经在补发快递中生成过记录,请不要再次添加他人发货的记录");
						return;
					}*/
					
					reissueGoodsName = (String) request.getParameter("reissueGood");
					expressReissue.setShopName(shopName);
					expressReissue.setOrderNum(orderNum);
					expressReissue.setWangwang(wangwang);
					expressReissue.setRemark(remark);
					/*if ("已处理".equals(status)) {
						expressReissue.setStatus(1);
					} else {
						expressReissue.setStatus(0);
					}*/
					expressReissue.setCreatorId(currentUser.getId());
					expressReissue.setGoodsName(reissueGoodsName);
					expressReissue.setAddress(reissueAddress);
					expressReissue.setEntryTime(System.currentTimeMillis());
					ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
				}else if("不处理".equals(changeStatus)){
					
					
				}
				
				
				/*afterSaleComeRecord.setReissueCourierNum(reissueCourierNum);
				afterSaleComeRecord.setReissueExpressName(reissueExpressName);
				afterSaleComeRecord.setReissueGoodsName(reissueGoodsName);*/
			}
			//afterSaleComeRecord.setCourierNum(courierNum);
			afterSaleComeRecord.setExpressName(expressName);
			afterSaleComeRecord.setShopName(shopName);
			afterSaleComeRecord.setGoodsName(goodsName);
			afterSaleComeRecord.setCheckResult(checkResult);
			afterSaleComeRecord.setWangwang(wangwang);
			afterSaleComeRecord.setPhoneNum(phoneNum);
			afterSaleComeRecord.setOrderNum(orderNum);
			afterSaleComeRecord.setRemark(remark);
			/*if ("已处理".equals(status)) {
				afterSaleComeRecord.setStatus(1);
			} else {
				afterSaleComeRecord.setStatus(0);
			}*/
			AfterSaleComeRecordDAO.getInstance().saveOrUpdate(afterSaleComeRecord);
			if (id == null || id.length() == 0) {
				responseSuccess("新建售后记录成功");
			} else {
				responseSuccess("修改售后记录成功");
			}
			

		} else if ("delete".equals(sign)) {// 删除
			String ascrIds = (String) request.getParameter("ascrIds");
			for (String ascrId : ascrIds.split(",")) {
				AfterSaleComeRecordDAO.getInstance().delete(Integer.parseInt(ascrId));
			}
			responseSuccess("删除成功");
		} else if ("search".equals(sign)) {// 搜索

			responseSuccess("查询成功");
		} else if ("addCourierNum".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			AfterSaleComeRecord afterSaleComeRecord = null;
			String courierNums = (String) request.getParameter("courierNums");
			String expressName = (String) request.getParameter("expressName3");
			if ("请选择:".equals(expressName)) {
				expressName = "";
			}
			String[] cns = courierNums.split("\r\n");
			for (int i = 0; i < cns.length; i++) {
				Pattern p = Pattern.compile("^[0-9a-zA-Z]{9,}$");
				Matcher m = p.matcher(cns[i]);
				if (m.find()) {
					afterSaleComeRecord = AfterSaleComeRecordDAO.getInstance().query(cns[i]);
					if(afterSaleComeRecord==null){
						afterSaleComeRecord = new AfterSaleComeRecord();
						afterSaleComeRecord.setCreatorId(currentUser.getId());
						afterSaleComeRecord.setEntryTime(System.currentTimeMillis());
						afterSaleComeRecord.setExpressName(expressName);
						afterSaleComeRecord.setCourierNum(cns[i]);
						AfterSaleComeRecordDAO.getInstance().saveOrUpdate(afterSaleComeRecord);
					}

				} else {
					responseError("快递单号有误");
				}
			}
			responseSuccess2("新建售后记录成功");
		}else if("SearchExportList".equals(sign)){
			
			response.setContentType("text/xml;charset=utf-8");
			//response.setCharacterEncoding("GB2312");
			
			String allSearch = request.getParameter("orderNumE");
			
			allSearch = URLDecoder.decode(allSearch , "utf-8");
			long total = ExportOrderListDAO.getInstance().count(allSearch);
			
				List<ExportOrderList> result = ExportOrderListDAO.getInstance().listALL(allSearch);
				List<ExportOrderListVO> vos = new ArrayList<ExportOrderListVO>();
				for (ExportOrderList reissue : result) {
					ExportOrderListVO vo = new ExportOrderListVO(reissue);
					vos.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", JSON.toJSON(total));
				obj.put("rows", JSON.toJSON(vos));
				//responseSuccess(JSON.toJSON(obj));
				//responseSuccess("-------------");
				response.setContentType("text/html");  
		        PrintWriter out = response.getWriter();  
		
		        out.println(JSON.toJSON(obj));  
		        out.close();  
				
			}
	}

}
