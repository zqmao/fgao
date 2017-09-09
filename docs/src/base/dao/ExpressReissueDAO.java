package base.dao;

import java.util.ArrayList;
import java.util.List;

import base.api.AfterSaleComeRecord;
import base.api.ExpressReissue;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class ExpressReissueDAO extends BaseDAO<ExpressReissue>{
	private static ExpressReissueDAO dao;
	private ExpressReissueDAO(){
		super("t_express_reissue");
	}
	public static ExpressReissueDAO getInstance(){
		if(dao==null){
			dao =new ExpressReissueDAO();
		}
		return dao;
	}
	public List<ExpressReissue> list() {
		String sql = "select * from t_express_reissue order by courierNum ";
		List<ExpressReissue> objs = JDBCUtil.queryObjectList(sql, ExpressReissue.class);
		return objs;
	}
	public List<ExpressReissue> list(String courierNum) {
		String sql = "select * from t_express_reissue where courierNum=? ";
		List<ExpressReissue> objs = JDBCUtil.queryObjectList(sql, ExpressReissue.class,courierNum);
		return objs;
	}
	public List<ExpressReissue> list(int index, int pagesize) {
		String sql = "select * from t_express_reissue order by id desc limit ?, ? ";
		List<ExpressReissue> objs = JDBCUtil.queryObjectList(sql, ExpressReissue.class, index, pagesize);
		return objs;
	}
	//总数
	public long listCount() {
		String sql = "select count(id) from t_express_reissue";
		return JDBCUtil.queryCount(sql);
	}
	
	public ExpressReissue load(int id) {
		String sql = "select * from t_express_reissue where id=?";
		return JDBCUtil.queryObject(sql, ExpressReissue.class, id);
	}
	
	public List<ExpressReissue> search(String courierNum,String expressName,String shopName,String goodsName,String orderNum,String phoneNum,int index, int pagesize ) {
		String sql = "select * from t_express_reissue where 1=1 ";
		List<Object> list = new ArrayList<Object>();
		if(courierNum!=null&&courierNum!=""){
			sql = sql+" and courierNum=? ";
			list.add(courierNum);
		}
		if(expressName!=null&&expressName!=""){
			sql = sql+" and expressName=? ";
			list.add(expressName);
		}
		if(shopName!=null&&shopName!=""){
			sql = sql+"and shopName=? ";
			list.add(shopName);
		}if(goodsName!=null&&goodsName!=""){
			sql = sql+"and goodsName=? ";
			list.add(goodsName);
		}if(orderNum!=null&&orderNum!=""){
			sql = sql+"and orderNum=? ";
			list.add(orderNum);
		}if(phoneNum!=null&&phoneNum!=""){
			sql = sql+"and phoneNum=? ";
			list.add(phoneNum);
		}
		sql = sql+"order by id desc limit ?, ? ";
		list.add(index);
		list.add(pagesize);
		@SuppressWarnings("unchecked")
		List<ExpressReissue> objs = JDBCUtil.searchList(sql, ExpressReissue.class,list);
		return objs;
	}

	public long searchCount(String courierNum, String expressName, String shopName, String goodsName, String orderNum,String phoneNum) {
		String sql = "select count(courierNum) from t_express_reissue where 1=1 ";
		List<Object> list = new ArrayList<Object>();
		if(courierNum!=null&&courierNum!=""){
			sql = sql+" and courierNum=? ";
			list.add(courierNum);
		}
		if(expressName!=null&&expressName!=""&&expressName!="全部"){
			sql = sql+" and expressName=? ";
			list.add(expressName);
		}
		if(shopName!=null&&shopName!=""){
			sql = sql+"and shopName=? ";
			list.add(shopName);
		}if(goodsName!=null&&goodsName!=""){
			sql = sql+"and goodsName=? ";
			list.add(goodsName);
		}if(orderNum!=null&&orderNum!=""){
			sql = sql+"and orderNum=? ";
			list.add(orderNum);
		}if(phoneNum!=null&&phoneNum!=""){
			sql = sql+"and phoneNum=? ";
			list.add(phoneNum);
		}
		return JDBCUtil.searchCount(sql,list);
	}
	
}
