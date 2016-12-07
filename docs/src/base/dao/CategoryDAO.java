package base.dao;

import java.util.List;

import base.api.Category;
import base.util.JDBCUtil;


public class CategoryDAO extends BaseDAO {

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

	public Category load(int id) {
		String sql = "select * from t_category where id=?";
		return JDBCUtil.queryObject(sql, Category.class, id);
	}
	
	public Category query(String name) {
		String sql = "select * from t_category where name=?";
		return JDBCUtil.queryObject(sql, Category.class, name);
	}
}
