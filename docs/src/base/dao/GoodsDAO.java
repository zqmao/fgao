package base.dao;

import java.util.List;

import base.api.Goods;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsDAO extends BaseDAO {

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

	public List<Goods> list() {
		String sql = "select * from t_goods ";
		List<Goods> objs = JDBCUtil.queryObjectList(sql, Goods.class);
		return objs;
	}
	
	public List<Goods> list(int index, int pagesize) {
		String sql = "select * from t_goods where id != 0 order by name desc limit ?, ? ";
		List<Goods> objs = JDBCUtil.queryObjectList(sql, Goods.class, index, pagesize);
		return objs;
	}
	
	public long listCount() {
		String sql = "select count(id) from t_goods";
		return JDBCUtil.queryCount(sql);
	}
	
	public Goods load(int id) {
		String sql = "select * from t_goods where id=?";
		return JDBCUtil.queryObject(sql, Goods.class, id);
	}
}
