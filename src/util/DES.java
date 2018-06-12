package util;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public class DES {

	public static String encrypt(String origin) throws Exception {
		if (origin==null)
			return null;
		return BytesUtils.bytesToHexString(encrypt(origin.getBytes()));
	}
	
	private static byte[] encrypt(byte[] origin) throws Exception {
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, SecretKeyFactory.getInstance("DES").generateSecret(new DESKeySpec(new byte[]{7,0,6,6,4,1,7,0})));
		return cipher.doFinal(origin);
	}
	
	public static String decrypt(String origin) throws Exception {
		if (origin==null)
			return null;
		return BytesUtils.bytesToHexString(decrypt(origin.getBytes()));
	}
	
	private static byte[] decrypt(byte[] origin) throws Exception {
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.DECRYPT_MODE, SecretKeyFactory.getInstance("DES").generateSecret(new DESKeySpec(new byte[]{7,0,6,6,4,1,7,0})));
		return cipher.doFinal(origin);
	}
	
}
