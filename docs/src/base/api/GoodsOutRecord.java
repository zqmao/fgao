package base.api;

/*
 * 出货记录
 * 销售和盘库矫正
 */
public class GoodsOutRecord {
	
	private int id;//自由编号
	private int goodsId;//货物id
	private int count;//出货量
	private long time;//出货时间
	private String remark;//出货理由
	
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
}
