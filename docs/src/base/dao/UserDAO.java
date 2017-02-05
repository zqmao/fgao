package base.dao;

import java.util.List;

import base.api.User;
import base.util.JDBCUtil;


public class UserDAO extends BaseDAO {

	private static UserDAO dao;

	private UserDAO() {
		super("t_user");
	}

	public static UserDAO getInstance() {
		if (dao == null) {
			dao = new UserDAO();
		}
		return dao;
	}

	public List<User> list() {
		String sql = "select * from t_user where id != 0 order by id ";
		List<User> objs = JDBCUtil.queryObjectList(sql, User.class);
		return objs;
	}
	
	public List<User> list(int index, int pagesize) {
		String sql = "select * from t_user where id != 0 order by id desc limit ?, ? ";
		List<User> objs = JDBCUtil.queryObjectList(sql, User.class, index, pagesize);
		return objs;
	}
	
	//总数
	public long listCount() {
		String sql = "select count(id) from t_user";
		return JDBCUtil.queryCount(sql);
	}

	public User load(int id) {
		String sql = "select * from t_user where id=?";
		return JDBCUtil.queryObject(sql, User.class, id);
	}

	public User query(String name) {
		String sql = "select * from t_user where loginName=? or name=?";
		return JDBCUtil.queryObject(sql, User.class, name, name);
	}
}
