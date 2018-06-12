package auth.principal;

import java.security.Principal;

public class UserPrincipal implements Principal, java.io.Serializable, Comparable<Principal> {
	private static final long serialVersionUID = -1351695412234732534L;
	
	private String userId;
	
	public UserPrincipal() {
	}

	public UserPrincipal(String userId) {
		if (userId==null)
			throw new NullPointerException("User ID是null");
		this.userId = userId;
	}
	
	@Override
	public int hashCode() {
		return userId.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj==null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final UserPrincipal other = (UserPrincipal) obj;
		if (userId==null){
			if (other.userId != null)
				return false;
		}else if (!userId.equals(other.userId)){
			return false;
		}
		return true;
	}

	@Override
	public String getName() {
		return userId;
	}

	public String toString() {
		return "UserPrincipal[name=" + userId + "]";
	}

	@Override
	public int compareTo(Principal o) {
		if (this==o) 
			return 0;
		if (o==null)
			return 1;
		if (o instanceof UserPrincipal) {
			UserPrincipal up = (UserPrincipal)o;
			return userId.compareTo(up.userId);
		} else
			throw new IllegalArgumentException("Principal类型不正确");
	}

}
