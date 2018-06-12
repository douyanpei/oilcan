package oilcan.base.filter;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
/**
 * 非法字符过滤
 * @author PL
 *
 */
public class IllegalCharacterFilter implements Filter
{

	@Override
	public void destroy()
	{
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain filterChain) throws IOException, ServletException
	{
		HttpServletRequest request = (HttpServletRequest)req;
		Map map = request.getParameterMap();
		Collection collection= map.values();
		Iterator iterator = collection.iterator();
		while(iterator.hasNext())
		{	
			// 参数可能是一个数组
			String[] s = (String[]) iterator.next();
			for (int i = 0; i < s.length; i++)
			{
				s[i] = s[i].replaceAll("'", "");
			}
		}
		filterChain.doFilter(req, res);		
	}

	@Override
	public void init(FilterConfig config) throws ServletException
	{
		// TODO Auto-generated method stub
	}

}
