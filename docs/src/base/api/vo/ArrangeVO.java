package base.api.vo;

import base.api.Arrange;
import base.api.User;
import base.util.DateUtil;

public class ArrangeVO {
	
	public static final String EARLY = "早班";
	public static final String NIGHT = "夜班";
	public static final String NORMAL = "正常上班";
	public static final String REST = "休息";
	
	private int id;
	private User user;
	private String status;
	private String day;
	
	public ArrangeVO(Arrange arrange){
		this.id = arrange.getId();
		if(arrange.getStatus().equals(Arrange.EARLY)){
			this.status = EARLY;
		}else if(arrange.getStatus().equals(Arrange.NIGHT)){
			this.status = NIGHT;
		}else if(arrange.getStatus().equals(Arrange.NORMAL)){
			this.status = NORMAL;
		}else if(arrange.getStatus().equals(Arrange.REST)){
			this.status = REST;
		}
		this.day = DateUtil.toDayString(arrange.getDay()) + "  " + DateUtil.toWeekString(arrange.getDay());
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}

}
