package util;

import java.lang.reflect.Field;
import java.util.List;

public class SelectorUtil {

	static public String printOptions(List<Object[]> data){
		StringBuffer html = new StringBuffer();
		for(Object[] obj : data){
			html.append("<option value='").append(obj[0]).append("'>");
			html.append(obj.length>1?obj[1]:obj[0]);
			html.append("</option>");
		}
		return html.toString();
	}
	static public String printOptions(List<?> data,String valueName,String textName){
		StringBuffer html = new StringBuffer();
		for(Object obj : data){
			Class clazz = obj.getClass();
			String value = "";
			String text = "";
			try {
				Field valueField = clazz.getDeclaredField(valueName);
				valueField.setAccessible(true);
				Field textField = clazz.getDeclaredField(textName);
				textField.setAccessible(true);
				value = valueField.get(obj).toString();
				text = textField.get(obj).toString();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (NoSuchFieldException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			html.append("<option value='").append(value).append("'>");
			html.append(text);
			html.append("</option>");
		}
		return html.toString();
	}
}
