package util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import oilcan.base.container.ServiceLocator;
import oilcan.base.exception.ServiceException;
import oilcan.model.Dict;
import oilcan.service.DictService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *	字典表工具
 * @author PL
 *
 */
public class DictUtil {
		
	// 用initFlag判断字典表是否已初始化
	private static boolean initFlag = false;
	
	// 所有类型字典表MAP
	private static Map allDictMap = new HashMap();
	
	// 代码锁
	private static String Lock = "lock";
	
	static Log logger = LogFactory.getLog(DictUtil.class);
	
	/**
	 * 从数据库获取DICT表的所有记录，并初始化MAP
	 * @throws ServiceException 
	 */
	private static void initDictMap() throws ServiceException
	{
		DictService dictService = ServiceLocator.getService("dictService", DictService.class);
		List<Dict> dictList = (List<Dict>)dictService.getDictList();
		if(!dictList.isEmpty())
		{
			allDictMap.clear(); // 将Map重置
			for (int i = 0; i < dictList.size(); i++) 
			{
				Dict dict = (Dict)dictList.get(i);
				if(allDictMap.containsKey(dict.getCodeType()))
					setMapValue((Map)allDictMap.get(dict.getCodeType()), dict);
				else
					setMapValue(new TreeMap(), dict);;
			}
		}
	}
	
	/**
	 * 执行初始化动作
	 */
	public static void init()
	{
		if (!initFlag) 
		{
			try 
			{ 
				synchronized (Lock) 
				{ 
					if (!initFlag) 
					{
						logger.debug("字典表初始化开始!!");
						initDictMap();
						initFlag = true;
						print();
						logger.debug("字典表初始化结束!!");
					} 
				}
			} catch (Exception e) 
			{
				logger.error("获取所有基础信息类型并生成Map失败!",e);
			}
		}
	}
	
	/**
	 * 重新初始化字典表MAP
	 */
	public static void reload()
	{
		initFlag = false;
		init();
	}
	
	/**
	 * 为allDictMap赋值
	 * @param dictTypeMap 
	 * @param dictType 字典表类型
	 * @param value
	 */
	private static void setMapValue(Map dictTypeMap, Dict fbDict)
	{
		dictTypeMap.put(fbDict.getCodeValue().trim(), fbDict.getCodeCnName()); 
		allDictMap.put(fbDict.getCodeType(), dictTypeMap);
	}
	
	/**
	 * 获取dictType类型MAP中code对应的value
	 * @param dictType
	 * @param code
	 * @return
	 */
	public static String getValueByDictCode(String dictType, String code)
	{
		if (!initFlag) 
			init();		
		if(null == (Map)allDictMap.get(dictType) || null == code)
			return "";
		else
			return StringUtil.escapeNull(((Map)allDictMap.get(dictType)).get(code)); 
	}
	
	/**
	 * 获取dictType类型的map
	 * @param dictType
	 * @param code
	 * @return
	 */
	public static Map getDictTypeMap(String dictType)
	{
		if (!initFlag) 
			init();		
		return (Map)allDictMap.get(dictType);
	}
	
	private static void print()
	{
//		Iterator iterator = allDictMap.entrySet().iterator();
//		while(iterator.hasNext()) 
//		{
//			Map.Entry entry = (Map.Entry) iterator.next(); 
//			Iterator iter = ((Map)entry.getValue()).entrySet().iterator();
//			System.out.println(" 字典表类型 为： " + entry.getKey());
//			while (iter.hasNext()) 
//			{
//				Map.Entry e = (Map.Entry) iter.next(); 
//				System.out.println("    >>>  代码 :  " + StringUtil.escapeNull(e.getKey()) + "        值 :  " + StringUtil.escapeNull(e.getValue())); 
//			}
//		} 
		System.out.println("    >>>  字典表加载完毕  ");
	}
}
