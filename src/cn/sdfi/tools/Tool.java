package cn.sdfi.tools;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
//import java.util.Date;
import java.util.Date; 

public class Tool { 
	/*
	 * 编码格式转换
	 */
	public static String codeToChina(String str){
	if(str!=null){
		try {
			str=new String(str.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("出错了--"+e);
			return str;
		}
	}
	return str;
}
	/*
	 * 生成订单流水号
	 */
	public static String getOrderId(){
		
		Calendar now = Calendar.getInstance();// 使用默认时区和语言环境获得一个日历。
        String month = now.get(Calendar.MONTH) + 1+"";//如果是一月，now.get(Calendar.MONTH)的值是0，所以后面需要加1.
        String day = now.get(Calendar.DAY_OF_MONTH)+"";
        String year = now.get(Calendar.YEAR)+"";
        String hour=now.get(Calendar.HOUR_OF_DAY)+"";
        String minute=now.get(Calendar.MINUTE)+"";
        String second=now.get(Calendar.SECOND)+"";
        String minisecond=now.get(Calendar.MILLISECOND)+"";
      
        if(month.length()<2)
        {
        	month="0"+month;
        }
        if(day.length()<2)
        {
        	day="0"+day;
        }
       
        if(hour.length()<2)
        {
        	hour="0"+hour;
        }
        if(minute.length()<2)
        {
        	minute="0"+minute;
        }
        if(second.length()<2)
        {
        	second="0"+second;
        }
        return year+month+day+hour+minute+second+minisecond;
	}
	/*
	 * 获取日期时间
	 * 2008-04-29  08:56:51
	 */
	public static String getDateTime()
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		return sdf.format(new Date());
	}
//	
//	public static void main(String[] args) {
//		System.out.println(getDateTime());
//	}
}