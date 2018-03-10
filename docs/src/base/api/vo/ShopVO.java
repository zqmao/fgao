package base.api.vo;

import base.api.Shop;

/*
 * 店铺类
 */
public class ShopVO {
	
	private int id;
	private String shopName;
	private String remark;
	
	public ShopVO(Shop shop){
		
		this.id = shop.getId();
		this.shopName = shop.getShopName();
		this.remark = shop.getRemark();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
