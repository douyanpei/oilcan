package oilcan.base.exception;

public class ServiceException extends Exception {
	private static final long serialVersionUID = -533549255528625912L;

	public ServiceException() {
	}

	public ServiceException(String message) {
		super(message);
	}

	public ServiceException(Throwable cause) {
		super(cause);
	}

	public ServiceException(String message, Throwable cause) {
		super(message, cause);
	}

}
