package util;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import jxl.Workbook;

public class DataImPort {
	private static Connection connection;
	
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String url = "jdbc:sqlserver://192.168.0.100;databaseName=ZHCT;SelectMethod=cursor";
	private static String name = "sa";
	private static String password = "sasa";

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
	
	public static void main(String[] args) {
//		importItem();
//		importItemSet();
//		importR_ItemSet_Item();
//		importConclusion();
//		importDesc();
		updateHarmFactorPYM();
	}
	
	/**
	 * 导入项目
	 */
	public static void importItem(){
		Connection conn = null;
		try{
			Map deptMap = new HashMap();
			List<String> list = new ArrayList<String>();
			conn = getConnection();
			conn.setAutoCommit(false);
			Statement stat = conn.createStatement();
			ResultSet rs =  stat.executeQuery("select deptId,deptName from ExaminationDepartment");
			while(rs.next()){
				deptMap.put(rs.getString("deptName"), rs.getString("deptId"));
			}
			rs.close();
			stat.close();
			
			int startNumber = 1;
			System.out.println("开始数据导入！");
/*
 * 导入项目
 */
			PreparedStatement pst = conn.prepareStatement("insert into ExaminationItem (itemCode,itemName,pym,gender,maritalStatus,deptId,isUpload,isUse,diseaseShow) values (?,?,?,?,?,?,?,?,?)");
			Workbook workbook = Workbook.getWorkbook(new File("D://项目可导入.xls"));
			Sheet sheet = workbook.getSheet(0);
			//逐行检索
			for(int row=0;row<sheet.getRows();row++)
			{
				//如果第一个单元格的数据为空，则判断EXCEL已到末尾
				if(CellType.EMPTY == sheet.getCell(0, row).getType() || StringUtil.isEmpty(sheet.getCell(0, row).getContents()))
					break;
				pst.setString(1, String.format("%04d", startNumber));
				pst.setString(2, sheet.getCell(0,row).getContents().trim());
				pst.setString(3, Hanyupinyin.toHanyuPinyinCapital(sheet.getCell(0,row).getContents().trim()));
				pst.setString(4, "003");
				pst.setString(5, "003");
				pst.setString(6, deptMap.get(sheet.getCell(2,row).getContents().trim()).toString());
				pst.setString(7, "0");
				pst.setString(8, "1");
				pst.setString(9, "0");
				pst.addBatch();
				startNumber++;
				
				if(row % 200 == 0)
				{
					pst.executeBatch();
					conn.commit();
					pst.clearBatch();
				}
			}
			pst.executeBatch();
			conn.commit();
			pst.clearBatch();
			pst.close();
			
			System.out.println("数据导入完成！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 导入项目组
	 */
	public static void importItemSet(){
		Connection conn = null;
		try{
			Map deptMap = new HashMap();
			List<String> list = new ArrayList<String>();
			conn = getConnection();
			conn.setAutoCommit(false);
			Statement stat = conn.createStatement();
			ResultSet rs =  stat.executeQuery("select deptId,deptName from ExaminationDepartment");
			while(rs.next()){
				deptMap.put(rs.getString("deptName"), rs.getString("deptId"));
			}
			rs.close();
			stat.close();
			
			int startNumber = 1;
			System.out.println("开始数据导入！");
			/**
			 * 导入项目组			
			 */
			PreparedStatement pst = conn.prepareStatement("insert into ItemSet (itemSetCode,itemSetName,pym,deptId,isUse,isRecover,isReport,gender,maritalStatus,isXItem) values (?,?,?,?,?,?,?,?,?,?)");
			Workbook workbook = Workbook.getWorkbook(new File("D://组合.xls"));
			Sheet sheet = workbook.getSheet(0);
			//逐行检索
			for(int row=0;row<sheet.getRows();row++)
			{
				//如果第一个单元格的数据为空，则判断EXCEL已到末尾
				if(CellType.EMPTY == sheet.getCell(0, row).getType() || StringUtil.isEmpty(sheet.getCell(0, row).getContents()))
					break;			
				pst.setString(1, String.format("%05d", startNumber));
				pst.setString(2, sheet.getCell(1,row).getContents().trim());
				pst.setString(3, Hanyupinyin.toHanyuPinyinCapital(sheet.getCell(1,row).getContents().trim()));
				pst.setString(4, deptMap.get(sheet.getCell(0,row).getContents().trim()).toString());
				pst.setString(5, "1");
				pst.setString(6, "0");
				pst.setString(7, "0");
				pst.setString(8, "003");
				pst.setString(9, "003");
				pst.setString(10, "0");
				pst.addBatch();
				System.out.print(startNumber+ ". " + sheet.getCell(0,row).getContents().trim() + ":" );
				System.out.println(deptMap.get(sheet.getCell(0,row).getContents().trim()).toString());
				startNumber++;
				if(row % 200 == 0)
				{
					pst.executeBatch();
					conn.commit();
					pst.clearBatch();
				}
			}
			pst.executeBatch();
			conn.commit();
			pst.clearBatch();
			pst.close();
			
			System.out.println("数据导入完成！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
	
	/**
	 * 导入项目项目组关系表
	 */
	public static void importR_ItemSet_Item(){
		Connection conn = null;
			/**
			 * 导入项目与项目组的关系			
			 */
		try{
			conn = getConnection();
			Connection conn2 = getConnection();
			conn.setAutoCommit(false);
			Statement stat = conn2.createStatement();			
			ResultSet rs = stat.executeQuery("select 对应系统组合编码,对应系统项目编码 from 临时表");
			PreparedStatement pst = conn.prepareStatement("insert into R_Item_ItemSet (itemSetCode,itemCode,id) values (?,?,?)");
			
			int startNumber = 1;
			System.out.println("开始数据导入！");			
			
			//逐行检索
			while(rs.next())
			{
	
				pst.setString(1, rs.getString("对应系统组合编码"));
				pst.setString(2, rs.getString("对应系统项目编码"));
				pst.setString(3, StringUtil.getUUID());
				pst.addBatch();
				
				if(startNumber % 200 == 0)
				{
					pst.executeBatch();
					conn.commit();
					pst.clearBatch();
				}
				startNumber++;
			}
			
			pst.executeBatch();
			conn.commit();
			pst.clearBatch();
			pst.close();
	
			rs.close();
			stat.close();
			conn2.close();
			
			System.out.println("数据导入完成！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
	
	/**
	 * 导入项目结论
	 */
	public static void importConclusion(){
		Connection conn = null;
 
		try{
			conn = getConnection();
			Connection conn2 = getConnection();
			conn.setAutoCommit(false);
			Statement stat = conn2.createStatement();			
			ResultSet rs = stat.executeQuery("select 体检结论名称,对应系统项目编码 from 体检结论表");
			PreparedStatement pst = conn.prepareStatement("insert into ExaminationConclusion (pid,itemCode,content,isPositive,isUse,pym,workState) values (?,?,?,?,?,?,?)");
			
			int startNumber = 1;
			System.out.println("开始数据导入！");			
			
			//逐行检索
			while(rs.next())
			{
	
				pst.setInt(1, startNumber);
				pst.setString(2, rs.getString("对应系统项目编码"));
				pst.setString(3, rs.getString("体检结论名称"));
				pst.setString(4, "0");
				pst.setString(5, "1");
				pst.setString(6, Hanyupinyin.toHanyuPinyinCapital(rs.getString("体检结论名称")));
				pst.setString(7, "10");
				pst.addBatch();
				
				if(startNumber % 200 == 0)
				{
					pst.executeBatch();
					conn.commit();
					pst.clearBatch();
				}
				startNumber++;
			}
			
			pst.executeBatch();
			conn.commit();
			pst.clearBatch();
			pst.close();
	
			rs.close();
			stat.close();
			conn2.close();
			
			System.out.println("数据导入完成！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
	}
	
	/**
	 * 导入结论描述
	 */
	public static void importDesc(){
		Connection conn = null;
		
		try{
			conn = getConnection();
			Connection conn2 = getConnection();
			conn.setAutoCommit(false);
			Statement stat = conn2.createStatement();			
			ResultSet rs = stat.executeQuery("select 描述,系统对应结论编号 from 体检描述临时表");
			PreparedStatement pst = conn.prepareStatement("insert into ExaminationDesc (descId,examinationConclusionId,descContent,isUse,isDefault) values (?,?,?,?,?)");
			
			int startNumber = 1;
			System.out.println("开始数据导入！");			
			
			//逐行检索
			while(rs.next())
			{
				
				pst.setString(1, StringUtil.getUUID());
				pst.setInt(2, rs.getInt("系统对应结论编号"));
				pst.setString(3, rs.getString("描述").trim());
				pst.setString(4, "1");
				pst.setString(5, "0");
				pst.addBatch();
				
				if(startNumber % 200 == 0)
				{
					pst.executeBatch();
					conn.commit();
					pst.clearBatch();
				}
				startNumber++;
			}
			
			pst.executeBatch();
			conn.commit();
			pst.clearBatch();
			pst.close();
			
			rs.close();
			stat.close();
			conn2.close();
			
			System.out.println("数据导入完成！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
	}
	
	public static void updateHarmFactorPYM(){
		Connection conn = null;
		List<String> sqlList = new ArrayList();
		try{
			conn = getConnection();
			Statement stat = conn.createStatement();	
			ResultSet rs = stat.executeQuery("select hfCode,hfName,pym from harmFactor");
			int i=1;
			while(rs.next()){
				System.out.println("update harmFactor set pym = '" + Hanyupinyin.toHanyuPinyinCapital(rs.getString("hfName")) + "' where hfCode = '"  + rs.getString("hfCode") + "' --" + i);
				i++;
			}
			rs.close();
			stat.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
}
