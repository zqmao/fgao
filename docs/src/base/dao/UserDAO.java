package base.dao;

import java.util.List;

import base.api.User;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class UserDAO extends BaseDAO<User> {

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
	
	public List<User> list(int index, int pagesize) {
		String sql = "select * from t_user where id != 0 order by id desc limit ?, ? ";
		List<User> objs = JDBCUtil.queryObjectList(sql, User.class, index, pagesize);
		return objs;
	}

	public User query(String name) {
		String sql = "select * from t_user where loginName=? or name=?";
		return JDBCUtil.queryObject(sql, User.class, name, name);
	}
}
