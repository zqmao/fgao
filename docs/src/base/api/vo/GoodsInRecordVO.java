package base.api.vo;

import base.api.Goods;
import base.api.GoodsComeRecord;
import base.api.GoodsInRecord;
import base.dao.GoodsDAO;
import base.util.DateUtil;

/*
 * 出货记录vo
 */
public class GoodsInRecordVO {
	
	private int id;//自由编号
	private String goodsName;//货物
	private int count;//进货量
	private String time;//进货时间
	private String remark;//进货备注
	private String comeInfo = "";//收货情况
	private int oweCount;//欠货数量
	
	public GoodsInRecordVO(GoodsInRecord record){
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
		int comeTotal = 0;
		if(record.getComes() != null){
			for(GoodsComeRecord come : record.getComes()){
				comeTotal += come.getCount();
				this.comeInfo += come.getCount() + ",";
			}
		}
		if(this.comeInfo != null && this.comeInfo.length() > 1){
			this.comeInfo = this.comeInfo.substring(0, this.comeInfo.length() - 1);
		}
		this.oweCount = comeTotal - record.getCount();
		if(this.oweCount > 0){
			this.oweCount = 0;
		}
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

	public String getComeInfo() {
		return comeInfo;
	}

	public void setComeInfo(String comeInfo) {
		this.comeInfo = comeInfo;
	}

	public int getOweCount() {
		return oweCount;
	}

	public void setOweCount(int oweCount) {
		this.oweCount = oweCount;
	}
}
