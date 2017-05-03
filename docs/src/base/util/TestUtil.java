package base.util;

import java.util.List;

import base.api.User;

public class TestUtil {
	
	static ThreadLocal<User> local = new ThreadLocal<User>();
	
	void setUser(User user){
		local.set(user);
	}
	
	User getUsert(){
		return local.get();
	}

	
	public static void main(String[] args) {
		System.out.println(DateUtil.getDayTime());
		System.out.println(DateUtil.toString(1493654400000L));
		List<String> re = null;
		for(String r :re){
			
		}
	}
	
}
