 
package oilcan.base.container;

import java.util.Map;

import oilcan.base.exception.ServiceNotFoundException;

public interface Container {

	public Object getService(Object key) throws ServiceNotFoundException;

	public Map getBeansOfType(Class type);

	public void reload();

	public void autowireService(Object bean);
}
