package base.servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import base.api.User;
import base.util.PermissionUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class BaseServlet extends HttpServlet{
	
	protected String sign = "";
	protected User currentUser = null;
	protected HttpServletRequest request;
	protected HttpServletResponse response;

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		request = req;
		response = resp;
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/plain");
		sign = (String) req.getParameter("sign");
		currentUser = (User)req.getSession().getAttribute("loginUser");
		
		try{
			
			System.out.println(JSON.toJSON(currentUser).toString());
		}catch(NullPointerException e){
			System.out.println(e.getMessage());
		}
		
	}
	
	protected String returnSqlstr(Map<String, String[]> paramMap) throws ParseException{

		StringBuffer sqlStr = new StringBuffer(" id != 0 ");
		
		for(Map.Entry<String, String[]> entry :paramMap.entrySet()){
            String paramName = entry.getKey();
            String paramValue = "";
            String[] paramValueArr = entry.getValue();
            for (int i = 0; paramValueArr!=null && i < paramValueArr.length; i++) {
                if (i == paramValueArr.length-1) {
                   paramValue+=paramValueArr[i];
               }else {
                   paramValue+=paramValueArr[i]+",";
               }
           }
           paramValue = paramValue.trim();
           
           if(paramName.indexOf("_") != -1 && !paramValue.equals("")){
          	 String[] arr = paramName.split("_");          	 
          	 if(arr[0].equals("eq")){
          		sqlStr.append(" And " +arr[1]+"="+paramValue);
          	 }else if(arr[0].equals("li")){          		 
          		sqlStr.append(" And " +arr[1]+" Like '%"+paramValue+"%' ");
          	 }else if(arr[0].equals("be")){
          		 
          		 SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
          		 
                 Date date = simpleDateFormat.parse(paramValue);
                 
          		if(arr[1].equals("start")){
          			sqlStr.append(" And " +arr[2]+" > "+date.getTime());
          		}else if(arr[1].equals("end")){
          			sqlStr.append(" And " +arr[2]+" <= "+date.getTime());
          		}
          	 }
           }
      
       }
		return sqlStr.toString();
	}
	
	protected void responseSuccess(Object cotent){
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(getResponseStr("1", cotent, ""));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	protected void returnJson(Object cotent){
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(JSON.toJSON(cotent).toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	
	protected void responseSuccess2(String reason){
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(getResponseStr("1", "",reason));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	protected void responseError(String reason) {
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(getResponseStr("0", "", reason));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.close();
	}
	
	private static String getResponseStr(String result, Object content, String reason) {
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		obj.put("data", content);
		obj.put("reason", reason);
		return obj.toString();
	}
	
	@SuppressWarnings("deprecation")
	protected String saveImage(HttpServletRequest request, FileItem item){
		// 获取文件需要上传到的路径
		String path = request.getRealPath("/upload");
		System.out.println("path"+path);
		String filename = System.currentTimeMillis() +".png";
		System.out.println("filename"+filename);
		String netPath = "../upload/" + filename;
		System.out.println("netPath"+netPath);
		OutputStream out;
		try {
			out = new FileOutputStream(new File(path, filename));
		
			InputStream in = item.getInputStream();
			int length = 0;
			byte[] buf = new byte[1024];
			while ((length = in.read(buf)) != -1) {
				out.write(buf, 0, length);
			}
			in.close();
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			netPath = "";
		} catch (IOException e) {
			e.printStackTrace();
			netPath = "";
		}
		return netPath;
	}
}
