package com.util;


import com.constant.Constant;

public class ParameterUtil {

	/**
	 * 若参数为null或者空字符串，返回true
	 * 否则，返回false
	 * @param s
	 * @return
	 */
	public static boolean isNull(String s){
		if(null == s  || "".equals(s.trim())){
			return true;
		}
		return false;
	}
	
	/**
	 * 若参数为null或者空字符串，返回true
	 * 否则，返回false
	 * @param s
	 * @return
	 */
	public static boolean isNullStorage(String s){
		if(null == s  || "".equals(s.trim()) || Constant.PARAMETER_COURSE_TYPE_IS_NULL.equals(s.trim())){
			return true;
		}
		return false;
	}
	
	
	
	/**
	 * 校验str是否包含非法字符串keyIllegal，包含则返回true
	 * @param keyIllegal 非法字符串
	 * @param str 待校验的字符串
	 * @return
	 */
	public  static boolean illegalCheck(String keyIllegal,String str){
		if(isNull(keyIllegal)  || isNull(str)){
			return false;
		}
		
		//消除空格的影响
		String[] arr = str.split("");
		StringBuffer sb  = new StringBuffer();
		for(int i = 0; i < arr.length; i++){
			if(" ".equals(arr[i])){
				continue;
			}
			sb.append(arr[i]);
		}
		str = sb.toString();
		
		if(str.contains(keyIllegal.trim())){
			return true;
		}
		return false;
	}

	
	/**
	 * 校验参数s是否包含非法字符串，是则返回true，不是则返回false
	 * @param s
	 * @return
	 */
	public static boolean isIllegal(String s){
		//非法字符串汇总
		String illegals = "共党,共产党,中共中央,习近平";
		String[] keyIllegals = illegals.split(",");
		
		for(int i = 0; i < keyIllegals.length; i++){
			if(illegalCheck(keyIllegals[i], s)){
				return true;
			}
		}
		return false;
	}
	
	
	

}
