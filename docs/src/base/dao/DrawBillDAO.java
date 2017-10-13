package base.dao;

import java.util.List;
import base.api.DrawBill;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;

public class DrawBillDAO extends BaseDAO<DrawBill>{
	private static DrawBillDAO dao;
	private DrawBillDAO(){
		super("t_draw_bill");
	}
	public static DrawBillDAO getInstance(){
		if(dao==null){
			dao =new DrawBillDAO();
		}
		return dao;
	}
	public List<DrawBill> list() {
		String sql = "select * from t_draw_bill order by courierNum ";
		List<DrawBill> objs = JDBCUtil.queryObjectList(sql, DrawBill.class);
		return objs;
	}
	public DrawBill list(String orderNum) {
		String sql = "select * from t_draw_bill where orderNum=? ";
		DrawBill objs = JDBCUtil.queryObject(sql, DrawBill.class,orderNum);
		return objs;
	}
	public List<DrawBill> list(int index, int pagesize) {
		String sql = "select * from t_draw_bill order by id desc limit ?, ? ";
		List<DrawBill> objs = JDBCUtil.queryObjectList(sql, DrawBill.class, index, pagesize);
		return objs;
	}
	public DrawBill export(int id) {
		String sql = "select * from t_draw_bill where id=? ";
		DrawBill objs = JDBCUtil.queryObject(sql, DrawBill.class, id);
		return objs;
	}
	public long checkNum(String orderNum){
		String sql = "select count(*) from t_draw_bill where orderNum=? ";
		return JDBCUtil.queryCount(sql, orderNum); 
	}
	
}
