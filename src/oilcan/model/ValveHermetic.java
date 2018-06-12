package oilcan.model;


public class ValveHermetic implements java.io.Serializable {

	private static final long serialVersionUID = 7788348783384387707L;

	private String pid;
	private String baseId;
	private String carNo;
	private String firstOilcan;
	private String secondOilcan;
	private String thirdOilcan;
	private String forthOilcan;
	private String fifthOilcan;
	private Integer pressureStart;
	private Integer pressureEnd;
	private String pressureState;
	private String question;
	private String conclusion;
	private String checkPerson;
	
	public ValveHermetic() {}

	public ValveHermetic(String pid, String baseId, String carNo,
			String firstOilcan, String secondOilcan, String thirdOilcan,
			String forthOilcan, String fifthOilcan, Integer pressureStart,
			Integer pressureEnd, String pressureState, String question,
			String conclusion, String checkPerson) {
		this.pid = pid;
		this.baseId = baseId;
		this.carNo = carNo;
		this.firstOilcan = firstOilcan;
		this.secondOilcan = secondOilcan;
		this.thirdOilcan = thirdOilcan;
		this.forthOilcan = forthOilcan;
		this.fifthOilcan = fifthOilcan;
		this.pressureStart = pressureStart;
		this.pressureEnd = pressureEnd;
		this.pressureState = pressureState;
		this.question = question;
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

	public String getFirstOilcan() {
		return firstOilcan;
	}

	public void setFirstOilcan(String firstOilcan) {
		this.firstOilcan = firstOilcan;
	}

	public String getSecondOilcan() {
		return secondOilcan;
	}

	public void setSecondOilcan(String secondOilcan) {
		this.secondOilcan = secondOilcan;
	}

	public String getThirdOilcan() {
		return thirdOilcan;
	}

	public void setThirdOilcan(String thirdOilcan) {
		this.thirdOilcan = thirdOilcan;
	}

	public String getForthOilcan() {
		return forthOilcan;
	}

	public void setForthOilcan(String forthOilcan) {
		this.forthOilcan = forthOilcan;
	}

	public String getFifthOilcan() {
		return fifthOilcan;
	}

	public void setFifthOilcan(String fifthOilcan) {
		this.fifthOilcan = fifthOilcan;
	}

	public Integer getPressureStart() {
		return pressureStart;
	}

	public void setPressureStart(Integer pressureStart) {
		this.pressureStart = pressureStart;
	}

	public Integer getPressureEnd() {
		return pressureEnd;
	}

	public void setPressureEnd(Integer pressureEnd) {
		this.pressureEnd = pressureEnd;
	}

	public String getPressureState() {
		return pressureState;
	}

	public void setPressureState(String pressureState) {
		this.pressureState = pressureState;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
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