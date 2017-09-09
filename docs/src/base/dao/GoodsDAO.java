package base.dao;

import java.util.List;

import base.api.Goods;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsDAO extends BaseDAO<Goods> {

	private static GoodsDAO dao;

	private GoodsDAO() {
		super("t_goods");
	}

	public static GoodsDAO getInstance() {
		if (dao == null) {
			dao = new GoodsDAO();
		}
		return dao;
	}
	
	public List<Goods> list(int index, int pagesize) {
		String sql = "select * from t_goods where id != 0 order by name desc limit ?, ? ";
		List<Goods> objs = JDBCUtil.queryObjectList(sql, Goods.class, index, pagesize);
		return objs;
	}
}
