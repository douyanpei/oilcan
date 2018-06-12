package auth.encryptor;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import util.BytesUtils;
import util.MD5;


public class DES3Encryptor implements Encryptor {

	public DES3Encryptor() {
	}

	public String encrypt(String credential) throws Exception {
		if (credential==null)
			return null;
		Cipher cipher = Cipher.getInstance("DESede");
		cipher.init(Cipher.ENCRYPT_MODE, SecretKeyFactory.getInstance("DESede").generateSecret(new DESedeKeySpec(new byte[]{7,0,6,6,4,1,7,0,6,6,4,1,7,0,6,6,4,1,7,0,6,6,4,1})));			
		return BytesUtils.bytesToHexString(MD5.hash(cipher.doFinal(credential.getBytes())));
	}
}
