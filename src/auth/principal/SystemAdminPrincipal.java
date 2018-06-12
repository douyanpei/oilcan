package auth.principal;

import java.security.Principal;

public class SystemAdminPrincipal implements Principal, java.io.Serializable, Comparable<Principal> {
	private static final long serialVersionUID = -1351695412234732534L;
	
	private String userName;
	
	public SystemAdminPrincipal() {
	}

	public SystemAdminPrincipal(String userName) {
		if (userName==null)
			throw new NullPointerException("User ID是null");
		this.userName = userName;
	}
	
	@Override
	public int hashCode() {
		return userName.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj==null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final SystemAdminPrincipal other = (SystemAdminPrincipal) obj;
		if (userName==null){
			if (other.userName != null)
				return false;
		}else if (!userName.equals(other.userName)){
			return false;
		}
		return true;
	}

	@Override
	public String getName() {
		return userName;
	}

	public String toString() {
		return "SystemAdminPrincipal[name=" + userName + "]";
	}

	@Override
	public int compareTo(Principal o) {
		if (this==o) 
			return 0;
		if (o==null)
			return 1;
		if (o instanceof SystemAdminPrincipal) {
			SystemAdminPrincipal up = (SystemAdminPrincipal)o;
			return userName.compareTo(up.userName);
		} else
			throw new IllegalArgumentException("Principal类型不正确");
	}
	
}
