package base.dao;

import java.util.List;

import base.api.GoodsInRecord;
import base.util.JDBCUtil;


public class GoodsInDAO extends BaseDAO {

	private static GoodsInDAO dao;

	private GoodsInDAO() {
		super("t_goods_in");
	}

	public static GoodsInDAO getInstance() {
		if (dao == null) {
			dao = new GoodsInDAO();
		}
		return dao;
	}
	
	public List<GoodsInRecord> list(int index, int pagesize) {
		String sql = "select * from t_goods_in order by status, id desc limit ?, ? ";
		List<GoodsInRecord> objs = JDBCUtil.queryObjectList(sql, GoodsInRecord.class, index, pagesize);
		return objs;
	}
	
	public long listCount() {
		String sql = "select count(id) from t_goods_in";
		return JDBCUtil.queryCount(sql);
	}
	
	public GoodsInRecord load(int id) {
		String sql = "select * from t_goods_in where id=?";
		return JDBCUtil.queryObject(sql, GoodsInRecord.class, id);
	}
	
	public boolean goodsIng(int goodsId){
		//查询该货物是否正在进货
		String sql = "select * from t_goods_in where goodsId=? and status=0";
		List<GoodsInRecord> objs = JDBCUtil.queryObjectList(sql, GoodsInRecord.class, goodsId);
		if(objs != null && objs.size() > 0){
			return true;
		}else{
			return false;
		}
	}
}
