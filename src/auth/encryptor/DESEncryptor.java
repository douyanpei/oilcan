package auth.encryptor;

import util.DES;
import util.MD5;

public class DESEncryptor implements Encryptor {

	public DESEncryptor() {
	}

	public String encrypt(String credential) throws Exception {
		if (credential==null)
			return null;
		return MD5.hash(DES.encrypt(credential));
	}
}
