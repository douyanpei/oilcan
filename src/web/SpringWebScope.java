package web;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.ServletContextAware;


public class SpringWebScope implements WebScope,ServletContextAware {

	static public ThreadLocal<HttpSession> sessionLocal = new ThreadLocal<HttpSession>();
	static public ThreadLocal<HttpServletRequest> requestLocal = new ThreadLocal<HttpServletRequest>();
	static public ThreadLocal<HttpServletResponse> responseLocal = new ThreadLocal<HttpServletResponse>();
	
	ServletContext servletContext;

	public SpringWebScope() {
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;		
	}
	@Override
	public ServletContext getServletContext() {
		return servletContext;
	}
	
	@Override
	public HttpSession getSession() {
		return sessionLocal.get();
	}

	@Override
	public HttpServletRequest getRequest() {
		return requestLocal.get();
	}

	@Override
	public HttpServletResponse getResponse() {
		return responseLocal.get();
	}
	
}
