package oilcan.model;

public class CheckRecord implements java.io.Serializable{

	private static final long serialVersionUID = 4322750215439704357L;
	
	private String pid;
	private String baseId;
	private String description;
	
	public CheckRecord(){}

	public CheckRecord(String pid, String baseId, String description) {
		this.pid = pid;
		this.baseId = baseId;
		this.description = description;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getBaseId() {
		return baseId;
	}

	public void setBaseId(String baseId) {
		this.baseId = baseId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
