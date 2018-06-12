package oilcan.service;

import java.lang.reflect.InvocationTargetException;
import java.security.AccessControlException;
import java.security.AccessController;
import java.security.BasicPermission;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.security.auth.Subject;

import auth.DBPolicy;
import auth.permission.ModulePermission;
import auth.principal.SystemAdminPrincipal;

import util.Constants;
import util.StringUtil;
import oilcan.base.exception.ServiceException;
import oilcan.base.service.ServiceSupport;
import oilcan.model.Permission;
import oilcan.model.Principal;

public class PermissionService extends ServiceSupport
{
	
	/**
	 * 查询权限
	 * @param conditions
	 * @param pagedList
	 * @return
	 * @throws ServiceException
	 */
	public List<Permission> queryPermission() throws ServiceException{
		String hql = "from Permission order by level,showOrder";
		return (List<Permission>)this.findByHql(hql);
	}
	
	/**
	 * 获取权限
	 * @param conditions
	 * @param pagedList
	 * @return
	 * @throws ServiceException
	 */
	public Permission getPermission(String id) throws ServiceException{
		return this.get(Permission.class, id);
	}
	
	public int savePermission(Permission permission) {
		try{
			if(!StringUtil.isEmpty(permission.getPermissionId())){
				hdao.merge(permission);
			}else{
				if(StringUtil.isEmpty(permission.getLevel()))
					permission.setLevel(getPermission(permission.getPermission().getPermissionId()).getLevel()+1);
				hdao.save(permission);
			}
			return Constants.SUCCESS;
		}catch (Exception e){
			e.printStackTrace();
			return Constants.FAILURE;
		}
	}
	
	public int deletePermissionById(String id) {
		try{
			this.deletePermission(this.getPermission(id));
			return Constants.SUCCESS;
		}catch (Exception e){
			e.printStackTrace();
			return Constants.FAILURE;
		}
	}
	
	public void deletePermission(Permission permission) throws ServiceException{
		for(Permission sub : permission.getPermissions())
			this.deletePermission(sub);
		this.hdao.delete(permission);
	}
	
	public String getPermissionsJsonByPid(String pid) throws ServiceException {
		return  queryPermissionsByPid(pid).toString();
	}
	
	/**
	 * 获取parentId为pid的Permission集合
	 * @param pid
	 * @return
	 * @throws ServiceException
	 */
	public List<Permission> queryPermissionsByPid(String pid) throws ServiceException{
		String hql = "from Permission where permission.permissionId = ? order by showOrder";
		return (List<Permission>)this.findByHql(hql, pid);
	}
	
	/**
	 * 查询菜单模块JSON
	 * @return
	 * @throws ServiceException
	 */
	public String queryPermissions() throws ServiceException{
		StringBuffer sb = new StringBuffer();
		List<Permission> list = (List<Permission>)this.findByHql("from Permission where level= 1 order by showOrder");
		sb.append("{id:0, item:[");
		int i=1;
		for(Permission permission : list){
			sb.append("{id:'").append(permission.getPermissionId()).append("',");
			sb.append("text:'").append(permission.getName()).append("', item:[");
				int j=1;
				for(Permission sub : permission.getPermissions()){
					sb.append("{id:'").append(sub.getPermissionId()).append("',");
					sb.append("text:'").append(sub.getName()).append("', item:[");		
						int k=1;
						for(Permission subsub : sub.getPermissions()){
							sb.append("{id:'").append(subsub.getPermissionId()).append("',");
							sb.append("text:'").append(subsub.getName()).append("'}");		
							if(k < sub.getPermissions().size())
								sb.append(",");
							k++;						
						}						
					sb.append("]}");
					if(j < permission.getPermissions().size())
						sb.append(",");
					j++;						
				}
			sb.append("]}");
			if(i < list.size())
				sb.append(",");
			i++;				
		}
		
		sb.append("]}");
		
		this.clearMemory(list);
		return sb.toString();
	}
	
