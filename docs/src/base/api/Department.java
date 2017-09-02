package base.api;

/**
 * 部门数据库类
 * 暂时没有使用到，未来扩展用
 * @author zqmao
 *
 */
public class Department {
	
	private int id;
	private String name;//部门名称
	private String info;//部门介绍
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}

}
