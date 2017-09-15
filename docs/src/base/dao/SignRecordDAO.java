package base.dao;

import base.api.SignRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class SignRecordDAO extends BaseDAO<SignRecord> {
	private static SignRecordDAO dao;
	
	public SignRecordDAO() {
		super("t_sign_record");
	}
	
	public static SignRecordDAO getInstance() {
		if (dao == null) {
			dao = new SignRecordDAO();
		}
		return dao;
	}
	
	public SignRecord query(String dayTime, int userId) {
		String sql = "select * from t_sign_record where dayTime=? and userId=?";
		return JDBCUtil.queryObject(sql, SignRecord.class, dayTime, userId);
	}

}
