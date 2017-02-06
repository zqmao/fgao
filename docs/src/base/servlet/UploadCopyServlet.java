package base.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.util.ImageUtil;

import com.alibaba.fastjson.JSONObject;

public class UploadCopyServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("deprecation")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doPost(request, response);
		// 获取文件需要上传到的路径
		String fileName = System.currentTimeMillis() + ".png";
		String localPath = request.getRealPath("/upload") + "/" + fileName;
		String path = "http://" + request.getLocalAddr() + ":"
				+ request.getLocalPort() + "/"
				+ request.getContextPath() + "/upload/" + fileName;
		try {
			String base64 = request.getParameter("image");
			ImageUtil.base64ToImage(base64, localPath);
			JSONObject obj = new JSONObject();
			obj.put("error", 0);
			obj.put("url", path);
			PrintWriter out = null;
			try {
				out = response.getWriter();
				out.write(obj.toJSONString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
