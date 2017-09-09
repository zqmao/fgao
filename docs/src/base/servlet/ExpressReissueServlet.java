package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import base.api.AfterSaleComeRecord;
import base.api.Express;
import base.api.ExpressReissue;
import base.api.User;
import base.api.vo.ExpressReissueVO;
import base.dao.AfterSaleComeRecordDAO;
import base.dao.ExpressDAO;
import base.dao.ExpressReissueDAO;
import base.dao.UserDAO;
import base.dao.core.BaseDAO;
import base.dao.core.BaseDAO.QueryBuilder;

/**
 * @author lcc
 *售后补发记录
 */
public class ExpressReissueServlet extends BaseServlet{
	private static final long serialVersionUID = 1L;
	public ExpressReissueServlet(){
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	@SuppressWarnings("null")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(request, response);
		if("list".equals(sign)){
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
			int index = (page-1) * rows;
			List<ExpressReissue> result = new ArrayList<ExpressReissue>();
			/*if((courierNum!=null&&courierNum.length()!=0)||(expressName!=null && expressName.length()!=0 )
					||(shopName!=null&&shopName.length()!=0)||(goodsName!=null&&goodsName.length()!=0)
					||(orderNum!=null&&orderNum.length()!=0)||(phoneNum!=null&&phoneNum.length()!=0)){
				total = ExpressReissueDAO.getInstance().searchCount(courierNum,expressName,shopName,goodsName,orderNum,phoneNum);
				result = ExpressReissueDAO.getInstance().search(courierNum,expressName,shopName,goodsName,orderNum,phoneNum,index, rows);
			}else{
			total = ExpressReissueDAO.getInstance().listCount();
			result = ExpressReissueDAO.getInstance().list(index,rows);
			}*/
			
			BaseDAO<ExpressReissue>.QueryBuilder builder = ExpressReissueDAO.getInstance().new QueryBuilder();
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
			builder.orderBy("id", true);
			builder.limit(index, rows);
			total = builder.queryCount();
			result = builder.queryList();
			
			List<ExpressReissueVO> vos = new ArrayList<ExpressReissueVO>();
			for(ExpressReissue reissue: result){
				ExpressReissueVO vo = new ExpressReissueVO(reissue);
				vos.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", JSON.toJSON(total));
			obj.put("rows", JSON.toJSON(vos));
			responseSuccess(JSON.toJSON(obj));
		}else if("add".equals(sign)){
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			String shopName = (String) request.getParameter("shopName");
			String address = (String) request.getParameter("address");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String wangwang = (String) request.getParameter("wangwang");
			String remark = (String) request.getParameter("remark");
			String courierNum = (String) request.getParameter("courierNum3");
			String expressName = (String) request.getParameter("expressName3");
			String bounceType = (String) request.getParameter("bounceType");
			
			String id = (String) request.getParameter("erlistId");
			ExpressReissue expressReissue = null;
			if(id==null || id.length()==0){
				expressReissue = new ExpressReissue();
				expressReissue.setCreatorId(currentUser.getId());
				expressReissue.setEntryTime(System.currentTimeMillis());
				expressReissue.setShopName(shopName);
				expressReissue.setAddress(address);
				expressReissue.setGoodsName(goodsName);
				expressReissue.setOrderNum(orderNum);
				expressReissue.setWangwang(wangwang);
				expressReissue.setRemark(remark);
				expressReissue.setBounceType(bounceType);
				
				if((courierNum!=null&&courierNum.length()!=0)||(expressName!=null&&expressName.length()!=0)){
					expressReissue.setCourierNum(courierNum);
					expressReissue.setExpressName(expressName);
					expressReissue.setIssuTime(System.currentTimeMillis());
				}
				
				
			}else{//修改
				expressReissue = ExpressReissueDAO.getInstance().load(Integer.parseInt(id));
				/*expressReissue.setShopName(expressReissue.getShopName());
				expressReissue.setAddress(expressReissue.getAddress());
				expressReissue.setGoodsName(expressReissue.getGoodsName());
				expressReissue.setOrderNum(expressReissue.getOrderNum());
				expressReissue.setWangwang(expressReissue.getWangwang());
				expressReissue.setRemark(expressReissue.getRemark());*/
				expressReissue.setShopName(shopName);
				expressReissue.setAddress(address);
				expressReissue.setGoodsName(goodsName);
				expressReissue.setOrderNum(orderNum);
				expressReissue.setWangwang(wangwang);
				expressReissue.setRemark(remark);
				expressReissue.setBounceType(bounceType);
				if((courierNum!=null&&courierNum.length()!=0)||(expressName!=null&&expressName.length()!=0)){
					expressReissue.setCourierNum(courierNum);
					expressReissue.setExpressName(expressName);
					expressReissue.setIssuTime(System.currentTimeMillis());
				}
			}
			ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
			if(id == null || id.length() == 0){
				responseSuccess("新建售后记录成功");
			}else{
				responseSuccess("修改售后记录成功");
			}
		}else if("reissueAdd".equals(sign)){
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			String status = (String)request.getParameter("status");
			String courierNum = (String)request.getParameter("courierNum");
			String expressName = (String)request.getParameter("expressName");
			String issuRemark = (String)request.getParameter("issuRemark");
			String id = (String) request.getParameter("updateId");
			
			if(id==null&&id.length()==0){
				responseError("请选择记录");
			}else {
				ExpressReissue expressReissue = ExpressReissueDAO.getInstance().load(Integer.parseInt(id));
				//expressReissue.setStatus(Integer.parseInt(status));
				expressReissue.setCourierNum(courierNum);
				expressReissue.setExpressName(expressName);
				expressReissue.setIssuRemark(issuRemark);
				System.out.println("id:"+currentUser.getId());
				expressReissue.setIssueDocumentor(currentUser.getId());
				expressReissue.setIssuTime(System.currentTimeMillis());
				if("已处理".equals(status)){
					expressReissue.setStatus(1);
				}else{
					expressReissue.setStatus(0);
				}
				
				ExpressReissueDAO.getInstance().saveOrUpdate(expressReissue);
				responseSuccess("修改售后记录成功");
			}
		}else if("select".equals(sign)){
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
		}else if("search".equals(sign)){
			responseSuccess("查询成功");
		}	
		
	}
}
