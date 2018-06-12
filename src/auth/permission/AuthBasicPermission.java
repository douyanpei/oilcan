package auth.permission;

import java.security.BasicPermission;
import java.security.Permission;

public class AuthBasicPermission extends BasicPermission {

	private static final long serialVersionUID = -6520046694705977652L;
	
	public AuthBasicPermission(String name) {
		super(name);
	}

	public AuthBasicPermission(String name, String actions) {
		super(name, actions);
	}
}

