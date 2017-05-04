package base.api.vo;

public class BugVO {
	
	private int id;
	private String category;
	private String title;
	private String createRemark;
	private String createInfo;
	private String finishInfo;
	private String finishRemark;
	
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
	public String getCreateInfo() {
		return createInfo;
	}
	public void setCreateInfo(String createInfo) {
		this.createInfo = createInfo;
	}
	public String getFinishInfo() {
		return finishInfo;
	}
	public void setFinishInfo(String finishInfo) {
		this.finishInfo = finishInfo;
	}
	public String getFinishRemark() {
		return finishRemark;
	}
	public void setFinishRemark(String finishRemark) {
		this.finishRemark = finishRemark;
	}
}
