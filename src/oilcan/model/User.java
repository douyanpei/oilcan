package oilcan.model;


public class User implements java.io.Serializable {

	private static final long serialVersionUID = -2689229513604608861L;
 
	public static final String STATE_EXPIRED = "过期"; 
	public static final String STATE_DISABLED = "禁用"; 
	public static final String STATE_USED = "在用"; 
	private String userId;
	private String personId;
	private String userName;
	private String personName;
	private String password;
	private String createTime;
	private String lastModifyTime;
	private String lastLoginTime;
	private String lastLoginIp;
	private Boolean sysadmin;
	private Boolean userType;
	private String accountExpiredAt;
	private String state;
	private String pym;
	private String py;
	private String seniorityCode;

 
	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(String userName, String password, String createTime,
			Boolean sysadmin) {
		this.userName = userName;
		this.password = password;
		this.createTime = createTime;
		this.sysadmin = sysadmin;
	}

	/** full constructor */
	public User(String userName, String personName,
			String password, String createTime, String lastModifyTime,
			String lastLoginTime, String lastLoginIp, Boolean sysadmin,
			Boolean userType, String accountExpiredAt, String state,
			String pym, String py) {
		this.userName = userName;
		this.personName = personName;
		this.password = password;
		this.createTime = createTime;
		this.lastModifyTime = lastModifyTime;
		this.lastLoginTime = lastLoginTime;
		this.lastLoginIp = lastLoginIp;
		this.sysadmin = sysadmin;
		this.userType = userType;
		this.accountExpiredAt = accountExpiredAt;
		this.state = state;
		this.pym = pym;
		this.py = py;
	}

	// Property accessors

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPersonName() {
		return this.personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getLastModifyTime() {
		return this.lastModifyTime;
	}

	public void setLastModifyTime(String lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public String getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getLastLoginIp() {
		return this.lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	public Boolean getSysadmin() {
		return this.sysadmin;
	}

	public void setSysadmin(Boolean sysadmin) {
		this.sysadmin = sysadmin;
	}

	public Boolean getUserType() {
		return this.userType;
	}

	public void setUserType(Boolean userType) {
		this.userType = userType;
	}

	public String getAccountExpiredAt() {
		return this.accountExpiredAt;
	}

	public void setAccountExpiredAt(String accountExpiredAt) {
		this.accountExpiredAt = accountExpiredAt;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPym() {
		return this.pym;
	}

	public void setPym(String pym) {
		this.pym = pym;
	}

	public String getPy() {
		return this.py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	public String getSeniorityCode() {
		return seniorityCode;
	}

	public void setSeniorityCode(String seniorityCode) {
		this.seniorityCode = seniorityCode;
	}
	
	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}	
}