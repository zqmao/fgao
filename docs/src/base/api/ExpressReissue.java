package base.api;

/**
 * 售后补发记录
 * @author lcc
 *
 */
public class ExpressReissue {
	private int id;//数据库主键
	private int creatorId;//登记人
	private long entryTime;//登记时间
	private String address;//补发地址
	private String shopName;//店铺名
	private String goodsName;//补发物品
	private String orderNum;//订单号
	private String wangwang;//用户旺旺
	private String remark;//备注
	private int issueDocumentor;//打单人员
	private String expressName;//快递名称
	private String courierNum;//快递单号
	private long issuTime;//打单时间
	private String issuRemark;//打单备注
	private int status;//处理状态:1已处理；0未处理
	private String afterSaTor;//售后人员
	
	public String getAfterSaTor() {
		return afterSaTor;
	}
	public void setAfterSaTor(String afterSaTor) {
		this.afterSaTor = afterSaTor;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public String getWangwang() {
		return wangwang;
	}
	public void setWangwang(String wangwang) {
		this.wangwang = wangwang;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getIssueDocumentor() {
		return issueDocumentor;
	}
	public void setIssueDocumentor(int issueDocumentor) {
		this.issueDocumentor = issueDocumentor;
	}
	public String getExpressName() {
		return expressName;
	}
	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}
	public String getCourierNum() {
		return courierNum;
	}
	public void setCourierNum(String courierNum) {
		this.courierNum = courierNum;
	}
	public long getIssuTime() {
		return issuTime;
	}
	public void setIssuTime(long issuTime) {
		this.issuTime = issuTime;
	}
	public String getIssuRemark() {
		return issuRemark;
	}
	public void setIssuRemark(String issuRemark) {
		this.issuRemark = issuRemark;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	

}
