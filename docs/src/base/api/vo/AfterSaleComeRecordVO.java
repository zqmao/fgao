package base.api.vo;

import base.api.AfterSaleComeRecord;
import base.api.User;
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
	private String wangwang;//用户旺旺
	private String phoneNum;//手机号
	private String orderNum;//订单号
	private String creator;//创建者
	private String createTime;//创建时间
	private String remark;//备注
	private String status;//处理状态
	
	public AfterSaleComeRecordVO(AfterSaleComeRecord afterSaleComeRecord){
		this.id = afterSaleComeRecord.getId();
		this.courierNum = afterSaleComeRecord.getCourierNum();
		this.expressName = afterSaleComeRecord.getExpressName();
		this.shopName = afterSaleComeRecord.getShopName();
		this.goodsName = afterSaleComeRecord.getGoodsName();
		this.checkResult = afterSaleComeRecord.getCheckResult();
		this.wangwang = afterSaleComeRecord.getWangwang();
		this.phoneNum = afterSaleComeRecord.getPhoneNum();
		this.orderNum = afterSaleComeRecord.getOrderNum();
		User user = UserDAO.getInstance().load(afterSaleComeRecord.getCreatorId());
		this.creator = user != null ? user.getName() : "";
		this.createTime = DateUtil.toString(afterSaleComeRecord.getCreateTime());
		this.remark = afterSaleComeRecord.getRemark();
		this.status = afterSaleComeRecord.getStatus() == 1 ? "已处理" : "待处理";
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

	public String getWangwang() {
		return wangwang;
	}

	public void setWangwang(String wangwang) {
		this.wangwang = wangwang;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
