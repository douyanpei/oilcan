package auth.encryptor;


public class XorEncryptor implements Encryptor {

	private final int KEY = 0xAA;
	
	public XorEncryptor() {
	}

	public String encrypt(String credential) throws Exception {
		if (credential==null) {
			return null;
		}
		byte[] buffer = credential.getBytes();
		for(int i=0; i<buffer.length; i++) {
			buffer[i] = (byte)(buffer[i] ^ KEY);
		}
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<buffer.length; i++) {
			sb.append(Integer.toHexString(buffer[i]));
		}
		return sb.toString();
	}
}
