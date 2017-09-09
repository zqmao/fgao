package base.dao;

import java.util.List;

import base.api.GoodsComeRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsComeDAO extends BaseDAO<GoodsComeRecord> {

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
}
