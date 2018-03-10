package base.api.vo;

import base.api.GoodsLink;
import base.api.Shop;
import base.dao.ShopDAO;

public class GoodsLinkVO {
	
	private int id;
	private int shopId;
	private String shopName;
	private String tid;
	
	private String imgLink;
	private String title;
	private String info;

	public GoodsLinkVO(GoodsLink goods){
		this.id = goods.getId();
		this.shopId     = goods.getShopId();
		
		Shop shop   = ShopDAO.getInstance().load(goods.getShopId());
		if(shop != null){
			this.shopName = shop.getShopName();
		}else{
			this.shopName = "----";
		}
		this.tid     = goods.getTid();
		this.imgLink = goods.getImgLink();
		this.title   = goods.getTitle();
		this.info = goods.getInfo();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getShopId() {
		return shopId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

}
