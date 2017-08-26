package base.api;

/**
 * 优秀评论数据库类
 * @author zqmao
 *
 */
public class Comment {
	
	private int id;
	private long time;//评论时间
	private String creator;//评论录入者
	private int goodsId;//评论商品
	private String firstComment;//评论首评
	private String firstCommentPic;//首评图片 
	private String secondComment;//追评内容
	private String secondCommentPic;//追评图片
	private String timeDes;//追评时间
	private int userId;//评论录入者id
	private String remark;//备注
	private int isVerify;//是否审核通过
	
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getIsVerify() {
		return isVerify;
	}
	public void setIsVerify(int isVerify) {
		this.isVerify = isVerify;
	}
	
}
