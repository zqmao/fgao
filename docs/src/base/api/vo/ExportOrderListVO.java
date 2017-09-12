package base.api.vo;

import base.api.ExportOrderList;
import base.api.User;
import base.dao.UserDAO;
import base.util.DateUtil;

/**
 * @author lcc
 *导入Excel数据的类
 */
public class ExportOrderListVO {
	
	private int id;//数据库主键
	private String orderNum;//订单编号
//	private String courierNum;//快递单号 
	private String wangwang;//用户旺旺
	private String alipayNum;//支付宝账号
	private String actualMoney;//实际金额
//	private String orderStatus;//订单状态
//	private String buyerMessage;//买家留言
	private String consigneeName;//收货人姓名
	private String address;//收货地址
	private String phoneNum;//手机号码
	private String orderCreateTime;//订单创建时间
	private String orderTime;//订单付款时间
	private String goodsHeadline;//宝贝标题
	/*private String expressName; //快递名称
	private String remark;//订单备注
*/	private String shopName;//店铺名称
	private String exportTime;//数据导入时间
	private String exportor;//数据导入者
	
	public ExportOrderListVO(ExportOrderList exportOrderList){
		this.id = exportOrderList.getId();
		this.orderNum = exportOrderList.getOrderNum();
		this.wangwang = exportOrderList.getWangwang();
		this.alipayNum = exportOrderList.getAlipayNum();
		this.actualMoney = exportOrderList.getActualMoney();
		this.consigneeName = exportOrderList.getConsigneeName();
		this.address = exportOrderList.getAddress();
		this.phoneNum = exportOrderList.getPhoneNum();
		this.orderCreateTime = exportOrderList.getOrderCreateTime();
		this.orderTime = exportOrderList.getOrderTime();
		this.goodsHeadline = exportOrderList.getGoodsHeadline();
		this.shopName = exportOrderList.getShopName();
		this.exportTime = exportOrderList.getExportTime()!=0 ? DateUtil.toString(exportOrderList.getExportTime()):"";
		User user = UserDAO.getInstance().load(exportOrderList.getExportor());
		this.exportor = user!=null ? user.getName():"";
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getWangwang() {
		return wangwang;
	}
	public void setWangwang(String wangwang) {
		this.wangwang = wangwang;
	}
	public String getAlipayNum() {
		return alipayNum;
	}
	public void setAlipayNum(String alipayNum) {
		this.alipayNum = alipayNum;
	}
	public String getActualMoney() {
		return actualMoney;
	}
	public void setActualMoney(String actualMoney) {
		this.actualMoney = actualMoney;
	}

	public String getConsigneeName() {
		return consigneeName;
	}
	public void setConsigneeName(String consigneeName) {
		this.consigneeName = consigneeName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getGoodsHeadline() {
		return goodsHeadline;
	}
	public void setGoodsHeadline(String goodsHeadline) {
		this.goodsHeadline = goodsHeadline;
	}

	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getExportTime() {
		return exportTime;
	}

	public void setExportTime(String exportTime) {
		this.exportTime = exportTime;
	}

	public String getExportor() {
		return exportor;
	}

	public void setExportor(String exportor) {
		this.exportor = exportor;
	}

	public String getOrderCreateTime() {
		return orderCreateTime;
	}

	public void setOrderCreateTime(String orderCreateTime) {
		this.orderCreateTime = orderCreateTime;
	}
	
	
	

}
