package base.dao;

import java.util.List;

import base.api.Coupon;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class CouponDAO extends BaseDAO{

	private static CouponDAO dao;

	private CouponDAO() {
		super("t_coupon");
	}

	public static CouponDAO getInstance() {
		if (dao == null) {
			dao = new CouponDAO();
		}
		return dao;
	}

	public List<Coupon> list() {
		String sql = "select * from t_coupon ";
		List<Coupon> objs = JDBCUtil.queryObjectList(sql, Coupon.class);
		return objs;
	}

	//全部的总数
	public long listCount() {
		String sql = "select count(*) from t_coupon ";
		return JDBCUtil.queryCount(sql);
	}
	
	public Coupon load(int id) {
		String sql = "select * from t_coupon where id=?";
		return JDBCUtil.queryObject(sql, Coupon.class, id);
	}
}
