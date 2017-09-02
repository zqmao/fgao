package base.api;

/**
 * 是一个快递的类
 * @author lcc
 *
 */
public class Express {
	private int id;//id
	private String expressName;//快递名称
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
