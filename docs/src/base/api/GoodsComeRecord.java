package base.api;

/**
 * 收货记录数据库类
 * @author zqmao
 *
 */
public class GoodsComeRecord {
	
	private int id;//自由编号
	private int inRecordId;//对应进货记录id
	private int count;//收货数量
	private String orderNum;//订单号
	private long time;//收货时间
	
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
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
}
