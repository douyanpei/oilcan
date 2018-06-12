package oilcan;

import java.io.Serializable;

import util.Hanyupinyin;


import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;


public class CallResult implements Serializable, Comparable<CallResult> {
	private static final long serialVersionUID = 1721867897601313161L;
	
	private int result;
	private String message;

	public CallResult() {
	}

	public CallResult(int result, String message) {
		this.result = result;
		this.message = message;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CallResult [message=");
		builder.append(message);
		builder.append(", result=");
		builder.append(result);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int compareTo(CallResult o) {
		if (this==o) 
			return 0;
		if (o==null)
			return 1;
		String thisMessage = (getMessage()==null)?"":getMessage();
		String anotherMessage = (o.getMessage()==null)?"":o.getMessage();
		
		int result = Integer.signum(getResult()-o.getResult());
		if (result==0) {
			try {
				result = Hanyupinyin.toHanyuPinyinWithPadding(thisMessage).compareToIgnoreCase(Hanyupinyin.toHanyuPinyinWithPadding(anotherMessage));
			} catch(BadHanyuPinyinOutputFormatCombination e) {
				result = -1;
			}
		}
		return result;
	}

}
