package base.api.vo;

import base.api.Goods;
import base.api.Shop;
import base.dao.GoodsInDAO;
import base.dao.ShopDAO;

/*
 * 货物类
 */
public class GoodsVO {
	
	private int id;
	private int shopId;
	private String tid;
	private String imgLink;
	private String title;
	private String name;
	private String stock;
	private String crisisCount;
	private String bm;
	private String specName;
	private String status;
	private String shopName;
	
	public GoodsVO(Goods goods){
		this.id = goods.getId();
		this.name = goods.getName();
		
		this.stock = "" + goods.getStock();
		this.crisisCount = "" + goods.getCrisisCount();
		this.bm = goods.getBm();
		this.specName = goods.getSpecName();
		if(goods.getStatus() > 0){
			this.status = "可用";
		}else{
			this.status = "不可用";
		}
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
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStock() {
		return stock;
	}
	public void setStock(String stock) {
		this.stock = stock;
	}

	public String getCrisisCount() {
		return crisisCount;
	}

	public void setCrisisCount(String crisisCount) {
		this.crisisCount = crisisCount;
	}

	public String getBm() {
		return bm;
	}

	public void setBm(String bm) {
		this.bm = bm;
	}

	public String getSpecName() {
		return specName;
	}

	public void setSpecName(String specName) {
		this.specName = specName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

}
