package base.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.csvreader.CsvReader;

import base.api.ExportOrderList;
import base.api.ExpressReissue;
import base.api.vo.ExportOrderListVO;
import base.api.vo.ExpressReissueVO;
import base.dao.AfterSaleComeRecordDAO;
import base.dao.ExportOrderListDAO;
import base.dao.ExpressReissueDAO;
import base.dao.core.BaseDAO;
import base.dao.core.BaseDAO.QueryBuilder;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.Iterator;
import java.util.List;
import java.io.BufferedReader;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.InputStreamReader;  
import java.util.ArrayList;  
import java.util.List;   
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 * @author lcc 售后补发记录
 */
public class ExportOrderListServlet extends BaseServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ServletContext sc;
	 
   
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	
 
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		super.doPost(request, response);
		if ("list".equals(sign)) {
			
			String allSearch = (String) request.getParameter("allSearch");
			
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			List<ExportOrderList> result = new ArrayList<ExportOrderList>();
			//List<ExportOrderList> result = ExportOrderListDAO.getInstance().list(index,rows);
			if(allSearch == null || allSearch.length() == 0){
				total = ExportOrderListDAO.getInstance().queryCount();
				result = ExportOrderListDAO.getInstance().list(index,rows);
			}else{
				total = ExportOrderListDAO.getInstance().count(allSearch);
				result = ExportOrderListDAO.getInstance().list(allSearch,index,rows);
			}
			
			
			/*BaseDAO<ExpressReissue>.QueryBuilder builder = ExpressReissueDAO.getInstance().new QueryBuilder();
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
			builder.orderBy("id", true);
			builder.limit(index, rows);
			total = builder.queryCount();
			result = builder.queryList();*/

			List<ExportOrderListVO> vos = new ArrayList<ExportOrderListVO>();
			for (ExportOrderList reissue : result) {
				ExportOrderListVO vo = new ExportOrderListVO(reissue);
				vos.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", JSON.toJSON(total));
			obj.put("rows", JSON.toJSON(vos));
			responseSuccess(JSON.toJSON(obj));
		} else if("add".equals(sign)){
			String path = "";
			String isCsv ="";
			request.setCharacterEncoding("UTF-8");
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			try{
			//创建一个解析器工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			 //得到解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			//upload.setHeaderEncoding("utf-8");
			//对相应的请求进行解析，有几个输入项，就有几个FileItem对象
			List<FileItem> items = upload.parseRequest(request);
			 //要迭代list集合，获取list集合中每一个输入项
			for(FileItem item :items){
				//判断输入的类型
				if(item.isFormField()){
					 //普通输入项
                    String inputName=item.getFieldName();
                    String inputValue=item.getString();
                    System.out.println(inputName+"::"+inputValue);
				}else{
					//上传文件输入项
					  String filename=item.getName();//上传文件的文件名
					  System.out.println(filename+"::"+"filename");
                      //filename=filename.substring(filename.lastIndexOf("\\"));
                      InputStream is=item.getInputStream();
                      FileOutputStream fos=new FileOutputStream("c:\\"+"updown\\"+filename);
                      path = "c:\\updown\\"+filename;
                      
                      File file = new File(path);
                      
                      isCsv = path.substring(path.lastIndexOf("."));
                      if(!".csv".equals(isCsv)){
                    	  responseError("请导入csv文件");
                      }else{byte[] buff=new byte[1024];
                      @SuppressWarnings("unused")
					  int len=0;
                      while((len=is.read(buff))>0){
                               fos.write(buff);
                      }
                      System.out.println("文件生成成功");
                      is.close();
                      fos.close();
                      }
                     /* byte[] buff=new byte[1024];
                      @SuppressWarnings("unused")
					  int len=0;
                      while((len=is.read(buff))>0){
                               fos.write(buff);
                      }
                      System.out.println("文件生成成功");
                      is.close();
                      fos.close();*/
                      if(path!=null&& ".csv".equals(isCsv)){
                    	  try {
							readCsvAndInstallDB(path);
							if(file.exists()){
								 file.delete();//删除原文件
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
                      }
				}
			}
            }catch (FileUploadException e) {
                     e.printStackTrace();
            }
			responseSuccess2("新建售后记录成功");
		}else if("search".equals(sign)){
			responseSuccess("查询成功");
		}
	}
	@SuppressWarnings("null")
	public void readCsvAndInstallDB(String path) throws Exception { 
       //String filePath = "";  
       //BufferedReader bReader = new BufferedReader(new InputStreamReader(new FileInputStream(path)));  
        ExportOrderList exportOrderList = new ExportOrderList();
        CsvReader reader = new CsvReader(path, ',', Charset.forName("GBK"));
        System.out.println(path);
        try {  
        	    reader.readRecord();
        		while(reader.readRecord()){
        		  
        		exportOrderList.setOrderNum(reader.get(0));//订单编号
        		exportOrderList.setWangwang(reader.get(1));//买家会员名
        		exportOrderList.setActualMoney(reader.get(8));//买家支付宝账号
        		exportOrderList.setAddress(reader.get(13).trim());//收件人地址
        		exportOrderList.setConsigneeName(reader.get(12));//收件人姓名
        		exportOrderList.setAlipayNum(reader.get(2).trim());//买家支付宝账号
        		exportOrderList.setExportor(currentUser.getId());//导入人
        		exportOrderList.setExportTime(System.currentTimeMillis());//导入时间
        		exportOrderList.setGoodsHeadline(reader.get(19).trim());//宝贝标题
        		exportOrderList.setOrderCreateTime(reader.get(17).trim());//订单创建时间
        		exportOrderList.setOrderTime(reader.get(18).trim());//订单付款时间
        		exportOrderList.setPhoneNum(reader.get(16).substring(1));//联系手机
        		exportOrderList.setShopName(reader.get(26).trim());//店铺名称
        		ExportOrderListDAO.getInstance().saveOrUpdate(exportOrderList);
        	
        	}
        }catch(IOException e){
        	e.printStackTrace();
        }  
    }  
}

