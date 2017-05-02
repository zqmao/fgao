package base.api;

public class Arrange {
	
	public static final String EARLY = "早";
	public static final String NIGHT = "夜";
	public static final String NORMAL = "正";
	public static final String REST = "休";
	
	private int id;
	private int userId;
	private String status;
	private long day;
	
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public long getDay() {
		return day;
	}
	public void setDay(long day) {
		this.day = day;
	}

}
