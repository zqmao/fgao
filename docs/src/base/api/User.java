package base.api;

/**
 * 人员数据库类
 * @author zqmao
 */
public class User {
	
	private int id;
	private int deptId;
	private String name;
	private String loginName;
	private String password;
	private String phone;
	private String info;
	
	private int admin;//默认0，非管理员
	private int inGoods;
	private int outGoods;
	private int coupon;//是否有设置优惠券的权限
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDeptId() {
		return deptId;
	}
	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public int getInGoods() {
		return inGoods;
	}
	public void setInGoods(int inGoods) {
		this.inGoods = inGoods;
	}
	public int getOutGoods() {
		return outGoods;
	}
	public void setOutGoods(int outGoods) {
		this.outGoods = outGoods;
	}
	public int getCoupon() {
		return coupon;
	}
	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}
}
