package com.common.uilt;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DateUtil {
	public final static SimpleDateFormat SD = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	public static String getTimeStamp() {
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		return dateFormat.format(date);
	}
	public static Date Stringformatdate(String str) throws ParseException{
		
		Date d= new Date();
		d=SD.parse(str);
		return d;
	}
	public static String getQuot(Date date1, Date date2) {
		long quot = 0;

		// Date date1 = FT.parse(oldtime1);
		// Date date2 = FT.parse(newtime2);
		quot = date2.getTime() - date1.getTime();
//		quot = quot / 1000 / 60 / 60 / 24;
		long day = quot / (24 * 60 * 60 * 1000);
		long hour = (quot / (60 * 60 * 1000) - day * 24);
		long min = ((quot / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long s = (quot / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		//System.out.println(""+day+"天"+hour+"小时"+min+"分"+s+"秒");
		String s1=day==0l?"":day+"天";
		//s1+="天";
		s1+=hour==0l?"":hour+"小时";
		//s1+="小时";
		s1+=min==0l?"":min+"分";
		return s1+s+"秒";
	}
	/**
	 * 返回当前时间的与参数的时间差
	 * @param date1
	 * @return
	 */
	
	public static String getQuot(Date date1) {
		long quot = 0;

		// Date date1 = FT.parse(oldtime1);
		// Date date2 = FT.parse(newtime2);
		quot = new Date().getTime() - date1.getTime();
		if(quot<0) return "";
//		quot = quot / 1000 / 60 / 60 / 24;
		long day = quot / (24 * 60 * 60 * 1000);
		long hour = (quot / (60 * 60 * 1000) - day * 24);
		long min = ((quot / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long s = (quot / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		//System.out.println(""+day+"天"+hour+"小时"+min+"分"+s+"秒");
		if(day>=3) return day+"天";
		String s1=day==0l?"":day+"天";
		//s1+="天";
		s1+=hour==0l?"":hour+"小时";
		//s1+="小时";
		s1+=min==0l?"":min+"分";
		return s1+s+"秒";
	}
	public static void main(String[] args) {
		//Date d = new Date(1420750041785l);
		System.out.println(getQuot(new Date(new Date().getTime()-1001*60*60*24*3)));
		try {
			SD.parse("2015-05-01 23:59:39.259");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
