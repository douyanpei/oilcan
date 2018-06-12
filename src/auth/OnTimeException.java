package auth;

import javax.security.auth.login.LoginException;

public class OnTimeException extends LoginException {
	private static final long serialVersionUID = 7858714386550007749L;

	public OnTimeException() {
	}

	public OnTimeException(String message) {
		super(message);
	}

}
