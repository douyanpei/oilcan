package oilcan.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import oilcan.base.exception.ServiceException;
import oilcan.base.service.ServiceSupport;
import oilcan.model.BaseInformation;
import oilcan.model.CheckRecord;
import oilcan.model.DetermineShow;
import oilcan.model.OilcanShoulder;
import oilcan.model.Problem;
import oilcan.model.RecoverDevice;
import oilcan.model.ReportPage;
import oilcan.model.SafeAttachment;
import oilcan.model.ValveHermetic;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import util.Constants;
import util.StringUtil;

public class OilcanService extends ServiceSupport{
	
	protected final Log logger = LogFactory.getLog(OilcanService.class);
	
	/**
	 * 保存罐车信息
	 * @param bi
	 * @param problems
	 * @return
	 * @throws ServiceException
	 */
	public int saveOilcan(BaseInformation bi, CheckRecord[] checkRecords, Problem[] problems, OilcanShoulder os, SafeAttachment sa, RecoverDevice rd, ValveHermetic vh, DetermineShow ds, ReportPage rp) throws ServiceException{
		if(StringUtil.isEmpty(bi.getId()))
			hdao.save(bi);
		else
			hdao.merge(bi);
		hdao.flush();
		
		for(Problem problem : problems){
			problem.setBaseId(bi.getId());
			if(StringUtil.isEmpty(problem.getPid()))
				hdao.save(problem);
			else
				hdao.merge(problem);
		}
		
		for(CheckRecord checkRecord : checkRecords){
			checkRecord.setBaseId(bi.getId());
			if(StringUtil.isEmpty(checkRecord.getPid()))
				hdao.save(checkRecord);
			else
				hdao.merge(checkRecord);
		}
		
		os.setBaseId(bi.getId());
		os.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(os.getPid()))
			hdao.save(os);
		else
			hdao.merge(os);
		
