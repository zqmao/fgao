package base.dao;

import java.util.List;

import com.alibaba.fastjson.JSON;

import base.api.FreshOrder;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class FreshOrderDAO extends BaseDAO<FreshOrder> {

	private static FreshOrderDAO dao;

	private FreshOrderDAO() {
		super("t_fresh_order");
	}

	public static FreshOrderDAO getInstance() {
		if (dao == null) {
			dao = new FreshOrderDAO();
		}
		return dao;
	}
	
	public long queryCount(String sqlStr) {

		String sql = "select count(*) from t_fresh_order where "+ sqlStr;
		return JDBCUtil.queryCount(sql);
	}
	
	public List<FreshOrder> list(int index, int pagesize,String sqlStr) {
		
		String sql = "select * from t_fresh_order where "+ sqlStr +" order by createAt desc limit ?, ? ";
		List<FreshOrder> objs = JDBCUtil.queryObjectList(sql, FreshOrder.class,index, pagesize);
		return objs;
	}
	
	public <T> List<T> queryTotal(String sqlStr){
		
		String sql = "select COUNT(*) AS totalNum,SUM(fo.`orderAmount`) AS totalAmount,SUM(fo.`commision`) AS totalCommission,fo.goodsId,gl.title,gl.imgLink "+
		"FROM t_fresh_order AS fo LEFT JOIN t_goods_link AS gl ON fo.goodsId=gl.tid "+sqlStr+" GROUP BY fo.goodsId;";
		List<T> objs = JDBCUtil.querySQL(sql);
		return objs;
	}
	
}
