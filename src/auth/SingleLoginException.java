package auth;

import javax.security.auth.login.LoginException;

public class SingleLoginException extends LoginException {
	private static final long serialVersionUID = 1672819854826913923L;

	public SingleLoginException() {
	}

	public SingleLoginException(String message) {
		super(message);
	}

}
