package base.api;

/**
 * 售前记录
 * @author Administrator
 *
 */
public class PreSaleRecord {
	
	private int id;//关键字
	private String orderNum;//订单号
	private String wangWang;//订单表数据太多，单独存一份
	private long orderCreateTime;
	private long orderPayTime;
	private int doneOrderUserId;//落实下单的售前人员
	private int donePayUserId;//落实付款的售前人员
	private String remark;//备注
	private String couponQuota;//优惠券金额
	private String praiseMoney;//好评返现
	private String differenceMoney;//返差价
	private int importUserId;//导入人员
	private long importTime;//导入时间
	private String returnMoney;//退款金额
	private String specialExpress;//特殊快递
	private String specialGift;//特殊礼物
	private String selfCheckRemark;//自审备注
	private int selfCheck;//自审 0未审核；1自审完成
	private String financeCheckRemark;//财审备注
	private int financeCheck;//财审 0未审核；1审核通过；2审核未通过
	private int isVirtual;//是否刷单
	private int selfCheckUserId;//自审人员id
	private long selfCheckTime;//自审时间
	private int financeCheckUserId;//财审人员id
	private long financeCheckTime;//财审时间
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getWangWang() {
		return wangWang;
	}
	public void setWangWang(String wangWang) {
		this.wangWang = wangWang;
	}
	public long getOrderCreateTime() {
		return orderCreateTime;
	}
	public void setOrderCreateTime(long orderCreateTime) {
		this.orderCreateTime = orderCreateTime;
	}
	public long getOrderPayTime() {
		return orderPayTime;
	}
	public void setOrderPayTime(long orderPayTime) {
		this.orderPayTime = orderPayTime;
	}
	public int getDoneOrderUserId() {
		return doneOrderUserId;
	}
	public void setDoneOrderUserId(int doneOrderUserId) {
		this.doneOrderUserId = doneOrderUserId;
	}
	public int getDonePayUserId() {
		return donePayUserId;
	}
	public void setDonePayUserId(int donePayUserId) {
		this.donePayUserId = donePayUserId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCouponQuota() {
		return couponQuota;
	}
	public void setCouponQuota(String couponQuota) {
		this.couponQuota = couponQuota;
	}
	public String getPraiseMoney() {
		return praiseMoney;
	}
	public void setPraiseMoney(String praiseMoney) {
		this.praiseMoney = praiseMoney;
	}
	public String getDifferenceMoney() {
		return differenceMoney;
	}
	public void setDifferenceMoney(String differenceMoney) {
		this.differenceMoney = differenceMoney;
	}
	public int getImportUserId() {
		return importUserId;
	}
	public void setImportUserId(int importUserId) {
		this.importUserId = importUserId;
	}
	public long getImportTime() {
		return importTime;
	}
	public void setImportTime(long importTime) {
		this.importTime = importTime;
	}
	public String getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(String returnMoney) {
		this.returnMoney = returnMoney;
	}
	public String getSpecialExpress() {
		return specialExpress;
	}
	public void setSpecialExpress(String specialExpress) {
		this.specialExpress = specialExpress;
	}
	public String getSpecialGift() {
		return specialGift;
	}
	public void setSpecialGift(String specialGift) {
		this.specialGift = specialGift;
	}
	public String getSelfCheckRemark() {
		return selfCheckRemark;
	}
	public void setSelfCheckRemark(String selfCheckRemark) {
		this.selfCheckRemark = selfCheckRemark;
	}
	public int getSelfCheck() {
		return selfCheck;
	}
	public void setSelfCheck(int selfCheck) {
		this.selfCheck = selfCheck;
	}
	public String getFinanceCheckRemark() {
		return financeCheckRemark;
	}
	public void setFinanceCheckRemark(String financeCheckRemark) {
		this.financeCheckRemark = financeCheckRemark;
	}
	public int getFinanceCheck() {
		return financeCheck;
	}
	public void setFinanceCheck(int financeCheck) {
		this.financeCheck = financeCheck;
	}
	public int getIsVirtual() {
		return isVirtual;
	}
	public void setIsVirtual(int isVirtual) {
		this.isVirtual = isVirtual;
	}
	public int getSelfCheckUserId() {
		return selfCheckUserId;
	}
	public void setSelfCheckUserId(int selfCheckUserId) {
		this.selfCheckUserId = selfCheckUserId;
	}
	public long getSelfCheckTime() {
		return selfCheckTime;
	}
	public void setSelfCheckTime(long selfCheckTime) {
		this.selfCheckTime = selfCheckTime;
	}
	public int getFinanceCheckUserId() {
		return financeCheckUserId;
	}
	public void setFinanceCheckUserId(int financeCheckUserId) {
		this.financeCheckUserId = financeCheckUserId;
	}
	public long getFinanceCheckTime() {
		return financeCheckTime;
	}
	public void setFinanceCheckTime(long financeCheckTime) {
		this.financeCheckTime = financeCheckTime;
	}
	
}
