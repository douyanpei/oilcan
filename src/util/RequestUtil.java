package util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.ServletRequestUtils;


/**
 * Convenience class for setting and retrieving cookies.
 */
public class RequestUtil extends ServletRequestUtils{
    private transient static Log log = LogFactory.getLog(RequestUtil.class);

    /**
     * Convenience method to set a cookie
     *
     * @param response
     * @param name
     * @param value
     * @param path
     */
    public static void setCookie(HttpServletResponse response, String name,
                                 String value, String path) {
        if (log.isDebugEnabled()) {
            log.debug("Setting cookie '" + name + "' on path '" + path + "'");
        }

        Cookie cookie = new Cookie(name, value);
        cookie.setSecure(false);
        cookie.setPath(path);
        cookie.setMaxAge(3600 * 24 * 30); // 30 days

        response.addCookie(cookie);
    }

    /**
     * Convenience method to get a cookie by name
     *
     * @param request the current request
     * @param name the name of the cookie to find
     *
     * @return the cookie (if found), null if not found
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        Cookie returnCookie = null;

        if (cookies == null) {
            return returnCookie;
        }

        for (int i = 0; i < cookies.length; i++) {
            Cookie thisCookie = cookies[i];

            if (thisCookie.getName().equals(name)) {
                // cookies with no value do me no good!
                if (!thisCookie.getValue().equals("")) {
                    returnCookie = thisCookie;

                    break;
                }
            }
        }

        return returnCookie;
    }

    /**
     * Convenience method for deleting a cookie by name
     *
     * @param response the current web response
     * @param cookie the cookie to delete
     * @param path the path on which the cookie was set (i.e. /appfuse)
     */
    public static void deleteCookie(HttpServletResponse response,
                                    Cookie cookie, String path) {
        if (cookie != null) {
            // Delete the cookie by setting its maximum age to zero
            cookie.setMaxAge(0);
            cookie.setPath(path);
            response.addCookie(cookie);
        }
    }
    
    /**
     * Convenience method to get the application's URL based on request
     * variables.
     */
    public static String getAppURL(HttpServletRequest request) {
        StringBuffer url = new StringBuffer();
    	int port = request.getServerPort();
        if (port < 0) {
            port = 80; // Work around java.net.URL bug
        }
        String scheme = request.getScheme();
        url.append(scheme);
        url.append("://");
        url.append(request.getServerName());
        if ((scheme.equals("http") && (port != 80)) || (scheme.equals("https") && (port != 443))) {
            url.append(':');
            url.append(port);
        }
        url.append(request.getContextPath());
        return url.toString();
    }
    public static Map getRequestParameterMap(HttpServletRequest request) {
		return getRequestParameterMap(request, "");
	}
    
    public static Map getRequestParameterMap(HttpServletRequest request, String id) {
		int lenghtOfId = (id == null) ? 0 : id.length();

		Map parameters = new HashMap(request.getParameterMap().size());
		for (Enumeration keys = request.getParameterNames(); keys.hasMoreElements();) {
			String key = (String) keys.nextElement();
			String[] values = request.getParameterValues(key);
			Object value = ((values == null) ? null : (values.length == 1 ? (Object) values[0] : (Object) values));

			if (lenghtOfId > 0) {
				if (key.endsWith(id)) {
					parameters.put(key.substring(0, key.length() - lenghtOfId), value);
				}
			} else {
				parameters.put(key, value);
			}

		}
		return parameters;
	}
    /**
     * 向HttpServletResponse的Writer写出一个json对象
     * @param res
     * @param jsonStr
     * @throws IOException
     */
    public static void writeJSONStr(HttpServletResponse res,String jsonStr) throws IOException {
    	PrintWriter pw = null;
    	try {
			pw = res.getWriter(); 
			pw.write(jsonStr);
			pw.flush();
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally{
			pw.close();
		}
    }
    /**
     * 获得Request中包括Parameter和Attribute在内的所有数据
     * @param req
     * @return
     */
    public static Map<String,Object> getAllParaAndAttr(HttpServletRequest req){
    	Map map = RequestUtil.getRequestParameterMap(req);
		Enumeration<String> names = req.getAttributeNames();
		while(names.hasMoreElements()){
			String name = names.nextElement();
			map.put(name, req.getAttribute(name));
		}
		return map;
    }
    /**
     * 从parameter中获取参数，如果没有得到该参数，则从attribute中获取
     * @param req request
     * @param name 参数名称
     * @param defaultValue 默认值
     * @return
     */
    public static String getParaOrAttr(ServletRequest req,String name,String defaultValue){
    	String value = req.getParameter(name);
    	if (value ==null || "".equals(value)) {
    		Object obj = req.getAttribute(name);
    		if(obj != null && obj instanceof String)
    			value = (String)obj;
    	}
    	if(value == null){
    		value = defaultValue;
    	}
    	return value;
    }
    /**
     * 从parameter中获取参数，如果没有得到该参数，则从attribute中获取
     * @param req request
     * @param name 参数名称
     * @return
     */
    public static String getParaOrAttr(ServletRequest req,String name){
    	String value = req.getParameter(name);
    	if (value ==null || "".equals(value)) {
    		Object obj = req.getAttribute(name);
    		if(obj != null && obj instanceof String)
    			value = (String)obj;
    	}
    	return value;
    }
    
    /**
     * 获得Controller名称
     * @param req
     * @return
     */
    public static String getControllerName(HttpServletRequest req){
    	StringBuffer url = req.getRequestURL();
    	return url.substring(url.lastIndexOf("/")+1,url.lastIndexOf("."));
    }
    

//    private static String getControllerName(String req){
//    	StringBuffer url = req.getRequestURL();
//    	return url.substring(url.lastIndexOf("/")+1,url.lastIndexOf("."));
//    }
//    
//    /**
//     * 获得按钮组ID
//     * @param req
//     * @return
//     */
//    public static String getButtonSetId(HttpServletRequest req){
//    	String uri = req.getRequestURI();
//    	String id = uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
//    	id += "."+req.getParameter("method")+"->";
//    	
//    	return id;
//    }
}
