package oilcan.service;

import java.io.IOException;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

import util.RoleConstants;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.tjchxt.license.VerifyLicense;
import util.Constants;
import util.FileUtil;
import web.WebScope;
import auth.LoginModuleCfg;
import oilcan.CallResult;
import oilcan.base.service.ServiceSupport;
import oilcan.model.User;

public class LoginService extends ServiceSupport {
	private HibernateTemplate hdao;
	private WebScope webScope;

	public LoginService() {
	}

	public LoginService(HibernateTemplate hdao, WebScope webScope) {
		this.hdao = hdao;
		this.webScope = webScope;
	}

	public CallResult login(final String userName, final String passWord) throws UnknownHostException {
		try {
			LoginContext loginCtx = new LoginContext("OilcanAuth", null, new CallbackHandler() {
				@Override
				public void handle(Callback[] callbacks) throws IOException, UnsupportedCallbackException {
					for (int index = 0; index < callbacks.length; index++) {
						if (callbacks[index] instanceof NameCallback) {
							NameCallback ncb = (NameCallback) callbacks[index];
							ncb.setName(userName);
						} else if (callbacks[index] instanceof PasswordCallback) {
							PasswordCallback pcb = (PasswordCallback) callbacks[index];
							pcb.setPassword(passWord.toCharArray());
						}
					}
				}
			}, LoginModuleCfg.getConfiguration());
			loginCtx.login();
			User user = (User) hdao.find("from User where userName=?", userName).iterator().next();
			this.updateLoginInfo(user);
			this.bindUserToSession(user);
			webScope.getSession().setAttribute(Subject.class.getName(), loginCtx.getSubject());
			return new CallResult(Constants.SUCCESS, "");
		} catch (Exception e) {
			e.printStackTrace();
			return new CallResult(Constants.FAILURE, "登陆失败:" + e.getMessage());
		}
	}

	public String getRemortIP(HttpServletRequest request) {
		if (request.getHeader("x-forwarded-for") == null) {
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forwarded-for");
	}
	
	private void updateLoginInfo(User user) {
		user.setLastLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		user.setLastLoginIp(webScope.getRequest().getRemoteAddr());
		hdao.update(user);
	}
}
