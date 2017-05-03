package base.api.vo;

import base.api.Goods;
import base.api.GoodsComeRecord;
import base.api.GoodsInRecord;
import base.dao.GoodsDAO;
import base.dao.GoodsInDAO;
import base.util.DateUtil;

public class GoodsComeRecordVO {
	
	private int id;//自由编号
	private int inRecordId;//对应进货记录id
	private int count;//收货数量
	private String orderNum;//订单号
	private String time;//收货时间
	private String goodsName;
	
	public GoodsComeRecordVO(GoodsComeRecord record){
		this.id = record.getId();
		this.inRecordId = record.getInRecordId();
		this.count = record.getCount();
		this.orderNum = record.getOrderNum();
		this.time = DateUtil.toString(record.getTime());
		GoodsInRecord inRecord = GoodsInDAO.getInstance().load(inRecordId);
		Goods goods = GoodsDAO.getInstance().load(inRecord.getGoodsId());
		this.goodsName = goods.getName();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getInRecordId() {
		return inRecordId;
	}
	public void setInRecordId(int inRecordId) {
		this.inRecordId = inRecordId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
}
