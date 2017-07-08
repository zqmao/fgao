package base.api.vo;

import base.api.Goods;
import base.dao.GoodsInDAO;

/*
 * 货物类
 */
public class GoodsVO {
	
	private int id;
	private String name;
	private String stock;
	private String crisisCount;
	
	public GoodsVO(Goods goods){
		this.id = goods.getId();
		this.name = goods.getName();
		if(goods.getStock() <= goods.getCrisisCount()){
			if(GoodsInDAO.getInstance().goodsIng(id)){
				this.stock = goods.getStock()+ " (正在进货中)";
			}else{
				this.stock = goods.getStock()+ " (急需进货)";
			}
		}else{
			this.stock = "" + goods.getStock();
		}
		this.crisisCount = "" + goods.getCrisisCount();
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

}
