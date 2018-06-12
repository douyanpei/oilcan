package util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class BytesUtils {
	
	private final static String[] HEX_DIGITS = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n = 256 + n;
		int a = n / 16;
		int c = n % 16;
		return HEX_DIGITS[a] + HEX_DIGITS[c];
	}

	public static String bytesToHexString(byte[] b) {
		StringBuffer result = new StringBuffer();
		for (int i = 0; i < b.length; i++)
			result.append(byteToHexString(b[i]));
		return result.toString();
	}
	
    //byte数组转成String
    public static String bytesToLongString(byte[] b) {
        long s = 0;
        long s0 = b[0] & 0xff;	// 最高位
        long s1 = b[1] & 0xff;
        long s2 = b[2] & 0xff;
        long s3 = b[3] & 0xff;
        // s3不变
        s2 <<= 8;
        s1 <<= 16;
        s0 <<= 24;
        s = s0 | s1 | s2 | s3;
        return "" + s;
    }
    
	public static byte[] InputStreamToByte(InputStream is) throws IOException {  
		ByteArrayOutputStream bytestream = new ByteArrayOutputStream();  
		int ch;  
		while ((ch = is.read()) != -1) {  
			bytestream.write(ch);  
		}  
		byte imgdata[] = bytestream.toByteArray();  
		bytestream.close();  
		return imgdata;  
	}  
}
