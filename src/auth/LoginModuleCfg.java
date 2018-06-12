package auth;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.security.auth.login.AppConfigurationEntry;
import javax.security.auth.login.AppConfigurationEntry.LoginModuleControlFlag;
import javax.security.auth.login.Configuration;

public class LoginModuleCfg extends Configuration {
	private Map<String, Set<AppConfigurationEntry>> cfg = new HashMap<String, Set<AppConfigurationEntry>>();
	
	public LoginModuleCfg() {
		Set<AppConfigurationEntry> set = new HashSet<AppConfigurationEntry>();
		AppConfigurationEntry e = new AppConfigurationEntry("auth.PasswordLoginModule", LoginModuleControlFlag.REQUIRED, new HashMap<String, String>());
		set.add(e);
		cfg.put("OilcanAuth", set);
	}

	@Override
	public AppConfigurationEntry[] getAppConfigurationEntry(String name) {
		name = "OilcanAuth";
		Set<AppConfigurationEntry> set = this.cfg.get(name);
		return set.toArray(new AppConfigurationEntry[set.size()]);
	}
	
	
}
