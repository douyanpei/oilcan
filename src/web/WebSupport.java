package web;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class WebSupport {
	
	protected WebScope webScope;

	public WebSupport() {
	}

	public WebSupport(WebScope webScope) {
		this.webScope = webScope;
	}

	public File getFile(String fileName) {
		return new File(getRealPath(fileName));
	}

	public String getRealPath(String virtualPath) {
		return webScope.getServletContext().getRealPath(virtualPath);
	}
	
	public String encodeFileName(String filename) {
		try {
			return URLEncoder.encode(filename, "utf-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}
	
}
