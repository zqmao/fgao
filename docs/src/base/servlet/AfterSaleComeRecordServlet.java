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
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import base.api.AfterSaleComeRecord;
import base.api.Express;
import base.api.User;
import base.api.vo.AfterSaleComeRecordVO;
import base.api.vo.ExpressVO;
import base.dao.AfterSaleComeRecordDAO;
import base.dao.ExpressDAO;
import base.dao.UserDAO;
import base.dao.core.BaseDAO;
import base.dao.core.BaseDAO.QueryBuilder;

public class AfterSaleComeRecordServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public AfterSaleComeRecordServlet() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {// 查询列表
			String courierNum = (String) request.getParameter("courierNum");
			String expressName = (String) request.getParameter("expressName2");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String phoneNum = (String) request.getParameter("phoneNum");
			if("全部".equals(expressName)){
				expressName = "";
			}
			if("全部".equals(shopName)){
				shopName = "";
			}
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			List<AfterSaleComeRecord> result =new ArrayList<AfterSaleComeRecord>();
			/*if((courierNum!=null&&courierNum.length()!=0)||(expressName!=null && expressName.length()!=0 )
					||(shopName!=null&&shopName.length()!=0)||(goodsName!=null&&goodsName.length()!=0)
					||(orderNum!=null&&orderNum.length()!=0)||(phoneNum!=null&&phoneNum.length()!=0)){
				total = AfterSaleComeRecordDAO.getInstance().searchCount(courierNum,expressName,shopName,goodsName,orderNum,phoneNum);
				result = AfterSaleComeRecordDAO.getInstance().search(courierNum,expressName,shopName,goodsName,orderNum,phoneNum,index, rows);
			}else{
				total = AfterSaleComeRecordDAO.getInstance().listCount();
				result = AfterSaleComeRecordDAO.getInstance().list(index, rows);
			}
			*/
			BaseDAO<AfterSaleComeRecord>.QueryBuilder builder = AfterSaleComeRecordDAO.getInstance().new QueryBuilder();
			if((courierNum!=null&&courierNum.length()!=0)){
				builder.eq("courierNum", courierNum);
			}
			if(expressName!=null && expressName.length()!=0){
				builder.eq("expressName", expressName);
			}
			if(shopName!=null&&shopName.length()!=0){
				builder.eq("shopName", shopName);
			}
			if(goodsName!=null&&goodsName.length()!=0){
				builder.eq("goodsName", goodsName);
			}
			if(orderNum!=null&&orderNum.length()!=0){
				builder.eq("orderNum", orderNum);
			}
			if(phoneNum!=null&&phoneNum.length()!=0){
				builder.eq("phoneNum", phoneNum);
			}
			//builder.orderBy(key, desc);
			builder.limit(index, rows);
			total = builder.queryCount();
			result = builder.queryList();
			
			List<AfterSaleComeRecordVO> vos = new ArrayList<AfterSaleComeRecordVO>();
			for(AfterSaleComeRecord record : result){
				AfterSaleComeRecordVO vo = new AfterSaleComeRecordVO(record);
				vos.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(vos));
			
