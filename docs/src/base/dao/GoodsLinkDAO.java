package base.dao;

import java.util.List;

import base.api.FreshOrder;
import base.api.GoodsLink;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class GoodsLinkDAO extends BaseDAO<GoodsLink> {

	private static GoodsLinkDAO dao;

	private GoodsLinkDAO() {
		super("t_goods_link");
	}

	public static GoodsLinkDAO getInstance() {
		if (dao == null) {
			dao = new GoodsLinkDAO();
		}
		return dao;
	}
	


	public GoodsLink findByGoodsId(String goodsId){
		String sql = "select * from t_goods_link where tid ='"+goodsId+"' limit 1";
		GoodsLink goods = JDBCUtil.queryObject(sql, GoodsLink.class);
		return goods;
	}
	
	public long queryCount(String sqlStr) {

		String sql = "select count(*) from t_goods_link where "+ sqlStr;
		return JDBCUtil.queryCount(sql);
	}
	
	public List<GoodsLink> list(int index, int pagesize,String sqlStr) {
		
		String sql = "select * from t_goods_link where "+ sqlStr +" limit ?, ? ";
		List<GoodsLink> objs = JDBCUtil.queryObjectList(sql, GoodsLink.class,index, pagesize);
		return objs;
	}
}
