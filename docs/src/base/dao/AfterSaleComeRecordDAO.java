package base.dao;

import java.util.ArrayList;
import java.util.List;

import base.api.AfterSaleComeRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

/**
 * 售后收货记录数据库操作类
 * @author zqmao
 *
 */
public class AfterSaleComeRecordDAO extends BaseDAO<AfterSaleComeRecord> {

	private static AfterSaleComeRecordDAO dao;

	private AfterSaleComeRecordDAO() {
		super("t_after_sale_come_record");
	}

	public static AfterSaleComeRecordDAO getInstance() {
		if (dao == null) {
			dao = new AfterSaleComeRecordDAO();
		}
		return dao;
	}

	public List<AfterSaleComeRecord> list() {
		String sql = "select * from t_after_sale_come_record order by courierNum ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class);
		return objs;
	}
	public List<AfterSaleComeRecord> list(String courierNum) {
		String sql = "select * from t_after_sale_come_record where courierNum=? ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class,courierNum);
		return objs;
	}
	public List<AfterSaleComeRecord> list(int index, int pagesize) {
		String sql = "select * from t_after_sale_come_record order by id desc limit ?, ? ";
		List<AfterSaleComeRecord> objs = JDBCUtil.queryObjectList(sql, AfterSaleComeRecord.class, index, pagesize);
		return objs;
	}
	//总数
	public long listCount() {
		String sql = "select count(courierNum) from t_after_sale_come_record";
		return JDBCUtil.queryCount(sql);
	}
	
	public AfterSaleComeRecord load(int id) {
		String sql = "select * from t_after_sale_come_record where id=?";
		return JDBCUtil.queryObject(sql, AfterSaleComeRecord.class, id);
	}
	
	public List<AfterSaleComeRecord> search(String courierNum,String expressName,String shopName,String goodsName,String orderNum,String phoneNum,int index, int pagesize ) {
		String sql = "select * from t_after_sale_come_record where 1=1 ";
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
		sql = sql+"order by id desc limit ?, ? ";
		list.add(index);
		list.add(pagesize);
		@SuppressWarnings("unchecked")
		List<AfterSaleComeRecord> objs = JDBCUtil.searchList(sql, AfterSaleComeRecord.class,list);
		return objs;
	}

	public long searchCount(String courierNum, String expressName, String shopName, String goodsName, String orderNum,String phoneNum) {
		String sql = "select count(courierNum) from t_after_sale_come_record where 1=1 ";
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
