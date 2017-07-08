package base.api;

public class Comment {
	
	private int id;
	private long time;
	private String creator;
	private int goodsId;
	private String firstComment;
	private String firstCommentPic;
	private String secondComment;
	private String secondCommentPic;
	private String timeDes;
	private int userId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getFirstComment() {
		return firstComment;
	}
	public void setFirstComment(String firstComment) {
		this.firstComment = firstComment;
	}
	public String getFirstCommentPic() {
		return firstCommentPic;
	}
	public void setFirstCommentPic(String firstCommentPic) {
		this.firstCommentPic = firstCommentPic;
	}
	public String getSecondComment() {
		return secondComment;
	}
	public void setSecondComment(String secondComment) {
		this.secondComment = secondComment;
	}
	public String getSecondCommentPic() {
		return secondCommentPic;
	}
	public void setSecondCommentPic(String secondCommentPic) {
		this.secondCommentPic = secondCommentPic;
	}
	public String getTimeDes() {
		return timeDes;
	}
	public void setTimeDes(String timeDes) {
		this.timeDes = timeDes;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
}