	/**
	 * 根据角色ID 获取分配的权限
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public String queryPermissionsByRoleId(String roleId) throws ServiceException{
		String permissionIds = "";
 		Principal principal = ((List<Principal>)this.hdao.find("from Principal where name = ? and className = 'auth.principal.RolePrincipal'", roleId)).get(0);
		List<Map<String, Object>> permissionList = this.jdao.queryForList("select permissionId from PermissionGrant where principalId = ?" , principal.getPrincipalId());
		for (int i = 0; i < permissionList.size(); i++) 
			permissionIds += "," + permissionList.get(i).get("permissionId");
		
		this.clearMemory(permissionList);
		return permissionIds.length() > 1?permissionIds.substring(1):permissionIds;
	}
	
	/**
	 * 保存角色的权限
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public int savePermissionsByRoleId(String roleId, String[] permissionIds) throws ServiceException{
		List<String> sqlList = new ArrayList<String>();
		Principal principal = ((List<Principal>)this.hdao.find("from Principal where name = ? and className = 'auth.principal.RolePrincipal'", roleId)).get(0);
		sqlList.add("delete from PermissionGrant where principalId = '" + principal.getPrincipalId() + "'");
		for (int i = 0; i < permissionIds.length; i++) 
			sqlList.add("insert into PermissionGrant values ('" + principal.getPrincipalId() + "','" + permissionIds[i] + "')");
		
		this.jdao.batchUpdate(sqlList.toArray(new String[0]));
		try {
			refreshPermissionGrant(principal, permissionIds);
		} catch (Exception e) {
			e.printStackTrace();
		}
		clearMemory(sqlList);
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据当前登录人的身份，查询其可以使用的功能
	 * @return
	 * @throws ServiceException
	 */
	public String queryPermissionForCurrentSubject() throws ServiceException {
 		List<String> list = new ArrayList<String>();
		List<Permission> permissions = (List<Permission>)this.findByHql("from Permission order by showOrder");
		Subject subject = Subject.getSubject(AccessController.getContext());
		if(subject != null){
			Set<SystemAdminPrincipal> sysp = subject.getPrincipals(SystemAdminPrincipal.class);

			for(Permission p : permissions) {
				if(sysp.size()==0){
					ModulePermission perm = new ModulePermission(p.getCode());
					try {
						AccessController.checkPermission(perm);
						list.add(p.getPermissionId());
						//System.out.println("可用权限 ："+ perm.getName());
					} catch(AccessControlException e) {
						//System.out.println("不可用权限 ："+ perm.getName());
					}
				}else{
					list.add(p.getPermissionId());
				}
			}
		}
		
		clearMemory(permissions);
		return StringUtil.arrayToString(list.toArray(new String[0]), ",", "");
	}	
	
	/**
	 * 获取权限集合
	 * @return
	 * @throws ServiceException
	 */
	public List<Map<String,Object>> findAllPermission() throws ServiceException {
		String permissions = queryPermissionForCurrentSubject();
		//获取所有的父节点
		String sql = "select distinct parentId from Permission where permissionId" +
			" in('" + permissions.replaceAll(",", "','") + "')";
		List<Map<String, Object>> parents = jdao.queryForList(sql);
		for(Map<String, Object> parent : parents){
			String parentId = StringUtil.escapeNull(parent.get("parentId"));
			if(!"".equals(parentId))
				permissions += "," + parentId;
		}
		//获取所有权限
		List<Map<String, Object>> permissionList = jdao.queryForList("select permissionId,code,level,name,description,url,img from Permission order by showOrder");
		//定义返回数组
		List<Map<String,Object>> returnPermissions = new ArrayList<Map<String,Object>>();
		for(Map<String, Object> permissionMap : permissionList){
			String permissionId = StringUtil.escapeNull(permissionMap.get("permissionId"));
			String disabled = "1";
			if(permissions.contains(permissionId))
				disabled = "0";
			permissionMap.put("disabled", disabled);
			returnPermissions.add(permissionMap);
		}
		
		return returnPermissions;
	}
	
