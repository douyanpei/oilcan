package auth.principal;

import java.security.Principal;

public class RolePrincipal implements Principal, java.io.Serializable, Comparable<Principal> {
	private static final long serialVersionUID = -5032182870211022484L;

	private String roleId;
	
	public RolePrincipal() {
	}

	public RolePrincipal(String roleId) {
		if (roleId==null)
			throw new NullPointerException("Role ID是null");
		this.roleId = roleId;
	}
	
	@Override
	public int hashCode() {
		return roleId.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj==null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final RolePrincipal other = (RolePrincipal) obj;
		if (roleId==null){
			if (other.roleId != null)
				return false;
		}else if (!roleId.equals(other.roleId)){
			return false;
		}
		return true;
	}

	@Override
	public String getName() {
		return roleId;
	}

	public String toString() {
		return "RolePrincipal[name=" + roleId + "]";
	}

	@Override
	public int compareTo(Principal o) {
		if (this==o) 
			return 0;
		if (o==null)
			return 1;
		if (o instanceof RolePrincipal) {
			RolePrincipal rp = (RolePrincipal)o;
			return roleId.compareTo(rp.roleId);
		} else
			throw new IllegalArgumentException("Principal类型不正确");
	}
	
}
