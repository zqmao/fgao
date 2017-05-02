package base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class DateUtil {
	
	public static SimpleDateFormat SDF = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
	
	public static SimpleDateFormat SDF_D = new SimpleDateFormat("yyyy年MM月dd日");
	
	public static SimpleDateFormat SDF_W = new SimpleDateFormat("EEEE");
	
	public static String toString(long time){
		Date date = new Date();
		date.setTime(time);
		return SDF.format(date);
	}
	
	public static String toDayString(long time){
		Date date = new Date();
		date.setTime(time);
		return SDF_D.format(date);
	}
	
	public static String toWeekString(long time){
		Date date = new Date();
		date.setTime(time);
		return SDF_W.format(date);
	}
	
	public static long getDayTime(){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		return c.getTimeInMillis();
	}

}
