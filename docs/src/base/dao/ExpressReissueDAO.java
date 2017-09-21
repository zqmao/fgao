package base.dao;

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
	public ExpressReissue list(String orderNum) {
		String sql = "select * from t_express_reissue where orderNum=? ";
		ExpressReissue objs = JDBCUtil.queryObject(sql, ExpressReissue.class,orderNum);
		return objs;
	}
	public List<ExpressReissue> list(int index, int pagesize) {
		String sql = "select * from t_express_reissue order by id desc limit ?, ? ";
		List<ExpressReissue> objs = JDBCUtil.queryObjectList(sql, ExpressReissue.class, index, pagesize);
		return objs;
	}
	public ExpressReissue export(int id) {
		String sql = "select * from t_express_reissue where id=? ";
		ExpressReissue objs = JDBCUtil.queryObject(sql, ExpressReissue.class, id);
		return objs;
	}
	
}