			responseSuccess(JSON.toJSON(obj));
		}else if("add".equals(sign)){//新增纪录
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			 String courierNum = (String) request.getParameter("courierNum");
			 AfterSaleComeRecord couesult = AfterSaleComeRecordDAO.getInstance().query(courierNum);
			 String expressName = (String) request.getParameter("expressName");
			 String shopName = (String)request.getParameter("shopName");
			 String goodsName = (String) request.getParameter("goodsName");
			 String checkResult = (String) request.getParameter("checkResult");
			 String wangwang = (String) request.getParameter("wangwang");
			 String phoneNum = (String) request.getParameter("phoneNum");
			 String orderNum = (String) request.getParameter("orderNum");
			 String remark = (String) request.getParameter("remark");
			 String status = (String) request.getParameter("status");
			// String entryTime = (String) request.getParameter("entryTime");
			 String id = (String) request.getParameter("ascrId");
			 if(id == null || id.length() == 0){
				 if(couesult!=null){
					 id=""+couesult.getId();
					long time = couesult.getCreateTime();
					long eTime = couesult.getEntryTime();
					 if((System.currentTimeMillis()>=(time+1000*60*60*24*21))&&(System.currentTimeMillis()>=(eTime+1000*60*60*24*21))){
						 responseError("此账单创建时间过久，不许修改");
					 }
				 }
			 }
			AfterSaleComeRecord afterSaleComeRecord = null;
			//如果没有id是新建
			if(id == null || id.length() == 0){
				afterSaleComeRecord = new AfterSaleComeRecord();
				afterSaleComeRecord.setCreatorId(currentUser.getId());
				afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
			}else{
				afterSaleComeRecord = AfterSaleComeRecordDAO.getInstance().load(Integer.parseInt(id));
				long entryTime = afterSaleComeRecord.getEntryTime();
				afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
				afterSaleComeRecord.setEntryTime(entryTime);
			}
			//afterSaleComeRecord.setCreateTime(System.currentTimeMillis());
			afterSaleComeRecord.setCourierNum(courierNum);
			afterSaleComeRecord.setExpressName(expressName);
			
			afterSaleComeRecord.setShopName(shopName);
			afterSaleComeRecord.setGoodsName(goodsName);
			afterSaleComeRecord.setCheckResult(checkResult);
			afterSaleComeRecord.setWangwang(wangwang);
			afterSaleComeRecord.setPhoneNum(phoneNum);
			afterSaleComeRecord.setOrderNum(orderNum);
			afterSaleComeRecord.setRemark(remark);
			if("已处理".equals(status)){
				afterSaleComeRecord.setStatus(1);
			}else{
				afterSaleComeRecord.setStatus(0);
			}
			AfterSaleComeRecordDAO.getInstance().saveOrUpdate(afterSaleComeRecord);
			if(id == null || id.length() == 0){
				responseSuccess("新建售后记录成功");
			}else{
				responseSuccess("修改售后记录成功");
			}
		    
		} else if ("delete".equals(sign)) {// 删除
			String ascrIds = (String) request.getParameter("ascrIds");
			for(String ascrId : ascrIds.split(",")){
				AfterSaleComeRecordDAO.getInstance().delete(Integer.parseInt(ascrId));
			}
			responseSuccess("删除成功");
		}else if("search".equals(sign)){//搜索
			
			responseSuccess("查询成功");
		}else if("select".equals(sign)){//查询快递
		//查询所有快递种类
				List<Express> expressResult = new ArrayList<Express>();
				expressResult = ExpressDAO.getInstance().express();
				JSONArray array = new JSONArray();
				for(Express express : expressResult){
					JSONObject obj = new JSONObject();
					obj.put("id", express.getId());
					obj.put("text", express.getExpressName());
					array.add(obj);
				}
				responseSuccess(JSON.toJSON(array));
          }else if("addCourierNum".equals(sign)){
        	  if(currentUser == null){
  				responseError("需要登录");
  				return;
  			}
        	  AfterSaleComeRecord afterSaleComeRecord = null;
        	 String courierNums = (String) request.getParameter("courierNums");
        	 String expressName = (String) request.getParameter("expressName3");
        	 String id = (String) request.getParameter("courierNumId");
        	 if("请选择:".equals(expressName)){
        		 expressName = "";
        	 }
        	 String[] cns = courierNums.split("\r\n");
        	 for(int i = 0;i<cns.length;i++){
        		 Pattern p = Pattern.compile("^[0-9a-zA-Z]{9,}$");
        	        Matcher m = p.matcher(cns[i]);
        	        if (m.find()) {
        	        	afterSaleComeRecord = new AfterSaleComeRecord();
              			afterSaleComeRecord.setCreatorId(currentUser.getId());
              			afterSaleComeRecord.setEntryTime(System.currentTimeMillis());
                		 afterSaleComeRecord.setExpressName(expressName);
                    	 afterSaleComeRecord.setCourierNum(cns[i]);
                    	 AfterSaleComeRecordDAO.getInstance().saveOrUpdate(afterSaleComeRecord);  
        	        	
        	        }else{
        	        	responseError("快递单号有误");
        	        }
        	 }
        	
        	 responseSuccess2("新建售后记录成功");
          }

    }
		
}

