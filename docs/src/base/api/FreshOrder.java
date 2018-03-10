package base.api;

/*
 * 刷单
 */
public class FreshOrder {
	
	private int id;
	private String goodsId;
	private int createUser;
	private int shopId;
	private String orderSn;
	private String keyWords;
	private String keyImage;
	private String contractType;
	private String contractAccount;
	private String commision;
	private String orderAmount;
	private int isPay;
	private String payType;
	private String payAccount;
	private String payName;
	private String remark;
	private String payRemark;
	private long createAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCreateUser() {
		return createUser;
	}
	public void setCreateUser(int createUser) {
		this.createUser = createUser;
	}
	public int getShopId() {
		return shopId;
	}
	public void setShopId(int shopId) {
		this.shopId = shopId;
	}
	public String getOrderSn() {
		return orderSn;
	}
	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	public String getContractType() {
		return contractType;
	}
	public void setContractType(String contractType) {
		this.contractType = contractType;
	}
	public String getContractAccount() {
		return contractAccount;
	}
	public void setContractAccount(String contractAccount) {
		this.contractAccount = contractAccount;
	}
	public String getCommision() {
		return commision;
	}
	public void setCommision(String commision) {
		this.commision = commision;
	}
	public String getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(String orderAmount) {
		this.orderAmount = orderAmount;
	}
	public int getIsPay() {
		return isPay;
	}
	public void setIsPay(int isPay) {
		this.isPay = isPay;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getPayAccount() {
		return payAccount;
	}
	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}
	public String getPayName() {
		return payName;
	}
	public void setPayName(String payName) {
		this.payName = payName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String reamrk) {
		this.remark = reamrk;
	}
	public String getPayRemark() {
		return payRemark;
	}
	public void setPayRemark(String payRemark) {
		this.payRemark = payRemark;
	}
	public long getCreateAt() {
		return createAt;
	}
	public void setCreateAt(long createAt) {
		this.createAt = createAt;
	}
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public String getKeyImage() {
		return keyImage;
	}
	public void setKeyImage(String keyImage) {
		this.keyImage = keyImage;
	}
}
