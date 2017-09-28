package base.servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import base.api.Comment;
import base.api.CommentGoods;
import base.dao.CommentDAO;
import base.dao.CommentGoodsDAO;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class CommentServlet extends BaseServlet{
	
	private static final long serialVersionUID = 1L;

	public CommentServlet() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@SuppressWarnings("deprecation")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {// 查询列表
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			//int goodsId = Integer.parseInt(request.getParameter("goodsId"));
			String goodsName = request.getParameter("goodsName");
			
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			System.out.println("goodsName+++"+goodsName);
			int index = (page - 1) * rows;
			
			//List<Comment> result = CommentDAO.getInstance().list(currentUser.getId(), goodsId, index, rows);
			List<Comment> result = CommentDAO.getInstance().list(currentUser.getId(), goodsName, index, rows);
			JSONObject obj = new JSONObject();
			//obj.put("total", CommentDAO.getInstance().listCount(goodsId));
			obj.put("total", CommentDAO.getInstance().listCount(goodsName));
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		}else if ("selectAll".equals(sign)) {// 查询评论货物列表
			List<CommentGoods> result = CommentGoodsDAO.getInstance().queryForAll();
			System.out.println("result+++"+result);
			JSONArray array = new JSONArray();
			JSONObject all = new JSONObject();
			/*all.put("id", -1);
			all.put("text", "所有");
			array.add(all);
			JSONObject other = new JSONObject();
			other.put("id", -2);
			other.put("text", "其他");
			array.add(other);
			for(CommentGoods item : result){
				JSONObject obj = new JSONObject();
				obj.put("id", item.getId());
				obj.put("text", item.getName());
				array.add(obj);
			}*/
			JSONObject other = new JSONObject();
			other.put("id", 1);
			other.put("text", "全部");
			array.add(other);
			for(CommentGoods item : result){
				JSONObject obj = new JSONObject();
				obj.put("id", item.getId());
				obj.put("text", item.getName());
				array.add(obj);
			}
			responseSuccess(JSON.toJSON(array));
		}else if ("select".equals(sign)) {// 查询评论货物列表
			List<CommentGoods> result = CommentGoodsDAO.getInstance().queryForAll();
			JSONArray array = new JSONArray();
			JSONObject def = new JSONObject();
			/*def.put("id", -3);
			def.put("text", "-请选择-");
			array.add(def);
			JSONObject other = new JSONObject();
			other.put("id", -2);
			other.put("text", "其他");
			array.add(other);
			for(CommentGoods item : result){
				JSONObject obj = new JSONObject();
				obj.put("id", item.getId());
				obj.put("text", item.getName());
				array.add(obj);
			}*/
			
			for(CommentGoods item : result){
				JSONObject obj = new JSONObject();
				obj.put("id", item.getId());
				obj.put("text", item.getName());
				array.add(obj);
			}
			responseSuccess(JSON.toJSON(array));
		}else if ("add".equals(sign)) {// 查询评论货物列表
			String firstComment = "";
			String timeDes = "";
			String secondComment = "";
			String commentId = "";
			//String goodsId = "";
			String goodsName = "";
			String remark = "";
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 获取文件需要上传到的路径
			String path = request.getRealPath("/upload");
			factory.setRepository(new File(path));
			factory.setSizeThreshold(1024 * 1024);
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> list = null;
			try {
				list = (List<FileItem>) upload.parseRequest(request);
				for (FileItem item : list) {
					String name = item.getFieldName();
					System.out.println("name666"+name);
					if (item.isFormField()) {
						//获取普通表单参数
						String value = new String(item.getString().getBytes("ISO8859_1"),"utf-8");
						if(name.equals("firstComment")){
							firstComment = value;
						}else if(name.equals("timeDes")){
							if(value == null || value.length() == 0){
								value = "7";
							}
							timeDes = value + "天后";
						}else if(name.equals("secondComment")){
							secondComment = value;
						}else if(name.equals("commentId")){
							commentId = value;
						}/*else if(name.equals("goodsId")){
							goodsId = value;
						}*/
						else if(name.equals("goodsName")){
							goodsName = value;
						}
						else if(name.equals("remark")){
							remark = value;
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Comment comment = null;
			if(commentId == null || commentId.length() == 0){
				comment = new Comment();
			}else{
				comment = CommentDAO.getInstance().load(Integer.parseInt(commentId));
			}
			comment.setFirstComment(firstComment);
			comment.setSecondComment(secondComment);
			comment.setTime(System.currentTimeMillis());
			comment.setTimeDes(timeDes);
			comment.setRemark(remark);
			/*if(goodsId == null || goodsId.length() == 0){
				responseError("商品参数错误");
				return;
			}*/
			//comment.setGoodsId(Integer.parseInt(goodsId));
			comment.setGoodsName(goodsName);
			if(currentUser != null){
				comment.setUserId(currentUser.getId());
				comment.setCreator(currentUser.getName());
			}else{
				responseError("需要登录");
				return;
			}
			int id = CommentDAO.getInstance().saveOrUpdate(comment);
			if (comment.getId() == 0) {
				responseSuccess("增加成功");
			} else {
				responseSuccess("修改成功");
				id = comment.getId();
			}
			
			String firstCommentPic = "";
			String secondCommentPic = "";
			for (FileItem item : list) {
				String name = item.getFieldName();
				if (!item.isFormField()) {
					//获取文件列表
					if(item.getInputStream() != null && item.getName() != null && item.getName().length() > 0){
						String netPath = saveImage(request, item, id);
						System.out.println("netPath+++"+netPath);
						if(name.startsWith("first")){
							firstCommentPic += "," + netPath;
						}else if(name.startsWith("second")){
							secondCommentPic += "," + netPath;
						}
					}
				}
			}
			if(firstCommentPic.length() > 0){
				firstCommentPic = firstCommentPic.substring(1);
			}
			if(secondCommentPic.length() > 0){
				secondCommentPic = secondCommentPic.substring(1);
			}
			comment.setId(id);
			comment.setFirstCommentPic(firstCommentPic);
			comment.setSecondCommentPic(secondCommentPic);
			CommentDAO.getInstance().saveOrUpdate(comment);
		} else if ("delete".equals(sign)) {// 删除
			String commentIds = (String) request.getParameter("commentIds");
			for(String commentId : commentIds.split(",")){
				CommentDAO.getInstance().delete(Integer.parseInt(commentId));
			}
			responseSuccess("删除成功");
		} else if ("verify".equals(sign)) {// 审核
			String commentIds = (String) request.getParameter("commentIds");
			for(String commentId : commentIds.split(",")){
				Comment comment = null;
				comment = CommentDAO.getInstance().load(Integer.parseInt(commentId));
				comment.setIsVerify(1);
				CommentDAO.getInstance().saveOrUpdate(comment);
			}
			responseSuccess("审核成功");
		}
	}
	
	@SuppressWarnings("deprecation")
	private String saveImage(HttpServletRequest request, FileItem item, int commentId){
		// 获取文件需要上传到的路径
		String path = request.getRealPath("/upload");
		System.out.println("path"+path);
		String filename = commentId + "_" + item.getFieldName() + ".png";
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
