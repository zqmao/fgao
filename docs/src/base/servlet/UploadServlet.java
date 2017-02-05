package base.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alibaba.fastjson.JSONObject;

public class UploadServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("deprecation")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 获取文件需要上传到的路径
		String path = request.getRealPath("/upload");
		factory.setRepository(new File(path));
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		String netPath = "";
		try {
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);
			for (FileItem item : list) {
				String name = item.getFieldName();
				if (item.isFormField()) {
					String value = item.getString();
					System.out.println("value:" + value);
					request.setAttribute(name, value);
				} else {
					// 获取路径名
					String value = item.getName();
					int start = value.lastIndexOf("\\");
					String filename = value.substring(start + 1);
					request.setAttribute(name, filename);
					netPath = "http://" + request.getLocalAddr() + ":"
							+ request.getLocalPort() + "/"
							+ request.getContextPath() + "/upload/" + filename;
					System.out.println(netPath);
					OutputStream out = new FileOutputStream(new File(path, filename));
					InputStream in = item.getInputStream();
					int length = 0;
					byte[] buf = new byte[1024];
					System.out.println("获取上传文件的总共的容量：" + item.getSize());
					while ((length = in.read(buf)) != -1) {
						out.write(buf, 0, length);
					}
					in.close();
					out.close();
				}
			}
//			responseSuccess(netPath);
			JSONObject obj = new JSONObject();  
            obj.put("error", 0);  
            obj.put("url", netPath);
            PrintWriter out = null;
    		try {
    			out = response.getWriter();
    			out.write(obj.toJSONString());
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    		out.close();
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
