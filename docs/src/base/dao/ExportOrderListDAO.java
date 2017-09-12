package base.dao;

import java.util.List;

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
	public List<ExportOrderList> list() {
		String sql = "select * from t_export_order_list order by courierNum ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class);
		return objs;
	}
	public List<ExportOrderList> list(String courierNum) {
		String sql = "select * from t_export_order_list where courierNum=? ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class,courierNum);
		return objs;
	}
	public List<ExportOrderList> list(int index, int pagesize) {
		String sql = "select * from t_export_order_list order by id desc limit ?, ? ";
		List<ExportOrderList> objs = JDBCUtil.queryObjectList(sql, ExportOrderList.class, index, pagesize);
		return objs;
	}

}
