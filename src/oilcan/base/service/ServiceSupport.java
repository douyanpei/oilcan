package oilcan.base.service;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import oilcan.base.exception.ServiceException;
import oilcan.model.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import report.api.Reportable;
import util.Constants;
import util.StringUtil;
import web.WebScope;

public abstract class ServiceSupport implements ApplicationContextAware {

	protected final Log logger = LogFactory.getLog(this.getClass());

	protected HibernateTemplate hdao;
	protected JdbcTemplate jdao;

	protected ApplicationContext applicationContext;
	protected WebScope webScope;

	public WebScope getWebScope() {
		return webScope;
	}

	public void setWebScope(WebScope webScope) {
		this.webScope = webScope;
	}

	public ServiceSupport() {
		super();
	}

	public ServiceSupport(HibernateTemplate hdao, JdbcTemplate jdao) {
		this.hdao = hdao;
		this.jdao = jdao;
	}

	public void setHdao(HibernateTemplate hdao) {
		this.hdao = hdao;
	}
	
	public void setJdao(JdbcTemplate jdao) {
		this.jdao = jdao;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}

	
	/**
	 * 根据HQL语句查询条数
	 * 
	 * @param hql
	 * @param values
	 * @return
	 */
	protected long countByHql(String hql, Object... values) {
		if (hql != null && hql.length() > 0) {
			String h = hql.trim();
			if (h.startsWith("select"))
				return (Long) hdao.find("select count(*) from (" + h + ") t", values).iterator().next();
			else if (h.startsWith("from"))
				return (Long) hdao.find("select count(*) " + h, values).iterator().next();
			return 0L;
		}
		return 0L;
	}

