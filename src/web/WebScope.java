package web;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface WebScope {
	
	ServletContext getServletContext();

	HttpSession getSession();

	HttpServletRequest getRequest();

	HttpServletResponse getResponse();

}
