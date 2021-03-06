package base.api.vo;

import base.api.AfterSaleComeRecord;
import base.api.ExportOrderList;
import base.api.User;
import base.dao.ExportOrderListDAO;
import base.dao.UserDAO;
import base.util.DateUtil;

/**
 * 售后收货记录View层
 * @author Administrator
 *
 */
public class AfterSaleComeRecordVO {
	
	private int id;//数据库主键
	private String courierNum;//快递单号
	private String expressName;//快递名称
	private String shopName;//商店名称
	private String goodsName;//物品名称
	private String checkResult;//检测结果
	
	private String phoneNum;//手机号
	private String orderNum;//订单号
	private String afterSaTor;//售后人员
	private String creator;//创建者
	private String unpackor;//拆包人员
	private String createTime;//创建时间
	private String entryTime;//录入时间
	private String remark;//备注
	//private String status;//处理状态
	
	private String bounceType;//退件类型
	
	private String wangwang;
	
	/*private String reissueCourierNum;//补发快递单号
	private String reissueExpressName;//补发快递名称
	private String reissueGoodsName;//补发物品名称
	private String reissueAddress;//补发地址
*/	
	
	public AfterSaleComeRecordVO(AfterSaleComeRecord afterSaleComeRecord){
		this.id = afterSaleComeRecord.getId();
		this.courierNum = afterSaleComeRecord.getCourierNum();
		this.expressName = afterSaleComeRecord.getExpressName();
		this.shopName = afterSaleComeRecord.getShopName();
		this.goodsName = afterSaleComeRecord.getGoodsName();
		
		this.checkResult = afterSaleComeRecord.getCheckResult();

		this.phoneNum = afterSaleComeRecord.getPhoneNum();
		this.orderNum = afterSaleComeRecord.getOrderNum();
		this.afterSaTor = afterSaleComeRecord.getAfterSaTor();
		User user = UserDAO.getInstance().load(afterSaleComeRecord.getCreatorId());
		this.creator = user != null ? user.getName() : "";
		this.createTime = afterSaleComeRecord.getCreateTime()!= 0 ? DateUtil.toString(afterSaleComeRecord.getCreateTime()):"";
		this.entryTime = afterSaleComeRecord.getEntryTime()!=0 ? DateUtil.toString(afterSaleComeRecord.getEntryTime()):"";
		this.remark = afterSaleComeRecord.getRemark()!=null ? afterSaleComeRecord.getRemark():" ";
		//this.status = afterSaleComeRecord.getStatus() == 1 ? "已处理" : "待处理";
		user = UserDAO.getInstance().load(afterSaleComeRecord.getUnpackId());
		this.unpackor = user != null ? user.getName() : "";
		this.bounceType = afterSaleComeRecord.getBounceType();
		//this.wangwang = afterSaleComeRecord.getWangwang();
		
		if(null == orderNum){
			this.wangwang = "未知";
		}else{
			ExportOrderList order = ExportOrderListDAO.getInstance().query(orderNum);
			if(null != order){
				this.wangwang = order.getWangwang();
			}else{
				this.wangwang = "未知";
			}
		}
	}
	
	public String getAfterSaTor() {
		return afterSaTor;
	}

	public void setAfterSaTor(String afterSaTor) {
		this.afterSaTor = afterSaTor;
	}

	public String getUnpackor() {
		return unpackor;
	}

	public void setUnpackor(String unpackor) {
		this.unpackor = unpackor;
	}

	public String getBounceType() {
		return bounceType;
	}

	public void setBounceType(String bounceType) {
		this.bounceType = bounceType;
	}

	public String getEntryTime() {
		return entryTime;
	}

	public void setEntryTime(String entryTime) {
		this.entryTime = entryTime;
	}

	public String getExpressName() {
		return expressName;
	}

	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCourierNum() {
		return courierNum;
	}

	public void setCourierNum(String courierNum) {
		this.courierNum = courierNum;
	}
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	

	

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getWangwang() {
		return wangwang;
	}

	public void setWangwang(String wangwang) {
		this.wangwang = wangwang;
	}

}
