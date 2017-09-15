package base.api;


/**
 * 签到签退记录
 * @author Administrator
 *
 */
public class SignRecord {
	
	private int id;//数据库id
	private int userId;//签到人员
	private String dayTime;
	private long signInTime;//签到时间
	private long signOutTime;//签退时间
	private int adminHandle;//是否是管理员处理
	
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
	public String getDayTime() {
		return dayTime;
	}
	public void setDayTime(String dayTime) {
		this.dayTime = dayTime;
	}
	public long getSignInTime() {
		return signInTime;
	}
	public void setSignInTime(long signInTime) {
		this.signInTime = signInTime;
	}
	public long getSignOutTime() {
		return signOutTime;
	}
	public void setSignOutTime(long signOutTime) {
		this.signOutTime = signOutTime;
	}
	public int getAdminHandle() {
		return adminHandle;
	}
	public void setAdminHandle(int adminHandle) {
		this.adminHandle = adminHandle;
	}
}
