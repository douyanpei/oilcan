package oilcan.base.container;

import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.support.WebApplicationContextUtils;

import oilcan.base.exception.ServiceNotFoundException;

public class SpringContainer implements Container {

	private ServletContext servletContext;
	private ApplicationContext applicationContext;

	public void setServletContext(ServletContext context) {
		servletContext = context;
		this.applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContext);
	}

	public ServletContext getServletContext() {
		return servletContext;
	}

	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	public void setApplicationContext(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}

	public SpringContainer() {
	}

	public Object getService(Object key) throws ServiceNotFoundException {
		if (applicationContext == null)
			throw new IllegalStateException("Spring Application context has not been set");
		if (key == null)
			throw new ServiceNotFoundException("The component key can not be null");
		if (key instanceof Class) {
			Map beans = applicationContext.getBeansOfType((Class) key);
			if (beans == null)
				throw new ServiceNotFoundException("The container is unable to resolve single instance of "
						+ ((Class) key).getName() + ", none instances found");
			if (beans.size() == 0 || beans.size() > 1)
				throw new ServiceNotFoundException("The container is unable to resolve single instance of "
						+ ((Class) key).getName() + ", number of instances found was: " + beans.size());
			key = beans.keySet().iterator().next();
		}
		return applicationContext.getBean(key.toString());
	}

	public void reload() {
		ContextLoader loader = new ContextLoader();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(servletContext);
		if (ctx != null)
			loader.closeWebApplicationContext(servletContext);
		loader.initWebApplicationContext(servletContext);
		if (applicationContext == null)
			setApplicationContext(WebApplicationContextUtils.getWebApplicationContext(servletContext));
	}

	public void autowireService(Object bean) {
		((AbstractApplicationContext) applicationContext).getBeanFactory().autowireBeanProperties(bean,
				AutowireCapableBeanFactory.AUTOWIRE_BY_NAME, false);
	}

	public Map getBeansOfType(Class type) {
		return applicationContext.getBeansOfType(type);
	}
}
