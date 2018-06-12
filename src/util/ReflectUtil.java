package util;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class ReflectUtil {

	
	static public List<Method> getMethods(Class<?> clazz,Class annotationClass){
		Method[] methods = clazz.getMethods();
		List<Method> list = new ArrayList<Method>();
		for(Method m :methods){
			if(m.getAnnotation(annotationClass)!=null){
				list.add(m);
			}
		}
		return list;
	}

	static public Object[] matchArgsTypes(Class<?>[] argClass,Object[] args){
		if(argClass.length != args.length){
			throw new ClassCastException("参数数量不匹配");
		}else{
			for(int i=0;i<argClass.length;i++){
				Class<?> clazz = argClass[i];
				if(args[i] == null || args[i].getClass().equals(clazz) || clazz.isInstance(args[i])){
					continue;
				}else if(args[i] instanceof BigDecimal){
					BigDecimal value = (BigDecimal)args[i];
					if(Short.class.equals(clazz) || short.class.equals(clazz)){
						args[i] = new Short(value.shortValue());
					}else if(Integer.class.equals(clazz) || int.class.equals(clazz)){
						args[i] = new Integer(value.intValue());
					}else if(Long.class.equals(clazz) || long.class.equals(clazz)){
						args[i] = new Long(value.longValue());
					}else if(Byte.class.equals(clazz) || byte.class.equals(clazz)){
						args[i] = new Byte(value.byteValue());
					}else if(Float.class.equals(clazz) || float.class.equals(clazz)){
						args[i] = new Float(value.floatValue());
					}else if(Double.class.equals(clazz) || double.class.equals(clazz)){
						args[i] = new Double(value.doubleValue());
					}else if(BigInteger.class.equals(clazz) ){
						args[i] = value.toBigInteger();
					}else{
						throw new ClassCastException("参数的"+clazz+"类型不能匹配");
					}
				}else{
					throw new ClassCastException("参数的"+clazz+"类型不能匹配");
				}
			}
		}
		return args;
	}
	
}
