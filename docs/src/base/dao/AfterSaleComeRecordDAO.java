package base.dao;

import java.util.List;

import base.api.AfterSaleComeRecord;
import base.api.User;
import base.util.JDBCUtil;

/**
 * 售后收货记录数据库操作类
 * @author zqmao
 *
 */
public class AfterSaleComeRecordDAO extends BaseDAO {

	private static AfterSaleComeRecordDAO dao;

	private AfterSaleComeRecordDAO() {
		super("t_after_sale_come_record");
	}

	public static AfterSaleComeRecordDAO getInstance() {
		if (dao == null) {
			dao = new AfterSaleComeRecordDAO();
		}
		return dao;
	}

	public List<AfterSaleComeRecord> list() {
		String sql = "select * from t_after_sale_come_record order by courierNum ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class);
		return objs;
	}
	
	public List<AfterSaleComeRecord> list(int index, int pagesize) {
		String sql = "select * from t_after_sale_come_record order by id desc limit ?, ? ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class, index, pagesize);
		return objs;
	}
	
	//总数
	public long listCount() {
		String sql = "select count(courierNum) from t_after_sale_come_record";
		return JDBCUtil.queryCount(sql);
	}

	public AfterSaleComeRecord load(int id) {
		String sql = "select * from t_after_sale_come_record where id=?";
		return JDBCUtil.queryObject(sql, AfterSaleComeRecord.class, id);
	}
	public AfterSaleComeRecord query(String courierNum) {
		String sql = "select * from t_after_sale_come_record where courierNum=? ";
		return JDBCUtil.queryObject(sql, AfterSaleComeRecord.class, courierNum );
	}

}
