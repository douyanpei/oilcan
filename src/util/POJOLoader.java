package util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * <p>Title: POJO对象装载类</p>
 * <p>Description: 用于将HttpServletRequest中的parameter自动载入Hibernate的POJO对象中。 </p>
 * <p>Copyright: Copyright (c) </p>
 * <p>Company: </p>
 * @author <a href="mailTo:liyingxu30@gmail,com">李迎旭</a>
 * @version 1.0
 */
public class POJOLoader {

	public static void load(Object pojo, Map parameterMap) throws Exception{
		load(pojo, parameterMap, 0,null);
	}
	/**
	 * 从Map中将属性载入POJO对象，POJO对象的属性名要与Map中的key相同，
	 * 并且POJO提供set方法，方法名set（小写）开头，后面接属性名，且首字母大写。
	 * @param pojo 
	 * @param parameterMap
	 * @param index 参数数组中的第几个值被赋值到pojo中
	 * @param prefix 所有参数名称的前缀
	 * @throws Exception
	 */
	private static void load(Object pojo, Map parameterMap,int index,String prefix) throws Exception{
		if(pojo == null){
			throw new Exception("POJO 为空！");
		}
		Method[] methods = pojo.getClass().getMethods();
		for (int i = 0; i < methods.length; i++) {
			String methodName = methods[i].getName();
			//set方法中set必须是小写
			if(methodName.startsWith("set")){
				//根据set方法获得属性名，并将首字母小写
				String fieldName = methodName.substring(3);
				String firstChar = fieldName.substring(0, 1);
				fieldName = firstChar.toLowerCase() + fieldName.substring(1);
				//获得属性值
				Object[] temp = (Object[])parameterMap.get((prefix==null?"":prefix)+fieldName);
				Object value;
				if(temp != null && temp.length>0){
					//如果参数中没有第index个参数，那么取第一个
					if(temp.length >index){
						value = temp[index];
					}else{
						value = temp[0];
					}
				}else{
					continue;
				}
				if(value != null && !"".equals(value)){
					Class<?>[] argumentClasses = methods[i].getParameterTypes();
					if(argumentClasses.length ==1 ){
						Class<?> argumentClass = argumentClasses[0];
						Object parameters = null;
						if(value.getClass().equals(argumentClass)){
							parameters = value;
						}else{
							if(Number.class.equals(argumentClass.getSuperclass())){//如果是数字
								if(value instanceof String){//去掉逗号分隔符
									value = value.toString().trim().replaceAll(",", "");
								}
							}
							if(Boolean.class.equals(argumentClass) || boolean.class.equals(argumentClass) ){
								parameters = Boolean.parseBoolean(value.toString());
							}else if(Short.class.equals(argumentClass) || short.class.equals(argumentClass) ){
								parameters = Short.valueOf(value.toString());
							}else if(Integer.class.equals(argumentClass) || int.class.equals(argumentClass) ){
								parameters = Integer.valueOf(value.toString());
							}else if(Long.class.equals(argumentClass) || long.class.equals(argumentClass) ){
								parameters = Long.valueOf(value.toString());
							}else if(Float.class.equals(argumentClass) || float.class.equals(argumentClass)){
								parameters = Float.valueOf(value.toString());
							}else if(Double.class.equals(argumentClass) || double.class.equals(argumentClass) ){
								parameters = Double.valueOf(value.toString());
							}else if(String.class.equals(argumentClass)){
								parameters = value.toString();
								
							}else if(Date.class.equals(argumentClass)){
								parameters = new Date((Calendar.getInstance().getTimeInMillis()));
							}else{
								//没有匹配的属性类型，抛出异常
								throw new POJOLoadException("no Class match, please put Map with your object.");
							}
						}
						if(parameters != null){
							//执行set方法
							methods[i].invoke(pojo,parameters);
						}
					}
				}else if("".equals(value)){
					Class<?>[] argumentClasses = methods[i].getParameterTypes();
					if(argumentClasses.length ==1 )
						methods[i].invoke(pojo,new Object[]{null});
				}
			}
		}
	}
	/**
	 * 从Map中将属性载入POJO对象，POJO对象的属性名要与req中的parameterName相同，
	 * 并且POJO提供set方法，方法名set（小写）开头，后面接属性名，且首字母大写。
	 * @param pojo
	 * @param req
	 * @throws Exception
	 */
	public static void load(Object pojo, HttpServletRequest req) throws Exception{
		load(pojo, req.getParameterMap());
	}
	/**
	 * 实例化clazz对象，并load
	 * @param clazz
	 * @param req
	 * @return Object
	 * @throws Exception
	 */
	public static <T> T load(Class<T> clazz, HttpServletRequest req) throws Exception{
		T pojo= clazz.newInstance();
		load(pojo, req.getParameterMap());
		return pojo;
	}

	/**
	 * 实例化clazz对象，并load,返回pojo list
	 * @param clazz
	 * @param size
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static <T> List<T> load(Class<T> clazz,int size, HttpServletRequest req) throws Exception{
		return load(clazz, size, req, null);
	}
	/**
	 * 实例化clazz对象，并load,返回pojo list
	 * @param clazz
	 * @param size
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static <T> List<T> load(Class<T> clazz,int size, HttpServletRequest req,String prefix) throws Exception{
		List<T> list = new ArrayList<T>();
		for(int i=0;i<size;i++){
			T pojo= clazz.newInstance();
			load(pojo, req.getParameterMap(),i,prefix);
			list.add(pojo);
		}
		return list;
	}
	/**
	 * 拆解Pojo对象成Map
	 * @param pojo
	 * @return
	 */
	public static Map<String, Object> disassemble(Object pojo){
		Field[] fs = pojo.getClass().getDeclaredFields(); 
		Map<String, Object> ret = new HashMap<String, Object>();
		for (int i = 0; i < fs.length; i++) {
			try {
				fs[i].setAccessible(true);
				ret.put(fs[i].getName(), fs[i].get(pojo));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return ret;
	}
	/**
	 * 拆解Pojo对象并放入输入框中
	 * @param pojo
	 * @return javascripgt脚本代码，用于赋值
	 */
	public static String disassemblePutInInput(Object pojo){
		if(pojo == null) return "";
		Field[] fs = pojo.getClass().getDeclaredFields(); 
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < fs.length; i++) {
			try {
				fs[i].setAccessible(true);
				Object value = fs[i].get(pojo);
				if(value != null){
					value = value.toString().replaceAll("\"", "'");
					sb.append("$(\"[name='").append(fs[i].getName()).append("']\").val(\"").append(value).append("\");\n");
				}
					
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return sb.toString();
	}
	/**
	 * 拆解Pojo对象，并设置到request的attribute
	 * @param pojo
	 * @param req
	 */
	public static void disassemble(Object pojo,HttpServletRequest req){
		Field[] fs = pojo.getClass().getDeclaredFields(); 
		for (int i = 0; i < fs.length; i++) {
			try {
				fs[i].setAccessible(true);
				req.setAttribute(fs[i].getName(), fs[i].get(pojo));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
	}
}
