package util;

/**
 * 前台输入验证类
 * 
 * @author zjm
 * 2010-11
 */
public class DataValidator {
	//是否为必填项
	private static boolean mustFill;
	//最大长度
	private static int maxLength;
	//最大值
	private static String max;
	//最小值
	private static String min;
	//是否是日期型
	private static boolean isDate;
	//是否是时间型
	private static boolean isDateTime;
	//是否是数值型
	private static boolean isNumeric;
	//是否是整数型
	private static boolean isInteger;
	//验证失败是提示信息，这里指验证控件的名称、代号
	private static String Info;

	//必填项的相应验证代码
	private static String strMustFill;
	//最大长度的相应验证代码
	private static String strMaxlen;
	//最大值的相应验证代码
	private static String strMax;
	//最小值的相应验证代码
	private static String strMin;
	//日期格式的相应验证代码
	private static String strisDate;
	//时间格式的相应验证代码
	private static String strisDateTime;
	//数值类型的相应验证代码
	private static String strNumeric;
	//整数类型的相应验证代码
	private static String strisInteger;
	//提示信息的相应代码
	private static String strInfo;

	/**
	 * 验证数字的方法
	 * 
	 * @param isMustfill
	 *            是否可以为空
	 * @param MaxValue
	 *            最大值
	 * @param MinValue
	 *            最小值
	 * @return 生成JS验证字符串
	 */
	public static String verifyNumeric(boolean isMustfill, String MaxValue,
			String MinValue) {
		ini();

		mustFill = isMustfill;
		isNumeric = true;
		max = MaxValue;
		min = MinValue;

		return creatCode();
	}

