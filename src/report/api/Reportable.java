package report.api;

import java.util.Map;

public interface Reportable extends java.io.Serializable {
	String report(Map args) throws Exception;
}
