package base.api;

import java.util.List;

/*
 * 进货记录
 */
public class GoodsInRecord {
	
	private int id;//自由编号
	private int goodsId;//货物id
	private int count;//进货量
	private int status;//进货记录状态：正在进货，收货完成
	private long time;//进货时间
	private String remark;//进货备注（保护各批次快递单号，数量）
	
	private List<GoodsComeRecord> comes;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public List<GoodsComeRecord> getComes() {
		return comes;
	}
	public void setComes(List<GoodsComeRecord> comes) {
		this.comes = comes;
	}
}
