package util;

import java.util.Date;

public class RoleConstants
{
	/**
	 * 系统使用权限
	 */
	public static String LICENSE_AUTHORIZED = null;
	
	/**
	 * 系统到期时间
	 */
	public static Date LICENSE_NOT_AFTER = null;
	
	/**
	 * 检查证书时间
	 */
	public static Date LICENSE_CHECK_DATE = null;
	
	/**
	 * 医院用户
	 */
	public static final String ROLE_HOSPITAL_UUID = "0002";
	
	public static final String ROLE_HOSPITAL_NAME = "医院";
	
	/**
	 * 交流中心用户
	 */
	public static final String ROLE_CENTER_UUID = "0001";
	
	public static final String ROLE_CENTER_NAME = "交流中心";
	
	/**
	 * 援外用户
	 */
	public static final String ROLE_FA_UUID = "0003";
	
	public static final String ROLE_FA_NAME = "援外用户";
	
	/**
	 * 管理员
	 */
	public static final String SYSTEM_MANAGE_UUID = "9999";
	
	public static final String SYSTEM_MANAGE_NAME = "管理员";

}
