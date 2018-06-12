package auth;

import java.security.Principal;
import java.util.List;
import java.util.Set;

import javax.security.auth.Subject;
import javax.security.auth.login.AccountException;
import javax.security.auth.login.AccountLockedException;
import javax.security.auth.login.LoginException;

import oilcan.model.Role;
import oilcan.model.User;
import oilcan.service.UserService;
import auth.principal.RolePrincipal;
import auth.principal.SystemAdminPrincipal;
import auth.principal.UserPrincipal;

public abstract class Authenticator {
	
	protected UserService userService;
	protected boolean singlelogin;
	
	public Authenticator() {
	}

	public Authenticator(UserService userService, boolean singlelogin) {
		this.userService = userService;
		this.singlelogin = singlelogin;
	}

	protected void preauthenticate(User user) throws LoginException {
//		if(!user.getUserType() && !StringUtil.isEmpty(user.getAccountExpiredAt())){
//			try {
//				if (new Date(System.currentTimeMillis()).after(new SimpleDateFormat("yyyy-MM-dd").parse(user.getAccountExpiredAt()))){
//					user.setState(User.STATE_EXPIRED);
//					user.getPersonInfo().setState(User.STATE_EXPIRED);
//					userService.updateUser(user);
//					throw new AccountExpiredException("对不起，您的账号已过期,请联系管理员!");
//				}
//			} catch (ParseException e) {
//				throw new LoginException("您的账号已过期,请联系管理员!");
//			}
//		}
		if (User.STATE_DISABLED.equals(user.getState()))  				
			throw new AccountLockedException("对不起，您的账号被禁用!");
	}
	
	protected void buildSubject(User user,Subject subject) {
		Set<Principal> pSet = subject.getPrincipals();
		pSet.add(new UserPrincipal(user.getUserId()));
		if(user.getSysadmin()){
			pSet.add(new SystemAdminPrincipal(user.getUserName()));
		}else{
			List<Role> roleList = this.userService.getRolesByUserId(user.getUserId());
			for(Role role : roleList)
				pSet.add(new RolePrincipal(role.getRoleId()));
		}
	}
	
	public abstract void authenticate(Object credentials,Subject subject) throws LoginException,AccountException;
	
}
