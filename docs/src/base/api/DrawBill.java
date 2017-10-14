package base.api;

/**
 * 发票登记
 * @author lcc
 *
 */
public class DrawBill {
	private int id;//数据库主键
	private int creatorId;//登记人
	private long entryTime;//登记时间
	private String money;//金额;
	private String sum;//数量;
	
	private String shopName;//店铺名称
	private String goodsName;//开票明细
	private String orderNum;//订单号
	private String billHead;//发票抬头;
	private String tfn;//税号;
	private String emailOrPhone;//邮箱或者手机号;
	private String remark;//备注
	private int Drawingor;//开票人员
	private long billTime;//开票时间
	private String billRemark;//开票备注;
	private int status;//处理状态:1已处理；0未处理
	
	
	public String getBillRemark() {
		return billRemark;
	}
	public void setBillRemark(String billRemark) {
		this.billRemark = billRemark;
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(int creatorId) {
		this.creatorId = creatorId;
	}
	public long getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(long entryTime) {
		this.entryTime = entryTime;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getDrawingor() {
		return Drawingor;
	}
	public void setDrawingor(int drawingor) {
		Drawingor = drawingor;
	}
	
	public long getBillTime() {
		return billTime;
	}
	public void setBillTime(long billTime) {
		this.billTime = billTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
