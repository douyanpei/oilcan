package oilcan.model;


public class DetermineShow implements java.io.Serializable {

	private static final long serialVersionUID = 5643348783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private String deviceModel;
	private String oilcanMaterial;
	private String deviceCrack;
	private String coverHeader;
	private Double tube;
	private String coupling;
	private Integer gaugeNum;
	private String thickness;
	private Integer image1;
	private Integer image2;
	private String showCheck;
	private String conclusion;
	private String checkPerson;
	
	
	public DetermineShow() {}

	public DetermineShow(String pid, String baseId, String carNo,
			String deviceModel, String oilcanMaterial, String deviceCrack,
			String coverHeader, Double tube, String coupling, Integer gaugeNum,
			String thickness, Integer image1, Integer image2, String showCheck,
			String conclusion, String checkPerson) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.deviceModel = deviceModel;
		this.oilcanMaterial = oilcanMaterial;
		this.deviceCrack = deviceCrack;
		this.coverHeader = coverHeader;
		this.tube = tube;
		this.coupling = coupling;
		this.gaugeNum = gaugeNum;
		this.thickness = thickness;
		this.image1 = image1;
		this.image2 = image2;
		this.showCheck = showCheck;
		this.conclusion = conclusion;
		this.checkPerson = checkPerson;
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

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getOilcanMaterial() {
		return oilcanMaterial;
	}

	public void setOilcanMaterial(String oilcanMaterial) {
		this.oilcanMaterial = oilcanMaterial;
	}

	public String getDeviceCrack() {
		return deviceCrack;
	}

	public void setDeviceCrack(String deviceCrack) {
		this.deviceCrack = deviceCrack;
	}

	public String getCoverHeader() {
		return coverHeader;
	}

	public void setCoverHeader(String coverHeader) {
		this.coverHeader = coverHeader;
	}

	public Double getTube() {
		return tube;
	}

	public void setTube(Double tube) {
		this.tube = tube;
	}

	public String getCoupling() {
		return coupling;
	}

	public void setCoupling(String coupling) {
		this.coupling = coupling;
	}

	public Integer getGaugeNum() {
		return gaugeNum;
	}

	public void setGaugeNum(Integer gaugeNum) {
		this.gaugeNum = gaugeNum;
	}

	public String getThickness() {
		return thickness;
	}

	public void setThickness(String thickness) {
		this.thickness = thickness;
	}

	public Integer getImage1() {
		return image1;
	}

	public void setImage1(Integer image1) {
		this.image1 = image1;
	}

	public Integer getImage2() {
		return image2;
	}

	public void setImage2(Integer image2) {
		this.image2 = image2;
	}

	public String getShowCheck() {
		return showCheck;
	}

	public void setShowCheck(String showCheck) {
		this.showCheck = showCheck;
	}

	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public String getCheckPerson() {
		return checkPerson;
	}

	public void setCheckPerson(String checkPerson) {
		this.checkPerson = checkPerson;
	}



}