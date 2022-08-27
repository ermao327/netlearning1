package com.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 * @author soft01
 *
 */
public class DateUtil {
		
	/**
	 *  搜索的开始时间
	 *  将形如“2018-9-09-12”日期字符串转换为时间“2018-9-12 00:00:00”
	 * @param dateStr
	 * @return
	 */
	public static Date startDate(String dateStr){
		if(ParameterUtil.isNull(dateStr)){
			return null;
		}
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(dateStr);
			return date;
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 *  搜索的结束时间
	 *  将形如“2018-9-09-12”日期字符串转换为时间“2018-9-12 23:59:59.999”
	 * @param dateStr
	 * @return
	 */
	public static Date endDate(String dateStr){
		if(ParameterUtil.isNull(dateStr)){
			return null;
		}
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			dateStr = dateStr + "   23:59:59.999";
			Date date = sdf.parse(dateStr);
			return date;
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 监测开始时间start  是否早于  结束时间end
	 * 若start和end都不为null，且start比end晚，则返回false
	 * 否则，返回true
	 * @param start
	 * @param end
	 * @return
	 */
	public static boolean compareDate(Date start, Date end){
		if(null != start && null != end && start.after(end)){
			return false;
		}
		return true;
	}
	
	
	/**
	 * 判断是否需要签到
	 * 签到超过24小时的，需要重新签到，返回true
	 * 签到虽在24小时内，但不是今天签到的，也返回true
	 * 其他返回false
	 * @param prevLoginDate
	 * @return
	 */
	public static boolean isNeedSign(Date prevLoginDate){
		Date now = new Date();
		//签到超过24小时
		if(now.getTime() - prevLoginDate.getTime() >= 24*60*60*1000){
			return true;
		}
		
		Calendar cNow = Calendar.getInstance();
		Calendar cPrev = Calendar.getInstance();
		cNow.setTime(now);
		cPrev.setTime(prevLoginDate);
		//签到虽在24小时内，但不是今天签到的
		if(cNow.get(Calendar.DATE) != cPrev.get(Calendar.DATE)){
			return true;
		}
		
		return false;
	}
	
	
	/**
	 * 将当时当刻的时间转换成年-月-日 时：分：秒形式
	 * @return
	 */
	public static String getDateStr(){
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DATE)+" "+c.get(Calendar.HOUR_OF_DAY)+":"+c.get(Calendar.MINUTE)+":"+c.get(Calendar.SECOND)+" ";
	}
	
	
	
	
	
	
	
	
	
}
