package base.api;

/**
 * 售后收货记录
 * @author zqmao
 *
 */
public class AfterSaleComeRecord {
	
	private int id;//数据库主键
	private String courierNum;//快递单号
	private String expressName;//快递名称
	private String shopName;//商店名称
	private String goodsName;//物品名称
	private String checkResult;//检测结果
	private String phoneNum;//手机号
	private String orderNum;//订单号
	private String afterSaTor;//售后人员
	private int creatorId;//创建者
	private int unpackId;//拆包人员
	private long createTime;//创建时间
	private String remark;//备注
	//private int status;//处理状态:1已处理；0未处理
	private long entryTime;//打单时间
	
	private String bounceType;//退件类型
	
	/*private String reissueCourierNum;//补发快递单号
	private String reissueExpressName;//补发快递名称
	private String reissueGoodsName;//补发物品名称
	private String reissueAddress;//补发地址
*/	
	
	public void setEntryTime(long entryTime) {
		this.entryTime = entryTime;
	}
	
	public String getAfterSaTor() {
		return afterSaTor;
	}

	public void setAfterSaTor(String afterSaTor) {
		this.afterSaTor = afterSaTor;
	}

	public int getUnpackId() {
		return unpackId;
	}

	public void setUnpackId(int unpackId) {
		this.unpackId = unpackId;
	}

	public String getBounceType() {
		return bounceType;
	}

	public void setBounceType(String bounceType) {
		this.bounceType = bounceType;
	}

	public long getEntryTime() {
		return entryTime;
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
	public int getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(int creatorId) {
		this.creatorId = creatorId;
	}
	public long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
