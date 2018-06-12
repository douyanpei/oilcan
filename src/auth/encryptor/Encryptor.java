package auth.encryptor;

public interface Encryptor {
	String encrypt(String credential) throws Exception;
}
