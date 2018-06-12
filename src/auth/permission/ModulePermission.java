package auth.permission;

import java.security.BasicPermission;

public class ModulePermission extends BasicPermission {
	private static final long serialVersionUID = -6520046694705977652L;
	
	public ModulePermission(String name) {
		super(name);
	}

	public ModulePermission(String name, String actions) {
		super(name, actions);
	}
	
}

