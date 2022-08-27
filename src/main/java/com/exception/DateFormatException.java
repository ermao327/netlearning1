package com.exception;

public class DateFormatException extends RuntimeException{

	public DateFormatException() {
		super();
	}

	public DateFormatException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause);
	}

	public DateFormatException(String message, Throwable cause) {
		super(message, cause);
	}

	public DateFormatException(String message) {
		super(message);
	}

	public DateFormatException(Throwable cause) {
		super(cause);
	}

}