	/**
	 * 根据HQL语句查询结果
	 * 
	 * @param hql
	 * @param values
	 * @return
	 * @throws ServiceException
	 */
	public List<? extends Object> findByHql(String hql, Object... values) throws ServiceException {
		try {
			return hdao.find(hql, (Object[]) values);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	/**
	 * 根据SQL语句查询结果
	 * 
	 * @param hql
	 * @param objNames 表名（别名），此表作为对象返回
	 * @param objClasses 表对应的类，此表作为对象返回
	 * @param values
	 * @return
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	public List<? extends Object> findBySql(final String sql,final String[] objNames, final Class[] objClasses, final Object... values) throws ServiceException {
		return this.hdao.execute(new HibernateCallback<List>() {

			public List doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				for (int i = 0; i < values.length; i++) {
					query.setParameter(i, values[i]);
				}
				if(objNames != null && objClasses != null && objNames.length <= objClasses.length){
					for (int i = 0; i < objNames.length; i++) {
						query.addEntity(objNames[i], objClasses[i]);
					}
				}
				return query.list();
			}

		});
	}
	
	public List<? extends Object> findBySql(final String sql, final Object... values) throws ServiceException {
		return this.findBySql(sql, null, null, values);
	}

	/**
	 * 获取一个POJO对象
	 * 
	 * @param entityClass
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public <T> T get(Class<T> entityClass, Serializable id) throws ServiceException {
		try {
			return hdao.get(entityClass, id);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	/**
	 * 删除对象
	 * 
	 * @param entity
	 * @throws ServiceException
	 */
	public void delete(Object entity) throws ServiceException {
		try {
			hdao.delete(entity);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	/**
	 * 删除对象
	 * 
	 * @param entity
	 * @throws ServiceException
	 */
	public <T> void delete(Class<T> entityClass, Serializable id) throws ServiceException {
		try {
			hdao.delete(hdao.get(entityClass, id));
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	/**
	 * 根据HQL执行更新或删除
	 * @param hql
	 * @param values
	 * @return 更新或删除的数据条数
	 * @throws ServiceException
	 */
	public int excuteUpdate(final String hql, final Object... values) throws ServiceException {
		try {
			return hdao.execute(new HibernateCallback<Integer>() {

				@Override
				public Integer doInHibernate(Session session) throws HibernateException, SQLException {
					Query query = session.createQuery(hql);
					for (int i = 0; i < values.length; i++) {
						query.setParameter(i, values[i]);
					}
					return query.executeUpdate();
				}
			});
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	protected User getCurrentUser() {
		return (User) this.webScope.getSession().getAttribute(Constants.SessionBundleName.user);
	}
	
	protected void setCurrentUser(User user) {
		this.webScope.getSession().setAttribute(Constants.SessionBundleName.user, user);
	}

	protected void bindUserToSession(User user) {
		this.webScope.getSession().setAttribute(Constants.SessionBundleName.user, user);
	}
	
	/**
	 * 查询实体类
	 * @param hql
	 * @return string
	 * @throws ServiceException
	 */
	public String findEntity(String hql) throws ServiceException {
		List<? extends Object> entityList = hdao.find(hql);
		StringBuffer sb = new StringBuffer();
		sb.append("{rows:");
		sb.append(entityList.toString());
		sb.append("}");
		clearMemory(entityList);
		return sb.toString();
	}
	
	/**
	 * 查询实体类属性
	 * @param hql
	 * @return string
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	public String findEntityProperties(String hql) throws ServiceException {
		List<? extends Object> entityList = hdao.find(hql);
		StringBuffer sb = new StringBuffer();
		sb.append("{rows:[");
		for(int i=0; i<entityList.size(); i++){
			sb.append("{id:");
			Object[] entity = (Object[]) entityList.get(i);
			for(int j=0; j<entity.length; j++){
				if(j == 0){
					sb.append("'" + entity[0] + "',data:[");
					sb.append("'',");
				}else if(j != entity.length-1){
					sb.append("'" + (entity[j]==null?"":entity[j]) + "',");
				}else{
					sb.append("'" + (entity[j]==null?"":entity[j]) + "'");
				}
			}
			sb.append("]}");
			if(i != entityList.size()-1)
				sb.append(",");
		}
		sb.append("]}");
		
		clearMemory(entityList);
		return sb.toString();
	}

	/**
	 * 查询实体类属性
	 * @param hql
	 * @return string
	 * @throws ServiceException
	 */
	public String findEntityProperties(String hql, boolean hasSN) throws ServiceException {
		if(hasSN)
			return findEntityProperties(hql);
		else{
			List<? extends Object> entityList = hdao.find(hql);
			StringBuffer sb = new StringBuffer();
			sb.append("{rows:[");
			for(int i=0; i<entityList.size(); i++){
				sb.append("{id:");
				Object[] entity = (Object[]) entityList.get(i);
				for(int j=0; j<entity.length; j++){
					if(j == 0){
						sb.append("'" + entity[0] + "',data:[");
					}else if(j != entity.length-1){
						sb.append("'" + (entity[j]==null?"":entity[j]) + "',");
					}else{
						sb.append("'" + (entity[j]==null?"":entity[j]) + "'");
					}
				}
				sb.append("]}");
				if(i != entityList.size()-1)
					sb.append(",");
			}
			sb.append("]}");
			
			clearMemory(entityList);
			return sb.toString();
		}
	}
	
	
	/**
	 * 查询实体类属性
	 * @param sql
	 * @return string
	 * @throws ServiceException
	 */
	public String findPropertiesBySql(String sql) throws ServiceException {
		List<Map<String, Object>> entityList = jdao.queryForList(sql);
		StringBuffer sb = new StringBuffer();
		sb.append("{rows:[");
		for(int i=0; i<entityList.size(); i++){
			Map<String, Object> entityMap = entityList.get(i);
			sb.append("{id:");
			int j = 0;
			for(String keyCode : entityMap.keySet()){
				if(j == 0){
					sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "',data:[");
					sb.append("'',");
				}else if(j != entityMap.keySet().size()-1){
					sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "',");
				}else{
					sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "'");
				}
				j++;
			}
			sb.append("]}");
			if(i != entityList.size()-1)
				sb.append(",");
		}
		sb.append("]}");
		
		clearMemory(entityList);
		return sb.toString();
	}
	
	public String findPropertiesBySql(String sql, boolean hasSN) throws ServiceException {
		if(hasSN)
			return findPropertiesBySql(sql);
		else{
			List<Map<String, Object>> entityList = jdao.queryForList(sql);
			StringBuffer sb = new StringBuffer();
			sb.append("{rows:[");
			for(int i=0; i<entityList.size(); i++){
				Map<String, Object> entityMap = entityList.get(i);
				sb.append("{id:");
				int j = 0;
				for(String keyCode : entityMap.keySet()){
					if(j == 0){
						sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "',data:[");
						sb.append("");
					}else if(j != entityMap.keySet().size()-1){
						sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "',");
					}else{
						sb.append("'" + StringUtil.escapeNull(entityMap.get(keyCode)) + "'");
					}
					j++;
				}
				sb.append("]}");
				if(i != entityList.size()-1)
					sb.append(",");
			}
			sb.append("]}");
			
			clearMemory(entityList);
			return sb.toString();
		}		
	}
	
	
	
	/**
     * 打印
     * @param args
     * @return String
     * @throws ServiceException
     */
	public String report(Map args) throws ServiceException {
 		String reportName = (String)args.get("reportName");
		if (applicationContext.containsBean(reportName)) {
			Reportable reportable = applicationContext.getBean(reportName, Reportable.class);
			try {
				return reportable.report(args);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				throw new ServiceException(e.getMessage(), e);
			}
		}
		return null;
	}
	
	
	/**
	 * 清除占用内存
	 * @param obj
	 */
	public void clearMemory(Object obj){
		obj = null;
	} 
	
	/**
	 * 清除占用内存
	 * @param obj
	 */
	public void clearMemory(Object[] objs){
		for (int i = 0; i < objs.length; i++) {
			objs[i] = null;
		}
	} 	
}
