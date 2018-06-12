package auth.principal;

import java.security.Principal;

public class OrganizationPrincipal implements Principal, java.io.Serializable, Comparable<Principal> {
	private static final long serialVersionUID = -5032182870211022484L;

	private String orgId;
	
	public OrganizationPrincipal() {
	}

	public OrganizationPrincipal(String orgId) {
		if (orgId==null)
			throw new NullPointerException("Role ID是null");
		this.orgId = orgId;
	}
	
	@Override
	public int hashCode() {
		return orgId.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj==null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final OrganizationPrincipal other = (OrganizationPrincipal) obj;
		if (orgId==null)
			if (other.orgId != null)
				return false;
		else if (!orgId.equals(other.orgId))
			return false;
		return true;
	}

	@Override
	public String getName() {
		return orgId;
	}

	public String toString() {
		return "RolePrincipal[name=" + orgId + "]";
	}

	@Override
	public int compareTo(Principal o) {
		if (this==o) 
			return 0;
		if (o==null)
			return 1;
		if (o instanceof UserPrincipal) {
			UserPrincipal up = (UserPrincipal)o;
			return orgId.compareTo(up.getName());
		} else if (o instanceof OrganizationPrincipal) {
			OrganizationPrincipal rp = (OrganizationPrincipal)o;
			return orgId.compareTo(rp.orgId);
		} else
			throw new IllegalArgumentException("Principal类型不正确");
	}
	
}
