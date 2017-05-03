package base.api.vo;

import base.api.Goods;
import base.api.GoodsOutRecord;
import base.dao.GoodsDAO;
import base.util.DateUtil;

/*
 * 出货记录vo
 */
public class GoodsOutRecordVO {
	
	private int id;//自由编号
	private String goodsName;//货物
	private int count;//出货量
	private String time;//出货时间
	private String remark;//出货理由
	
	public GoodsOutRecordVO(GoodsOutRecord record){
		this.id = record.getId();
		Goods goods = GoodsDAO.getInstance().load(record.getGoodsId());
		if(goods != null){
			this.goodsName = goods.getName();
		}else{
			this.goodsName = "该货物已经不存在";
		}
		this.count = record.getCount();
		this.time = DateUtil.toString(record.getTime());
		this.remark = record.getRemark();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
