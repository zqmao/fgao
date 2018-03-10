package base.dao;

import java.util.List;

import base.api.FreshOrder;
import base.api.Goods;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsDAO extends BaseDAO<Goods> {

	private static GoodsDAO dao;

	private GoodsDAO() {
		super("t_goods");
	}

	public static GoodsDAO getInstance() {
		if (dao == null) {
			dao = new GoodsDAO();
		}
		return dao;
	}
	


	public Goods findByGoodsId(String goodsId){
		String sql = "select * from t_goods where tid ='"+goodsId+"' limit 1";
		Goods goods = JDBCUtil.queryObject(sql, Goods.class);
		return goods;
	}
	
	public long queryCount(String sqlStr) {

		String sql = "select count(*) from t_goods where "+ sqlStr;
		return JDBCUtil.queryCount(sql);
	}
	
	public List<Goods> list(int index, int pagesize,String sqlStr) {
		
		String sql = "select * from t_goods where "+ sqlStr +" limit ?, ? ";
		List<Goods> objs = JDBCUtil.queryObjectList(sql, Goods.class,index, pagesize);
		return objs;
	}
}
