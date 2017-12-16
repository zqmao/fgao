package base.dao;

import java.util.List;

import base.api.AfterSaleComeRecord;
import base.api.PreSaleRecord;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;
import base.util.DateUtil;
import base.dao.core.BaseDAO.QueryBuilder;

public class PreSaleRecordDAO extends BaseDAO<PreSaleRecord>{

	private static PreSaleRecordDAO dao;
	
	private PreSaleRecordDAO() {
		super("t_pre_sale_record");
	}
	
	public static PreSaleRecordDAO getInstance() {
		if (dao == null) {
			dao = new PreSaleRecordDAO();
		}
		return dao;
	}
	
	public List<PreSaleRecord> list(int userId, String status, String orderNum, String orderCreateStartTime, String orderCreateEndTime, 
			String orderPayStartTime, String orderPayEndTime, int index, int pagesize) {
		BaseDAO<PreSaleRecord>.QueryBuilder builder = new QueryBuilder();
		if (orderNum != null && orderNum.length() != 0) {
			builder.eq("orderNum", orderNum);
		}
		if (status != null && status.length() != 0) {
			builder.eq("selfCheck", status);
		}
		if (userId != 0) {
			builder.or("doneOrderUserId", userId);
			builder.or("donePayUserId", userId);
		}
		if(orderCreateStartTime != null && orderCreateStartTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderCreateStartTime);
			builder.gt("orderCreateTime", time);
		}
		if(orderCreateEndTime != null && orderCreateEndTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderCreateEndTime);
			builder.lt("orderCreateTime", time);
		}
		if(orderPayStartTime != null && orderPayStartTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderPayStartTime);
			builder.gt("orderPayTime", time);
		}
		if(orderPayEndTime != null && orderPayEndTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderPayEndTime);
			builder.lt("orderPayTime", time);
		}
		builder.orderBy("id", true);
		builder.limit(index, pagesize);
		return builder.queryList();
	}
	
	public long listCount(int userId, String status, String orderNum, String orderCreateStartTime, String orderCreateEndTime, String orderPayStartTime, String orderPayEndTime) {
		BaseDAO<PreSaleRecord>.QueryBuilder builder = new QueryBuilder();
		if (orderNum != null && orderNum.length() != 0) {
			builder.eq("orderNum", orderNum);
		}
		if (status != null && status.length() != 0) {
			builder.eq("selfCheck", status);
		}
		if (userId != 0) {
			builder.or("doneOrderUserId", userId);
			builder.or("donePayUserId", userId);
		}
		if(orderCreateStartTime != null && orderCreateStartTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderCreateStartTime);
			builder.gt("orderCreateTime", time);
		}
		if(orderCreateEndTime != null && orderCreateEndTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderCreateEndTime);
			builder.lt("orderCreateTime", time);
		}
		if(orderPayStartTime != null && orderPayStartTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderPayStartTime);
			builder.gt("orderPayTime", time);
		}
		if(orderPayEndTime != null && orderPayEndTime.length() > 0){
			long time = DateUtil.getTimeInMillis(orderPayEndTime);
			builder.lt("orderPayTime", time);
		}
		return builder.queryCount();
	}

}
