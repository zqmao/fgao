package base.util;

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
		
	}
}
