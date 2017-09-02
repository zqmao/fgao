package base.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class ReflectUtil {

	/**
	 * 利用反射机制得到Object的属性值
	 * 
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getValues(Object obj) throws Exception {
		Map<String, Object> valueMap = new HashMap<String, Object>();
		Method[] methods = obj.getClass().getDeclaredMethods();
		String key = "";
		Object value;
		for (Method m : methods) {
			boolean sign = false;
			if (m.getName().startsWith("get")) {// get方法
				key = m.getName().substring(3);
				sign = true;
			}
			if (m.getName().startsWith("is")) {// is方法
				key = m.getName().substring(2);
				sign = true;
			}
			if (sign) {// get方法或者is方法
				Class<?> type = m.getReturnType();
				// 只保留String int long
				if (type != String.class && type != int.class && type != long.class && type != float.class) {
					continue;
				}
				if (key.length() == 0) {
					continue;
				}
				key = key.substring(0, 1).toLowerCase() + key.substring(1);// 将第一个字母变为小写
				value = m.invoke(obj);
				valueMap.put(key, value);
			}
		}
		return valueMap;
	}
}
