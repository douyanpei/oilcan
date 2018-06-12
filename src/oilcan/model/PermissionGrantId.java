package oilcan.model;

public class PermissionGrantId implements java.io.Serializable {

	private static final long serialVersionUID = -93138188321311L;

	private Principal principal;
	private Permission permission;

	public PermissionGrantId() {
	}

	public PermissionGrantId(Principal principal, Permission permission) {
		this.principal = principal;
		this.permission = permission;
	}


	public Principal getPrincipal() {
		return principal;
	}

	public void setPrincipal(Principal principal) {
		this.principal = principal;
	}

	public Permission getPermission() {
		return this.permission;
	}

	public void setPermission(Permission permission) {
		this.permission = permission;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof PermissionGrantId))
			return false;
		PermissionGrantId castOther = (PermissionGrantId) other;

		return ((this.getPrincipal() == castOther.getPrincipal()) || (this
				.getPrincipal() != null
				&& castOther.getPrincipal() != null && this.getPrincipal()
				.equals(castOther.getPrincipal())))
				&& ((this.getPermission() == castOther.getPermission()) || (this
						.getPermission() != null
						&& castOther.getPermission() != null && this
						.getPermission()
						.equals(castOther.getPermission())));
	
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getPrincipal() == null ? 0 : this.getPrincipal()
						.hashCode());
		result = 37
				* result
				+ (getPermission() == null ? 0 : this.getPermission()
						.hashCode());
		return result;
	}

}