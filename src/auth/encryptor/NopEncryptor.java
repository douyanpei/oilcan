package auth.encryptor;


public class NopEncryptor implements Encryptor {

	public NopEncryptor() {
	}

	public String encrypt(String credential) throws Exception {		
		return credential;
	}
	
}
