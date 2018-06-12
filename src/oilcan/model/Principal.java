package oilcan.model;

import java.util.HashSet;
import java.util.Set;

public class Principal implements java.io.Serializable {

	private static final long serialVersionUID = -7371273171L;

	private String principalId;
	private String name;
	private String className;
	private Set permissions = new HashSet(0);

	public Principal() {
	}

	public Principal(String name, String className) {
		this.name = name;
		this.className = className;
	}

	public Principal(String name, String className, Set permissions) {
		this.name = name;
		this.className = className;
		this.permissions = permissions;
	}


	public String getPrincipalId() {
		return this.principalId;
	}

	public void setPrincipalId(String principalId) {
		this.principalId = principalId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getClassName() {
		return this.className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Set getPermissions() {
		return this.permissions;
	}

	public void setPermissions(Set permissions) {
		this.permissions = permissions;
	}

}