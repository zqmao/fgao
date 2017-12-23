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
	private int incumbency;//1是在职，0是离职
	
	private int admin;//默认0，非管理员
	private int inGoods;
	private int outGoods;
	private int coupon;//是否有设置优惠券的权限
	private int after;//是否有操作售后记录的权限
	private int export;//是否有导入csv文件的权限
	private int editor;//是否有编辑知识库的权限
	private int drawBill;//是否有开发票的权限
	private int importPreSale;//是否具有导入售前记录的权限
	private int exportPreSale;//是否具有导出售前记录的权限
	private int finance;//是否是财务
	private int instead;//是否有代自审权限
	
	
	public int getDrawBill() {
		return drawBill;
	}
	public void setDrawBill(int drawBill) {
		this.drawBill = drawBill;
	}
	public int getExport() {
		return export;
	}
	public void setExport(int export) {
		this.export = export;
	}
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
	
	public int getIncumbency() {
		return incumbency;
	}
	public void setIncumbency(int incumbency) {
		this.incumbency = incumbency;
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
	public int getAfter() {
		return after;
	}
	public void setAfter(int after) {
		this.after = after;
	}
	public int getEditor() {
		return editor;
	}
	public void setEditor(int editor) {
		this.editor = editor;
	}
	public int getImportPreSale() {
		return importPreSale;
	}
	public void setImportPreSale(int importPreSale) {
		this.importPreSale = importPreSale;
	}
	public int getExportPreSale() {
		return exportPreSale;
	}
	public void setExportPreSale(int exportPreSale) {
		this.exportPreSale = exportPreSale;
	}
	public int getFinance() {
		return finance;
	}
	public void setFinance(int finance) {
		this.finance = finance;
	}
	public int getInstead() {
		return instead;
	}
	public void setInstead(int instead) {
		this.instead = instead;
	}
	
}
