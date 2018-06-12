package report.impl;

import java.util.List;
import java.util.Map;

import oilcan.model.BaseInformation;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import report.api.AbstractXmlReport;
import util.DictUtil;
import util.StringUtil;
import web.WebScope;

public class OilcanReport extends AbstractXmlReport {

	private static final long serialVersionUID = -4322286859402639132L;
	
	private JdbcTemplate jdao;
	private HibernateTemplate hdao;
	
	public OilcanReport() {}
	
	public OilcanReport(String xml, String xsl, JdbcTemplate jdao, HibernateTemplate hdao, WebScope webScope) {
		super(xml, xsl, webScope);
		this.jdao = jdao;
		this.hdao = hdao;
	}

	@Override
	protected void buildXmlDocument(Map args, Document xmlDoc) throws Exception {
		try{
			String id = (String)args.get("id");
			BaseInformation bi = hdao.get(BaseInformation.class, id);
			
			NodeList list = xmlDoc.getElementsByTagName("base");
			Element node = (Element) list.item(0);
			Element e = xmlDoc.createElement("baseLine");
			node.appendChild(e);
			e.setAttribute("brandModel", bi.getOilcanBrand() + " " + bi.getOilcanModel()); 
			e.setAttribute("carNo", bi.getCarNo()); 
			e.setAttribute("produce1", StringUtil.escapeNull(bi.getProduce1())); 
			e.setAttribute("carModel", StringUtil.escapeNull(bi.getCarModel())); 
			e.setAttribute("outDate1", StringUtil.escapeNull(bi.getOutDate1())); 
			e.setAttribute("produce2", StringUtil.escapeNull(bi.getProduce2())); 
			e.setAttribute("firstCheckDate", StringUtil.escapeNull(bi.getFirstCheckDate())); 
			e.setAttribute("outDate2", StringUtil.escapeNull(bi.getOutDate2())); 
			e.setAttribute("medium", StringUtil.escapeNull(DictUtil.getValueByDictCode("MEDIUM", bi.getMedium())) + (StringUtil.isEmpty(bi.getDensity()) ? "" : "  相对密度" + bi.getDensity())); 
			e.setAttribute("regDate", StringUtil.escapeNull(bi.getRegDate())); 
			e.setAttribute("lwh", bi.getLength() + "×" + bi.getWidth() + "×" + bi.getHeight()); 
			e.setAttribute("weightAxis", bi.getWeight() + "吨" + bi.getAxisNum() + "轴"); 
			e.setAttribute("outCapacity", StringUtil.escapeNull(bi.getOutCapacity()));
			e.setAttribute("allowCapacity", StringUtil.escapeNull(bi.getAllowCapacity()));
			e.setAttribute("allowWeight", StringUtil.escapeNull(bi.getAllowWeight()));
			e.setAttribute("oilcanMaterial", StringUtil.escapeNull(DictUtil.getValueByDictCode("MATERIAL", bi.getOilcanMaterial())));
			e.setAttribute("warehouseNum", StringUtil.escapeNull(bi.getWarehouseNum()));
			e.setAttribute("unitName", StringUtil.escapeNull(bi.getUnitName()));
			e.setAttribute("outCode", StringUtil.escapeNull(bi.getOutCode()));
			e.setAttribute("licensedCode", StringUtil.escapeNull(bi.getLicensedCode()));
			e.setAttribute("organizationName", StringUtil.escapeNull(bi.getOrganizationName()));
			e.setAttribute("checkCode", StringUtil.escapeNull(bi.getCheckCode()));
			e.setAttribute("spotCode", StringUtil.escapeNull(bi.getSpotCode()));
			e.setAttribute("conclusion", StringUtil.escapeNull(bi.getConclusion()));
			e.setAttribute("nextCheckDate", StringUtil.escapeNull(bi.getNextCheckDate()));
			e.setAttribute("checkDate", StringUtil.escapeNull(bi.getCheckDate()));
			e.setAttribute("convertNote", StringUtil.escapeNull(bi.getConvertNote()));
			String checkDate = StringUtil.escapeNull(bi.getCheckDate());
			
			list = xmlDoc.getElementsByTagName("problem");
			node = (Element) list.item(0);
			List<Map<String, Object>> problemList = jdao.queryForList("select * from Problem where baseId='" + id + "'");
			for(int i=0; i<problemList.size(); i++){
				Map<String, Object> problemMap = problemList.get(i);
				e = xmlDoc.createElement("problemLine");
				node.appendChild(e);
				e.setAttribute("description", StringUtil.escapeNull(problemMap.get("description")));
			}
			
			list = xmlDoc.getElementsByTagName("checkRecord");
			node = (Element) list.item(0);
			List<Map<String, Object>> checkRecordList = jdao.queryForList("select * from CheckRecord where baseId='" + id + "'");
			for(int i=0; i<checkRecordList.size(); i++){
				Map<String, Object> checkRecordMap = checkRecordList.get(i);
				e = xmlDoc.createElement("checkRecordLine");
				node.appendChild(e);
				e.setAttribute("description", StringUtil.escapeNull(checkRecordMap.get("description")));
			}
			
			list = xmlDoc.getElementsByTagName("oilcanShoulder");
			node = (Element) list.item(0);
			List<Map<String, Object>> oilcanShoulderList = jdao.queryForList("select * from OilcanShoulder where baseId='" + id + "'");
			if(oilcanShoulderList.size() != 0){
				Map<String, Object> oilcanShoulderMap = oilcanShoulderList.get(0);
				e = xmlDoc.createElement("oilcanShoulderLine");
				node.appendChild(e);
				e.setAttribute("checkDate", checkDate.substring(0, 4) + "年" + Integer.parseInt(checkDate.substring(5, 7)) + "月" + Integer.parseInt(checkDate.substring(8)) + "日");
				String checkPerson = StringUtil.escapeNull(oilcanShoulderMap.get("checkPerson"));
				if(!"".equals(checkPerson)){
					String personName = jdao.queryForObject("select img from PersonInfo where pid='" + checkPerson + "'", String.class);
					e.setAttribute("checkPerson", "<img width='100px' height='25px' src='" + personName + "'/>");
				}
				e.setAttribute("bulwarkNum", "内置" + StringUtil.escapeNull(oilcanShoulderMap.get("bulwarkNum") + "块"));
				e.setAttribute("bulwarkState", StringUtil.escapeNull(oilcanShoulderMap.get("bulwarkState")));
				e.setAttribute("holeNum", StringUtil.escapeNull(oilcanShoulderMap.get("holeNum")) + "个");
				e.setAttribute("holeState", StringUtil.escapeNull(oilcanShoulderMap.get("holeState")));
				e.setAttribute("affluxNum", StringUtil.escapeNull(oilcanShoulderMap.get("affluxNum")) + "个");
				e.setAttribute("affluxState", StringUtil.escapeNull(oilcanShoulderMap.get("affluxState")));
				e.setAttribute("detroitType", StringUtil.escapeNull(oilcanShoulderMap.get("detroitType")));
				e.setAttribute("detroitState", StringUtil.escapeNull(oilcanShoulderMap.get("detroitState")));
				e.setAttribute("hasCrack", StringUtil.escapeNull(oilcanShoulderMap.get("hasCrack")));
				
				String oilcanShowStr = "";
				List<Map<String, Object>> oilcanShowList = jdao.queryForList("select * from Dict where codeType='SHOW'");
				String oilcanShow = StringUtil.escapeNull(oilcanShoulderMap.get("oilcanShow"));
				for(int i=0; i<oilcanShow.split(",").length; i++){
					if(oilcanShow.split(",")[i].equals("1")){
						oilcanShowStr += "," + StringUtil.escapeNull(oilcanShowList.get(i).get("codeCNName"));
					}
				}
				if(!"".equals(oilcanShowStr))
					oilcanShowStr = oilcanShowStr.substring(1);
				
				e.setAttribute("oilcanShow", oilcanShowStr);
				e.setAttribute("oilcanDefect", StringUtil.escapeNull(oilcanShoulderMap.get("oilcanDefect")));
				
				String diameterStr = "";
				if(!StringUtil.isEmpty(oilcanShoulderMap.get("diameter"))){
					String diameter = StringUtil.escapeNull(oilcanShoulderMap.get("diameter"));
					String diameterNum = StringUtil.escapeNull(oilcanShoulderMap.get("diameterNum"));
					for(int y=0; y<diameter.split(",").length; y++){
						if(y != diameter.split(",").length-1)
							diameterStr += "DN" + diameter.split(",")[y] + " " + diameterNum.split(",")[y] + "个  ";
						else
							diameterStr += " DN" + diameter.split(",")[y] + " " + diameterNum.split(",")[y] + "个";
					}
				}
				
				e.setAttribute("diameter", diameterStr);
				e.setAttribute("diameterNum", "");
				
				e.setAttribute("valveType", StringUtil.escapeNull(oilcanShoulderMap.get("valveType")));
				
				String valveMaterialStr = "";
				List<Map<String, Object>> valveMaterialList = jdao.queryForList("select * from Dict where codeType='VALVEMATERIAL'");
				String valveMaterial = StringUtil.escapeNull(oilcanShoulderMap.get("valveMaterial"));
				for(int i=0; i<valveMaterial.split(",").length; i++){
					if(valveMaterial.split(",")[i].equals("1")){
						valveMaterialStr += "," + StringUtil.escapeNull(valveMaterialList.get(i).get("codeCNName"));
					}
				}
				if(!"".equals(valveMaterialStr))
					valveMaterialStr = valveMaterialStr.substring(1);
				e.setAttribute("valveMaterial", valveMaterialStr);
				
				e.setAttribute("seepage", StringUtil.escapeNull(DictUtil.getValueByDictCode("SEEPAGE", (String)oilcanShoulderMap.get("seepage"))));
				e.setAttribute("refuel", StringUtil.escapeNull(oilcanShoulderMap.get("refuel")));
				e.setAttribute("hose", StringUtil.escapeNull(oilcanShoulderMap.get("hose")));
				e.setAttribute("recoverSystem", StringUtil.escapeNull(oilcanShoulderMap.get("recoverSystem")));
				e.setAttribute("recoverState", StringUtil.escapeNull(oilcanShoulderMap.get("recoverState")));
				e.setAttribute("bengSystem", StringUtil.escapeNull(oilcanShoulderMap.get("bengSystem")));
				e.setAttribute("bengState", StringUtil.escapeNull(oilcanShoulderMap.get("bengState")));
				
				String measureSystemStr = "";
				List<Map<String, Object>> measureSystemList = jdao.queryForList("select * from Dict where codeType='MEASURESYSTEM'");
				String measureSystem = StringUtil.escapeNull(oilcanShoulderMap.get("measureSystem"));
				for(int i=0; i<measureSystem.split(",").length; i++){
					if(measureSystem.split(",")[i].equals("1")){
						measureSystemStr += "," + StringUtil.escapeNull(measureSystemList.get(i).get("codeCNName"));
					}
				}
				if(!"".equals(measureSystemStr))
					measureSystemStr = measureSystemStr.substring(1);
				e.setAttribute("measureSystem", measureSystemStr);
				
				e.setAttribute("refitPlace", StringUtil.escapeNull(oilcanShoulderMap.get("refitPlace")));
				e.setAttribute("oilcanHeat", StringUtil.escapeNull(oilcanShoulderMap.get("oilcanHeat")));
				e.setAttribute("carNo", StringUtil.escapeNull(oilcanShoulderMap.get("carNo")));
			}
			
			list = xmlDoc.getElementsByTagName("safeAttachment");
			node = (Element) list.item(0);
			List<Map<String, Object>> safeAttachmentList = jdao.queryForList("select * from SafeAttachment where baseId='" + id + "'");
			if(safeAttachmentList.size() != 0){
				Map<String, Object> safeAttachmentMap = safeAttachmentList.get(0);
				e = xmlDoc.createElement("safeAttachmentLine");
				node.appendChild(e);
				e.setAttribute("checkDate", checkDate.substring(0, 4) + "年" + Integer.parseInt(checkDate.substring(5, 7)) + "月" + Integer.parseInt(checkDate.substring(8)) + "日");
				String checkPerson = StringUtil.escapeNull(safeAttachmentMap.get("checkPerson"));
				if(!"".equals(checkPerson)){
					String personName = jdao.queryForObject("select img from PersonInfo where pid='" + checkPerson + "'", String.class);
					e.setAttribute("checkPerson", "<img width='100px' height='25px' src='" + personName + "'/>");
				}
				e.setAttribute("fireDevice", StringUtil.escapeNull(safeAttachmentMap.get("fireDevice")));
				e.setAttribute("dangerLamp", StringUtil.escapeNull(safeAttachmentMap.get("dangerLamp")));
				e.setAttribute("dangerPlate", StringUtil.escapeNull(safeAttachmentMap.get("dangerPlate")));
				e.setAttribute("surfaceMark", StringUtil.escapeNull(safeAttachmentMap.get("surfaceMark")));
				e.setAttribute("paintColor", StringUtil.escapeNull(safeAttachmentMap.get("paintColor")));
				e.setAttribute("systemPosition", StringUtil.escapeNull(safeAttachmentMap.get("systemPosition")));
				e.setAttribute("rubber", StringUtil.escapeNull(safeAttachmentMap.get("rubber")));
				e.setAttribute("transmitType", StringUtil.escapeNull(safeAttachmentMap.get("transmitType")));
				e.setAttribute("transmitValue", StringUtil.escapeNull(safeAttachmentMap.get("transmitValue")));
				e.setAttribute("attendance", StringUtil.escapeNull(safeAttachmentMap.get("attendance")));
				e.setAttribute("ladder", StringUtil.escapeNull(safeAttachmentMap.get("ladder")));
				e.setAttribute("valveContainer", StringUtil.escapeNull(safeAttachmentMap.get("valveContainer")));
				e.setAttribute("valveState", StringUtil.escapeNull(safeAttachmentMap.get("valveState")));
				e.setAttribute("garnerContainer", StringUtil.escapeNull(safeAttachmentMap.get("garnerContainer")));
				e.setAttribute("switchSystem", StringUtil.escapeNull(safeAttachmentMap.get("switchSystem")));
				e.setAttribute("pressure", StringUtil.escapeNull(safeAttachmentMap.get("pressure")));
				e.setAttribute("dnLength", StringUtil.escapeNull(safeAttachmentMap.get("dnLength")));
				e.setAttribute("dnNum", StringUtil.escapeNull(safeAttachmentMap.get("dnNum")));
				e.setAttribute("dnState", StringUtil.escapeNull(safeAttachmentMap.get("dnState")));
				e.setAttribute("breakSystem", StringUtil.escapeNull(safeAttachmentMap.get("breakSystem")));
				e.setAttribute("carNo", StringUtil.escapeNull(safeAttachmentMap.get("carNo")));
			}
			
			list = xmlDoc.getElementsByTagName("recoverDevice");
			node = (Element) list.item(0);
			List<Map<String, Object>> recoverDeviceList = jdao.queryForList("select * from RecoverDevice where baseId='" + id + "'");
			if(recoverDeviceList.size() != 0){
				Map<String, Object> recoverDeviceMap = recoverDeviceList.get(0);
				e = xmlDoc.createElement("recoverDeviceLine");
				node.appendChild(e);
				e.setAttribute("checkDate", checkDate.substring(0, 4) + "年" + Integer.parseInt(checkDate.substring(5, 7)) + "月" + Integer.parseInt(checkDate.substring(8)) + "日");
				e.setAttribute("carNo", StringUtil.escapeNull(recoverDeviceMap.get("carNo")));
				if(!StringUtil.escapeNull(recoverDeviceMap.get("kiss")).equals("/")){
					e.setAttribute("kissNum", StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("kissState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("kissState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("kissState3", "√");
					e.setAttribute("kissNote", (StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[2] : ""));
				}else
					e.setAttribute("kissState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("hat")).equals("/")){
					e.setAttribute("hatNum", StringUtil.escapeNull(recoverDeviceMap.get("hat")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("hatState1", "√");	
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("hatState2", "√");	
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("hatState3", "√");	
					e.setAttribute("hatNote", (StringUtil.escapeNull(recoverDeviceMap.get("hat")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("hat")).split(";")[2] : ""));
				}else
					e.setAttribute("hatState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("valve")).equals("/")){
					e.setAttribute("valveNum", StringUtil.escapeNull(recoverDeviceMap.get("valve")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("valveState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("valveState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("valveState3", "√");
					e.setAttribute("valveNote", (StringUtil.escapeNull(recoverDeviceMap.get("valve")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("valve")).split(";")[2] : ""));
				}else
					e.setAttribute("valveState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("gluing")).equals("/")){
					e.setAttribute("gluingNum", StringUtil.escapeNull(recoverDeviceMap.get("gluing")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("gluingState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("gluingState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("gluingState3", "√");
					e.setAttribute("gluingNote", (StringUtil.escapeNull(recoverDeviceMap.get("gluing")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("gluing")).split(";")[2] : ""));
				}else
					e.setAttribute("gluingState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("oilcanPipe")).equals("/")){
					e.setAttribute("oilcanPipeNum", StringUtil.escapeNull(recoverDeviceMap.get("oilcanPipe")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("oilcanPipeState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("oilcanPipeState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("oilcanPipeState3", "√");
					e.setAttribute("oilcanPipeNote", (StringUtil.escapeNull(recoverDeviceMap.get("oilcanPipe")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("oilcanPipe")).split(";")[2] : ""));
				}else
					e.setAttribute("oilcanPipeState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("lineValve")).equals("/")){
					e.setAttribute("lineValveNum", StringUtil.escapeNull(recoverDeviceMap.get("lineValve")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("lineValveState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("lineValveState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("lineValveState3", "√");
					e.setAttribute("lineValveNote", (StringUtil.escapeNull(recoverDeviceMap.get("lineValve")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("lineValve")).split(";")[2] : ""));
				}else
					e.setAttribute("lineValveState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("stand")).equals("/")){
					e.setAttribute("standNum", StringUtil.escapeNull(recoverDeviceMap.get("stand")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("standState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("standState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("standState3", "√");
					e.setAttribute("standNote", (StringUtil.escapeNull(recoverDeviceMap.get("stand")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("stand")).split(";")[2] : ""));
				}else
					e.setAttribute("standState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("pressure")).equals("/")){
					e.setAttribute("pressureNum", StringUtil.escapeNull(recoverDeviceMap.get("pressure")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("pressureState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("pressureState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("pressureState3", "√");
					e.setAttribute("pressureNote", (StringUtil.escapeNull(recoverDeviceMap.get("pressure")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("pressure")).split(";")[2] : ""));
				}else
					e.setAttribute("pressureState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("bottomKiss")).equals("/")){
					e.setAttribute("bottomKissNum", StringUtil.escapeNull(recoverDeviceMap.get("bottomKiss")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("bottomKissState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("bottomKissState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("bottomKissState3", "√");
					e.setAttribute("bottomKissNote", (StringUtil.escapeNull(recoverDeviceMap.get("bottomKiss")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("bottomKiss")).split(";")[2] : ""));
				}else
					e.setAttribute("bottomKissState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("bottomHat")).equals("/")){
					e.setAttribute("bottomHatNum", StringUtil.escapeNull(recoverDeviceMap.get("bottomHat")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("bottomHatState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("bottomHatState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("bottomHatState3", "√");
					e.setAttribute("bottomHatNote", (StringUtil.escapeNull(recoverDeviceMap.get("bottomHat")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("bottomHat")).split(";")[2] : ""));
				}else
					e.setAttribute("bottomHatState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("bottomValve")).equals("/")){
					e.setAttribute("bottomValveNum", StringUtil.escapeNull(recoverDeviceMap.get("bottomValve")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("bottomValveState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("bottomValveState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("bottomValveState3", "√");
					e.setAttribute("bottomValveNote", (StringUtil.escapeNull(recoverDeviceMap.get("bottomValve")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("bottomValve")).split(";")[2] : ""));
				}else
					e.setAttribute("bottomValveState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("centerValve")).equals("/")){
					e.setAttribute("centerValveNum", StringUtil.escapeNull(recoverDeviceMap.get("centerValve")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("centerValveState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("centerValveState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("centerValveState3", "√");
					e.setAttribute("centerValveNote", (StringUtil.escapeNull(recoverDeviceMap.get("centerValve")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("centerValve")).split(";")[2] : ""));
				}else
					e.setAttribute("centerValveState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("outlet")).equals("/")){
					e.setAttribute("outletNum", StringUtil.escapeNull(recoverDeviceMap.get("outlet")).split(";")[0] + "个");
					if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("良好"))
						e.setAttribute("outletState1", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("破损"))
						e.setAttribute("outletState2", "√");
					else if(StringUtil.escapeNull(recoverDeviceMap.get("kiss")).split(";")[1].equals("缺失"))
						e.setAttribute("outletState3", "√");
					e.setAttribute("outletNote", (StringUtil.escapeNull(recoverDeviceMap.get("outlet")).split(";").length  >2 ? StringUtil.escapeNull(recoverDeviceMap.get("outlet")).split(";")[2] : ""));
				}else
					e.setAttribute("outletState1", "/");
				
				if(!StringUtil.escapeNull(recoverDeviceMap.get("fixHeight")).equals("/")){
					e.setAttribute("fixHeightNum", StringUtil.escapeNull(recoverDeviceMap.get("fixHeight")).split(";")[0]);
					e.setAttribute("fixHeightState", StringUtil.escapeNull(recoverDeviceMap.get("fixHeight")).split(";")[1]);
				}
				
			}
			
			
			list = xmlDoc.getElementsByTagName("valveHermetic");
			node = (Element) list.item(0);
			List<Map<String, Object>> valveHermeticList = jdao.queryForList("select * from ValveHermetic where baseId='" + id + "'");
			if(valveHermeticList.size() != 0){
				Map<String, Object> valveHermeticMap = valveHermeticList.get(0);
				e = xmlDoc.createElement("valveHermeticLine");
				node.appendChild(e);
				e.setAttribute("checkDate", checkDate.substring(0, 4) + "年" + Integer.parseInt(checkDate.substring(5, 7)) + "月" + Integer.parseInt(checkDate.substring(8)) + "日");
				
				String checkPerson = StringUtil.escapeNull(valveHermeticMap.get("checkPerson"));
				if(!"".equals(checkPerson)){
					String personName = jdao.queryForObject("select img from PersonInfo where pid='" + checkPerson + "'", String.class);
					e.setAttribute("checkPerson", "<img width='100px' height='25px' src='" + personName + "'/>");
				}
				
				if(!StringUtil.escapeNull(valveHermeticMap.get("firstOilcan")).equals("/")){
					e.setAttribute("firstOilcan1", StringUtil.escapeNull(valveHermeticMap.get("firstOilcan")).split(";")[0]);
					e.setAttribute("firstOilcan2", StringUtil.escapeNull(valveHermeticMap.get("firstOilcan")).split(";")[1]);
					e.setAttribute("firstOilcan3", StringUtil.escapeNull(valveHermeticMap.get("firstOilcan")).split(";")[2]);
				}else
					e.setAttribute("firstOilcan1", "/");
				
				if(!StringUtil.escapeNull(valveHermeticMap.get("secondOilcan")).equals("/")){
					e.setAttribute("secondOilcan1", StringUtil.escapeNull(valveHermeticMap.get("secondOilcan")).split(";")[0]);
					e.setAttribute("secondOilcan2", StringUtil.escapeNull(valveHermeticMap.get("secondOilcan")).split(";")[1]);
					e.setAttribute("secondOilcan3", StringUtil.escapeNull(valveHermeticMap.get("secondOilcan")).split(";")[2]);
				}else
					e.setAttribute("secondOilcan1", "/");
				
				if(!StringUtil.escapeNull(valveHermeticMap.get("thirdOilcan")).equals("/")){
					e.setAttribute("thirdOilcan1", StringUtil.escapeNull(valveHermeticMap.get("thirdOilcan")).split(";")[0]);
					e.setAttribute("thirdOilcan2", StringUtil.escapeNull(valveHermeticMap.get("thirdOilcan")).split(";")[1]);
					e.setAttribute("thirdOilcan3", StringUtil.escapeNull(valveHermeticMap.get("thirdOilcan")).split(";")[2]);
				}else
					e.setAttribute("thirdOilcan1", "/");
				
				if(!StringUtil.escapeNull(valveHermeticMap.get("forthOilcan")).equals("/")){
					e.setAttribute("forthOilcan1", StringUtil.escapeNull(valveHermeticMap.get("forthOilcan")).split(";")[0]);
					e.setAttribute("forthOilcan2", StringUtil.escapeNull(valveHermeticMap.get("forthOilcan")).split(";")[1]);
					e.setAttribute("forthOilcan3", StringUtil.escapeNull(valveHermeticMap.get("forthOilcan")).split(";")[2]);
				}else
					e.setAttribute("forthOilcan1", "/");
				
				if(!StringUtil.escapeNull(valveHermeticMap.get("fifthOilcan")).equals("/")){
					e.setAttribute("fifthOilcan1", StringUtil.escapeNull(valveHermeticMap.get("fifthOilcan")).split(";")[0]);
					e.setAttribute("fifthOilcan2", StringUtil.escapeNull(valveHermeticMap.get("fifthOilcan")).split(";")[1]);
					e.setAttribute("fifthOilcan3", StringUtil.escapeNull(valveHermeticMap.get("fifthOilcan")).split(";")[2]);
				}else
					e.setAttribute("fifthOilcan1", "/");
				
				e.setAttribute("pressureStart", StringUtil.escapeNull(valveHermeticMap.get("pressureStart")));
				e.setAttribute("pressureEnd", StringUtil.escapeNull(valveHermeticMap.get("pressureEnd")));
				e.setAttribute("pressureState", StringUtil.escapeNull(valveHermeticMap.get("pressureState")));
				e.setAttribute("question", StringUtil.escapeNull(valveHermeticMap.get("question")));
				e.setAttribute("conclusion", StringUtil.escapeNull(valveHermeticMap.get("conclusion")));
			}
			
			list = xmlDoc.getElementsByTagName("determineShow");
			node = (Element) list.item(0);
			List<Map<String, Object>> determineShowList = jdao.queryForList("select * from DetermineShow where baseId='" + id + "'");
			if(determineShowList.size() != 0){
				Map<String, Object> determineShowMap = determineShowList.get(0);
				e = xmlDoc.createElement("determineShowLine");
				node.appendChild(e);
				e.setAttribute("checkDate", checkDate.substring(0, 4) + "年" + Integer.parseInt(checkDate.substring(5, 7)) + "月" + Integer.parseInt(checkDate.substring(8)) + "日");
				String checkPerson = StringUtil.escapeNull(determineShowMap.get("checkPerson"));
				if(!"".equals(checkPerson)){
					String personName = jdao.queryForObject("select img from PersonInfo where pid='" + checkPerson + "'", String.class);
					e.setAttribute("checkPerson", "<img width='100px' height='25px' src='" + personName + "'/>");
				}
				e.setAttribute("carNo", StringUtil.escapeNull(determineShowMap.get("carNo")));
				e.setAttribute("deviceModel", StringUtil.escapeNull(determineShowMap.get("deviceModel")));
				e.setAttribute("oilcanMaterial", StringUtil.escapeNull(determineShowMap.get("oilcanMaterial")));
				e.setAttribute("deviceCrack", StringUtil.escapeNull(determineShowMap.get("deviceCrack")));
				e.setAttribute("coverHeader", StringUtil.escapeNull(determineShowMap.get("coverHeader")));
				e.setAttribute("coupling", StringUtil.escapeNull(determineShowMap.get("coupling")));
				e.setAttribute("gaugeNum", StringUtil.escapeNull(determineShowMap.get("gaugeNum")));
				e.setAttribute("image", "<img width='500px' height='150px' src='d:/image/罐体图.jpg'/>");
				e.setAttribute("image1", "<img width='150px' height='120px' src='d:/image/" + StringUtil.escapeNull(determineShowMap.get("image1")) + ".png'/>");
				e.setAttribute("image2", "<img width='150px' height='120px' src='d:/image/" + StringUtil.escapeNull(determineShowMap.get("image2")) + ".png'/>");
				e.setAttribute("showCheck", StringUtil.escapeNull(determineShowMap.get("showCheck")));
				e.setAttribute("conclusion", StringUtil.escapeNull(determineShowMap.get("conclusion")));
				e.setAttribute("a1", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[0].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[0]);
				e.setAttribute("a2", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[1].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[1]);
				e.setAttribute("a3", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[2].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[2]);
				e.setAttribute("a4", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[3].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[3]);
				e.setAttribute("b1", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[4].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[4]);
				e.setAttribute("b2", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[5].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[5]);
				e.setAttribute("b3", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[6].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[6]);
				e.setAttribute("b4", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[7].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[7]);
				e.setAttribute("c1", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[8].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[8]);
				e.setAttribute("c2", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[9].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[9]);
				e.setAttribute("c3", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[10].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[10]);
				e.setAttribute("c4", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[11].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[11]);
				e.setAttribute("d1", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[12].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[12]);
				e.setAttribute("d2", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[13].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[13]);
				e.setAttribute("d3", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[14].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[14]);
				e.setAttribute("d4", StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[15].equals("") ? "/" : StringUtil.escapeNull(determineShowMap.get("thickness")).split(",")[15]);
			}
			
			list = xmlDoc.getElementsByTagName("reportPage");
			node = (Element) list.item(0);
			List<Map<String, Object>> reportPageList = jdao.queryForList("select * from ReportPage where baseId='" + id + "'");
			if(reportPageList.size() != 0){
				Map<String, Object> reportPageMap = reportPageList.get(0);
				e = xmlDoc.createElement("reportPageLine");
				node.appendChild(e);
				e.setAttribute("code", StringUtil.escapeNull(reportPageMap.get("code")));
				e.setAttribute("materialType", DictUtil.getValueByDictCode("MATERIALTYPE", (String)reportPageMap.get("materialType")));
				e.setAttribute("mediumName",  DictUtil.getValueByDictCode("MATERIALTYPE", bi.getMedium()));
				e.setAttribute("mediumCode", StringUtil.escapeNull(bi.getMediumCode()));
				e.setAttribute("mediumType", DictUtil.getValueByDictCode("MEDIUMTYPE", (String)reportPageMap.get("mediumType")));
				e.setAttribute("mediumNote", DictUtil.getValueByDictCode("MEDIUMNOTE", (String)reportPageMap.get("mediumNote")));
				e.setAttribute("unitName", StringUtil.escapeNull(bi.getUnitName()));
				e.setAttribute("carNo", StringUtil.escapeNull(bi.getCarNo()));
				e.setAttribute("registerCode", StringUtil.escapeNull(reportPageMap.get("registerCode")));
				e.setAttribute("roadCode", StringUtil.escapeNull(reportPageMap.get("roadCode")));
				e.setAttribute("nextCheckDate", StringUtil.escapeNull(bi.getNextCheckDate()));
			}
			
			printXML(xmlDoc, System.out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
