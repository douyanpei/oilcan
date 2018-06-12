package oilcan.model;


public class Dict implements java.io.Serializable {

	private static final long serialVersionUID = 5313016384044105625L;
	
	private Integer id;
	private String codeType;
	private String codeDesc;
	private String codeCnName;
	private String codeValue;
	private String codeCnDesc;
	private String codeIsUse;

	public Dict() {
	}

	public Dict(Integer id, String codeType, String codeDesc,
			String codeCnName, String codeValue, String codeIsUse, String codeCnDesc) {
		this.id = id;
		this.codeType = codeType;
		this.codeDesc = codeDesc;
		this.codeCnName = codeCnName;
		this.codeValue = codeValue;
		this.codeIsUse = codeIsUse;
		this.codeCnDesc = codeCnDesc;
	}


	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getCodeType() {
		return this.codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getCodeDesc() {
		return this.codeDesc;
	}

	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}

	public String getCodeCnName() {
		return this.codeCnName;
	}

	public void setCodeCnName(String codeCnName) {
		this.codeCnName = codeCnName;
	}

	public String getCodeValue() {
		return this.codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	public String getCodeIsUse() {
		return this.codeIsUse;
	}

	public void setCodeIsUse(String codeIsUse) {
		this.codeIsUse = codeIsUse;
	}
	
	public String getCodeCnDesc() {
		return codeCnDesc;
	}

	public void setCodeCnDesc(String codeCnDesc) {
		this.codeCnDesc = codeCnDesc;
	}

	public boolean equals(Object object) {
       return true;
    }

    public int hashCode() {
       return 1;
    }
}