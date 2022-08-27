package com.util;

public  class StringUtil {

	
	public static Double getDouble(String doubleStr)
	{
		return getDouble(doubleStr, 0.0);
	}
	public static Double getDouble(String doubleStr,Double defaultValue)
	{
		
		if(doubleStr == null || "".equals(doubleStr))
		{
			return defaultValue;
		}
		
		return Double.parseDouble(doubleStr);
		
	}
	
	public static Integer getInt(String intStr)
	{
		return getInt(intStr, -1);
	}
	public static Integer getInt(String intStr,Integer defaultValue)
	{
		
		if(intStr == null || "".equals(intStr))
		{
			return defaultValue;
		}
		
		return Integer.parseInt(intStr);
		
	}
	
	
}