	/**
	 * 查询权限分配表
	 * @return
	 * @throws ServiceException 
	 */
	public Map<oilcan.model.Principal,Map<String,BasicPermission>> queryPermissionGrant() throws ServiceException{
		final Map<oilcan.model.Principal,Map<String,BasicPermission>> map = new HashMap<oilcan.model.Principal,Map<String,BasicPermission>>();
		try{
			String hql = " select permission,principal"+
					" from PermissionGrant pg,Permission permission ,Principal principal"+
					" where pg.id.permission.permissionId=permission.permissionId "+
					" and pg.id.principal.principalId=principal.principalId";
		List<Object[]> list =  (List<Object[]>)this.findByHql(hql);
		for(Object[] obj :list){
			Permission permission = (Permission)obj[0];
			oilcan.model.Principal principal = (oilcan.model.Principal)obj[1];
			Map<String,BasicPermission> tempMap = map.get(principal);
			if(tempMap == null){
				tempMap = new HashMap<String,BasicPermission>();
				map.put(principal, tempMap);
			}
			String key = permission.getClassName()+"."+permission.getCode();
			BasicPermission thisPermission = this.createBasicPermission(permission);
			BasicPermission permissionInMap = tempMap.get(key);
			if(permissionInMap == null){
				tempMap.put(key, thisPermission);
			}
		}
		}catch(Exception e){
			throw new ServiceException(e);
		}
		return map;
	}	
	
	private BasicPermission createBasicPermission(Permission permission) throws ClassNotFoundException, InstantiationException, IllegalAccessException, IllegalArgumentException, SecurityException, InvocationTargetException, NoSuchMethodException{
		Class permissionClass = Class.forName(permission.getClassName());
		return (BasicPermission)permissionClass.getConstructor(String.class,String.class).newInstance(permission.getCode(), "");
	}	
	
	/**
	 * 刷新权限授权数据
	 * 查询身份表，若为空则创建身份
	 * 删除全部授权后再插入当前授权记录
	 * @param p
	 * @param permissionIds
	 * @throws ServiceException 
	 */
	public void refreshPermissionGrant(Principal p,String[] permissionIds) throws Exception{
		if(p != null){
			DBPolicy.policy.remove(p);
			String hql = " select permission,principal"+
					" from PermissionGrant pg,Permission permission ,Principal principal"+
					" where pg.id.permission.permissionId=permission.permissionId "+
					" and pg.id.principal.principalId=principal.principalId and principal.principalId='"+p.getPrincipalId()+"'";
			List<Object[]> list =  (List<Object[]>)this.findByHql(hql);
			Map<String,BasicPermission> tempMap = new HashMap<String,BasicPermission>();
			for(Object[] obj :list){
				Permission permission = (Permission)obj[0];
				p = (oilcan.model.Principal)obj[1];
				String key = permission.getClassName()+"."+permission.getCode();
				BasicPermission thisPermission = this.createBasicPermission(permission);
				tempMap.put(key, thisPermission);
			}
			DBPolicy.policy.put(createPrincipal(p.getClassName(), p.getName()), tempMap);
//			this.refreshPolicy(this.queryPermissionGrant()); 刷新所有权限授权策略
		}
	}	
	
	/**
	 * 根据类型和名称获取身份pojo对象
	 * @param className
	 * @param name
	 * @return
	 */
	public Principal getPrincipal(String className,String name){
		List<Principal> list = this.hdao.find("from Principal where className=? and name=?",className,name);
		return list.iterator().next();
	}	
	
	public java.security.Principal createPrincipal(String clazz,String name) throws ClassNotFoundException, IllegalArgumentException, SecurityException, InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Class c = Class.forName(clazz);
		return (java.security.Principal) c.getConstructor(String.class).newInstance(name);
	}	
}
