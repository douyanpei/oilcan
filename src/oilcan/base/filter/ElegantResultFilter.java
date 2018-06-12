package oilcan.base.filter;


import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.security.auth.login.LoginException;

import org.directwebremoting.AjaxFilter;
import org.directwebremoting.AjaxFilterChain;

import util.Constants;
import oilcan.CallResult;
import oilcan.RangeList;


public class ElegantResultFilter implements AjaxFilter {

	@Override
	public Object doFilter(Object object, Method method, Object[] args, AjaxFilterChain chain) throws Exception {
		Object result = null;
		try {
			result = chain.doFilter(object, method, args);
		} catch(Exception e) {
			e.printStackTrace();
			Class returnType = method.getReturnType();
			if (int.class.isAssignableFrom(returnType)) {
				result = Constants.FAILURE;
			} else if (CallResult.class.isAssignableFrom(returnType)) {
				Throwable ex = e.getCause();
				while(ex!=null && !(ex instanceof LoginException)) {
					ex = ex.getCause();
				}
				if (ex!=null) {
					result = new CallResult(Constants.FAILURE, ex.getMessage());
				} else {
					result = new CallResult(Constants.FAILURE, "登录或注销失败");
				}
			} else if (List.class.isAssignableFrom(returnType)) {
				result = new ArrayList(0);
			} else if (Set.class.isAssignableFrom(returnType)) {
				result = new TreeSet();
			} else if (RangeList.class.isAssignableFrom(returnType)) {
				result = new RangeList(new Object[0], 0);
			} else if (String.class.isAssignableFrom(returnType)) {
				result = "";
			} else if (String[].class.isAssignableFrom(returnType)) {
				result = new String[0];
			} else {
				result = null;
			}
		}
		return result;
	}

}