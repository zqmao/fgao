package base.dao;

import java.util.List;
import base.api.Shop;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;
import com.alibaba.fastjson.JSON;

public class ShopDAO extends BaseDAO<Shop> {

	private static ShopDAO dao;

	private ShopDAO() {
		super("t_shop");
	}

	public static ShopDAO getInstance() {
		if (dao == null) {
			dao = new ShopDAO();
		}
		return dao;
	}
	
	public long queryCount() {
		String sql = "select count(*) from t_shop where id != 0";
		return JDBCUtil.queryCount(sql);
	}
	
	public List<Shop> list(int index, int pagesize) {
		String sql = "select * from t_shop where id != 0 limit ?, ? ";
		List<Shop> objs = JDBCUtil.queryObjectList(sql, Shop.class,index, pagesize);
		
		return objs;
	}
	
}
