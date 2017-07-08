package base.dao;

import java.util.List;

import base.api.CommentGoods;
import base.util.JDBCUtil;

public class CommentGoodsDAO extends BaseDAO{

	private static CommentGoodsDAO dao;

	private CommentGoodsDAO() {
		super("t_comment_goods");
	}

	public static CommentGoodsDAO getInstance() {
		if (dao == null) {
			dao = new CommentGoodsDAO();
		}
		return dao;
	}

	public List<CommentGoods> list() {
		String sql = "select * from t_comment_goods ";
		List<CommentGoods> objs = JDBCUtil.queryObjectList(sql, CommentGoods.class);
		return objs;
	}

}
