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
		String sql = "select * from t_user where id != 0 order by id";
		List<User> objs = JDBCUtil.queryObjectList(sql, User.class);
		return objs;
	}

	/**
	 * 用户登录
	 * 
	 * @param user
	 * @return
	 */
	public User login(User user) {
		String sql = "select * from t_user where name=? and password=?";
		User tempCustomer = JDBCUtil.queryObject(sql, User.class, user.getName(), user.getPassword());
		return tempCustomer;
	}

	public User load(int id) {
		String sql = "select * from t_user where id=?";
		return JDBCUtil.queryObject(sql, User.class, id);
	}

	/**
	 * 根据用户名查用户
	 * 
	 * @param userName
	 * @return
	 */
	public User query(String name) {
		String sql = "select * from t_user where name=?";
		return JDBCUtil.queryObject(sql, User.class, name);
	}
}
