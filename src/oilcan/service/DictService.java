package oilcan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import util.Constants;
import util.DictUtil;
import util.StringUtil;
import oilcan.base.exception.ServiceException;
import oilcan.base.service.ServiceSupport;
import oilcan.model.Dict;

public class DictService extends ServiceSupport {
	protected final Log logger = LogFactory.getLog(DictService.class);
	/**
	 * 获取所有记录 返回JSON
	 * 
	 * @param list
	 * @return
	 * @throws ServiceException
	 */
	public String queryAllDictList2Json() throws ServiceException {
		String hql = "from Dict order by codeType,codeValue ";
		return ((List<Dict>)this.findByHql(hql)).toString();
	}
	
	/**
	 * 获取指定的记录 返回JSON
	 * 
	 * @param list
	 * @return
	 * @throws ServiceException
	 */
	public String queryDictList2Json(String codeCnName, String codeType, String codeDesc) throws ServiceException {
		String hql = "from Dict where codeCnName like '%" + codeCnName + "%' and codeType like '%" + codeType + "%' and codeDesc like '%" + codeDesc + "%' order by codeType,codeValue"; 
		return ((List<Dict>)this.findByHql(hql)).toString();
	}
	
	/**
	 * 获取code_isuse = 1（在用）的所有记录
	 * 
	 * @param list
	 * @return
	 * @throws ServiceException
	 */
	public List<Dict> queryDictList() throws ServiceException {
		String hql = "from Dict where codeIsUse = '1' ";
		return (List<Dict>)this.findByHql(hql);
	}

	/**
	 * 获取code_isuse = 1（在用）的所有记录
	 * 
	 * @param list
	 * @return
	 * @throws ServiceException
	 */
	public List<Dict> getDictList() throws ServiceException {
		List<Dict> list = (List<Dict>)this.findByHql("from Dict where codeIsUse = '1'");
		return list;
	}
	
	/**
	 * 获取中文名为codeCnName的记录
	 * 
	 * @param codeType
	 * @param codeCnName
	 * @return
	 * @throws ServiceException
	 */
	public Dict getDictByCnName(String codeType, String codeCnName) throws ServiceException {
		List<Dict> list = (List<Dict>)this.findByHql("from Dict where codeType=? and codeCnName=? and codeIsUse = '1'", codeType, codeCnName);
		return list.size()>0?list.get(0):null;
	}
	
	public Dict getDictById(Integer id) throws ServiceException{
		return this.get(Dict.class, id);
	}

	/**
	 * 保存数据
	 * @param dict
	 * @return
	 */
	public int saveDict(Dict dict) {
		try{
			if(!StringUtil.isEmpty(dict.getId()))
				hdao.merge(dict);
			else
				hdao.save(dict);
			DictUtil.reload();
			return Constants.SUCCESS;
		}catch (Exception e){
			logger.error(e.getMessage(), e);
			e.printStackTrace();
			return Constants.FAILURE;
		}
	}
	
	/**
	 * 删除数据
	 * @param dict
	 * @return
	 */
	public int deleteDict(String id) {
		try{
			this.hdao.delete(getDictById(Integer.valueOf(id)));
			DictUtil.reload();
			return Constants.SUCCESS;
		}catch (Exception e){
			logger.error(e.getMessage(), e);
			e.printStackTrace();
			return Constants.FAILURE;
		}
	}

	/**
	 * 根据字典类型查询所有项目
	 * 
	 * @param codeType字典类型
	 * @return
	 * @throws ServiceException
	 */
	public List<Dict> queryDictByCodetype(String codeType) throws ServiceException {
		List<Dict> list = new ArrayList<Dict>();
		if (!"".equals(codeType)) {
			Map<String, String> map = DictUtil.getDictTypeMap(codeType);
			for (String str : map.keySet()) {
				Dict dict = new Dict();
				dict.setCodeCnName(map.get(str));
				dict.setCodeValue(str);
				list.add(dict);
			}
		}
		return list;
	}
	
