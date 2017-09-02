package base.util;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

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
		SqlBuild<User> build = new SqlBuild<User>();
	}
	
	static class SqlBuild<T>{
		protected Class<T> clazz;  
		  
	    public SqlBuild() {  
	        Class clazz = getClass();  
	        
	        while (clazz != Object.class) {  
	            Type t = clazz.getGenericSuperclass();  
	            System.out.println(t.getTypeName());
	            if (t instanceof ParameterizedType) {  
	                Type[] args = ((ParameterizedType) t).getActualTypeArguments();  
	                if (args[0] instanceof Class) {  
	                    this.clazz = (Class<T>) args[0];  
	                    break;  
	                }  
	            }  
	            clazz = clazz.getSuperclass();  
	        } 
	        System.out.println(clazz);
	    }  
	}
	
}
