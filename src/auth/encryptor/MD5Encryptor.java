package auth.encryptor;

import util.MD5;

public class MD5Encryptor implements Encryptor {

	public MD5Encryptor() {
	}

	public String encrypt(String credential) throws Exception {
		if (credential==null)
			return null;
		return MD5.hash(credential);
	}
}