	public String queryDictByCodetypeJSON(String codeType) throws ServiceException {
		String sql="SELECT codeValue,0,codeCNName FROM Dict where codeType='"+codeType+"' AND codeIsUse = '1' ORDER BY codeValue";
		return this.findPropertiesBySql(sql);
	}
	
	public String queryDictByCodetypeJSON(String codeType,String where) throws ServiceException {
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT codeValue,0,codeCNName FROM Dict where codeType='");
		sql.append(codeType).append("' ");
		if(!StringUtil.isEmpty(where)){
			sql.append(where);
		}
		sql.append(" AND codeIsUse = '1' ORDER BY codeValue");
				
		return this.findPropertiesBySql(sql.toString());
	}
	
	
	public String queryCodeCNNameByCodetype(String[] phIds,String codeType) throws ServiceException {
		if(phIds.length<1){
			return "";
		}
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM DICT WHERE codeType='").append(codeType).append("' AND codeValue IN (");
		sql.append(StringUtil.arrayToString(phIds, ",", "'",null));
		sql.append(")");

		List rows = jdao.queryForList(sql.toString());
		String codeCNName="";
		if(rows.size()>0){
			for(int i=0;i<rows.size();i++){ 
				Map map=(Map) rows.get(i);  
				codeCNName+=(map.get("codeCNName")+"").trim();
				
				if(i+1<rows.size()){
					codeCNName+=",";
				}
				
			}
		}
		return codeCNName;
	}
	
	@SuppressWarnings("unchecked")
	public List<Dict> queryDicetBySelect(String[] phIds,String codeType) throws ServiceException {
		List<Dict> dictList=new ArrayList<Dict>();
		
		if(phIds.length<1){
			return new ArrayList<Dict>();
		}
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM DICT WHERE codeType='").append(codeType).append("' AND codeValue IN (");
		sql.append(StringUtil.arrayToString(phIds, ",", "'",null));
		sql.append(")");

		List rows = jdao.queryForList(sql.toString());
		
		if(rows.size()>0){
			for(int i=0;i<rows.size();i++){ 
				Map map=(Map) rows.get(i);  
				Dict dict=new Dict();
				dict.setCodeCnName((map.get("codeCNName")+"").trim());
				dict.setCodeValue((map.get("codeValue")+"").trim());
				
				dictList.add(dict);
			}
		}
		return dictList;
	}
	
	/**
	 * 通过类别和名称查询编码
	 * @param codeType
	 * @param codeCNName
	 * @return
	 * @throws ServiceException
	 */
	public String queryDictValueByName(String codeType, String codeCNName) throws ServiceException {
		return jdao.queryForObject("select codeValue from DICT where codeType='" + codeType + "' and codeCNNname='" + codeType + "'", String.class);
	}
	
	
	/**
	 * 查询字典数据
	 * @return
	 * @throws ServiceException
	 */
	public String findDict(String conditionSql) throws ServiceException {
		List<Map<String, Object>> dictList = jdao.queryForList("select * from Dict" + conditionSql + " order by codeType,codeValue");
		StringBuffer sb = new StringBuffer();
		sb.append("{rows:[");
		for(int i=0; i<dictList.size(); i++){
			Map<String, Object> dictMap = dictList.get(i);
			sb.append("{id:");
			sb.append("'" + dictMap.get("id") + "',data:[");
			sb.append("'" + dictMap.get("codeType") + "',");
			sb.append("'" + StringUtil.escapeNull(dictMap.get("codeDesc")) + "',");
			sb.append("'" + dictMap.get("codeCNName") + "',");
			sb.append("'" + dictMap.get("codeValue") + "',");
			sb.append("'" + StringUtil.escapeNull(dictMap.get("codeCnDesc")) + "',");
			sb.append("'" + (StringUtil.escapeNull(dictMap.get("codeIsUse")).equals("1") ? "是" : "否") + "'");
			sb.append("]}");
			if(i != dictList.size()-1)
				sb.append(",");
		}
		sb.append("]}");
		clearMemory(dictList);
		return sb.toString();
	}
}