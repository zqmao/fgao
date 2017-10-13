package base.api.vo;

import base.api.DrawBill;
import base.api.User;
import base.dao.UserDAO;
import base.util.DateUtil;

/**
 * 发票记录
 * @author lcc
 *
 */
public class DrawBillVO {
	private int id;//数据库主键
	private String creatorId;//登记人
	private String entryTime;//登记时间
	private String money;//金额;
	private String sum;//数量;
	
	private String shopName;//店铺名称
	private String goodsName;//开票明细
	private String orderNum;//订单号
	private String billHead;//发票抬头;
	private String tfn;//税号;
	private String emailOrPhone;//邮箱或者手机号;
	private String remark;//备注
	private String Drawingor;//开票人员
	private String billTime;//开票时间
	private String status;//处理状态:1已处理；0未处理
	
	public DrawBillVO(DrawBill drawBill){
		this.id = drawBill.getId();
		User user = UserDAO.getInstance().load(drawBill.getCreatorId());
		this.creatorId = user != null ? user.getName() : "";
		this.entryTime = drawBill.getEntryTime() !=0 ? DateUtil.toString(drawBill.getEntryTime()) : "";
		this.money = drawBill.getMoney();
		this.sum = drawBill.getSum();
		this.shopName = drawBill.getShopName();
		this.goodsName = drawBill.getGoodsName();
		this.orderNum = drawBill.getOrderNum();
		this.billHead = drawBill.getBillHead();
		this.tfn = drawBill.getTfn();
		this.emailOrPhone = drawBill.getEmailOrPhone();
		this.remark = drawBill.getRemark();
		user = UserDAO.getInstance().load(drawBill.getDrawingor());
		this.Drawingor = user != null ? user.getName() : "";
		this.billTime = drawBill.getBillTime() != 0 ? DateUtil.toString(drawBill.getBillTime()) : "";
		this.status = drawBill.getStatus() == 1 ? "已处理" : "未处理";
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}
	public String getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(String entryTime) {
		this.entryTime = entryTime;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getSum() {
		return sum;
	}
	public void setSum(String sum) {
		this.sum = sum;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getBillHead() {
		return billHead;
	}
	public void setBillHead(String billHead) {
		this.billHead = billHead;
	}
	public String getTfn() {
		return tfn;
	}
	public void setTfn(String tfn) {
		this.tfn = tfn;
	}
	public String getEmailOrPhone() {
		return emailOrPhone;
	}
	public void setEmailOrPhone(String emailOrPhone) {
		this.emailOrPhone = emailOrPhone;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDrawingor() {
		return Drawingor;
	}
	public void setDrawingor(String drawingor) {
		Drawingor = drawingor;
	}
	
	public String getBillTime() {
		return billTime;
	}

	public void setBillTime(String billTime) {
		this.billTime = billTime;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	

}
