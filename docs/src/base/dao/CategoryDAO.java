package base.dao;

import java.util.List;

import base.api.Category;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class CategoryDAO extends BaseDAO<Category> {

	private static CategoryDAO dao;

	private CategoryDAO() {
		super("t_category");
	}

	public static CategoryDAO getInstance() {
		if (dao == null) {
			dao = new CategoryDAO();
		}
		return dao;
	}

	public List<Category> list(int categoryId) {
		String sql = "select * from t_category where id != 0 and parentId=? order by id";
		List<Category> objs = JDBCUtil.queryObjectList(sql, Category.class, categoryId);
		return objs;
	}

	public Category query(String name) {
		String sql = "select * from t_category where name=?";
		return JDBCUtil.queryObject(sql, Category.class, name);
	}
}
