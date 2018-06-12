package oilcan.model;


public class PermissionGrant implements java.io.Serializable {

	private static final long serialVersionUID = -1464976031046126517L;
	
	private PermissionGrantId id;

	public PermissionGrant() {
	}

	public PermissionGrant(PermissionGrantId id) {
		this.id = id;
	}

	public PermissionGrantId getId() {
		return this.id;
	}

	public void setId(PermissionGrantId id) {
		this.id = id;
	}

	public Permission getPermission() {
		return this.id.getPermission();
	}


}