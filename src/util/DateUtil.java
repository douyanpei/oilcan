package util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class DateUtil {

	public DateUtil() {
	}
	
	public static Timestamp getNowTime(Boolean flag){
		Date date = new Date();       
		Timestamp nousedate = new Timestamp(date.getTime());
		return nousedate;
	}
	/**
	 * 获得当前日期
	 * 
	 * @return yyyy-mm-dd
	 */
	public static String getCurFormatDate() {
		Date curDate = new Date();
		return getFormatDate(curDate);
	}
	
	/**
	 * 获得当前时间
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String getNowTime() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(new Date());
	}

	/**
	 * 获得当前上下午
	 * 
	 * @return
	 */
	public static String getCurAPM() {
		Calendar c = Calendar.getInstance();
		int h = c.get(Calendar.AM_PM);
		if (h == Calendar.AM)
			return "上午";
		else {
			return "下午";
		}
	}

	/**
	 * 获得当前日期后next天的日期
	 * 
	 * @param next
	 * @return yyyy-mm-dd
	 */
	public static String getNextFormatDate(int next) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_MONTH, next);
		return getFormatDate(c.getTime());
	}

	/**
	 * 获得当前时间
	 * 
	 * @return 获得当前时间
	 */
	public static String getCurFormatTime() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(cal.getTime());
	}

	/**
	 * 获得当前年份
	 * 
	 * @return 字符串
	 */
	public static String getCurYearStr() {
		return String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
	}
	
	/**
	 * 获得当前年份
	 * 
	 * @return 四位整数
	 */
	public static int getCurYear() {
		return Calendar.getInstance().get(Calendar.YEAR);
	}
	
	/**
	 * 获得日期的年份 格式 yyyy-MM-dd
	 * 
	 * @return 四位整数
	 */
	public static int getYear(String date) {
		Calendar cal = Calendar.getInstance();  
		cal.setTime(java.sql.Date.valueOf(date));
		return cal.get(Calendar.YEAR);
	}
	
	/**
	 * 获得日期的月份 格式 yyyy-MM-dd
	 * 
	 * @return 四位整数
	 */
	public static int getMonth(String date) {
		Calendar cal = Calendar.getInstance();  
		cal.setTime(java.sql.Date.valueOf(date));
		return cal.get(Calendar.MONTH)+1;
	}

	/**
	 * 获得当前月份
	 * 
	 * @return 01~12
	 */
	public static String getCurMonthStr() {
		int month = Calendar.getInstance().get(Calendar.MONTH);
		month++;
		if (month < 10)
			return "0" + month;
		else
			return String.valueOf(month);
	}

	/**
	 * 获得当前月份
	 * 
	 * @return 01~12
	 */
	public static int getCurMonth() {
		return Calendar.getInstance().get(Calendar.MONTH)+1;
	}

	/**
	 * 获得日期的月份
	 * 
	 * @return 01~12
	 */
	public static int getDateMonth(String date) {
		Calendar cal = Calendar.getInstance();  
		cal.setTime(java.sql.Date.valueOf(date));
		return cal.get(Calendar.MONTH)+1;
	}

	/**
	 * 将Date类型转换为字符串
	 * 
	 * @param datetime
	 * @return 将Date类型转换为字符串
	 */
	public static String getFormatDate(Date datetime) {
		if(datetime == null)
			return "";
		String str_date = "";
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		str_date = sf.format(datetime);
		return str_date;
	}
	/**
	 * 将字符类型转换为Date,格式为"yyyy-MM-dd"
	 * 
	 * @param datetime
	 * @return 将Date类型转换为字符串
	 * @throws ParseException 
	 */
	public static Date getFormatDate(String datetime) throws ParseException {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date date= sf.parse(datetime);
		return date;
	}

	/**
	 * 获得当前时间字符串yyyymmdd
	 * 
	 * @return 获得当前时间字符串yyyymmdd
	 */
	public static String getTime() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		if ((calendar.get(Calendar.MONTH) + 1) < 10) {
			month = "0" + month;
		}
		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		if (calendar.get(Calendar.DAY_OF_MONTH) < 10) {
			day = "0" + day;
		}
		return year + month + day;
	}

	/**
	 * 获得没有任何符号的时间字符串
	 * 
	 * @return
	 */
	public static String getCurTimeStr() {
		String curTimeStr;
		String curTime = getCurFormatTime();
		curTimeStr = curTime;
		curTimeStr = curTimeStr.replaceAll("-", "");
		curTimeStr = curTimeStr.replaceAll(":", "");
		curTimeStr = curTimeStr.replaceAll(" ", "");
		return curTimeStr;
	}

	/**
	 * 取得两个时间段的时间间隔 return t2 与t1的间隔天数 throws ParseException
	 * 如果输入的日期格式不是0000-00-00 格式抛出异常
	 */
	public static int getBetweenDays(String t1, String t2)
			throws ParseException {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = format.parse(t1);
		Date d2 = format.parse(t2);
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(d1);
		c2.setTime(d2);
		return DateUtil.getBetweenDays(c1, c2);
	}

	/**
	 * 取得两个时间段的时间间隔 return c2 与c1的间隔天数 
	 */
	public static int getBetweenDays(Calendar c1, Calendar c2) {
		int betweenDays = 0;
		// 保证第二个时间一定大于第一个时间
		if (c1.after(c2)) {
			Calendar temp = c1;
			c1 = c2;
			c2 = temp;
		}
		int betweenYears = c2.get(Calendar.YEAR) - c1.get(Calendar.YEAR);
		betweenDays = c2.get(Calendar.DAY_OF_YEAR)
				- c1.get(Calendar.DAY_OF_YEAR);
		for (int i = 0; i < betweenYears; i++) {
			c1.set(Calendar.YEAR, (c1.get(Calendar.YEAR) + 1));
			betweenDays += c1.getMaximum(Calendar.DAY_OF_YEAR);
		}
		return betweenDays;
	}
	
	/**
	 * 获取下个月月份
	 * @return
	 */
	public static String getNextMonth(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String time = sf.format(cal.getTime());
		return time.substring(0, time.lastIndexOf("-"));
	}
	
	/**
	 * 获取当月第一天
	 * @return
	 */
	public static String getMonthFirstDay(int year){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.DAY_OF_MONTH,1);
		cal.add(Calendar.MONTH, 0);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		return sf.format(cal.getTime());
	}
	
	/**
	 * 获取下月第一天
	 * @return
	 */
	public static String getNextMonthFirstDay(){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH,1);
		cal.add(Calendar.MONTH, 1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		return sf.format(cal.getTime());
	}
	
	/**
	 * 获取下月最后一天
	 * @return
	 */
	public static String getNextMonthLastDay(){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH,1);
		cal.add(Calendar.MONTH, 2);
		cal.add(Calendar.DATE, -1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		return sf.format(cal.getTime());
	}
	/**
	 * 根据日期判断该日期是周几
	 * @param date 参数格式"yyyy-MM-dd"
	 * @return 1-7,周日为1
	 * @throws ParseException 
	 */
	public static int getWeek(String date) throws ParseException{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(sf.parse(date));
		int week = cal.get(Calendar.DAY_OF_WEEK);
		return week;
	}
	
	/**
	 * 获取指定年月的工作日
	 * @param date 格式为"yyyy-MM"
	 * @return
	 */
	public static Map<Integer,Date> getWorkDates(String date) throws Exception {   
        Map<Integer,Date> dates = new HashMap<Integer,Date>();
        int year = Integer.valueOf(date.substring(0, date.indexOf("-")));
        int month = Integer.valueOf(date.substring(date.indexOf("-")+1));
        Calendar cal = Calendar.getInstance();   
        cal.set(Calendar.YEAR, year);   
        cal.set(Calendar.MONTH,  month - 1);   
        cal.set(Calendar.DATE, 1);   
           
           
        while(cal.get(Calendar.YEAR) == year &&    
                cal.get(Calendar.MONTH) < month){   
            int day = cal.get(Calendar.DAY_OF_WEEK);   
               
            if(!(day == Calendar.SUNDAY || day == Calendar.SATURDAY)){
            	dates.put(cal.get(Calendar.DATE), (Date)cal.getTime().clone());
            }   
            cal.add(Calendar.DATE, 1); 
        }   
        return dates;   
  
    } 
	
	/**
	 * 比较两个日期的大小
	 * @param DATE1
	 * @param DATE2
	 * @return
	 */
    public static int compare_date(String date1, String date2) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date dt1 = df.parse(date1);
            Date dt2 = df.parse(date2);
            if (dt1.getTime() > dt2.getTime()) {
                return 1;
            } else if (dt1.getTime() < dt2.getTime()) {
                return -1;
            } else {
                return 0;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return 0;
    }

	/**
	 * 判断是否是全月
	 * @param yearMonth 要判断的年份-月份
	 * @param startDate 起始日期
	 * @param endDate 结束日期
	 * @return
	 */
	public static boolean isTheWholeMonth(String yearMonth,String startDate,String endDate){
		Calendar cal = Calendar.getInstance();  
		String bom = yearMonth + "-01";
		cal.setTime(java.sql.Date.valueOf(bom));
		String eom = yearMonth + "-" + cal.getActualMaximum(Calendar.DATE);
		return startDate.equals(bom) && endDate.equals(eom);
	}
	
	/**
	 * 判断一个月的最大天数
	 * @param date
	 * @return
	 */
	public static int getActualMonthMaximum(String date){
		Calendar cal = Calendar.getInstance();  
		cal.setTime(java.sql.Date.valueOf(date));
		return cal.getActualMaximum(Calendar.DATE);
	}
	
	static public String getCurTime(String pattern){
		SimpleDateFormat sf = new SimpleDateFormat(pattern);
		return sf.format(new Date());
	}
	/** yyyy-MM-dd HH:mm:ss **/
	static public String getCurTime(){
		return DateUtil.getCurTime("yyyy-MM-dd HH:mm:ss");
	}
	/** yyyy-MM-dd **/
	static public String getCurDate(){
		return DateUtil.getCurTime("yyyy-MM-dd");
	}
}

	


