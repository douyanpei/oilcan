package oilcan.base.container;

import java.util.Map;


public class ServiceLocator {

	private static ServiceLocator instance = new ServiceLocator();
	private Container container;

	public static ServiceLocator getInstance() {
		return instance;
	}

	private ServiceLocator() {
		container = null;
	}

	public Container getContainer() {
		return container;
	}

	public void setContainer(Container container) {
		this.container = container;
	}
	public static Object getService(String key) {
		return getInstance().getContainer().getService(key);
	}
	public static <T> T getService(String key,Class<T> clazz) {
		return (T)getInstance().getContainer().getService(key);
	}
	public static Map getBeansOfType(Class type) {
		return getInstance().getContainer().getBeansOfType(type);
	}
	public static void autowireService(Object service) {
		getInstance().getContainer().autowireService(service);
	}

	public static void resetInstance() {
		instance = new ServiceLocator();
	}
}
