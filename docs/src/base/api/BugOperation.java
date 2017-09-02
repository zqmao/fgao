package base.api;

/**
 * 待办的操作记录数据库类
 * @author zqmao
 *
 */
public class BugOperation {
	
	private int id;
	private int bugId;//对应的bugid
	private String remark;//此次修改的描述
	private long time;//此次修改的时间
	private int operaterId;//谁进行的修改
	private int targetId;//指派给谁
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBugId() {
		return bugId;
	}
	public void setBugId(int bugId) {
		this.bugId = bugId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
	public int getOperaterId() {
		return operaterId;
	}
	public void setOperaterId(int operaterId) {
		this.operaterId = operaterId;
	}
	public int getTargetId() {
		return targetId;
	}
	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}
}
