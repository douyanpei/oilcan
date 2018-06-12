package auth;

import javax.security.auth.callback.Callback;
import javax.servlet.http.HttpSession;

/**
 * <p> Underlying security services instantiate and pass a
 * <code>NameCallback</code> to the <code>handle</code>
 * method of a <code>CallbackHandler</code> to retrieve name information.
 *
 * @see javax.security.auth.callback.CallbackHandler
 */
public class SessionCallback implements Callback, java.io.Serializable {

    private static final long serialVersionUID = 3770938795909392253L;

    /**
     */
    private HttpSession session;

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}
}
