package base.dao;

import java.util.List;

import base.api.GoodsComeRecord;
import base.util.JDBCUtil;


public class GoodsComeDAO extends BaseDAO {

	private static GoodsComeDAO dao;

	private GoodsComeDAO() {
		super("t_goods_come");
	}

	public static GoodsComeDAO getInstance() {
		if (dao == null) {
			dao = new GoodsComeDAO();
		}
		return dao;
	}
	
	public List<GoodsComeRecord> list(int recordId) {
		String sql = "select * from t_goods_come where inRecordId=? ";
		List<GoodsComeRecord> objs = JDBCUtil.queryObjectList(sql, GoodsComeRecord.class, recordId);
		return objs;
	}
	
	public long listTotal(int recordId) {
		String sql = "select sum(c.count) from t_goods_come c where c.inRecordId=? ";
		return JDBCUtil.queryCount(sql, recordId);
	}
	
	public GoodsComeRecord load(int id) {
		String sql = "select * from t_goods_come where id=?";
		return JDBCUtil.queryObject(sql, GoodsComeRecord.class, id);
	}
}
