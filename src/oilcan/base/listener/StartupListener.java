package oilcan.base.listener;

import java.security.Policy;

import javax.servlet.ServletContextEvent;

import util.DictUtil;
import auth.DBPolicy;
import auth.LoginModuleCfg;

public class StartupListener implements javax.servlet.ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		LoginModuleCfg.setConfiguration(new LoginModuleCfg());
		Policy.setPolicy(new DBPolicy());
		// 加载字典表数据
		DictUtil.init();
			
	}
}
