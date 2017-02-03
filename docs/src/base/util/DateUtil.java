package base.util;

import java.text.SimpleDateFormat;
import java.util.Date;


public class DateUtil {
	
	public static SimpleDateFormat SDF = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
	
	public static String toString(long time){
		Date date = new Date();
		date.setTime(time);
		return SDF.format(date);
	}

}
