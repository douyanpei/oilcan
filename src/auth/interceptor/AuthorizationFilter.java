package auth.interceptor;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.PrivilegedActionException;
import java.security.PrivilegedExceptionAction;

import javax.security.auth.Subject;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AuthorizationFilter implements Filter {

	public AuthorizationFilter() {
	}

	public void init(FilterConfig config) throws ServletException {
		System.out.println("[授权过滤器启动]");
	}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest)req).getSession(true);
		Subject subject = (Subject)session.getAttribute(Subject.class.getName());
		try {
			Subject.doAsPrivileged(subject, new AuthPrivilegedExceptionAction(req, res, chain), null);
		} catch(PrivilegedActionException paex) {
			Throwable ex = paex.getCause();
			while(ex!=null && !(ex instanceof SecurityException))
				ex = ex.getCause();
			if (ex!=null) {  //有SecurityException
				res.setContentType("text/html; charset=utf-8");
				PrintWriter out = res.getWriter();
				out.println("<html><head></head>");
				out.println("<body><script>alert('您没有执行该操作的权限!');self.close();history.back();</script>");
				out.println("</body></html>");
				return;
			}
			throw new ServletException(paex.getCause());
		}
	}

	public void destroy() {
		System.out.println("[授权过滤器停止]");
	}
	
}

class AuthPrivilegedExceptionAction implements PrivilegedExceptionAction<Object> {
	
	private ServletRequest req;
	private ServletResponse res;
	private FilterChain chain;

	public AuthPrivilegedExceptionAction(ServletRequest req, ServletResponse res, FilterChain chain) {
		super();
		this.req = req;
		this.res = res;
		this.chain = chain;
	}

	public AuthPrivilegedExceptionAction() {
	}

	public Object run() throws IOException, ServletException {
		chain.doFilter(req, res);
		return null;
	}
	
}


