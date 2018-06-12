package oilcan.model;


public class ReportPage implements java.io.Serializable {

	private static final long serialVersionUID = 8867348783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private String code;
	private String materialType;
	private String mediumType;
	private String mediumNote;
	private String registerCode;
	private String roadCode;
	
	public ReportPage() {}

	public ReportPage(String pid, String baseId, String carNo, String code,
			String materialType, String mediumType, String mediumNote,
			String registerCode, String roadCode) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.code = code;
		this.materialType = materialType;
		this.mediumType = mediumType;
		this.mediumNote = mediumNote;
		this.registerCode = registerCode;
		this.roadCode = roadCode;
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

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMaterialType() {
		return materialType;
	}

	public void setMaterialType(String materialType) {
		this.materialType = materialType;
	}

	public String getMediumType() {
		return mediumType;
	}

	public void setMediumType(String mediumType) {
		this.mediumType = mediumType;
	}

	public String getMediumNote() {
		return mediumNote;
	}

	public void setMediumNote(String mediumNote) {
		this.mediumNote = mediumNote;
	}

	public String getRegisterCode() {
		return registerCode;
	}

	public void setRegisterCode(String registerCode) {
		this.registerCode = registerCode;
	}

	public String getRoadCode() {
		return roadCode;
	}

	public void setRoadCode(String roadCode) {
		this.roadCode = roadCode;
	}

}