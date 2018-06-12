package auth;

import java.lang.reflect.InvocationTargetException;
import java.security.BasicPermission;
import java.security.Permission;
import java.security.Policy;
import java.security.Principal;
import java.security.ProtectionDomain;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import oilcan.base.container.ServiceLocator;
import oilcan.service.PermissionService;

public class DBPolicy extends Policy { 

	PermissionService permissionService;
	public static Map<Principal,Map<String,BasicPermission>> policy = null;
	public DBPolicy() {
		super();
		this.loadPermission();
	}
	
	public void loadPermission(){
		try {
			DBPolicy.policy = new HashMap<Principal,Map<String,BasicPermission>>();
			permissionService = ServiceLocator.getService("permissionService", PermissionService.class);
			Map<oilcan.model.Principal,Map<String,BasicPermission>> map = new HashMap<oilcan.model.Principal,Map<String,BasicPermission>>();
			map = permissionService.queryPermissionGrant();
			for (Entry<oilcan.model.Principal, Map<String,BasicPermission>> map1 : map.entrySet()) {
				Principal principal = this.createPrincipal(map1.getKey().getClassName(), map1.getKey().getName());
				DBPolicy.policy.put(principal, map1.getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Principal createPrincipal(String clazz,String name) throws ClassNotFoundException, IllegalArgumentException, SecurityException, InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Class c = Class.forName(clazz);
		return (Principal) c.getConstructor(String.class).newInstance(name);
	}

	@Override
	public boolean implies(ProtectionDomain domain, Permission permission) {
		List<java.security.Principal> pList = Arrays.asList(domain.getPrincipals());
		for (Entry<Principal, Map<String, BasicPermission>> entry : DBPolicy.policy.entrySet()) {
			if(pList.contains(entry.getKey())){
				for (BasicPermission p : entry.getValue().values()) {
					if(p.implies(permission))
						return true;
				}
			}
		}
		return false;
	}
	
}



