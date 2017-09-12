package base.dao;

import java.util.List;

import base.api.AfterSaleComeRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

/**
 * 售后收货记录数据库操作类
 * @author zqmao
 *
 */
public class AfterSaleComeRecordDAO extends BaseDAO<AfterSaleComeRecord> {

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
	public long count(String allSearch){
		String sql = "select count(id) from t_after_sale_come_record where courierNum=? or expressName=? or shopName=? or goodsName=? or orderNum=? or phoneNum=? or wangwang=? ";
		return JDBCUtil.queryCount(sql, allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch);
	}
	public List<AfterSaleComeRecord> list() {
		String sql = "select * from t_after_sale_come_record order by courierNum ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class);
		return objs;
	}
	public List<AfterSaleComeRecord> list(String allSearch,int index, int pagesize ) {
		String sql = "select * from t_after_sale_come_record where courierNum=? or expressName=? or shopName=? or goodsName=? or orderNum=? or phoneNum=? or wangwang=? order by id desc limit ?, ?";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,index,pagesize);
		return objs;
	}
	public List<AfterSaleComeRecord> list(int index, int pagesize) {
		String sql = "select * from t_after_sale_come_record order by id desc limit ?, ? ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class, index, pagesize);
		return objs;
	}
	public AfterSaleComeRecord query(String courierNum) {
		String sql = "select * from t_after_sale_come_record where courierNum=? ";
		return JDBCUtil.queryObject(sql, AfterSaleComeRecord.class, courierNum);
	}
}
