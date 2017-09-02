package base.dao;

import java.util.List;

import base.api.Express;
import base.api.User;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class ExpressDAO extends BaseDAO<Express>{
	private static ExpressDAO dao;

	private ExpressDAO() {
		super("t_express");
	}

	public static ExpressDAO getInstance() {
		if (dao == null) {
			dao = new ExpressDAO();
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

	public User query(String name) {
		String sql = "select * from t_user where loginName=? or name=?";
		return JDBCUtil.queryObject(sql, User.class, name, name);
	}

	public List<Express> express() {
		String sql = "select * from t_express";
		List<Express> objs = JDBCUtil.queryObjectList(sql, Express.class);
		return objs;
	}
	

}
