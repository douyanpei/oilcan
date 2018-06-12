package oilcan.base.filter;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

import oilcan.base.container.ServiceLocator;
import oilcan.base.container.SpringContainer;

/**
 * 系统启动时执行，创建一个SpringContainer对象装入ServiceLocator
 * 使其能够随时调用getService方法来获取service对象
 */
public class ContainerContextLoaderListener extends ContextLoaderListener {

	public ContainerContextLoaderListener() {
	}
	public void contextInitialized(ServletContextEvent event) {
		super.contextInitialized(event);
		SpringContainer springC = getNewSpringContainer();
		springC.setServletContext(event.getServletContext());
		ServiceLocator.getInstance().setContainer(springC);
	}
	/**
	 * 获取一个新的container对象
	 * @return
	 */
	protected SpringContainer getNewSpringContainer() {
		return new SpringContainer();
	}
}
