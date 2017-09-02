package base.dao;

import java.util.List;

import base.api.GoodsOutRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsOutDAO extends BaseDAO {

	private static GoodsOutDAO dao;

	private GoodsOutDAO() {
		super("t_goods_out");
	}

	public static GoodsOutDAO getInstance() {
		if (dao == null) {
			dao = new GoodsOutDAO();
		}
		return dao;
	}
	
	public List<GoodsOutRecord> list(int index, int pagesize) {
		String sql = "select * from t_goods_out where id != 0 order by id desc limit ?, ? ";
		List<GoodsOutRecord> objs = JDBCUtil.queryObjectList(sql, GoodsOutRecord.class, index, pagesize);
		return objs;
	}
	
	public long listCount() {
		String sql = "select count(id) from t_goods_out";
		return JDBCUtil.queryCount(sql);
	}
	
	public GoodsOutRecord load(int id) {
		String sql = "select * from t_goods_out where id=?";
		return JDBCUtil.queryObject(sql, GoodsOutRecord.class, id);
	}
}
