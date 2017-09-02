package base.dao;

import java.util.List;

import base.api.CommentGoods;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class CommentGoodsDAO extends BaseDAO<CommentGoods>{

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
