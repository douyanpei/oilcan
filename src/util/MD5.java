package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5 {
	
	public static String hash(String origin) {
		if (origin==null)
			return null;
		return BytesUtils.bytesToHexString(hash(origin.getBytes()));
	}
	
	public static byte[] hash(byte[] origin) {
			try {
				if (origin!=null)
				return MessageDigest.getInstance("MD5").digest(origin);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		return null;
	}
	
}
