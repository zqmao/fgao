package base.api.vo;

import base.api.Category;
import base.api.Document;
import base.api.User;
import base.dao.CategoryDAO;
import base.dao.UserDAO;
import base.util.DateUtil;

public class DocumentVO {
	
	private int id;//
	private String userName;
	private int userId;
	private String title;//
	private String content;//
	private String time;//
	private int categoryId;
	private String categoryName;
	
	public DocumentVO(){
		
	}
	
	public DocumentVO(Document document){
		setId(document.getId());
		setUserId(document.getUserId());
		User user = UserDAO.getInstance().load(document.getUserId());
		setUserName(user.getName());
		setTitle(document.getTitle());
		setContent(document.getContent());
		setTime(DateUtil.toString(document.getTime()));
		setCategoryId(document.getCategoryId());
		Category category = CategoryDAO.getInstance().load(document.getCategoryId());
		setCategoryName(category.getText());
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}
