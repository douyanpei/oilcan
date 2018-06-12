package auth.permission;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PermissionAction {

	private String pattern;
	
	public String getPattern() {
		return pattern;
	}

	public PermissionAction(String pattern){
		this.pattern = pattern;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj != null && obj instanceof PermissionAction && this.pattern != null && ((PermissionAction)obj).pattern != null){
			PermissionAction p = (PermissionAction)obj;
			Pattern pattern1 = Pattern.compile(p.pattern);
			Matcher m1 = pattern1.matcher(this.pattern);
			Pattern pattern2 = Pattern.compile(this.pattern);
			Matcher m2 = pattern2.matcher(p.pattern);
			return m1.matches()||m2.matches();
		}
		return false;
	}
	
	
}
