package base.api;

/**
 * 售后收货记录
 * @author zqmao
 *
 */
public class AfterSaleComeRecord {
	
	private String courierNum;//快递单号
	private String goodsName;//物品名称
	private String checkResult;//检测结果
	private String wangwang;//用户旺旺
	private String phoneNum;//手机号
	private String orderNum;//订单号
	private int creatorId;//创建者
	private long createTime;//创建时间
	private String remark;//备注
	private int status;//处理状态
	
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
