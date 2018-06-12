package oilcan.model;


public class OilcanShoulder implements java.io.Serializable {

	private static final long serialVersionUID = 7788348783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private Integer bulwarkNum;
	private String bulwarkState;
	private Integer holeNum;
	private String holeState;
	private Integer affluxNum;
	private String affluxState;
	private String detroitType;
	private String detroitState;
	private String hasCrack;
	private String oilcanShow;
	private String oilcanDefect;
	private String diameter;
	private String diameterNum;
	private String valveType;
	private String valveMaterial;
	private String seepage;
	private String refuel;
	private String hose;
	private String recoverSystem;
	private String recoverState;
	private String bengSystem;
	private String bengState;
	private String measureSystem;
	private String refitPlace;
	private String oilcanHeat;
	private String checkPerson;
	
	public OilcanShoulder() {}

	public OilcanShoulder(String pid, String baseId, String carNo,
			Integer bulwarkNum, String bulwarkState, Integer holeNum,
			String holeState, Integer affluxNum, String affluxState,
			String detroitType, String detroitState, String hasCrack,
			String oilcanShow, String oilcanDefect, String diameter,
			String diameterNum, String valveType, String valveMaterial,
			String seepage, String refuel, String hose, String recoverSystem,
			String recoverState, String bengSystem, String bengState,
			String measureSystem, String refitPlace, String oilcanHeat,String checkPerson) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.bulwarkNum = bulwarkNum;
		this.bulwarkState = bulwarkState;
		this.holeNum = holeNum;
		this.holeState = holeState;
		this.affluxNum = affluxNum;
		this.affluxState = affluxState;
		this.detroitType = detroitType;
		this.detroitState = detroitState;
		this.hasCrack = hasCrack;
		this.oilcanShow = oilcanShow;
		this.oilcanDefect = oilcanDefect;
		this.diameter = diameter;
		this.diameterNum = diameterNum;
		this.valveType = valveType;
		this.valveMaterial = valveMaterial;
		this.seepage = seepage;
		this.refuel = refuel;
		this.hose = hose;
		this.recoverSystem = recoverSystem;
		this.recoverState = recoverState;
		this.bengSystem = bengSystem;
		this.bengState = bengState;
		this.measureSystem = measureSystem;
		this.refitPlace = refitPlace;
		this.oilcanHeat = oilcanHeat;
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

	public Integer getBulwarkNum() {
		return bulwarkNum;
	}

	public void setBulwarkNum(Integer bulwarkNum) {
		this.bulwarkNum = bulwarkNum;
	}

	public String getBulwarkState() {
		return bulwarkState;
	}

	public void setBulwarkState(String bulwarkState) {
		this.bulwarkState = bulwarkState;
	}

	public Integer getHoleNum() {
		return holeNum;
	}

	public void setHoleNum(Integer holeNum) {
		this.holeNum = holeNum;
	}

	public String getHoleState() {
		return holeState;
	}

	public void setHoleState(String holeState) {
		this.holeState = holeState;
	}

	public Integer getAffluxNum() {
		return affluxNum;
	}

	public void setAffluxNum(Integer affluxNum) {
		this.affluxNum = affluxNum;
	}

	public String getAffluxState() {
		return affluxState;
	}

	public void setAffluxState(String affluxState) {
		this.affluxState = affluxState;
	}

	public String getDetroitType() {
		return detroitType;
	}

	public void setDetroitType(String detroitType) {
		this.detroitType = detroitType;
	}

	public String getDetroitState() {
		return detroitState;
	}

	public void setDetroitState(String detroitState) {
		this.detroitState = detroitState;
	}

	public String getHasCrack() {
		return hasCrack;
	}

	public void setHasCrack(String hasCrack) {
		this.hasCrack = hasCrack;
	}

	public String getOilcanShow() {
		return oilcanShow;
	}

	public void setOilcanShow(String oilcanShow) {
		this.oilcanShow = oilcanShow;
	}

	public String getOilcanDefect() {
		return oilcanDefect;
	}

	public void setOilcanDefect(String oilcanDefect) {
		this.oilcanDefect = oilcanDefect;
	}

	public String getDiameter() {
		return diameter;
	}

	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}

	public String getDiameterNum() {
		return diameterNum;
	}

	public void setDiameterNum(String diameterNum) {
		this.diameterNum = diameterNum;
	}

	public String getValveType() {
		return valveType;
	}

	public void setValveType(String valveType) {
		this.valveType = valveType;
	}

	public String getValveMaterial() {
		return valveMaterial;
	}

	public void setValveMaterial(String valveMaterial) {
		this.valveMaterial = valveMaterial;
	}

	public String getSeepage() {
		return seepage;
	}

	public void setSeepage(String seepage) {
		this.seepage = seepage;
	}

	public String getRefuel() {
		return refuel;
	}

	public void setRefuel(String refuel) {
		this.refuel = refuel;
	}

	public String getHose() {
		return hose;
	}

	public void setHose(String hose) {
		this.hose = hose;
	}

	public String getRecoverSystem() {
		return recoverSystem;
	}

	public void setRecoverSystem(String recoverSystem) {
		this.recoverSystem = recoverSystem;
	}

	public String getRecoverState() {
		return recoverState;
	}

	public void setRecoverState(String recoverState) {
		this.recoverState = recoverState;
	}

	public String getBengSystem() {
		return bengSystem;
	}

	public void setBengSystem(String bengSystem) {
		this.bengSystem = bengSystem;
	}

	public String getBengState() {
		return bengState;
	}

	public void setBengState(String bengState) {
		this.bengState = bengState;
	}

	public String getMeasureSystem() {
		return measureSystem;
	}

	public void setMeasureSystem(String measureSystem) {
		this.measureSystem = measureSystem;
	}

	public String getRefitPlace() {
		return refitPlace;
	}

	public void setRefitPlace(String refitPlace) {
		this.refitPlace = refitPlace;
	}

	public String getOilcanHeat() {
		return oilcanHeat;
	}

	public void setOilcanHeat(String oilcanHeat) {
		this.oilcanHeat = oilcanHeat;
	}

	public String getCheckPerson() {
		return checkPerson;
	}

	public void setCheckPerson(String checkPerson) {
		this.checkPerson = checkPerson;
	}

}