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

	public List<Comment> list(int goodsId) {
		String sql = "select * from t_comment where goodsId=? ";
		List<Comment> objs = JDBCUtil.queryObjectList(sql, Comment.class, goodsId);
		return objs;
	}

}
