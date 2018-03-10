package base.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import base.api.FreshOrder;
import base.api.User;
import base.api.vo.FreshOrderVO;
import base.dao.CommentDAO;
import base.dao.FreshOrderDAO;
import base.util.PermissionUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sun.jmx.snmp.Timestamp;

public class FreshOrderServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public FreshOrderServlet() {
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
				
				System.out.println(sqlStr);
				
				User user = PermissionUtil.getCurrentUser(request, response);
				if(user.getAdmin() == 0){
					sqlStr += " And createUser="+user.getId();
				}
				
				List<FreshOrder> result;
				total = FreshOrderDAO.getInstance().queryCount(sqlStr);
				result = FreshOrderDAO.getInstance().list(index, rows,sqlStr);
				
				List<FreshOrderVO> objs = new ArrayList<FreshOrderVO>();
				for(FreshOrder record : result){
					FreshOrderVO vo = new FreshOrderVO(record);
					objs.add(vo);
				}
				JSONObject obj = new JSONObject();
				obj.put("total", total);
				obj.put("rows", objs);
				
				returnJson(obj);
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if ("add".equals(sign)) {// 增加
			String id       = ""; 
			String goodsId  = "";
			String orderSn  = "";
			String contractType = "";
			String contractAccount = "";
			String commision =  "";
			String orderAmount = "";
			String shopId     = "";
			String remark = "";
			String keyWords = "";
		    /*	
			String isPay = (String) request.getParameter("isPay");
			String payType = (String) request.getParameter("payType");
			String payAccount = (String) request.getParameter("payAccount");
			String payName = (String) request.getParameter("payName");
			String payRemark = (String) request.getParameter("payRemark");
			
			*/
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 获取文件需要上传到的路径
			String path = request.getRealPath("/upload/fresh/oder");
			factory.setRepository(new File(path));
			factory.setSizeThreshold(1024 * 1024);
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> list = null;
			try {
				list = (List<FileItem>) upload.parseRequest(request);
				for (FileItem item : list) {
					String name = item.getFieldName();
					System.out.println("--field--"+name);
					if (item.isFormField()) {
						//获取普通表单参数
						String value = new String(item.getString().getBytes("ISO8859_1"),"utf-8");
						if(name.equals("goodsId")){
							goodsId = value;
						}else if(name.equals("orderSn")){
							orderSn = value;
						}else if(name.equals("contractType")){
							contractType = value;
						}else if(name.equals("contractAccount")){
							contractAccount = value;
						}else if(name.equals("commision")){
							commision = value;
						}else if(name.equals("orderAmount")){
							orderAmount = value;
						}else if(name.equals("shopId")){
							shopId = value;
						}else if(name.equals("id")){
							id = value;
						}else if(name.equals("remark")){
							remark = value;
						}else if(name.equals("keyWords")){
							keyWords = value;
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			
			FreshOrder order = null;
			if(id == null || id.length() == 0){
				order = new FreshOrder();
				order.setCreateAt(System.currentTimeMillis());
				order.setCreateUser(currentUser.getId());
			}else{
				order = FreshOrderDAO.getInstance().load(Integer.parseInt(id));
			}
			order.setGoodsId(goodsId);
			order.setShopId(Integer.parseInt(shopId));
			order.setOrderSn(orderSn);
			order.setContractType(contractType);
			order.setContractAccount(contractAccount);
			order.setCommision(commision);
			order.setOrderAmount(orderAmount);
			order.setRemark(remark);
			order.setKeyWords(keyWords);
			
			int lastId = FreshOrderDAO.getInstance().saveOrUpdate(order);
			if (order.getId() == 0) {
				responseSuccess("添加成功");
			} else {

				responseSuccess("修改成功");
				lastId = order.getId();
			}
			
			String keyImage = "";
			for (FileItem item : list) {
				String name = item.getFieldName();
				if (!item.isFormField()) {
					//获取文件列表
					if(item.getInputStream() != null && item.getName() != null && item.getName().length() > 0){
						keyImage = saveImage(request, item);
						System.out.println("netPath+++"+keyImage);
					}
				}
			}
			order.setId(lastId);
			order.setKeyImage(keyImage);
			FreshOrderDAO.getInstance().saveOrUpdate(order);

		} else if ("delete".equals(sign)) {// 删除
			String id = (String) request.getParameter("id");
			FreshOrderDAO.getInstance().delete(Integer.parseInt(id));
			responseSuccess("删除成功");
		}else if("record".equals(sign)){ //报表统计
			String start_createAt = request.getParameter("start_createAt");
			String end_createAt = request.getParameter("end_createAt");
			
			try {
				
				StringBuffer sqlStr = new StringBuffer();
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(start_createAt != null && end_createAt != null){
	
	                Date createAt1 = simpleDateFormat.parse(start_createAt);
	                Date createAt2 = simpleDateFormat.parse(end_createAt);
					sqlStr.append(" Where fo.createAt >"+createAt1.getTime());
					sqlStr.append(" And fo.createAt <="+createAt2.getTime());
					
				}else if(start_createAt != null && end_createAt == null){
	                Date date = simpleDateFormat.parse(start_createAt);
					sqlStr.append("Where fo.createAt >"+date.getTime());
				}else if(start_createAt == null && end_createAt != null){
					
	                Date date = simpleDateFormat.parse(end_createAt);
					sqlStr.append("Where fo.createAt <="+date.getTime());
				}else{
					long current = System.currentTimeMillis();
					long zero = current/(1000*3600*24)*(1000*3600*24) - TimeZone.getDefault().getRawOffset();
					
					sqlStr.append(" Where fo.createAt >" + zero);
				}
				
				List<FreshOrder> result;
				result = FreshOrderDAO.getInstance().queryTotal(sqlStr.toString());
		
				JSONObject obj = new JSONObject();
				//obj.put("total", result);
				obj.put("rows", result);
				returnJson(obj);		
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
