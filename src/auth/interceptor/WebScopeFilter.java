package auth.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.SpringWebScope;


public class WebScopeFilter implements Filter {

	public WebScopeFilter() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		SpringWebScope.requestLocal.set((HttpServletRequest)req);
		SpringWebScope.responseLocal.set((HttpServletResponse)res);
		SpringWebScope.sessionLocal.set(((HttpServletRequest)req).getSession());
		chain.doFilter(req, res);
	}


	@Override
	public void destroy() {
		
	}


	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

	
}
