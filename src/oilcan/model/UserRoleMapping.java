package oilcan.model;

public class UserRoleMapping implements java.io.Serializable {


	private UserRoleId id;

	public UserRoleMapping() {
	}

	public UserRoleMapping(UserRoleId id) {
		this.id = id;
	}

	public UserRoleId getId() {
		return this.id;
	}

	public void setId(UserRoleId id) {
		this.id = id;
	}

}