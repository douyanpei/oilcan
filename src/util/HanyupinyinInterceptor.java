package util;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;

public class HanyupinyinInterceptor extends EmptyInterceptor {
	private static final long serialVersionUID = 7208298297158050234L;

	public static final char HANYUPINYIN_SEPARATOR = '\u001F';
	
	private static String[] hanyupinyinPropertyNames;
	
	public HanyupinyinInterceptor() {
	}

	public HanyupinyinInterceptor(String hanyupinyinPropertyNames) {
		HanyupinyinInterceptor.hanyupinyinPropertyNames = hanyupinyinPropertyNames.split(",");
		for (int i = 0; i < HanyupinyinInterceptor.hanyupinyinPropertyNames.length; i++)
			HanyupinyinInterceptor.hanyupinyinPropertyNames[i] = HanyupinyinInterceptor.hanyupinyinPropertyNames[i].trim();
	}

	public String[] getHanyupinyinPropertyNames() {
		return hanyupinyinPropertyNames;
	}

	// insert时调用
	@Override
	public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types) {
		if (hasProperty(entity, "pym")) {
			int hanyupinyinCapitalIndex = 0;
			for (int i = 0; i < propertyNames.length; i++) {
				if (propertyNames[i].equals("pym"))
					hanyupinyinCapitalIndex = i;
			}
			String hanyupinyincapital = "";
			for (int i = 0; i < hanyupinyinPropertyNames.length; i++)
				if (hasProperty(entity, hanyupinyinPropertyNames[i]))
					try {
						hanyupinyincapital += Hanyupinyin.toHanyuPinyinCapital((String)getProperty(entity, hanyupinyinPropertyNames[i])) ;
					} catch (BadHanyuPinyinOutputFormatCombination e) {
					}
			if(state[hanyupinyinCapitalIndex] == null || "".equals(state[hanyupinyinCapitalIndex]))
				state[hanyupinyinCapitalIndex] = hanyupinyincapital.toLowerCase();
		}
		return super.onSave(entity, id, state, propertyNames, types);
	}

	// update时调用
	@Override
	public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState, String[] propertyNames, Type[] types) {
		if (hasProperty(entity, "pym")) {
			int hanyupinyinCapitalIndex = 0;
			for (int i = 0; i < propertyNames.length; i++) {
				if (propertyNames[i].equals("pym"))
					hanyupinyinCapitalIndex = i;
			}
			String hanyupinyincapital = "";
			for (int i = 0; i < hanyupinyinPropertyNames.length; i++)
				if (hasProperty(entity, hanyupinyinPropertyNames[i]))
					try {
						hanyupinyincapital += Hanyupinyin.toHanyuPinyinCapital((String)getProperty(entity, hanyupinyinPropertyNames[i])) ;
					} catch (BadHanyuPinyinOutputFormatCombination e) {
					}
			if(currentState[hanyupinyinCapitalIndex] == null || "".equals(currentState[hanyupinyinCapitalIndex]))
				currentState[hanyupinyinCapitalIndex] = hanyupinyincapital.toLowerCase();
		}
		return super.onFlushDirty(entity, id, currentState, previousState, propertyNames, types);
	}
	
	private boolean hasProperty(Object entity, String propertyName) {
		try {
			return (PropertyUtils.getPropertyDescriptor(entity, propertyName)!=null)? true : false;
		} catch (IllegalAccessException e) {
			return false;
		} catch (InvocationTargetException e) {
			return false;
		} catch (NoSuchMethodException e) {
			return false;
		}
	}
	
	private Object getProperty(Object entity, String propertyName) {
		try {
			return PropertyUtils.getProperty(entity, propertyName);
		} catch (IllegalAccessException e) {
			return null;
		} catch (InvocationTargetException e) {
			return null;
		} catch (NoSuchMethodException e) {
			return null;
		}
	}

}
