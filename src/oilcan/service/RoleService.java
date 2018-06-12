package oilcan.service;

import java.util.ArrayList;
import java.util.List;

import util.Constants;
import util.StringUtil;
import oilcan.CallResult;
import oilcan.base.exception.ServiceException;
import oilcan.base.service.ServiceSupport;
import oilcan.model.Principal;
import oilcan.model.Role;
import oilcan.model.User;

public class RoleService extends ServiceSupport{
	
	public Role getRoleById(String roleId) throws ServiceException{
		return this.get(Role.class, roleId);
	}
	
	/**
	 * 获取角色json
	 * @return
	 * @throws ServiceException 
	 */
	public String getRoles() throws ServiceException{
		return this.findEntityProperties("select roleId, roleName, state from Role");
	}
	
	/**
	 * 获取角色List
	 * @return
	 */
	public List<Role> getRoleList(){
		return this.hdao.find("from role");
	}
	
	/**
	 * 获取可用的角色List
	 * @return
	 */
	public List<Role> getInUseRoleList(){
		return this.hdao.find("from role where state = ? ", Role.STATE_USED);
	}
	
	/**
	 * 保存角色
	 * @param pageRole
	 * @return
	 */
	public CallResult saveRole(Role role){
		if(StringUtil.isEmpty(role.getRoleId())){
			if(verifyRoleNameExists(role.getRoleName()))
				return new CallResult(Constants.FAILURE, "该角色名已被使用,请重新输入！");			
			this.hdao.save(role);

			Principal principal = new Principal();
			principal.setName(role.getRoleId());
			principal.setClassName("auth.principal.RolePrincipal");
			this.hdao.save(principal);			
		}else
			this.hdao.update(role);
		return new CallResult(Constants.SUCCESS, "");
	}
	
	/**
	 * 删除角色
	 * @param roleId
	 * @return
	 */
	public int deleteRole(String roleId) throws ServiceException{
		List<String> sqlList = new ArrayList<String>();
		sqlList.add("delete from UserRoleMapping where roleId = '" + roleId + "'");
		sqlList.add("delete from Principal where className = 'auth.principal.RolePrincipal' and name = '" + roleId + "'");
		sqlList.add("delete from role where roleId = '" + roleId + "'");
		this.jdao.batchUpdate(sqlList.toArray(new String[0]));
		return Constants.SUCCESS;
	}
	
	/**
	 * 验证角色名是否重复
	 */
	public boolean verifyRoleNameExists(String roleName){
		int number = this.jdao.queryForInt("select count(*) from Role where roleName = ? ", roleName);
		if(number > 0)
			return true;
		else
			return false;
	}	
	
	/**
	 * 根据角色获取用户
	 * @param roleId
	 * @return
	 * @throws ServiceException 
	 */
	public String getUsersByRoleId(String roleId) throws ServiceException{
		return this.findPropertiesBySql("select UserInfo.userId, '0', userName, personName from UserInfo,UserRoleMapping where UserRoleMapping.userId = UserInfo.userId and UserRoleMapping.roleId = '" + roleId + "'", false);
	}
	
	/**
	 * 获取所有在用用户
	 * @param roleId
	 * @return
	 * @throws ServiceException 
	 */
	public String getInUseUsers() throws ServiceException{
		return this.findPropertiesBySql("select userId, '0', userName, personName from UserInfo  where sysadmin = '0' and state = '" + User.STATE_USED + "'", false);
	}
	
	/**
	 * 删除角色关联
	 * @param roleId
	 * @param userIds
	 * @return
	 */
	public int deleteUsersByRoleId(String roleId, String[] userIds){
		this.jdao.update("delete from UserRoleMapping where roleId = '" + roleId + "' and userId in (" + StringUtil.arrayToString(userIds, ",", "'") + ")");
		return Constants.SUCCESS;
	}
	
	/**
	 * 保存角色关联
	 * @param roleId
	 * @param userIds
	 * @return
	 */
	public int saveUserRoleMapping(String roleId, String[] userIds){
		List<String> sqlList = new ArrayList<String>();
		for(int i=0; i<userIds.length; i++)
			sqlList.add("insert into UserRoleMapping values('" + roleId + "', '" + userIds[i] + "')");
		this.jdao.batchUpdate(sqlList.toArray(new String[0]));
		return Constants.SUCCESS;
	}
}
