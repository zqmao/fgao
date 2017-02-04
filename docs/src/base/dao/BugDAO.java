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

	//全部
	public List<Bug> list() {
		String sql = "select * from t_bug order by id desc";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class);
		return objs;
	}
	//我创建的
	public List<Bug> listUserCreate(int userId) {
		String sql = "select * from t_bug where createrId = ? order by id desc";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId);
		return objs;
	}
	//我正在处理的
	public List<Bug> listUserHandle(int userId) {
		String sql = "SELECT * from t_bug where id in (SELECT bugId from t_bug_operation where id in (select MAX(bo.id) from t_bug_operation bo GROUP BY bugId) and targetId=?) ORDER BY id desc";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId);
		return objs;
	}
	//我完成的
	public List<Bug> listUserFinish(int userId) {
		String sql = "select * from t_bug where finisherId = ? order by id desc";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId);
		return objs;
	}
	//我参与的
	public List<Bug> listUserPart(int userId) {
		String sql = "select DISTINCT b.* from t_bug_operation bo, t_bug b where b.id=bo.bugId and targetId = ? ORDER BY id desc";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId);
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
