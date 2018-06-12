package auth;

import javax.security.auth.Subject;
import javax.security.auth.login.AccountNotFoundException;
import javax.security.auth.login.LoginException;

import oilcan.model.User;
import oilcan.service.UserService;
import util.MD5;
import auth.encryptor.Encryptor;

public class PasswordAuthenticator extends Authenticator {
	
	private Encryptor encryptor;
	
	public PasswordAuthenticator() {
	}

	public PasswordAuthenticator(UserService userService, boolean singlelogin, Encryptor encryptor) {
		super(userService, singlelogin);
		this.encryptor = encryptor;
	}

	public void authenticate(Object credentials,Subject subject) throws LoginException {
		if (credentials==null || !(credentials instanceof String[]) || ((credentials instanceof String[]) && ((String[])credentials).length!=2))
			throw new LoginException("credentials are not username and password");
		String username = ((String[])credentials)[0];
		String password = ((String[])credentials)[1];
		User user = this.userService.getUserByUserName(username);
		if(user!=null) {  //用户存在
			preauthenticate(user);
			// whether or not the password is correct
			String savedPassword = null;
			if(user.getPassword()==null)
				savedPassword = "";
			else
				savedPassword = user.getPassword().trim();
			String encryptedPassword = null;
			try {
				encryptedPassword = encryptor.encrypt(password);
			} catch (Exception e) {
				throw new LoginException(e.getMessage());
			}
			if (encryptedPassword==null)
				throw new LoginException("密码为空");
			if(!savedPassword.equals(MD5.hash(encryptedPassword)))  //password is incorrect
				throw new LoginException("密码不正确");
			this.buildSubject(user,subject);
			return;
		}
		throw new AccountNotFoundException("该用户不存在");
	}
	
	
}
