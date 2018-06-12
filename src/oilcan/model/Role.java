package oilcan.model;

public class Role implements java.io.Serializable {
	public static final String STATE_DISABLED = "禁用"; 
	public static final String STATE_USED = "在用"; 
	private String roleId;
	private String roleName;
	private String state;

	public Role() {
	}

	public Role(String roleName, String state) {
		this.roleName = roleName;
		this.state = state;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}