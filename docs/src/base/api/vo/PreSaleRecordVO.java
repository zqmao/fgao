package base.api.vo;

import base.api.PreSaleRecord;
import base.api.User;
import base.dao.UserDAO;
import base.util.DateUtil;

public class PreSaleRecordVO {
	
	private int id;//关键字
	private String orderNum;//订单号
	private String doneOrderUserName;//落实下单的售前人员
	private String donePayUserName;//落实付款的售前人员
	private String remark;//备注
	private String couponQuota;//优惠券金额
	private String praiseMoney;//好评返现
	private String differenceMoney;//返差价
	private String importUserName;
	private String importTime;
	private String returnMoney;//退款金额
	private String specialExpress;//特殊快递
	private String specialGift;//特殊礼物
	private String selfCheckRemark;//自审备注
	private String selfCheck;//自审 0未审核；1自审完成
	private String financeCheckRemark;//财审备注
	private String financeCheck;//财审 0未审核；1审核通过；2审核未通过
	private String isVirtual;//是否刷单
	
	public PreSaleRecordVO(PreSaleRecord record){
		this.id = record.getId();
		this.orderNum = record.getOrderNum();
		this.remark = record.getRemark();
		this.couponQuota = record.getCouponQuota();
		this.praiseMoney = record.getPraiseMoney();
		this.differenceMoney = record.getDifferenceMoney();
		this.orderNum = record.getOrderNum();
		User doneOrderUser = UserDAO.getInstance().load(record.getDoneOrderUserId());
		User donePayUser = UserDAO.getInstance().load(record.getDonePayUserId());
		User importUser = UserDAO.getInstance().load(record.getImportUserId());
		if(doneOrderUser != null){
			this.doneOrderUserName = doneOrderUser.getName();
		}else{
			this.doneOrderUserName = "未知";
		}
		if(donePayUser != null){
			this.donePayUserName = donePayUser.getName();
		}else{
			this.donePayUserName = "未知";
		}
		if(importUser != null){
			this.importUserName = importUser.getName();
		}else{
			this.importUserName = "未知";
		}
		this.importTime = DateUtil.toString(record.getImportTime());
		this.returnMoney = record.getReturnMoney();
		this.specialExpress = record.getSpecialExpress();
		this.specialGift = record.getSpecialGift();
		this.selfCheckRemark = record.getSelfCheckRemark();
		this.selfCheck = record.getSelfCheck() + "";
		this.financeCheckRemark = record.getFinanceCheckRemark();
		this.financeCheck = record.getFinanceCheck() + "";
		this.isVirtual = record.getIsVirtual() == 1 ? "是" : "否";
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

	public String getDoneOrderUserName() {
		return doneOrderUserName;
	}

	public void setDoneOrderUserName(String doneOrderUserName) {
		this.doneOrderUserName = doneOrderUserName;
	}

	public String getDonePayUserName() {
		return donePayUserName;
	}

	public void setDonePayUserName(String donePayUserName) {
		this.donePayUserName = donePayUserName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getCouponQuota() {
		return couponQuota;
	}

	public void setCouponQuota(String couponQuota) {
		this.couponQuota = couponQuota;
	}

	public String getPraiseMoney() {
		return praiseMoney;
	}

	public void setPraiseMoney(String praiseMoney) {
		this.praiseMoney = praiseMoney;
	}

	public String getDifferenceMoney() {
		return differenceMoney;
	}

	public void setDifferenceMoney(String differenceMoney) {
		this.differenceMoney = differenceMoney;
	}

	public String getImportUserName() {
		return importUserName;
	}

	public void setImportUserName(String importUserName) {
		this.importUserName = importUserName;
	}

	public String getImportTime() {
		return importTime;
	}

	public void setImportTime(String importTime) {
		this.importTime = importTime;
	}

	public String getReturnMoney() {
		return returnMoney;
	}

	public void setReturnMoney(String returnMoney) {
		this.returnMoney = returnMoney;
	}

	public String getSpecialExpress() {
		return specialExpress;
	}

	public void setSpecialExpress(String specialExpress) {
		this.specialExpress = specialExpress;
	}

	public String getSpecialGift() {
		return specialGift;
	}

	public void setSpecialGift(String specialGift) {
		this.specialGift = specialGift;
	}

	public String getSelfCheckRemark() {
		return selfCheckRemark;
	}

	public void setSelfCheckRemark(String selfCheckRemark) {
		this.selfCheckRemark = selfCheckRemark;
	}

	public String getSelfCheck() {
		return selfCheck;
	}

	public void setSelfCheck(String selfCheck) {
		this.selfCheck = selfCheck;
	}

	public String getFinanceCheckRemark() {
		return financeCheckRemark;
	}

	public void setFinanceCheckRemark(String financeCheckRemark) {
		this.financeCheckRemark = financeCheckRemark;
	}

	public String getFinanceCheck() {
		return financeCheck;
	}

	public void setFinanceCheck(String financeCheck) {
		this.financeCheck = financeCheck;
	}

	public String getIsVirtual() {
		return isVirtual;
	}

	public void setIsVirtual(String isVirtual) {
		this.isVirtual = isVirtual;
	}
	
}
