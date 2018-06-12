package util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * 字符串操作工具类
 * @author liyx
 *
 */
public class StringUtil {

	static public String arrayToString(Object[] objs,String separatMarks,String wrapMarks,String escapNull){
		StringBuffer sb = new StringBuffer();
		for(int i =0;i<objs.length;i++){
			String temp = escapNull;
			if(objs[i] != null){
				temp = objs[i].toString();
			}
			if(wrapMarks != null){
				sb.append(wrapMarks).append(temp).append(wrapMarks);
			}else{
				sb.append(temp);
			}
			if(separatMarks != null){
				sb.append(separatMarks);
			}
		}
		if(sb.length()>0 && separatMarks != null){
			sb.delete(sb.length()-separatMarks.length(), sb.length());
		}
		return sb.toString();
	}
	static public String arrayToString(Object[] objs,String separatMarks,String wrapMarks){
		return StringUtil.arrayToString(objs, separatMarks, wrapMarks, "");
	}
	static public String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	static public int stringToInt(String number,int defaultValue){
		int num = defaultValue;
		try{
			num = Integer.parseInt(number);
		}catch(Exception e){
		}
		return num;
	}
	
	static public Integer stringToInteger(String number,Integer defaultValue){
		Integer num = defaultValue;
		try{
			num = Integer.parseInt(number);
		}catch(Exception e){
		}
		return num;
	}
	
	static public Double stringToDouble(Object o,Double defaultValue){
		
		   try{
		          double d = (new Double(escapeNull(o))).doubleValue(); 
		          return d;
		      }
		      catch(Exception e){
		      }
		      
		      return defaultValue;
	}
	
	
	public static boolean isNumeric(String str){

		return str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
     }

	public static void main(String[] args) {
		
		System.out.println(isNumeric("1.01"));
		
	}
	
	static public String formatDate(String dateStr){
		if(dateStr != null && dateStr.length()==8)
			return dateStr.substring(0, 4) + "-" + dateStr.substring(4,6) + "-" + dateStr.substring(6, 8);
		else 
			return dateStr;
	}
	/**
	 * 获得拼音码（拼音首字母），大写
	 * @param name
	 * @return
	 */
	public static String getPYM(String name){
		//汉语拼音格式输出类   
		HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();   

		//输出设置，大小写，音标方式等   
		hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);    
		hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);   
		hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);   
		char[] srcChar = name.toCharArray();   
		String temp = "";   
		for(int j=0;j<srcChar.length;j++){   
			char c = srcChar[j];   
			//是中文或者a-z或者A-Z转换拼音(我的需求，是保留中文或者a-z或者A-Z)   
			if(String.valueOf(c).matches("[\\u4E00-\\u9FA5]+")){   
				try{   
					String[] pp = PinyinHelper.toHanyuPinyinStringArray(srcChar[j], hanYuPinOutputFormat);
					if(pp.length > 0 &&  pp[0].length()>0){
						temp += pp[0].charAt(0);
					}
				}catch(BadHanyuPinyinOutputFormatCombination e) {   
					e.printStackTrace();   
				}   
			}else{   
				temp += String.valueOf(srcChar[j]).toUpperCase();   
			}   
		}
		return temp;
	}
	/**
	 * 获得全拼
	 * @param name
	 * @return
	 */
	public static String getPY(String name){
		//汉语拼音格式输出类   
		HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();   
		//输出设置，大小写，音标方式等   
		hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);    
		hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);   
		hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);   
		char[] srcChar = name.toCharArray();   
		String temp = "";   
		for(int j=0;j<srcChar.length;j++){   
			char c = srcChar[j];   
			//如果是中文
			if(String.valueOf(c).matches("[\\u4E00-\\u9FA5]+")){   
				try{   
					String[] pp = PinyinHelper.toHanyuPinyinStringArray(srcChar[j], hanYuPinOutputFormat);
					if(pp.length > 0 &&  pp[0].length()>0){
						temp += pp[0];
					}
				}catch(BadHanyuPinyinOutputFormatCombination e) {   
					e.printStackTrace();   
				}   
			}else{   
				temp += String.valueOf(srcChar[j]).toUpperCase();   
			}   
		}
		return temp;
	}
	
	public static String escapeNull(String str){
		return str == null ? "" : str.trim();
	}
	
	public static String escapeNull(Object obj){
		return obj == null ? "" : obj.toString();
	}
	
	public static String escapeDouble(Object obj){
		return isEmpty(obj) ? null : obj.toString();
	}
	
	public static String escapeNull(Object obj, String defaultValue){
		return obj == null ? defaultValue : obj.toString();
	}
	
	public  static boolean isEmpty(String str){
		return str == null || str.equals("") || str.equals("null");
	}
	
	public  static boolean isEmpty(Object obj){
		return obj == null || obj.toString().equals("");
	}
	
	public static boolean isChineseChar(String str){
        boolean temp = false;
        Pattern p=Pattern.compile("[\u4e00-\u9fa5]"); 
        Matcher m=p.matcher(str); 
        if(m.find()){ 
            temp =  true;
        }
        return temp;
    }
	
	/**
	 * 消除 list<String> 中，重复数据
	 * @param list
	 * @return
	 */
	public static List<String> removeDuplicateList(List<String> list) {
		   Set set = new HashSet();
		   List<String> newList = new ArrayList<String>();
		   for (Iterator iter = list.iterator(); iter.hasNext();) {
		          String element = (String) iter.next();
		          if (set.add(element))
		             newList.add(element);
		       }
		     
		   return newList;
	}
	
	public static String ListToArrStr(List<String> list){
		
		StringBuffer arr = new StringBuffer();
		for(String a : list){
			arr.append("'"+a+"',");
		}
		if(arr.length() != 0)
			arr.deleteCharAt(arr.length()-1);
		
		return arr.toString();
		
	}
	
	
	
}
