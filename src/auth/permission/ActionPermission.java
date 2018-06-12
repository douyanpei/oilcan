package auth.permission;

import java.security.BasicPermission;

public class ActionPermission extends BasicPermission {
	private static final long serialVersionUID = -6520046694705977652L;
	
	public ActionPermission(String name) {
		super(name);
	}

	public ActionPermission(String name, String actions) {
		super(name, actions);
	}
	
}

