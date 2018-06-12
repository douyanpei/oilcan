package oilcan.model;


public class SafeAttachment implements java.io.Serializable {

	private static final long serialVersionUID = 6998758783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private String fireDevice;
	private String dangerLamp;
	private String dangerPlate;
	private String surfaceMark;
	private String paintColor;
	private String systemPosition;
	private String rubber;
	private String transmitType;
	private String transmitValue;
	private String attendance;
	private String ladder;
	private String valveContainer;
	private String valveState;
	private String garnerContainer;
	private String switchSystem;
	private String pressure;
	private Integer dnLength;
	private Integer dnNum;
	private String dnState;
	private String breakSystem;
	private String checkPerson;
	
	public SafeAttachment() {}

	
	public SafeAttachment(String pid, String baseId, String carNo,
			String fireDevice, String dangerLamp, String dangerPlate,
			String surfaceMark, String paintColor, String systemPosition,
			String rubber, String transmitType, String transmitValue,
			String attendance, String ladder, String valveContainer,
			String valveState, String garnerContainer, String switchSystem,
			String pressure, Integer dnLength, Integer dnNum, String dnState,
			String breakSystem, String checkPerson) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.fireDevice = fireDevice;
		this.dangerLamp = dangerLamp;
		this.dangerPlate = dangerPlate;
		this.surfaceMark = surfaceMark;
		this.paintColor = paintColor;
		this.systemPosition = systemPosition;
		this.rubber = rubber;
		this.transmitType = transmitType;
		this.transmitValue = transmitValue;
		this.attendance = attendance;
		this.ladder = ladder;
		this.valveContainer = valveContainer;
		this.valveState = valveState;
		this.garnerContainer = garnerContainer;
		this.switchSystem = switchSystem;
		this.pressure = pressure;
		this.dnLength = dnLength;
		this.dnNum = dnNum;
		this.dnState = dnState;
		this.breakSystem = breakSystem;
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

	public String getFireDevice() {
		return fireDevice;
	}

	public void setFireDevice(String fireDevice) {
		this.fireDevice = fireDevice;
	}

	public String getDangerLamp() {
		return dangerLamp;
	}

	public void setDangerLamp(String dangerLamp) {
		this.dangerLamp = dangerLamp;
	}

	public String getDangerPlate() {
		return dangerPlate;
	}

	public void setDangerPlate(String dangerPlate) {
		this.dangerPlate = dangerPlate;
	}

	public String getSurfaceMark() {
		return surfaceMark;
	}

	public void setSurfaceMark(String surfaceMark) {
		this.surfaceMark = surfaceMark;
	}

	public String getPaintColor() {
		return paintColor;
	}

	public void setPaintColor(String paintColor) {
		this.paintColor = paintColor;
	}

	public String getSystemPosition() {
		return systemPosition;
	}

	public void setSystemPosition(String systemPosition) {
		this.systemPosition = systemPosition;
	}

	public String getRubber() {
		return rubber;
	}

	public void setRubber(String rubber) {
		this.rubber = rubber;
	}

	public String getTransmitType() {
		return transmitType;
	}

	public void setTransmitType(String transmitType) {
		this.transmitType = transmitType;
	}

	public String getTransmitValue() {
		return transmitValue;
	}

	public void setTransmitValue(String transmitValue) {
		this.transmitValue = transmitValue;
	}

	public String getAttendance() {
		return attendance;
	}

	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}

	public String getLadder() {
		return ladder;
	}

	public void setLadder(String ladder) {
		this.ladder = ladder;
	}

	public String getValveContainer() {
		return valveContainer;
	}

	public void setValveContainer(String valveContainer) {
		this.valveContainer = valveContainer;
	}

	public String getValveState() {
		return valveState;
	}

	public void setValveState(String valveState) {
		this.valveState = valveState;
	}

	public String getGarnerContainer() {
		return garnerContainer;
	}

	public void setGarnerContainer(String garnerContainer) {
		this.garnerContainer = garnerContainer;
	}

	public String getSwitchSystem() {
		return switchSystem;
	}

	public void setSwitchSystem(String switchSystem) {
		this.switchSystem = switchSystem;
	}

	public String getPressure() {
		return pressure;
	}

	public void setPressure(String pressure) {
		this.pressure = pressure;
	}

	public Integer getDnLength() {
		return dnLength;
	}

	public void setDnLength(Integer dnLength) {
		this.dnLength = dnLength;
	}

	public Integer getDnNum() {
		return dnNum;
	}

	public void setDnNum(Integer dnNum) {
		this.dnNum = dnNum;
	}

	public String getDnState() {
		return dnState;
	}

	public void setDnState(String dnState) {
		this.dnState = dnState;
	}

	public String getBreakSystem() {
		return breakSystem;
	}

	public void setBreakSystem(String breakSystem) {
		this.breakSystem = breakSystem;
	}

	public String getCheckPerson() {
		return checkPerson;
	}

	public void setCheckPerson(String checkPerson) {
		this.checkPerson = checkPerson;
	}

}