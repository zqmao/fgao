package base.dao;

import java.util.List;

import base.api.Comment;
import base.util.JDBCUtil;

public class CommentDAO extends BaseDAO{

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

	public List<Comment> list(int goodsId, int index, int pagesize) {
		String sql = "select * from t_comment where goodsId=? limit ?, ? ";
		List<Comment> objs = JDBCUtil.queryObjectList(sql, Comment.class, goodsId, index, pagesize);
		return objs;
	}

	//全部的总数
	public long listCount(int goodsId) {
		String sql = "select count(*) from t_comment where goodsId=? order by id desc";
		return JDBCUtil.queryCount(sql, goodsId);
	}
	
	public Comment load(int id) {
		String sql = "select * from t_comment where id=?";
		return JDBCUtil.queryObject(sql, Comment.class, id);
	}
}
