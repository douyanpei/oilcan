package web;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;


public class DwrWebScope implements WebScope {

	public DwrWebScope() {
	}

	@Override
	public ServletContext getServletContext() {
		WebContext ctx = WebContextFactory.get();
		if (ctx!=null)
			return ctx.getServletContext();
		return null;
	}
	
	@Override
	public HttpSession getSession() {
		WebContext ctx = WebContextFactory.get();
		if (ctx!=null)
			return ctx.getSession(true);
		return null;
	}

	@Override
	public HttpServletRequest getRequest() {
		WebContext ctx = WebContextFactory.get();
		if (ctx!=null)
			return ctx.getHttpServletRequest();
		return null;
	}

	@Override
	public HttpServletResponse getResponse() {
		WebContext ctx = WebContextFactory.get();
		if (ctx!=null)
			return ctx.getHttpServletResponse();
		return null;
	}
	
}
