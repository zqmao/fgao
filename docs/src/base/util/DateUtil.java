package base.util;

import java.text.ParseException;
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
	
	public static long getDayTime(String time){
		try {
			return SDF_D.parse(time).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0L;
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
	
	public static long getTime(int hours){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.HOUR_OF_DAY, hours);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		return c.getTimeInMillis();
	}
	
	/**
	 * 获取当前月份天数
	 * @return
	 */
	public static int getMonthDayCount(){
		Calendar c = Calendar.getInstance();
		return c.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * 获取上月份天数
	 * @return
	 */
	public static int getLastMonthDayCount(){
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH);
		c.set(Calendar.MONTH, month - 1);
		return c.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	public static long getTimeInMillis(String time){
		if(time == null || time.length() == 0){
			return 0;
		}
		//先确定开头的年月日直接的符号"-","/","年月日"
		String ymdStr = "yyyyMMdd";
		if(time.indexOf("-") != -1){
			ymdStr = "yyyy-MM-dd";
		}else if(time.indexOf("/") != -1){
			ymdStr = "yyyy/MM/dd";
		}else if(time.indexOf("年") != -1 && time.indexOf("月") != -1 && time.indexOf("日") != -1){
			ymdStr = "yyyy年MM月dd日";
		}
		String hmsStr = "";
		if(time.indexOf(":") != -1){
			if(time.indexOf(":") == time.lastIndexOf(":")){
				//只有一个":"
				hmsStr = "HH:mm";
			}else{
				//有两个及以上":"
				hmsStr = "HH:mm:ss";
			}
		}else{
			hmsStr = "HHmmss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(ymdStr + " " + hmsStr);
		try {
			System.out.println("" + time);
			return sdf.parse(time).getTime();
		} catch (ParseException e) {
			System.out.println("时间格式错误" + e.getMessage());
		}
		return 0;
	}

}
