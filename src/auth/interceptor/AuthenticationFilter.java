package auth.interceptor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import javax.security.auth.Subject;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {
	
	private String loginPage;
	private Collection<String> excludedPaths;
	
	public AuthenticationFilter() {
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		loginPage = config.getInitParameter("loginPage");
		String excludedPathsInitParameterValue = config.getInitParameter("excludedPaths");
		if (excludedPathsInitParameterValue==null || excludedPathsInitParameterValue.length()==0)
			excludedPaths = new ArrayList<String>(0);
		else {
			String[] excludedPaths = excludedPathsInitParameterValue.split(",");
			for (int i = 0; i < excludedPaths.length; i++) {
				excludedPaths[i] = excludedPaths[i].trim();
				if (!excludedPaths[i].startsWith("/"))
					excludedPaths[i] = "/" + excludedPaths[i];
			}
			this.excludedPaths = Arrays.asList(excludedPaths);
		}
		System.out.println("[验证过滤器启动]");
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		if (!alreadyLoginned(req))//尚未成功登陆
			if (!isExcludedPath(req) && !isLoginPage(req)) {
				res.setContentType("text/html; charset=utf-8");
				PrintWriter out = res.getWriter();
				out.println("<script type='text/javascript'>location.replace('" + getLoginPageURL(req) + "');</script>");
				return;
			}
		chain.doFilter(req, res);
	}

	@Override
	public void destroy() {
		System.out.println("[验证过滤器停止]");
	}
	
	//是否已登陆
	private boolean alreadyLoginned(ServletRequest req) {
		HttpSession session = ((HttpServletRequest)req).getSession(true);
		Subject subject = (Subject)session.getAttribute(Subject.class.getName());
		if (subject==null)  //尚未成功登陆
			return false;
		return true;
	}
	
	//是否是排除路径
	private boolean isExcludedPath(ServletRequest req) {
		String requestPath = ((HttpServletRequest)req).getServletPath();
		if (excludedPaths.contains(requestPath))
			return true;
		for (String excludedPath : excludedPaths) {
			if (excludedPath.equals("/*"))
				return true;
			if (excludedPath.endsWith("/*")) {
				String s = excludedPath.substring(0, excludedPath.length() - 2);
				if (requestPath.startsWith(s))
					return true;
			}
		}
		return false;
	}
	
	private boolean isLoginPage(ServletRequest req) {
		HttpServletRequest request = (HttpServletRequest)req;
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		String requestURL = basePath + request.getServletPath();
		String loginPageURL;
		if (loginPage.startsWith("/"))
			loginPageURL = basePath + loginPage;
		else
			loginPageURL = basePath + "/" + loginPage;
		return requestURL.equalsIgnoreCase(loginPageURL);
	}
	
	private String getLoginPageURL(ServletRequest req) {
		HttpServletRequest request = (HttpServletRequest)req;
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		if (loginPage.startsWith("/"))
			return basePath + loginPage;
		return basePath + "/" + loginPage;
	}
	
}
