package oilcan.model;


public class RecoverDevice implements java.io.Serializable {

	private static final long serialVersionUID = 4333348783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private String kiss;
	private String hat;
	private String valve;
	private String gluing;
	private String oilcanPipe;
	private String lineValve;
	private String stand;
	private String pressure;
	private String bottomKiss;
	private String bottomHat;
	private String bottomValve;
	private String centerValve;
	private String outlet;
	private String fixHeight;
	
	public RecoverDevice() {}

	public RecoverDevice(String pid, String baseId, String carNo, String kiss,
			String hat, String valve, String gluing, String oilcanPipe,
			String lineValve, String stand, String pressure, String bottomKiss,
			String bottomHat, String bottomValve, String centerValve,
			String outlet, String fixHeight) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.kiss = kiss;
		this.hat = hat;
		this.valve = valve;
		this.gluing = gluing;
		this.oilcanPipe = oilcanPipe;
		this.lineValve = lineValve;
		this.stand = stand;
		this.pressure = pressure;
		this.bottomKiss = bottomKiss;
		this.bottomHat = bottomHat;
		this.bottomValve = bottomValve;
		this.centerValve = centerValve;
		this.outlet = outlet;
		this.fixHeight = fixHeight;
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

	public String getKiss() {
		return kiss;
	}

	public void setKiss(String kiss) {
		this.kiss = kiss;
	}

	public String getHat() {
		return hat;
	}

	public void setHat(String hat) {
		this.hat = hat;
	}

	public String getValve() {
		return valve;
	}

	public void setValve(String valve) {
		this.valve = valve;
	}

	public String getGluing() {
		return gluing;
	}

	public void setGluing(String gluing) {
		this.gluing = gluing;
	}

	public String getOilcanPipe() {
		return oilcanPipe;
	}

	public void setOilcanPipe(String oilcanPipe) {
		this.oilcanPipe = oilcanPipe;
	}

	public String getLineValve() {
		return lineValve;
	}

	public void setLineValve(String lineValve) {
		this.lineValve = lineValve;
	}

	public String getStand() {
		return stand;
	}

	public void setStand(String stand) {
		this.stand = stand;
	}

	public String getPressure() {
		return pressure;
	}

	public void setPressure(String pressure) {
		this.pressure = pressure;
	}

	public String getBottomKiss() {
		return bottomKiss;
	}

	public void setBottomKiss(String bottomKiss) {
		this.bottomKiss = bottomKiss;
	}

	public String getBottomHat() {
		return bottomHat;
	}

	public void setBottomHat(String bottomHat) {
		this.bottomHat = bottomHat;
	}

	public String getBottomValve() {
		return bottomValve;
	}

	public void setBottomValve(String bottomValve) {
		this.bottomValve = bottomValve;
	}

	public String getCenterValve() {
		return centerValve;
	}

	public void setCenterValve(String centerValve) {
		this.centerValve = centerValve;
	}

	public String getOutlet() {
		return outlet;
	}

	public void setOutlet(String outlet) {
		this.outlet = outlet;
	}

	public String getFixHeight() {
		return fixHeight;
	}

	public void setFixHeight(String fixHeight) {
		this.fixHeight = fixHeight;
	}


}