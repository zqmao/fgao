package base.dao;

import base.api.CommentGoods;
import base.dao.core.BaseDAO;

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
}
