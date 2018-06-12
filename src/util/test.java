package util;

import java.util.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class test {
	private static Connection connection;
	
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String url = "jdbc:sqlserver://localhost;databaseName=ZHCT;SelectMethod=cursor";
	private static String name = "sa";
	private static String password = "sa1234";

	public static Connection getConnection() {
		try {
			if (connection==null||connection.isClosed()) {
				Class.forName(driver);
				connection = DriverManager.getConnection( url, name, password); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	public static void main(String[] aaa) throws ParseException, SQLException{
		int totalcount = 0;
		int upCount = 10;
		int downCount = 1;
		int[] year = {2011,2012};
		int[] month = {1,2,3,4,5,6,7,8,9,10,11,12};
		DecimalFormat df = new DecimalFormat("######0.00");  
		
		Connection conn = test.getConnection();
		PreparedStatement pst = conn.prepareStatement("insert into test (deptName,deptCode,channel,createTime,temperature) values (?,?,?,?,?)");
		
		// 遍历年
		for (int i = 0; i < year.length; i++) {
			// 遍历月
			for (int j = 0; j < month.length; j++) {
				if(year[i] == 2015 && month[j] >= DateUtil.getCurMonth())
					continue;
				if(year[i] == 2011 && month[j] < 11)
					continue;

				int days = (int)(Math.random()*11) + 5;
				System.out.println(year[i] + "年" + month[j] + "月 有"+days+"天 温度异常！！！");
				Map<String, String> map = new HashMap<String, String>();
				// 随机生成日期
				for (int k = 0; k < days; k++) {
					String date = year[i]+"/"+month[j]+"/"+((int)(Math.random()*getActualMonthMaximum(year[i],month[j])) +1);
					while(map.get(date) != null)
						date = year[i]+"/"+month[j]+"/"+((int)(Math.random()*getActualMonthMaximum(year[i],month[j])) +1);
					map.put(date, date);
					System.out.println( "    》》》》" + date);
					
					//随机生成时间
					int times = (int)(Math.random()* 20) + 1;
					System.out.println( "         次数为 》》》》" + times);
					for (int l = 0; l < times; l++) {
						String[] wendu = {df.format(Math.random()* 2 + 8), df.format(Math.random()* 2)};
						pst.setString(1, "南开区疾病预防控制中心");
						pst.setString(2, null);
						pst.setString(3, String.valueOf((int)(Math.random()* 2 + 1)));
						pst.setString(4, date + " " +getRandomTime());
						pst.setString(5, wendu[(int)(Math.random()* 2)]);
						pst.addBatch();
						totalcount = totalcount + 1;
						if (totalcount%200==0) {
							pst.executeBatch();
							conn.commit();
							pst.clearBatch();
						}
					}
				}
			}
		}
		pst.executeBatch();
		conn.commit();
		pst.clearBatch();
		System.out.println("南开区疾病预防控制中心总数为 " + totalcount);
		pst.close();
		conn.close();
	}
	
	
	/**
	 * 判断一个月的最大天数
	 * @param date
	 * @return
	 */
	public static int getActualMonthMaximum(int year, int month){
		Calendar cal = Calendar.getInstance();  
        cal.set(Calendar.YEAR, year);   
        cal.set(Calendar.MONTH,  month - 1);   
		return cal.getActualMaximum(Calendar.DATE);
	}
	
	public static String getRandomTime() throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("hh:mm:ss");
		Date start = format.parse("00:00:00");//构造开始日期
		Date end = format.parse("24:59:59");//构造结束日期
		Date randomdate =  new Date(random(start.getTime(),end.getTime()));
		return randomdate.getHours()+":"+randomdate.getMinutes();
	}
	
	public static long random(long begin,long end){
		long rtn = begin + (long)(Math.random() * (end - begin));
		//如果返回的是开始时间和结束时间，则递归调用本函数查找随机值
		if(rtn == begin || rtn == end){
			return random(begin,end);
		 }
		 return rtn;
	}

}
	
