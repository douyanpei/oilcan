package auth;

import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.LoginException;

public class AuthLoginModule implements javax.security.auth.spi.LoginModule {
	
	public AuthLoginModule() {
	}
	
	public void initialize(Subject subject, CallbackHandler callbackHandler, Map<String, ?>  sharedState, Map<String, ?>  options) {
	}

	public boolean login() throws LoginException {
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