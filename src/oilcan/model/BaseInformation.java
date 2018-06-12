package oilcan.model;


public class BaseInformation implements java.io.Serializable {

	private static final long serialVersionUID = 6335658783384387707L;
	
	private String id;
	private String oilcanBrand;
	private String oilcanModel;
	private String carNo;
	private String produce1;
	private String carModel;
	private String outDate1;
	private String produce2;
	private String firstCheckDate;
	private String outDate2;
	private String medium;
	private String mediumCode;
	private String density;
	private String regDate;
	private Integer length;
	private Integer width;
	private Integer height;
	private Double weight;
	private Integer axisNum;
	private Double outCapacity;
	private Double allowCapacity;
	private Double allowWeight;
	private String oilcanMaterial;
	private Integer warehouseNum;
	private String unitName;
	private String outCode;
	private String licensedCode;
	private String organizationName;
	private String checkCode;
	private String spotCode;
	private String conclusion;
	private String nextCheckDate;
	private String checkDate; 
	private String convertNote; 
	
	public BaseInformation() {}

	public BaseInformation(String id, String oilcanBrand, String oilcanModel,
			String carNo, String produce1, String carModel, String outDate1,
			String produce2, String firstCheckDate, String outDate2,
			String medium, String density, String regDate, Integer length,
			Integer width, Integer height, Double weight, Integer axisNum,
			Double outCapacity, Double allowCapacity, Double allowWeight,
			String oilcanMaterial, Integer warehouseNum, String unitName,
			String outCode, String licensedCode, String organizationName,
			String checkCode, String spotCode, String conclusion,
			String nextCheckDate, String mediumCode, String checkDate, String convertNote) {
		this.id = id;
		this.oilcanBrand = oilcanBrand;
		this.oilcanModel = oilcanModel;
		this.carNo = carNo;
		this.produce1 = produce1;
		this.carModel = carModel;
		this.outDate1 = outDate1;
		this.produce2 = produce2;
		this.firstCheckDate = firstCheckDate;
		this.outDate2 = outDate2;
		this.medium = medium;
		this.density = density;
		this.regDate = regDate;
		this.length = length;
		this.width = width;
		this.height = height;
		this.weight = weight;
		this.axisNum = axisNum;
		this.outCapacity = outCapacity;
		this.allowCapacity = allowCapacity;
		this.allowWeight = allowWeight;
		this.oilcanMaterial = oilcanMaterial;
		this.warehouseNum = warehouseNum;
		this.unitName = unitName;
		this.outCode = outCode;
		this.licensedCode = licensedCode;
		this.organizationName = organizationName;
		this.checkCode = checkCode;
		this.spotCode = spotCode;
		this.conclusion = conclusion;
		this.nextCheckDate = nextCheckDate;
		this.mediumCode = mediumCode;
		this.checkDate = checkDate;
		this.convertNote = convertNote;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOilcanBrand() {
		return oilcanBrand;
	}

	public void setOilcanBrand(String oilcanBrand) {
		this.oilcanBrand = oilcanBrand;
	}

	public String getOilcanModel() {
		return oilcanModel;
	}

	public void setOilcanModel(String oilcanModel) {
		this.oilcanModel = oilcanModel;
	}

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getProduce1() {
		return produce1;
	}

	public void setProduce1(String produce1) {
		this.produce1 = produce1;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}

	public String getOutDate1() {
		return outDate1;
	}

	public void setOutDate1(String outDate1) {
		this.outDate1 = outDate1;
	}

	public String getProduce2() {
		return produce2;
	}

	public void setProduce2(String produce2) {
		this.produce2 = produce2;
	}

	public String getFirstCheckDate() {
		return firstCheckDate;
	}

	public void setFirstCheckDate(String firstCheckDate) {
		this.firstCheckDate = firstCheckDate;
	}

	public String getOutDate2() {
		return outDate2;
	}

	public void setOutDate2(String outDate2) {
		this.outDate2 = outDate2;
	}

	public String getMedium() {
		return medium;
	}

	public void setMedium(String medium) {
		this.medium = medium;
	}

	public String getMediumCode() {
		return mediumCode;
	}

	public void setMediumCode(String mediumCode) {
		this.mediumCode = mediumCode;
	}

	public String getDensity() {
		return density;
	}

	public void setDensity(String density) {
		this.density = density;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public Integer getAxisNum() {
		return axisNum;
	}

	public void setAxisNum(Integer axisNum) {
		this.axisNum = axisNum;
	}

	public Double getOutCapacity() {
		return outCapacity;
	}

	public void setOutCapacity(Double outCapacity) {
		this.outCapacity = outCapacity;
	}

	public Double getAllowCapacity() {
		return allowCapacity;
	}

	public void setAllowCapacity(Double allowCapacity) {
		this.allowCapacity = allowCapacity;
	}

	public Double getAllowWeight() {
		return allowWeight;
	}

	public void setAllowWeight(Double allowWeight) {
		this.allowWeight = allowWeight;
	}

	public String getOilcanMaterial() {
		return oilcanMaterial;
	}

	public void setOilcanMaterial(String oilcanMaterial) {
		this.oilcanMaterial = oilcanMaterial;
	}

	public Integer getWarehouseNum() {
		return warehouseNum;
	}

	public void setWarehouseNum(Integer warehouseNum) {
		this.warehouseNum = warehouseNum;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getOutCode() {
		return outCode;
	}

	public void setOutCode(String outCode) {
		this.outCode = outCode;
	}

	public String getLicensedCode() {
		return licensedCode;
	}

	public void setLicensedCode(String licensedCode) {
		this.licensedCode = licensedCode;
	}

	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public String getSpotCode() {
		return spotCode;
	}

	public void setSpotCode(String spotCode) {
		this.spotCode = spotCode;
	}

	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public String getNextCheckDate() {
		return nextCheckDate;
	}

	public void setNextCheckDate(String nextCheckDate) {
		this.nextCheckDate = nextCheckDate;
	}

	public String getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}

	public String getConvertNote() {
		return convertNote;
	}

	public void setConvertNote(String convertNote) {
		this.convertNote = convertNote;
	}


}