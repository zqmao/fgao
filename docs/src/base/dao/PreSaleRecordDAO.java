package base.dao;

import java.util.List;

import base.api.PreSaleRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class PreSaleRecordDAO extends BaseDAO<PreSaleRecord>{

	private static PreSaleRecordDAO dao;
	
	private PreSaleRecordDAO() {
		super("t_pre_sale_record");
	}
	
	public static PreSaleRecordDAO getInstance() {
		if (dao == null) {
			dao = new PreSaleRecordDAO();
		}
		return dao;
	}
	
	public List<PreSaleRecord> list(int userId, int index, int pagesize) {
		List<PreSaleRecord> objs;
		if(userId == 0){
			String sql = "select * from t_pre_sale_record order by id desc limit ?, ? ";
			objs = JDBCUtil.queryObjectList(sql, PreSaleRecord.class, index, pagesize);
		}else{
			String sql = "select * from t_pre_sale_record where doneOrderUserId=? or donePayUserId=? order by id desc limit ?, ? ";
			objs = JDBCUtil.queryObjectList(sql, PreSaleRecord.class, userId, userId, index, pagesize);
		}
		return objs;
	}
	
	public long listCount(int userId) {
		long count = 0;
		if(userId == 0){
			String sql = "select count(*) from t_pre_sale_record  ";
			count = JDBCUtil.queryCount(sql);
		}else{
			String sql = "select count(*) from t_pre_sale_record where doneOrderUserId=? or donePayUserId=? ";
			count = JDBCUtil.queryCount(sql, userId, userId);
		}
		return count;
	}

}
