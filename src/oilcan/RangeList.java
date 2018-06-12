package oilcan;

import java.io.Serializable;

public class RangeList implements Serializable {
	private static final long serialVersionUID = 4032315966615573273L;
	
	private Object[] data;
	private long totalSize;

	public RangeList() {
	}

	public RangeList(Object[] data, long totalSize) {
		this.data = data;
		this.totalSize = totalSize;
	}

	public Object[] getData() {
		return data;
	}

	public void setData(Object[] data) {
		this.data = data;
	}

	public long getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RangeList [data=");
		builder.append(data);
		builder.append(", totalSize=");
		builder.append(totalSize);
		builder.append("]");
		return builder.toString();
	}
	
}