		sa.setBaseId(bi.getId());
		sa.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(sa.getPid()))
			hdao.save(sa);
		else
			hdao.merge(sa);
		
		rd.setBaseId(bi.getId());
		rd.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(rd.getPid()))
			hdao.save(rd);
		else
			hdao.merge(rd);
		
		vh.setBaseId(bi.getId());
		vh.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(vh.getPid()))
			hdao.save(vh);
		else
			hdao.merge(vh);
		
		ds.setBaseId(bi.getId());
		ds.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(ds.getPid()))
			hdao.save(ds);
		else
			hdao.merge(ds);
		
		rp.setBaseId(bi.getId());
		rp.setCarNo(bi.getCarNo());
		if(StringUtil.isEmpty(rp.getPid()))
			hdao.save(rp);
		else
			hdao.merge(rp);
		
		return Constants.SUCCESS;
	}
	
	/**
	 * 删除罐车信息
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public int deleteOilcan(String id) throws ServiceException{
		jdao.update("delete from ValveHermetic where baseId='" + id + "'");
		jdao.update("delete from SafeAttachment where baseId='" + id + "'");
		jdao.update("delete from RecoverDevice where baseId='" + id + "'");
		jdao.update("delete from DetermineShow where baseId='" + id + "'");
		jdao.update("delete from Problem where baseId='" + id + "'");
		jdao.update("delete from CheckRecord where baseId='" + id + "'");
		jdao.update("delete from OilcanShoulder where baseId='" + id + "'");
		jdao.update("delete from BaseInformation where id='" + id + "'");
		jdao.update("delete from CheckRecord where baseId='" + id + "'");
		jdao.update("delete from ReportPage where baseId='" + id + "'");
		return Constants.SUCCESS;
	}
	
	/**
	 * 删除罐车信息
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public int bjOilcan(String id) throws ServiceException{
		jdao.update("update BaseInformation set bj='1' where id='" + id + "'");
		return Constants.SUCCESS;
	}
	
	
	public List<Map<String, Object>> findPerson() throws ServiceException{
		String sql = "select pid, name from PersonInfo";
		return jdao.queryForList(sql);
	}
	
	public int deleteBase(String id) throws ServiceException{
		return jdao.update("delete from Problem where pid='" + id + "'");
	}
	
	public int deleteCheck(String id) throws ServiceException{
		return jdao.update("delete from CheckRecord where pid='" + id + "'");
	}
	
	
	public int insertSql(String path) throws ServiceException{
		List<String> sqlList = new ArrayList<String>(); 
		try {
			FileReader fr = new FileReader(path);
			BufferedReader br = new BufferedReader(fr); 
			String s = ""; 
			while ((s = br.readLine()) != null) { 
				if(s.endsWith("#")){ 
					sqlList.add(s.substring(0, s.length()-1)); 
				}
			}
			this.jdao.batchUpdate(sqlList.toArray(new String[0]));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 数据导出
	 * @param ids
	 * @throws ServiceException
	 */
	public void exportOilcan(String ids) throws ServiceException{
		ids = ids.replaceAll(",", "','");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			File folder = new File("D:" + File.separator + "SQL");
			if(!folder.exists())
				folder.mkdirs();
			File file = new File("D:" + File.separator + "SQL" + File.separator + df.format(new Date()) + ".sql");
		
			file.createNewFile();
			FileOutputStream out = new FileOutputStream(file);
			byte[] b = new byte[409600];
			StringBuffer deleteBuffer = new StringBuffer();
			
			deleteBuffer.append("delete from BaseInformation where id in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from CheckRecord where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from DetermineShow where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from OilcanShoulder where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from Problem where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from RecoverDevice where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from ReportPage where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from SafeAttachment where baseId in('" + ids + "')#\n\r");
			deleteBuffer.append("delete from ValveHermetic where baseId in('" + ids + "')#\n\r");
			
			List<Map<String, Object>> baseInformationList = jdao.queryForList("select * from BaseInformation where id in('" + ids + "')");
			String baseInformation = "";
			for (Map<String, Object> baseInformationMap : baseInformationList) {
				baseInformation += "INSERT INTO BaseInformation (id, oilcanBrand, oilcanModel, carNo, produce1, carModel, outDate1," + 
					" produce2, firstCheckDate, outDate2, medium, mediumCode, density, regDate, length, width, height, weight," +
					" axisNum, outCapacity, allowCapacity, allowWeight, oilcanMaterial, warehouseNum, unitName, outCode," + 
					" licensedCode, organizationName, checkCode, spotCode, conclusion, nextCheckDate, checkDate, convertNote) VALUES" +
					" ('" + StringUtil.escapeNull(baseInformationMap.get("id")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("oilcanBrand")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("oilcanModel")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("carNo")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("produce1")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("carModel")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("outDate1")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("produce2")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("firstCheckDate")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("outDate2")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("medium")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("mediumCode")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("density")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("regDate")) + "'," +
					StringUtil.escapeDouble(baseInformationMap.get("length")) + ", " + StringUtil.escapeDouble(baseInformationMap.get("width")) + "," +
					StringUtil.escapeDouble(baseInformationMap.get("height")) + ", " + StringUtil.escapeDouble(baseInformationMap.get("weight")) + "," +
					StringUtil.escapeDouble(baseInformationMap.get("axisNum")) + ", " + StringUtil.escapeDouble(baseInformationMap.get("outCapacity")) + "," +
					StringUtil.escapeDouble(baseInformationMap.get("allowCapacity")) + ", " + StringUtil.escapeDouble(baseInformationMap.get("allowWeight")) + "," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("oilcanMaterial")) + "', " + StringUtil.escapeDouble(baseInformationMap.get("warehouseNum")) + "," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("unitName")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("outCode")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("licensedCode")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("organizationName")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("checkCode")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("spotCode")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("conclusion")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("nextCheckDate")) + "'," +
					"'" + StringUtil.escapeNull(baseInformationMap.get("checkDate")) + "', '" + StringUtil.escapeNull(baseInformationMap.get("convertNote")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> valveHermeticList = jdao.queryForList("select * from ValveHermetic where baseId in('" + ids + "')");
			String valveHermetic = "";
			for (Map<String, Object> valveHermeticMap : valveHermeticList) {
				valveHermetic += "INSERT INTO ValveHermetic (pid, baseId, carNo, firstOilcan, secondOilcan, thirdOilcan, forthOilcan," +
					"fifthOilcan, pressureStart, pressureEnd, pressureState, question, conclusion, checkPerson) VALUES" +
				 	" ('" + StringUtil.escapeNull(valveHermeticMap.get("pid")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(valveHermeticMap.get("carNo")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("firstOilcan")) + "'," +
					"'" + StringUtil.escapeNull(valveHermeticMap.get("secondOilcan")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("thirdOilcan")) + "'," +
					"'" + StringUtil.escapeNull(valveHermeticMap.get("forthOilcan")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("fifthOilcan")) + "'," +
					StringUtil.escapeDouble(valveHermeticMap.get("pressureStart")) + ", " + StringUtil.escapeDouble(valveHermeticMap.get("pressureEnd")) + "," +
					"'" + StringUtil.escapeNull(valveHermeticMap.get("pressureState")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("question")) + "'," +
					"'" + StringUtil.escapeNull(valveHermeticMap.get("conclusion")) + "', '" + StringUtil.escapeNull(valveHermeticMap.get("checkPerson")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> safeAttachmentList = jdao.queryForList("select * from SafeAttachment where baseId in('" + ids + "')");
			String safeAttachment = "";
			for (Map<String, Object> safeAttachmentMap : safeAttachmentList) {
				safeAttachment += "INSERT INTO SafeAttachment (pid, baseId, carNo, fireDevice, dangerLamp, dangerPlate, surfaceMark," + 
					"paintColor, systemPosition, rubber, transmitType, transmitValue, attendance, ladder, valveContainer," +
					"valveState, garnerContainer, switchSystem, pressure, dnLength, dnNum, dnState, breakSystem, checkPerson) VALUES" +
					" ('" + StringUtil.escapeNull(safeAttachmentMap.get("pid")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("carNo")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("fireDevice")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("dangerLamp")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("dangerPlate")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("surfaceMark")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("paintColor")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("systemPosition")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("rubber")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("transmitType")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("transmitValue")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("attendance")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("ladder")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("valveContainer")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("valveState")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("garnerContainer")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("switchSystem")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("pressure")) + "', " + StringUtil.escapeDouble(safeAttachmentMap.get("dnLength")) + "," +
					StringUtil.escapeDouble(safeAttachmentMap.get("dnNum")) + ", '" + StringUtil.escapeNull(safeAttachmentMap.get("dnState")) + "'," +
					"'" + StringUtil.escapeNull(safeAttachmentMap.get("breakSystem")) + "', '" + StringUtil.escapeNull(safeAttachmentMap.get("checkPerson")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> reportPageList = jdao.queryForList("select * from ReportPage where baseId in('" + ids + "')");
			String reportPage = "";
			for (Map<String, Object> reportPageMap : reportPageList) {
				reportPage += "INSERT INTO ReportPage (pid, baseId, code, materialType, mediumType, mediumNote, registerCode, roadCode, carNo) VALUES" +
					" ('" + StringUtil.escapeNull(reportPageMap.get("pid")) + "', '" + StringUtil.escapeNull(reportPageMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(reportPageMap.get("code")) + "', '" + StringUtil.escapeNull(reportPageMap.get("materialType")) + "'," +
					"'" + StringUtil.escapeNull(reportPageMap.get("mediumType")) + "', '" + StringUtil.escapeNull(reportPageMap.get("mediumNote")) + "'," +
					"'" + StringUtil.escapeNull(reportPageMap.get("registerCode")) + "', '" + StringUtil.escapeNull(reportPageMap.get("roadCode")) + "'," +
					"'" + StringUtil.escapeNull(reportPageMap.get("carNo")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> recoverDeviceList = jdao.queryForList("select * from RecoverDevice where baseId in('" + ids + "')");
			String recoverDevice = "";
			for (Map<String, Object> recoverDeviceMap : recoverDeviceList) {
				recoverDevice += "INSERT INTO RecoverDevice (pid, baseId, carNo, kiss, hat, valve, gluing, oilcanPipe, lineValve," +
					"stand, pressure, bottomKiss, bottomHat, bottomValve, centerValve, outlet, fixHeight) VALUES" +
					" ('" + StringUtil.escapeNull(recoverDeviceMap.get("pid")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("carNo")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("kiss")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("hat")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("valve")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("gluing")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("oilcanPipe")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("lineValve")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("stand")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("pressure")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("bottomKiss")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("bottomHat")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("bottomValve")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("centerValve")) + "', '" + StringUtil.escapeNull(recoverDeviceMap.get("outlet")) + "'," +
					"'" + StringUtil.escapeNull(recoverDeviceMap.get("fixHeight")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> problemList = jdao.queryForList("select * from Problem where baseId in('" + ids + "')");
			String problem = "";
			for (Map<String, Object> problemMap : problemList) {
				problem += "INSERT INTO Problem (pid, baseId, description) VALUES" +
					" ('" + StringUtil.escapeNull(problemMap.get("pid")) + "', '" + StringUtil.escapeNull(problemMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(problemMap.get("description")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> oilcanShoulderList = jdao.queryForList("select * from OilcanShoulder where baseId in('" + ids + "')");
			String oilcanShoulder = "";
			for (Map<String, Object> oilcanShoulderMap : oilcanShoulderList) {
				oilcanShoulder += "INSERT INTO OilcanShoulder (pid, baseId, carNo, bulwarkNum, bulwarkState, holeNum, holeState," + 
					"affluxNum, affluxState, detroitType, detroitState, hasCrack, oilcanShow, oilcanDefect, diameter," + 
					"diameterNum, valveType, valveMaterial, seepage, hose, refuel, recoverSystem, recoverState," + 
					"bengSystem, bengState, measureSystem, refitPlace, oilcanHeat, checkPerson) VALUES" +
					" ('" + StringUtil.escapeNull(oilcanShoulderMap.get("pid")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("carNo")) + "', " + StringUtil.escapeDouble(oilcanShoulderMap.get("bulwarkNum")) + "," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("bulwarkState")) + "', " + StringUtil.escapeDouble(oilcanShoulderMap.get("holeNum")) + "," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("holeState")) + "', " + StringUtil.escapeDouble(oilcanShoulderMap.get("affluxNum")) + "," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("affluxState")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("detroitType")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("detroitState")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("hasCrack")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("oilcanShow")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("oilcanDefect")) + "'," +
					StringUtil.escapeDouble(oilcanShoulderMap.get("diameter")) + ", " + StringUtil.escapeDouble(oilcanShoulderMap.get("diameterNum")) + "," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("valveType")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("valveMaterial")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("seepage")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("hose")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("refuel")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("recoverSystem")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("recoverState")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("bengSystem")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("bengState")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("measureSystem")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("refitPlace")) + "', '" + StringUtil.escapeNull(oilcanShoulderMap.get("oilcanHeat")) + "'," +
					"'" + StringUtil.escapeNull(oilcanShoulderMap.get("checkPerson")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> determineShowList = jdao.queryForList("select * from DetermineShow where baseId in('" + ids + "')");
			String determineShow = "";
			for (Map<String, Object> determineShowMap : determineShowList) {
				determineShow += "INSERT INTO DetermineShow (pid, baseId, carNo, deviceModel, oilcanMaterial, deviceCrack, coverHeader," +
					"coupling, gaugeNum, thickness, image1, image2, showCheck, conclusion, checkPerson) VALUES" +
					" ('" + StringUtil.escapeNull(determineShowMap.get("pid")) + "', '" + StringUtil.escapeNull(determineShowMap.get("baseId")) + "'," +
					"'" + StringUtil.escapeNull(determineShowMap.get("carNo")) + "', '" + StringUtil.escapeNull(determineShowMap.get("deviceModel")) + "'," +
					"'" + StringUtil.escapeNull(determineShowMap.get("oilcanMaterial")) + "', '" + StringUtil.escapeNull(determineShowMap.get("deviceCrack")) + "'," +
					"'" + StringUtil.escapeNull(determineShowMap.get("coverHeader")) + "', '" + StringUtil.escapeNull(determineShowMap.get("coupling")) + "'," +
					StringUtil.escapeDouble(determineShowMap.get("gaugeNum")) + ", '" + StringUtil.escapeDouble(determineShowMap.get("thickness")) + "'," +
					StringUtil.escapeDouble(determineShowMap.get("image1")) + ", " + StringUtil.escapeDouble(determineShowMap.get("image2")) + "," +
					"'" + StringUtil.escapeNull(determineShowMap.get("showCheck")) + "', '" + StringUtil.escapeNull(determineShowMap.get("conclusion")) + "'," +
					"'" + StringUtil.escapeNull(determineShowMap.get("checkPerson")) + "')#\n\r";
			}
			
			
			List<Map<String, Object>> checkRecordList = jdao.queryForList("select * from CheckRecord where baseId in('" + ids + "')");
			String checkRecord = "";
			for (Map<String, Object> checkRecordMap : checkRecordList) {
				checkRecord += "INSERT INTO CheckRecord (pid, baseId, description) VALUES" +
				" ('" + StringUtil.escapeNull(checkRecordMap.get("pid")) + "', '" + StringUtil.escapeNull(checkRecordMap.get("baseId")) + "'," +
				"'" + StringUtil.escapeNull(checkRecordMap.get("description")) + "')#\n\r";
			}
			 
			b = (deleteBuffer.toString() + baseInformation + valveHermetic + safeAttachment + reportPage + recoverDevice + problem + oilcanShoulder + determineShow + checkRecord).getBytes();
			out.write(b);   //写入文本内容  
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();	
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
