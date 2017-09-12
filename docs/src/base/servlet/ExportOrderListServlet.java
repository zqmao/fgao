package base.servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import base.api.ExportOrderList;
import base.api.ExpressReissue;
import base.api.vo.ExportOrderListVO;
import base.api.vo.ExpressReissueVO;
import base.dao.ExportOrderListDAO;
import base.dao.ExpressReissueDAO;
import base.dao.core.BaseDAO;
import base.dao.core.BaseDAO.QueryBuilder;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
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
	 
    private String savePath;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	public void init(ServletConfig config) {
        // 在web.xml中设置的一个初始化参数
        savePath = config.getInitParameter("savePath");
        sc = config.getServletContext();
    }
 
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		super.doPost(request, response);
		if ("list".equals(sign)) {
			/*String courierNum = (String) request.getParameter("courierNum");
			String expressName = (String) request.getParameter("expressName2");
			String shopName = (String) request.getParameter("shopName");
			String goodsName = (String) request.getParameter("goodsName");
			String orderNum = (String) request.getParameter("orderNum");
			String phoneNum = (String) request.getParameter("phoneNum");

			if ("全部".equals(expressName)) {
				expressName = "";
			}
			if ("全部".equals(shopName)) {
				shopName = "";
			}*/
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			long total = 0;
			int index = (page - 1) * rows;
			List<ExportOrderList> result = ExportOrderListDAO.getInstance().list(index,rows);
			
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
			request.setCharacterEncoding("UTF-8");
			/*if (currentUser == null) {
				responseError("需要登录");
				return;
			}*/
			//判断请求类型是否是文件上传
	        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	 
	        if (isMultipart) {
	            try {
	                DiskFileItemFactory factory = new DiskFileItemFactory();
	                ServletFileUpload upload = new ServletFileUpload(factory);
	 
	                // 得到所有的表单域，它们目前都被当作FileItem
	                List<FileItem> items = upload.parseRequest(request);
	                Iterator<FileItem> itr = items.iterator();
	                 
	                // 依次处理每个表单域
	                while (itr.hasNext()) {
	                    FileItem item = (FileItem) itr.next();
	                    if (item.isFormField()) {
	                        // 如果item是正常的表单域
	                        System.out.println("表单参数名:" + item.getFieldName() + "，表单参数值:" + item.getString("UTF-8"));
	                    } else {
	                        if (item.getName() != null && !item.getName().equals("")) {
	                            System.out.println("上传文件的大小:" + item.getSize());
	                            System.out.println("上传文件的类型:" + item.getContentType());
	                            // item.getName()返回上传文件在客户端的完整路径名称
	                            System.out.println("上传文件的名称:" + item.getName());
	 
	                            File tempFile = new File(item.getName());
	                            //PrintStream printStream = new PrintStream(tempFile);
	                            FileInputStream is =new FileInputStream(tempFile);  	
	                            byte[] data = new byte[1024];  
	                            // 读取内容，放到字节数组里面  
	                            is.read(data);  
	                            System.out.println(new String(data));  
	                            
	                       System.out.println(tempFile+"44444444444444");
	                            }
	                         
	                    }
	                }
	            } catch (FileUploadException e) {
	                e.printStackTrace();
	                request.setAttribute("upload.message", "上传文件失败！");
	            } catch (Exception e) {
	                e.printStackTrace();
	                request.setAttribute("upload.message", "上传文件失败！");
	            }
	        } else {
	            System.out.println("the enctype must be multipart/form-data");
	        }
	        request.getRequestDispatcher("/result.jsp").forward(request, response);
			
			
		}
		
	}
	/*public static void readCsvAndInstallDB(String path) throws Exception {  
        File file = new File(path);  
        BufferedReader bReader = new BufferedReader(new InputStreamReader(new FileInputStream(file)));  
        String line = "";  
        List<ExportOrderList> beanList = new ArrayList<ExportOrderList>();  
        int count = 0;  
        // 忽略前几行标题  
        if(ignoreRows > 0) {  
            for (int i = 0; i < ignoreRows; i++) {  
                line = bReader.readLine();  
            }  
        }  
        try {  
            while((line = bReader.readLine()) != null) {  
    //          System.out.println(++count+"  "+line);  
                if(line.trim() != "") {  
                    String[] pills = line.split(",");  
                    ExportOrderList bean = new ExportOrderList(pills[0].trim(), pills[1].trim(), pills[2].trim(), pills[3].trim());  
                    beanList.add(bean);  
                    if(++count%Constants.BATCH_NUM == 0) {  
                        // 数据库操作， 见“jdbc批量插入一文”  
                        DBHelp.executeUpate(DBHelp.SQL_INSTALL_IDNO_THIRD, beanList, Constants.DATE_FORMATE_DEFAULT);  
                        beanList.clear();  
                    }  
                }  
            }  
            // 操作集合中最后一批数据  <span style="font-family: Arial, Helvetica, sans-serif;">数据库操作， 见“jdbc批量插入一文”</span>  
            DBHelp.executeUpate(DBHelp.SQL_INSTALL_IDNO_THIRD, beanList, Constants.DATE_FORMATE_DEFAULT);  
            beanList.clear();  
            DBHelp.closeSources(DBHelp.getConn(), DBHelp.getPs());  
            beanList = null;  
        }finally {  
            if(bReader != null) {  
                bReader.close();  
            }  
        }  
    }  */
}

