package base.dao;

import java.util.List;

import base.api.Comment;
import base.api.User;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class CommentDAO extends BaseDAO<Comment>{

	private static CommentDAO dao;

	private CommentDAO() {
		super("t_comment");
	}

	public static CommentDAO getInstance() {
		if (dao == null) {
			dao = new CommentDAO();
		}
		return dao;
	}

	public List<Comment> list(int userId, int goodsId, int index, int pagesize) {
		String condition = "";
		if(goodsId != -1){
			condition = " where goodsId=? ";
		}else{
			condition = " where 1=1 ";
		}
		User user = UserDAO.getInstance().load(userId);
		
		if(user.getAdmin() == 1){
			//是管理员就可以看到全部
			condition += " ";
		}else{
			//自己创建的，即使没有审核通过，也能看到
			condition += " and (userId=" + userId + " or isVerify=1) ";
		}
		
		String sql = "select * from t_comment " + condition + " ORDER BY isVerify, time DESC limit ?, ? ";
		List<Comment> objs = null;
		if(goodsId != -1){
			objs = JDBCUtil.queryObjectList(sql, Comment.class, goodsId, index, pagesize);
		}else{
			objs = JDBCUtil.queryObjectList(sql, Comment.class, index, pagesize);
		}
		return objs;
	}
	public List<Comment> list(int userId, String goodsName, int index, int pagesize) {
		String condition = "";
		System.out.println("11111"+goodsName);
		if(!"全部".equals(goodsName)){
			condition = " where goodsName=? ";
		}else{
			condition = " where 1=1 ";
		}
		User user = UserDAO.getInstance().load(userId);
		
		if(user.getAdmin() == 1){
			//是管理员就可以看到全部
			condition += " ";
		}else{
			//自己创建的，即使没有审核通过，也能看到
			condition += " and (userId=" + userId + " or isVerify=1) ";
		}
		
		String sql = "select * from t_comment " + condition + " ORDER BY isVerify, time DESC limit ?, ? ";
		List<Comment> objs = null;
		if(!"全部".equals(goodsName)){
			objs = JDBCUtil.queryObjectList(sql, Comment.class, goodsName, index, pagesize);
		}else{
			objs = JDBCUtil.queryObjectList(sql, Comment.class, index, pagesize);
		}
		return objs;
	}
	//以goodsName查询总数
		public long listCount(String goodsName) {
			String condition = "";
			if(goodsName != "全部"){
				condition = " where goodsName=? ";
			}
			String sql = "select count(*) from t_comment " + condition;
			if(goodsName != "全部"){
				return JDBCUtil.queryCount(sql, goodsName);
			}else{
				return JDBCUtil.queryCount(sql);
			}
		}


	//全部的总数
	public long listCount(int goodsId) {
		String condition = "";
		if(goodsId != -1){
			condition = " where goodsId=? ";
		}
		String sql = "select count(*) from t_comment " + condition;
		if(goodsId != -1){
			return JDBCUtil.queryCount(sql, goodsId);
		}else{
			return JDBCUtil.queryCount(sql);
		}
	}
}
