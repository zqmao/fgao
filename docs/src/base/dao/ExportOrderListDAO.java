package base.dao;

import java.util.List;

import base.api.AfterSaleComeRecord;
import base.api.ExportOrderList;
import base.api.ExpressReissue;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

/**
 * @author lcc
 *导入Excel数据的类
 */
public class ExportOrderListDAO extends BaseDAO<ExportOrderList>{
	private static ExportOrderListDAO dao;
	private ExportOrderListDAO(){
		super("t_export_order_list");
	}
	public static ExportOrderListDAO getInstance(){
		if(dao==null){
			dao = new ExportOrderListDAO(); 
		}
		return dao;
	}
	public long count(String allSearch){
		String sql = "select count(id) from t_export_order_list where orderNum=? or shopName=? or wangwang=? or address like ? or phoneNum=? or goodsHeadline like ? or alipayNum=? or consigneeName=? ";
		return JDBCUtil.queryCount(sql, allSearch,allSearch,allSearch,"%"+allSearch+"%",allSearch,"%"+allSearch+"%",allSearch,allSearch);
	}
	public List<ExportOrderList> list(String allSearch,int index, int pagesize ) {
		String sql = "select * from t_export_order_list where orderNum=? or shopName=? or wangwang=? or address like ? or phoneNum=? or goodsHeadline like ? or alipayNum=? or consigneeName=? order by id desc limit ?, ?";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class,allSearch,allSearch,allSearch,"%"+allSearch+"%",allSearch,"%"+allSearch+"%",allSearch,allSearch,index,pagesize);
		return objs;
	}
	public List<ExportOrderList> list() {
		String sql = "select * from t_export_order_list order by id ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class);
		return objs;
	}
	public List<ExportOrderList> list(String courierNum) {
		String sql = "select * from t_export_order_list where courierNum=? ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class,courierNum);
		return objs;
	}
	public List<ExportOrderList> listALL(String allSearch) {
		String sql = "select * from t_export_order_list where orderNum=? or shopName=? or wangwang=? or address=? or phoneNum=? or goodsHeadline=? or alipayNum=? or consigneeName=? order by id ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch);
		return objs;
	}
	public long countALL(String allSearch){
		String sql = "select count(id) from t_export_order_list where orderNum=? or shopName=? or wangwang=? or address=? or phoneNum=? or goodsHeadline=? or alipayNum=? or consigneeName=? ";
		return JDBCUtil.queryCount(sql, allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch,allSearch);
	}
	public List<ExportOrderList> list(int index, int pagesize) {
		String sql = "select * from t_export_order_list order by id desc limit ?, ? ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class, index, pagesize);
		return objs;
	}
	public ExportOrderList query(String orderNum) {
		String sql = "select * from t_export_order_list where orderNum=? ";
		return JDBCUtil.queryObject(sql, ExportOrderList.class, orderNum);
	}
	public long exportCount(String orderNumE){
		String sql = "select count(id) from t_export_order_list where orderNum=? ";
		return JDBCUtil.queryCount(sql, orderNumE);
	}
	public List<ExportOrderList> exportList(String orderNumE) {
		String sql = "select * from t_export_order_list where orderNum=? ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class,orderNumE);
		return objs;
	}
	

}
