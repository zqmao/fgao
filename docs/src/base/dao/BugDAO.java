package base.dao;

import java.util.List;

import base.api.Bug;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


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
	public List<Bug> list(int index, int pagesize) {
		String sql = "select * from t_bug order by createTime desc limit ?, ? ";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, index, pagesize);
		return objs;
	}
	//全部的总数
	public long listCount() {
		String sql = "select count(*) from t_bug order by id desc";
		return JDBCUtil.queryCount(sql);
	}
	//我创建的
	public List<Bug> listUserCreate(int userId, int index, int pagesize) {
		String sql = "select * from t_bug where createrId = ? order by createTime desc limit ?, ? ";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId, index, pagesize);
		return objs;
	}
	//我创建的总数
	public long listUserCreateCount(int userId) {
		String sql = "select count(*) from t_bug where createrId = ? order by createTime desc";
		return JDBCUtil.queryCount(sql, userId);
	}
	//我正在处理的
	public List<Bug> listUserHandle(int userId, int index, int pagesize) {
		String sql = "SELECT * from t_bug where finisherId=0 and id in (SELECT bugId from t_bug_operation where id in (select MAX(bo.id) from t_bug_operation bo GROUP BY bugId) and targetId=?) ORDER BY createTime desc limit ?, ? ";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId, index, pagesize);
		return objs;
	}
	//我创建的总数
	public long listUserHandleCount(int userId) {
		String sql = "select count(*) from t_bug where id in (SELECT bugId from t_bug_operation where id in (select MAX(bo.id) from t_bug_operation bo GROUP BY bugId) and targetId=?) ORDER BY createTime desc";
		return JDBCUtil.queryCount(sql, userId);
	}
	//我完成的
	public List<Bug> listUserFinish(int userId, int index, int pagesize) {
		String sql = "select * from t_bug where finisherId = ? order by createTime desc limit ?, ? ";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId, index, pagesize);
		return objs;
	}
	//我完成的总数
	public long listUserFinishCount(int userId) {
		String sql = "select count(*) from t_bug where finisherId = ? order by createTime desc";
		return JDBCUtil.queryCount(sql, userId);
	}
	//我参与的
	public List<Bug> listUserPart(int userId, int index, int pagesize) {
		String sql = "select DISTINCT b.* from t_bug_operation bo, t_bug b where b.id=bo.bugId and bo.targetId = ? ORDER BY b.createTime desc limit ?, ? ";
		List<Bug> objs = JDBCUtil.queryObjectList(sql, Bug.class, userId, index, pagesize);
		return objs;
	}
	//我完成的总数
	public long listUserPartCount(int userId) {
		String sql = "select count(DISTINCT b.id) from t_bug_operation bo, t_bug b where b.id=bo.bugId and bo.targetId = ? ORDER BY b.createTime desc";
		return JDBCUtil.queryCount(sql, userId);
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
	
	public void deleteOp(int bugId) {
		String sql = "delete from t_bug_operation where bugId=?";
		JDBCUtil.delete(sql, bugId);
	}
}
