package base.api.vo;

import base.api.SignRecord;
import base.api.User;
import base.dao.UserDAO;
import base.util.DateUtil;

public class SignRecordVO {

	private int id;//数据库id
	private String userName;//签到人员
	private String signInTime;//签到时间
	private String signOutTime;//签退时间
	private String dayTime;//签到的日期
	private int signOutException;
	private String adminHandle;
	
	public SignRecordVO(SignRecord record){
		this.id = record.getId();
		User user = UserDAO.getInstance().load(record.getUserId());
		if(user != null){
			this.userName = user.getName();
		}else{
			this.userName = "人员不存在";
		}
		if(record.getSignInTime() == 0){
			this.signInTime = "未签到";
		}else{
			this.signInTime = DateUtil.toString(record.getSignInTime());
		}
		if(record.getSignOutTime() == 0){
			this.signOutTime = "未签退";
		}else{
			this.signOutTime = DateUtil.toString(record.getSignOutTime());
		}
		this.dayTime = record.getDayTime();
		
		long nextDayTime = DateUtil.getDayTime(this.dayTime) + 24 * 60 * 60 * 1000;
		if(record.getSignOutTime() > nextDayTime){
			this.signOutException = 1;
		}else{
			this.signOutException = 0;
		}
		this.adminHandle = record.getAdminHandle() == 1 ? "是" : "否";
	}
	public SignRecordVO(){
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSignInTime() {
		return signInTime;
	}
	public void setSignInTime(String signInTime) {
		this.signInTime = signInTime;
	}
	public String getSignOutTime() {
		return signOutTime;
	}
	public void setSignOutTime(String signOutTime) {
		this.signOutTime = signOutTime;
	}
	public String getDayTime() {
		return dayTime;
	}
	public void setDayTime(String dayTime) {
		this.dayTime = dayTime;
	}
	public int getSignOutException() {
		return signOutException;
	}
	public void setSignOutException(int signOutException) {
		this.signOutException = signOutException;
	}
	public String getAdminHandle() {
		return adminHandle;
	}
	public void setAdminHandle(String adminHandle) {
		this.adminHandle = adminHandle;
	}
}
