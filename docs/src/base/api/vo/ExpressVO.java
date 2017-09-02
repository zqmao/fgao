package base.api.vo;

import base.api.Express;

public class ExpressVO {
	private int id;//id
	private String expressName;//快递名称
	
	public ExpressVO(Express express){
		this.id = express.getId();
		this.expressName = express.getExpressName();
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getExpressName() {
		return expressName;
	}
	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}
	
}
