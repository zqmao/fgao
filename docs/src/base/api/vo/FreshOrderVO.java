package base.api.vo;

import base.api.FreshOrder;
import base.api.GoodsLink;
import base.api.Shop;
import base.api.User;
import base.dao.UserDAO;
import base.dao.GoodsLinkDAO;
import base.dao.ShopDAO;
import base.util.DateUtil;

/*
 * 刷单
 */
public class FreshOrderVO {
	
	private int id;
	private String goodsId;
	private String goodsName;
	private int createUser;
	private String createUserName;
	private int shopId;
	private String shopName;
	private String orderSn;
	private String keyWords;
	private String keyImage;
	private String contractType;
	private String contractAccount;
	private String  commision;
	private String  orderAmount;
	private int isPay;
	private String payType;
	private String payAccount;
	private String payName;
	private String remark;
	private String payRemark;
	private String createAt;
	
	public FreshOrderVO(FreshOrder freshOrder){
		this.id = freshOrder.getId();
		User user = UserDAO.getInstance().load(freshOrder.getCreateUser());
		if(user != null){
			this.setCreateUserName(user.getName());
		}else{
			this.setCreateUserName("----");
		}
		this.createUser = freshOrder.getCreateUser();
		
		Shop shop = ShopDAO.getInstance().load(freshOrder.getShopId());
		if(shop != null){
			this.shopName = shop.getShopName();
		}else{
			this.shopName = "----";
		}
		
		GoodsLink goodsLink = GoodsLinkDAO.getInstance().findByGoodsId(freshOrder.getGoodsId());
		if(goodsLink != null){
			this.goodsName = goodsLink.getTitle();
		}else{
			this.goodsName = "----";
		}
		this.shopId         = freshOrder.getShopId();
		this.goodsId         = freshOrder.getGoodsId();
		this.orderSn         = freshOrder.getOrderSn();
		this.keyWords        = freshOrder.getKeyWords();
		this.contractType    = freshOrder.getContractType();
		this.contractAccount = freshOrder.getContractAccount();
		this.commision       = freshOrder.getCommision();
		this.orderAmount     = freshOrder.getOrderAmount();
		this.isPay           = freshOrder.getIsPay();
		this.payType         = freshOrder.getPayType();
		this.payAccount      = freshOrder.getPayAccount();
		this.payName         = freshOrder.getPayName();
		this.payRemark       = freshOrder.getPayRemark();
		this.remark          = freshOrder.getRemark();
		this.createAt        = DateUtil.toString(freshOrder.getCreateAt());
		this.keyImage = freshOrder.getKeyImage();
	}
	
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

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getKeyImage() {
		return keyImage;
	}

	public void setKeyImage(String keyImage) {
		this.keyImage = keyImage;
	}

	
}
