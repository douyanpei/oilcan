package oilcan.model;

import java.util.HashSet;
import java.util.Set;

public class Permission implements java.io.Serializable {

	private static final long serialVersionUID = 3255637604591209849L;

	private String permissionId;
	private Permission permission;
	private Integer level;
	private String code;
	private String name;
	private String description;
	private String showOrder;
	private String url;
	private String pym;
	private String className;
	private String img;
	private Set principals = new HashSet(0);
	private Set permissions = new HashSet(0);

	public Permission() {
	}

	public Permission(String permissionId, Permission permission,
			Integer level, String code, String name, String description,
			String showOrder, String url, String pym, String className,
			String img, Set principals, Set permissions) {
		this.permissionId = permissionId;
		this.permission = permission;
		this.level = level;
		this.code = code;
		this.name = name;
		this.description = description;
		this.showOrder = showOrder;
		this.url = url;
		this.pym = pym;
		this.className = className;
		this.img = img;
		this.principals = principals;
		this.permissions = permissions;
	}

	public String getPermissionId() {
		return this.permissionId;
	}

	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}

	public Permission getPermission() {
		return this.permission;
	}

	public void setPermission(Permission permission) {
		this.permission = permission;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getShowOrder() {
		return this.showOrder;
	}

	public void setShowOrder(String showOrder) {
		this.showOrder = showOrder;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPym() {
		return this.pym;
	}

	public void setPym(String pym) {
		this.pym = pym;
	}

	public String getClassName() {
		return this.className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Set getPrincipals() {
		return this.principals;
	}

	public void setPrincipals(Set principals) {
		this.principals = principals;
	}

	public Set<Permission> getPermissions() {
		return this.permissions;
	}

	public void setPermissions(Set permissions) {
		this.permissions = permissions;
	}
	
	public String getImg()
	{
		return img;
	}

	public void setImg(String img)
	{
		this.img = img;
	}

	@Override
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("{id:");
		sb.append("'" + permissionId + "',data:[");
		sb.append("'',");
		sb.append("'" + code + "',");
		sb.append("'" + name + "',");
		sb.append("'" + showOrder + "',");
		sb.append("'" + pym + "',");
		sb.append("'" + img + "',");
		sb.append("'" + url + "',");
		sb.append("'" + className + "',");
		sb.append("'" + level + "',");
		sb.append("'" + description + "']}");
		return sb.toString();
	}
}