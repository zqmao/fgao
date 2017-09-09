package base.dao;

import base.api.Coupon;
import base.dao.core.BaseDAO;

public class CouponDAO extends BaseDAO<Coupon>{

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
}
