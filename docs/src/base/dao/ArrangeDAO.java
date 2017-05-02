package base.dao;

import java.util.List;

import base.api.Arrange;
import base.util.DateUtil;
import base.util.JDBCUtil;


public class ArrangeDAO extends BaseDAO {

	private static ArrangeDAO dao;

	private ArrangeDAO() {
		super("t_arrange");
	}

	public static ArrangeDAO getInstance() {
		if (dao == null) {
			dao = new ArrangeDAO();
		}
		return dao;
	}

	public List<Arrange> list(int userId) {
		long time = DateUtil.getDayTime();
		String sql = "select * from t_arrange where day>=? and userId=? order by day ";
		List<Arrange> objs = JDBCUtil.queryObjectList(sql, Arrange.class, time, userId);
		return objs;
	}
	
	public Arrange query(int userId, long time) {
		String sql = "select * from t_arrange where userId=? and day=?";
		return JDBCUtil.queryObject(sql, Arrange.class, userId, time);
	}
}
