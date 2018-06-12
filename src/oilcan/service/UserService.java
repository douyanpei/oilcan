package oilcan.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import auth.principal.RolePrincipal;
import oilcan.CallResult;
import oilcan.base.exception.ServiceException;
import oilcan.base.service.ServiceSupport;
import oilcan.model.Principal;
import oilcan.model.Role;
import oilcan.model.User;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import util.Constants;
import util.DateUtil;
import util.Hanyupinyin;
import util.MD5;
import util.StringUtil;

public class UserService extends ServiceSupport
{
	protected final Log logger = LogFactory.getLog(UserService.class);
	/**
	 * 保存用户
	 * @param u
	 * @throws BadHanyuPinyinOutputFormatCombination 
	 */
	public CallResult saveUser(User pageUser) throws BadHanyuPinyinOutputFormatCombination{
		User user = null;
		if(StringUtil.isEmpty(pageUser.getUserId())){
			if(verifyUserNameExists(pageUser.getUserName()))
				return new CallResult(Constants.FAILURE, "该用户名已被使用,请重新输入！");
			user = new User();
			user.setPassword(MD5.hash("888888"));
			user.setCreateTime(DateUtil.getCurFormatDate());
		}else{
			user = getUserByUserId(pageUser.getUserId());
		}
		
		user.setSysadmin(false);
		user.setUserName(pageUser.getUserName());
		user.setPersonName(pageUser.getPersonName());
		user.setUserType(pageUser.getUserType());
		user.setState(pageUser.getState());
		user.setSeniorityCode(pageUser.getSeniorityCode());
		user.setPym(Hanyupinyin.toHanyuPinyinCapital(pageUser.getPersonName()));
		this.hdao.saveOrUpdate(user);
		
		if(StringUtil.isEmpty(pageUser.getUserId())){
			Principal principal = new Principal();
			principal.setName(user.getUserId());
			principal.setClassName("auth.principal.UserPrincipal");
			this.hdao.save(principal);				
		}
		return new CallResult(Constants.SUCCESS, "");
	}
	
	/**
	 * 验证用户名是否重复
	 */
	public boolean verifyUserNameExists(String userName){
		int number = this.jdao.queryForInt("select count(*) from UserInfo where userName = ? ", userName);
		if(number > 0)
			return true;
		else
			return false;
	}
	/**
	 * 根据用户名获取用户对象
	 * @param userName
	 * @return
	 */
	public User getUserByUserName(String userName){
		Iterator<User> iterator = hdao.find("from User where userName=?", userName).iterator();
		if (iterator.hasNext())
			return iterator.next();
		return null;
	}
	
	/**
	 * 根据用户ID获取用户对象
	 * @param userId
	 * @return
	 */
	public User getUserByUserId(String userId){
		return this.hdao.get(User.class, userId);
	}
	
	/**
	 * 获取所有可用的用户List
	 * @param userId
	 * @return sysadmin=? and , false
	 */
	public List<User> getUserList(){
		return (List<User>)hdao.find("from User");
	}
	
	/**
	 * 获取所有可用的用户List
	 * @param userId
	 * @return sysadmin=? and , false
	 */
	public List<User> getInUseUserList(){
		return (List<User>)hdao.find("from User where state=? ", User.STATE_USED);
	}
	
	/**
	 * 获取所有可用的用户
	 * @param userId
	 * @return sysadmin=? and , false
	 */
	public String getUsers(){
		List<User> list = getUserList();
		StringBuffer sb = new StringBuffer();
		sb.append("{id:0, item:[");
		int i=1;		
		
		for(User user : list){
			sb.append("{id:'").append(user.getUserId()).append("',");
			sb.append("text:'").append(user.getUserName()).append("(").append(user.getPersonName() + "_" + user.getPym()).append(")").append("',");
			sb.append("im0:'").append(user.STATE_USED.equals(user.getState())?"blank.gif":"lock.gif").append("'}");
			if(i < list.size())
				sb.append(",");
			i++;				
		}
		
		sb.append("]}");
		
		this.clearMemory(list);
		return sb.toString();
	}
	
	/**
	 * 重置用户密码
	 * @param userId
	 * @return
	 */
	public int resetPassword(String userId){
		User user = getUserByUserId(userId);
		user.setPassword(MD5.hash("888888"));
		this.hdao.update(user);
		return Constants.SUCCESS;
	}
	
	/**
	 * 删除用户
	 * @param userId
	 * @return
	 * @throws ServiceException
	 */
	public int deleteUser(String userId) throws ServiceException{
		String sql = "delete from EntryPermission where userId='" + userId + "';";
		sql += "delete from UserRoleMapping where userId='" + userId + "';";
		sql += "delete from UserInfo where userId='" + userId + "'";
		jdao.update(sql);
		return Constants.SUCCESS;
	}
	
	/**
	 * 获取用户所有角色
	 * @param userId
	 * @return
	 */
	public List<Role> getRolesByUserId(String userId){
		return this.hdao.find("select r from Role as r, UserRoleMapping as m where r.roleId = m.id.role.roleId and m.id.user.userId = ?", userId);
	}
	
	
	public List<Map<String, Object>> userPermission(){
		String sql = "SELECT B.userId,LEFT(entryList,LEN(entryList)-1) as itemCode FROM (" +
			" SELECT userId,(SELECT itemId+',' FROM EntryPermission" +
			" WHERE userId=A.userId and rtype='register' order by userId,itemId" +
			" FOR XML PATH('')) AS entryList" +
			" FROM EntryPermission A GROUP BY userId) B";
		return jdao.queryForList(sql);
	}
}
