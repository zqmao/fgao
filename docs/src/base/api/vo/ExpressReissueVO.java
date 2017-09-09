package base.api.vo;

import base.api.ExpressReissue;
import base.api.User;
import base.dao.UserDAO;
import base.util.DateUtil;

public class ExpressReissueVO {
	private int id;//数据库主键
	private String creator;//登记人
	private String entryTime;//登记时间
	private String address;//补发地址
	private String shopName;//店铺名
	private String goodsName;//补发物品
	private String orderNum;//订单号
	private String wangwang;//用户旺旺
	private String remark;//备注
	private String bounceType;//退件类型
	
	private String issueDocumentor;//打单人员
	private String expressName;//快递名称
	private String courierNum;//快递单号
	private String issuTime;//打单时间
	private String issuRemark;//打单备注
	private String status;//处理状态:1已处理；0未处理
	
	public ExpressReissueVO(ExpressReissue expressReissue){
		this.id = expressReissue.getId();
		User user = UserDAO.getInstance().load(expressReissue.getCreatorId());
		this.creator = user != null ? user.getName() : "";
		this.entryTime = expressReissue.getEntryTime()!=0 ? DateUtil.toString(expressReissue.getEntryTime()):"";
		this.address = expressReissue.getAddress();
		this.shopName = expressReissue.getShopName();
		this.goodsName = expressReissue.getGoodsName();
		this.orderNum = expressReissue.getOrderNum();
		this.wangwang = expressReissue.getWangwang();
		this.remark = expressReissue.getRemark();
		this.bounceType = expressReissue.getBounceType();
		
		user = UserDAO.getInstance().load(expressReissue.getIssueDocumentor());
		this.issueDocumentor = user != null ? user.getName() : "";
		//this.createTime = afterSaleComeRecord.getCreateTime()!= 0 ? DateUtil.toString(afterSaleComeRecord.getCreateTime()):"";
		this.expressName = expressReissue.getExpressName();
		this.courierNum = expressReissue.getCourierNum();
		this.issuTime = expressReissue.getIssuTime()!=0 ? DateUtil.toString(expressReissue.getIssuTime()):"";
		this.issuRemark = expressReissue.getIssuRemark();
		this.status = expressReissue.getStatus()==1?"已处理":"待处理";
	}
	
	public String getBounceType() {
		return bounceType;
	}

	public void setBounceType(String bounceType) {
		this.bounceType = bounceType;
	}


	public String getIssueDocumentor() {
		return issueDocumentor;
	}

	public void setIssueDocumentor(String issueDocumentor) {
		this.issueDocumentor = issueDocumentor;
	}

	public String getExpressName() {
		return expressName;
	}

	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}

	public String getCourierNum() {
		return courierNum;
	}

	public void setCourierNum(String courierNum) {
		this.courierNum = courierNum;
	}

	public String getIssuTime() {
		return issuTime;
	}

	public void setIssuTime(String issuTime) {
		this.issuTime = issuTime;
	}

	public String getIssuRemark() {
		return issuRemark;
	}

	public void setIssuRemark(String issuRemark) {
		this.issuRemark = issuRemark;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreatorId(String creator) {
		this.creator = creator;
	}

	public String getEntryTime() {
		return entryTime;
	}

	public void setEntryTime(String entryTime) {
		this.entryTime = entryTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
