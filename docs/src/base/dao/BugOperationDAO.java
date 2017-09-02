package base.dao;

import java.util.List;

import base.api.BugOperation;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class BugOperationDAO extends BaseDAO<BugOperation> {

	private static BugOperationDAO dao;

	private BugOperationDAO() {
		super("t_bug_operation");
	}

	public static BugOperationDAO getInstance() {
		if (dao == null) {
			dao = new BugOperationDAO();
		}
		return dao;
	}

	public List<BugOperation> list(int bugId) {
		String sql = "select * from t_bug_operation where bugId=? order by id desc";
		List<BugOperation> objs = JDBCUtil.queryObjectList(sql, BugOperation.class, bugId);
		return objs;
	}

	public BugOperation load(int id) {
		String sql = "select * from t_bug_operation where id=?";
		return JDBCUtil.queryObject(sql, BugOperation.class, id);
	}
}