	/**
	 * 验证数字
	 * 
	 * @param isMustfill 是否必填
	 * @param MaxValue 最大值
	 * @param MinValue 最小值
	 * @param Info 提示信息
	 * @return
	 */
	public static String verifyNumeric(boolean isMustfill, String MaxValue,
			String MinValue, String info) {
		ini();

		mustFill = isMustfill;
		isNumeric = true;
		max = MaxValue;
		min = MinValue;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证数字
	 * 
	 * @param isMustfill 是否必填
	 * @return
	 */
	public static String verifyNumeric(boolean isMustfill) {
		ini();

		mustFill = isMustfill; 
		isNumeric = true;
		max = "99999999";
		min = "1";

		return creatCode();
	}

	/**
	 * 验证数字
	 * 
	 * @param isMustfill 是否必填
	 * @param Info 提示信息
	 * @return
	 */
	public static String verifyNumeric(boolean isMustfill, String info) {
		ini();

		mustFill = isMustfill;
		isNumeric = true;
		max = "99999999";
		min = "0";
		Info = info;

		return creatCode();
	}

	/**
	 * 验证整数
	 * 
	 * @param isMustfill 是否必填
	 * @param MaxValue 最大值
	 * @param MinValue 最小值
	 * @return
	 */
	public static String verifyInteger(boolean isMustfill, String MaxValue,
			String MinValue) {
		ini();

		mustFill = isMustfill;
		max = MaxValue;
		min = MinValue;
		isInteger = true;

		return creatCode();
	}

	/**
	 * 验证整数
	 * 
	 * @param isMustfill 是否必填
	 * @param MaxValue 最大值
	 * @param MinValue 最小值
	 * @param Info 提示信息
	 * @return
	 */
	public static String verifyInteger(boolean isMustfill, String MaxValue,
			String MinValue, String info) {
		ini();

		mustFill = isMustfill;
		max = MaxValue;
		min = MinValue;
		Info = info;
		isInteger = true;

		return creatCode();
	}

	/**
	 * 验证整数
	 * 
	 * @param isMustfill 是否必填
	 * @return
	 */
	public static String verifyInteger(boolean isMustfill) {
		ini();

		mustFill = isMustfill;
		max = "99999999";
		min = "1";
		isInteger = true;

		return creatCode();
	}

	/**
	 * 验证整数
	 * 
	 * @param isMustfill 是否必填
	 * @param Info 提示信息
	 * @return
	 */
	public static String verifyInteger(boolean isMustfill, String info) {
		ini();

		mustFill = isMustfill;
		max = "99999999";
		min = "1";
		Info = info;
		isInteger = true;

		return creatCode();
	}

	/**
	 * 验证字符串
	 * 
	 * @param isMustfill 是否必填
	 * @param Maxlen 最大长度
	 * @return
	 */
	public static String verifyString(boolean isMustfill, int Maxlen) {
		ini();

		mustFill = isMustfill;
		maxLength = Maxlen;

		return creatCode();
	}

	/**
	 * 验证字符串
	 * @param isMustfill 是否必填 
	 * @param Maxlen 最大长度
	 * @param info 提示信息
	 * @return
	 */
	public static String verifyString(boolean isMustfill, int Maxlen,
			String info) {
		ini();

		mustFill = isMustfill;
		maxLength = Maxlen;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证字符串
	 * @param isMustfill 是否必填
	 * @return
	 */
	public static String verifyString(boolean isMustfill) {
		ini();

		mustFill = isMustfill;
		maxLength = 32;

		return creatCode();
	}

	/**
	 * 验证字符串
	 * @param isMustfill 是否必填
	 * @param info 提示信息
	 * @return
	 */
	public static String verifyString(boolean isMustfill, String info) {
		ini();

		mustFill = isMustfill;
		maxLength = 32;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证日期格式
	 * 
	 * @param isMustfill 是否必填
	 * @return
	 */
	public static String verifyDate(boolean isMustfill) {
		ini();

		mustFill = isMustfill;
		isDate = true;

		return creatCode();
	}

	/**
	 * 验证日期格式
	 * @param isMustfill 是否必填
	 * @param info 提示信息
	 * @return
	 */
	public static String verifyDate(boolean isMustfill, String info) {
		ini();

		mustFill = isMustfill;
		isDate = true;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证时间格式
	 * @param isMustfill 是否必填
	 * @return
	 */
	public static String verifyTime(boolean isMustfill) {
		ini();

		mustFill = isMustfill;
		isDateTime = true;

		return creatCode();
	}

	/**
	 * 验证时间格式
	 * @param isMustfill 是否必填
	 * @param info 提示信息
	 * @return
	 */
	public static String verifyTime(boolean isMustfill, String info) {
		ini();

		mustFill = isMustfill;
		isDateTime = true;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证必填项
	 * @param info 提示信息
	 * @return
	 */
	public static String verifyFill(String info) {
		ini();

		mustFill = true;
		Info = info;

		return creatCode();
	}

	/**
	 * 验证必填项
	 * @return
	 */
	public static String verifyFill() {
		ini();

		mustFill = true;

		return creatCode();
	}

	/**
	 * 初始化
	 * 因为该类提供的都是静态方法，在执行每个验证时需要将内部变量全部初始化
	 */
	private static void ini() {
		strMustFill = "";
		strMaxlen = "";
		strMax = "";
		strMin = "";
		strisDate = "";
		strisDateTime = "";
		strNumeric = "";
		strisInteger = "";
		strInfo = "";

		mustFill = false;
		isNumeric = false;
		maxLength = 0;
		max = "";
		min = "";
		isDate = false;
		isDateTime = false;
		isInteger = false;
		Info = "";
	}

	/**
	 * 生成代码
	 * 根据验证方法所设置的值生成相应的验证代码，这些代码为JS代码，配合JS文件中的方法执行前台验证
	 */
	private static String creatCode() {
		StringBuffer sb;
		
		if (mustFill)
			strMustFill = " mustFill = \"true\" ";
		if (isNumeric)
			strNumeric = " isNumeric=\"true\" ";
		if (maxLength != 0) {
			sb = new StringBuffer();
			sb.append(" maxLength=\"");
			sb.append(maxLength);
			sb.append("\"");
			strMaxlen = sb.toString();
		}
		if (!"".equals(max)) {
			sb = new StringBuffer();
			sb.append(" max=\"");
			sb.append(max);
			sb.append("\"");
			strMax = sb.toString();
		}
		if (!"".equals(min)) {
			sb = new StringBuffer();
			sb.append(" min=\"");
			sb.append(min);
			sb.append("\"");
			strMin = sb.toString();
		}
			
		if (isDate)
			strisDate = " isDate= \"true\" ";
		if (isDateTime)
			strisDateTime = " isDateTime= \"true\" ";
		if (isInteger)
			strisInteger = " isInteger= \"true\"";
		if (!"".equals(Info)) {
			sb = new StringBuffer();
			sb.append(" promptName =\"");
			sb.append(Info);
			sb.append("\"");
			strInfo = sb.toString();
		}
			
		sb = new StringBuffer();
		sb.append(strMustFill);
		sb.append(strNumeric);
		sb.append(strMaxlen);
		sb.append(strMax);
		sb.append(strMin);
		sb.append(strisDate);
		sb.append(strisDateTime);
		sb.append(strisInteger);
		sb.append(strInfo);
		sb.append(" verify=\"true\"");
		return sb.toString();
	}

}