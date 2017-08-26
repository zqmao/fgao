package base.api;

/**
 * 待办数据库类
 * @author zqmao
 *
 */
public class Bug {
	
	private int id;
	private String category;//bug的类别
	private String title;//标题
	
	private String createRemark;//创建时填写的描述
	private long createTime;//创建时间
	private int createrId;//创建者
	private String createrName;
	private String finishRemark;//完成时填写的描述
	private long finishTime;//完成时间
	private int finisherId;//完成者
	private String finisherName;
	private String wangwang;
	private String goods;
	
	private int state;//0,未完成；1,完成
	private String currentName;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCreateRemark() {
		return createRemark;
	}

	public void setCreateRemark(String createRemark) {
		this.createRemark = createRemark;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}

	public int getCreaterId() {
		return createrId;
	}

	public void setCreaterId(int createrId) {
		this.createrId = createrId;
	}

	public String getFinishRemark() {
		return finishRemark;
	}

	public void setFinishRemark(String finishRemark) {
		this.finishRemark = finishRemark;
	}

	public long getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(long finishTime) {
		this.finishTime = finishTime;
	}

	public int getFinisherId() {
		return finisherId;
	}

	public void setFinisherId(int finisherId) {
		this.finisherId = finisherId;
	}

	public String getCreaterName() {
		return createrName;
	}

	public void setCreaterName(String createrName) {
		this.createrName = createrName;
	}

	public String getFinisherName() {
		return finisherName;
	}

	public void setFinisherName(String finisherName) {
		this.finisherName = finisherName;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getCurrentName() {
		return currentName;
	}

	public void setCurrentName(String currentName) {
		this.currentName = currentName;
	}

	public String getWangwang() {
		return wangwang;
	}

	public void setWangwang(String wangwang) {
		this.wangwang = wangwang;
	}

	public String getGoods() {
		return goods;
	}

	public void setGoods(String goods) {
		this.goods = goods;
	}
}
