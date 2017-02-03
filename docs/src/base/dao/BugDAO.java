package base.dao;

import java.util.List;

import base.api.Bug;
import base.util.JDBCUtil;


public class BugDAO extends BaseDAO {

	private static BugDAO dao;

	private BugDAO() {
		super("t_bug");
	}

	public static BugDAO getInstance() {
		if (dao == null) {
			dao = new BugDAO();
		}
		return dao;
	}

	public List<Bug> list() {
		String sql = "select * from t_bug order by id";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class);
		return objs;
	}

	public Bug load(int id) {
		String sql = "select * from t_bug where id=?";
		return JDBCUtil.queryObject(sql, Bug.class, id);
	}

	public List<Bug> search(String key) {
		String sql = "select * from t_bug where title like ? or createRemark like ? or finishRemark like ?";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, "%" + key + "%", "%" + key + "%", "%" + key + "%");
		return objs;
	}
}
