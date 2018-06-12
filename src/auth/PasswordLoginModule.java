package auth;

import java.io.IOException;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import oilcan.base.container.ServiceLocator;

import auth.Authenticator;
import auth.PasswordAuthenticator;

public class PasswordLoginModule implements javax.security.auth.spi.LoginModule {

    protected final transient Log logger = LogFactory.getLog(getClass());
    
	Subject subject;
	
	CallbackHandler callbackHandler;
	
	Authenticator passwordAuthenticator;	
	

	public Authenticator getPasswordAuthenticator() {
		return passwordAuthenticator;
	}

	public void setPasswordAuthenticator(Authenticator passwordAuthenticator) {
		this.passwordAuthenticator = passwordAuthenticator;
	}

	public PasswordLoginModule() {
	}
	
	public void initialize(Subject subject, CallbackHandler callbackHandler, Map<String, ?>  sharedState, Map<String, ?>  options) {
		this.subject = subject;
        this.callbackHandler = callbackHandler; 
        this.passwordAuthenticator = ServiceLocator.getService("passwordAuthenticator", PasswordAuthenticator.class);
	}

	public boolean login() throws LoginException {
		//获取用户输入的用户名和密码
		NameCallback ncb = new NameCallback("name");
		PasswordCallback pcb = new PasswordCallback("Password",false);
		final Callback[] calls= new Callback[]{ncb,pcb};
		try {
			callbackHandler.handle(calls);
		} catch (IOException e) {
			throw new LoginException(e.getMessage());
		} catch (UnsupportedCallbackException e) {
			throw new LoginException(e.getMessage());
		}
		final String userName = ncb.getName();
		final String password = String.valueOf(pcb.getPassword());
		try{
			this.passwordAuthenticator.authenticate(new String[]{userName, password},this.subject);
		}catch(LoginException e){
			throw e;
		}
		return true;
	}

	public boolean commit() throws LoginException {
		return true;
	}
	
	public boolean abort() throws LoginException {
		logout();
		return true;
	}

	public boolean logout() throws LoginException {
		return true;
	}
}