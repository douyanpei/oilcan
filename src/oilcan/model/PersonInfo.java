package oilcan.model;

public class PersonInfo implements java.io.Serializable{

	private static final long serialVersionUID = 7677750215439704357L;
	
	private String pid;
	private String name;
	private byte[] img;
	
	public PersonInfo(){}

	public PersonInfo(String pid, String name, byte[] img) {
		this.pid = pid;
		this.name = name;
		this.img = img;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public byte[] getImg() {
		return img;
	}

	public void setImg(byte[] img) {
		this.img = img;
	}

	

}
