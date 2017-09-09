package base.dao;

import base.api.Express;
import base.dao.core.BaseDAO;

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
}
