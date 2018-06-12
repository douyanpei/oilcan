<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="common.jsp" %>
<%@ page import="oilcan.model.Dict" %>
<%@ page import="java.util.*" %>
<%@ page import="util.DictUtil" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="oilcan.service.OilcanService" %>
<%
	Map<String, String> mediumDicts = DictUtil.getDictTypeMap("MEDIUM");
	Map<String, String> materialDicts = DictUtil.getDictTypeMap("MATERIAL");
	Map<String, String> valveTypeDicts = DictUtil.getDictTypeMap("VALVETYPE");
	Map<String, String> valveMaterialDicts = DictUtil.getDictTypeMap("VALVEMATERIAL");
	Map<String, String> seepageDicts = DictUtil.getDictTypeMap("SEEPAGE");
	Map<String, String> showDicts = DictUtil.getDictTypeMap("SHOW");
	Map<String, String> measureSystemDicts = DictUtil.getDictTypeMap("MEASURESYSTEM");
	Map<String, String> materialTypeDicts = DictUtil.getDictTypeMap("MATERIALTYPE");
	Map<String, String> mediumTypeDicts = DictUtil.getDictTypeMap("MEDIUMTYPE");
	Map<String, String> mediumNoteDicts = DictUtil.getDictTypeMap("MEDIUMNOTE");
	
	OilcanService oilcanService = WebApplicationContextUtils.getWebApplicationContext(getServletContext()).getBean("oilcanService", OilcanService.class);
	List<Map<String,Object>> persons = oilcanService.findPerson();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>罐车信息管理系统</title>
    <base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<script type='text/javascript' src='js/dateFormat.js'></script>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>  
	<script type='text/javascript' src='dwr/interface/oilcansvc.js'></script>
	<style>
		html, body {
			width: 100%;
			height: 100%;
			margin: 0px;
			padding: 0px;
			background-color: #ebebeb;
			overflow: hidden;
		}
		div#layoutObj {
			position: relative;
			margin-top: 20px;
			margin-left: 20px;
			width: 1000px;
			height: 500px;
		}
		div.dhxform_item_label_left.button_search div.dhxform_btn_txt {
			background-image: url(images/icon/search.png);
			background-repeat: no-repeat;
			background-position: 0px 3px;
			padding-left: 22px;
			margin: 0px 15px 0px 12px;
		}
	</style>
	<script>
		var winWidth = window.screen.availWidth;
		var winHeight = window.screen.availHeight;
		
		var searchForm, oilcanGrid, baseForm, baseGrid, reportForm, checkGrid;
		var shoulderAForm, shoulderBForm, shoulderCForm, attachmentAForm, attachmentBForm;
		var deviceForm, hermeticForm, determineShowForm;
		function loadView() {
			//定义窗体布局
			var mainLayout = new dhtmlXLayoutObject({
				parent: document.body,
				pattern: "2U",
				cells: [
					{id: "a", text: "<font size=2>查询条件</font>", width: 235},
					{id: "b", header: false}
				]
			});
			
			//定义查询面板
			var searchFormData = [
				{type: "block", list: [
					{type: "checkbox", name: "ch_carNo", offsetTop: 10},
					{type: "newcolumn"},
					{type: "input", label: "车牌照号", name: "sh_carNo", inputWidth: 140, offsetLeft: 5, offsetTop: 10}
				]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_unitName", offsetTop: 10},
					{type: "newcolumn"},
					{type: "input", label: "单位名称", name: "sh_unitName", inputWidth: 140, offsetLeft: 5, offsetTop: 10}
				]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_regDate", offsetTop: 10},
					{type: "newcolumn"},
				    {type: "input", label: "登记日期", name: "sh_regStart", inputWidth: 140, offsetLeft: 5, offsetTop: 10},
				    {type: "input", label: "至", name: "sh_regEnd", inputWidth: 140, offsetLeft: 41, offsetTop: 10}
	            ]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_firstCheckDate", offsetTop: 10},
					{type: "newcolumn"},
				    {type: "input", label: "首检日期", name: "sh_firstCheckStart", inputWidth: 140, offsetLeft: 5, offsetTop: 10},
				    {type: "input", label: "至", name: "sh_firstCheckEnd", inputWidth: 140, offsetLeft: 41, offsetTop: 10}
	            ]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_checkDate", offsetTop: 10},
					{type: "newcolumn"},
				    {type: "calendar", label: "查检日期", name: "sh_checkStart", inputWidth: 140, offsetLeft: 5, offsetTop: 10},
				    {type: "calendar", label: "至", name: "sh_checkEnd", inputWidth: 140, offsetLeft: 41, offsetTop: 10}
	            ]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_nextCheckDate", offsetTop: 10},
					{type: "newcolumn"},
				    {type: "input", label: "下次查检", name: "sh_nextCheckStart", inputWidth: 140, offsetLeft: 5, offsetTop: 10},
				    {type: "input", label: "至", name: "sh_nextCheckEnd", inputWidth: 140, offsetLeft: 41, offsetTop: 10}
	            ]},
	            {type: "block", list: [
					{type: "checkbox", name: "ch_brand", offsetTop: 10},
					{type: "newcolumn"},
					{type: "input", label: "汽车品牌", name: "sh_brand", inputWidth: 140, offsetLeft: 5, offsetTop: 10}
				]},
	            {type: "block", list: [
					{type: "checkbox", name: "ch_produce1", offsetTop: 10},
					{type: "newcolumn"},
					{type: "input", label: "制造厂名", name: "sh_produce1", inputWidth: 140, offsetLeft: 5, offsetTop: 10}
				]},
	            {type: "block", list: [
					{type: "checkbox", name: "ch_produce2", offsetTop: 10},
					{type: "newcolumn"},
					{type: "input", label: "罐制造商", name: "sh_produce2", inputWidth: 140, offsetLeft: 5, offsetTop: 10}
				]},
	            {type: "block", list: [
					{type: "checkbox", name: "ch_medium", offsetTop: 10},
					{type: "newcolumn"},
					{type: "select", label: "准运介质", inputWidth: 140, name: "sh_medium", offsetLeft: 5, offsetTop: 10, options:[
	               		{text: "不限", value: ""},
			            <%
			            	int x = 0;
			            	for(String keyCode : mediumDicts.keySet()){
			            		if(x != mediumDicts.keySet().size()-1){
			            %>
			                		{text: "<%=mediumDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=mediumDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		x++;
			            	}
			            %>
	                ]}
				]},
				{type: "block", list: [
					{type: "checkbox", name: "ch_bj", offsetTop: 10},
					{type: "newcolumn"},
					{type: "checkbox", label: "标记", name: "sh_bj", offsetLeft: 5, offsetTop: 10}
				]},
				{type: "block", list: [
               	 	{type: "button", value: "查&nbsp;&nbsp;询", className: "button_search", name: "sh_search", offsetRight: 5, offsetTop: 15}
                ]}
			];
			
			searchForm = mainLayout.cells("a").attachForm(searchFormData);
			
			searchForm.getInput("sh_checkStart").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			searchForm.getInput("sh_checkStart").style.backgroundPosition = "center right";
			searchForm.getInput("sh_checkStart").style.backgroundRepeat = "no-repeat";
			searchForm.getInput("sh_checkEnd").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			searchForm.getInput("sh_checkEnd").style.backgroundPosition = "center right";
			searchForm.getInput("sh_checkEnd").style.backgroundRepeat = "no-repeat";
			searchForm.setItemValue("sh_checkStart", now_Date);
			searchForm.setItemValue("sh_checkEnd", now_Date);
			
			searchForm.attachEvent("onButtonClick", function(name){
				var ch_carNo = searchForm.getItemValue("ch_carNo");
				var ch_unitName = searchForm.getItemValue("ch_unitName");
				var ch_regDate = searchForm.getItemValue("ch_regDate");
				var ch_firstCheckDate = searchForm.getItemValue("ch_firstCheckDate");
				var ch_nextCheckDate = searchForm.getItemValue("ch_nextCheckDate");
				var ch_checkDate = searchForm.getItemValue("ch_checkDate");
				var ch_brand = searchForm.getItemValue("ch_brand");
				var ch_produce1 = searchForm.getItemValue("ch_produce1");
				var ch_produce2 = searchForm.getItemValue("ch_produce2");
				var ch_medium = searchForm.getItemValue("ch_medium");
				var ch_bj = searchForm.getItemValue("ch_bj");
				
				if(ch_carNo == false && ch_unitName == false && ch_regDate == false && ch_firstCheckDate == false && ch_checkDate == false
					&& ch_nextCheckDate == false && ch_brand == false && ch_produce1 == false && ch_produce2 == false
					&& ch_medium == false && ch_bj == false){
					dhtmlx.alert("请选择要查询的条件");
					return;	
				}
				
				var sql = "select a.id,a.carNo,a.unitName,a.oilcanBrand,a.oilcanModel,a.carModel," +
					" b.codeCNName as medium,a.regDate,a.firstCheckDate,a.nextCheckDate" +
					" from BaseInformation a left join Dict b on b.codeType='MEDIUM' and b.codeValue=a.medium where 1=1";
				
				if(ch_carNo == true){
					var sh_carNo = searchForm.getItemValue("sh_carNo");
					if(!isEmpty(sh_carNo))
						sql += " and a.carNo like'%" + sh_carNo + "%'";
				}
				if(ch_unitName == true){
					var sh_unitName = searchForm.getItemValue("sh_unitName");
					if(!isEmpty(sh_unitName))
						sql += " and a.unitName like'%" + sh_unitName + "%'";
				}
				if(ch_regDate == true){
					var sh_regStart = searchForm.getItemValue("sh_regStart");
					var sh_regEnd = searchForm.getItemValue("sh_regEnd");
					if(!isEmpty(sh_regStart) && !isEmpty(sh_regEnd))
						sql += " and a.regDate between '" + sh_regStart + "' and '" + sh_regEnd + "'";
				}
				if(ch_firstCheckDate == true){
					var sh_firstCheckStart = searchForm.getItemValue("sh_firstCheckStart");
					var sh_firstCheckEnd = searchForm.getItemValue("sh_firstCheckEnd");
					if(!isEmpty(sh_firstCheckStart) && !isEmpty(sh_firstCheckEnd))
						sql += " and a.firstCheckDate between '" + sh_firstCheckStart + "' and '" + sh_firstCheckEnd + "'";
				}
				if(ch_checkDate == true){
					var sh_checkStart = searchForm.getItemValue("sh_checkStart");
					var sh_checkEnd = searchForm.getItemValue("sh_checkEnd");
					if(!isEmpty(sh_checkStart) && !isEmpty(sh_checkEnd))
						sql += " and a.checkDate between '" + sh_checkStart.Format('yyyy-MM-dd') + "' and '" + sh_checkEnd.Format('yyyy-MM-dd') + "'";
				}
				if(ch_nextCheckDate == true){
					var sh_nextCheckStart = searchForm.getItemValue("sh_nextCheckStart");
					var sh_nextCheckEnd = searchForm.getItemValue("sh_nextCheckEnd");
					if(!isEmpty(sh_nextCheckStart) && !isEmpty(sh_nextCheckEnd))
						sql += " and a.nextCheckDate between '" + sh_nextCheckStart + "' and '" + sh_nextCheckEnd + "'";
				}
				if(ch_brand == true){
					var sh_brand = searchForm.getItemValue("sh_brand");
					if(!isEmpty(sh_brand))
						sql += " and a.oilcanBrand like'%" + sh_brand + "%'";
				}
				if(ch_produce1 == true){
					var sh_produce1 = searchForm.getItemValue("sh_produce1");
					if(!isEmpty(sh_produce1))
						sql += " and a.produce1 like'%" + sh_produce1 + "%'";
				}
				if(ch_produce2 == true){
					var sh_produce2 = searchForm.getItemValue("sh_produce2");
					if(!isEmpty(sh_produce2))
						sql += " and a.produce2 like'%" + sh_produce2 + "%'";
				}
				if(ch_medium == true){
					var sh_medium = searchForm.getItemValue("sh_medium");
					if(!isEmpty(sh_medium))
						sql += " and a.medium ='" + sh_medium + "'";
				}
				if(ch_bj == true){
					var sh_bj = searchForm.getItemValue("sh_bj");
					if(sh_bj == "1")
						sql += " and a.bj ='1'";
					else
						sql += " and (a.bj is null or a.bj='')"
				}
				
				oilcansvc.findPropertiesBySql(sql, function(data){
					oilcanGrid.clearAll();
					oilcanGrid.parse(data, "json");
				})
				
			});
			
			
			var oilcanToolbar = mainLayout.cells("b").attachToolbar();
			oilcanToolbar.setIconsPath('<%=basePath%>images/icon32/');
			oilcanToolbar.loadStruct('<%=basePath%>page/xml/oilcanToolbar.xml', function(){
				oilcanToolbar.setItemText("oilcanAdd", "<div style='font-size:12px;'>新增</div>");
				oilcanToolbar.setItemText("oilcanUpdate", "<div style='font-size:12px;'>修改</div>");
				oilcanToolbar.setItemText("oilcanDelete", "<div style='font-size:12px;'>删除</div>");
				oilcanToolbar.setItemText("oilcanRepeat", "<div style='font-size:12px;'>复用</div>");
				oilcanToolbar.setItemText("oilcanPrint", "<div style='font-size:12px;'>打印</div>");
				oilcanToolbar.setItemText("oilcanImport", "<div style='font-size:12px;'>导入</div>");
				oilcanToolbar.setItemText("oilcanExport", "<div style='font-size:12px;'>导出</div>");
				oilcanToolbar.setItemText("oilcanConfig", "<div style='font-size:12px;'>数据维护</div>");
				oilcanToolbar.setItemText("oilcanBj", "<div style='font-size:12px;'>标记</div>");
			});
			oilcanToolbar.setIconSize(32);
			
			
			oilcanGrid = mainLayout.cells("b").attachGrid();
			oilcanGrid.setImagePath("<%=basePath%>images/icon/");
			oilcanGrid.setHeader(",车牌照号,单位名称,汽车品牌,汽车型号,油罐型号,准运介质,登记日期,首检日期,查检日期",null,
				["text-align:center","text-align:center","text-align:center","text-align:center","text-align:center",
				"text-align:center","text-align:center","text-align:center","text-align:center","text-align:center"]);
			oilcanGrid.setInitWidths("30,130,*,100,100,100,100,100,100,100");
			oilcanGrid.setColAlign("center,center,center,center,center,center,center,center,center,center");
			oilcanGrid.setColTypes("cntr,ro,ro,ro,ro,ro,ro,ro,ro,ro");
			oilcanGrid.setColSorting("int,str,str,str,str,str,str,str,str,str");
			oilcanGrid.enableMultiselect(true);
			oilcanGrid.setSkin("dhx_skyblue");
			oilcanGrid.init();
			
			
			//定义罐车信息窗体
			//定义结论操作窗体
			var oilcanWins = new dhtmlXWindows();
			oilcanWin = oilcanWins.createWindow("oilcanWinId", winWidth/2-500, 20, 1000, 600);
			oilcanWin.setText("<font size=2>罐车信息管理</font>");
			
			oilcanWin.attachEvent("onClose", function(win){
			    oilcanWin.hide();
			});
			
			oilcanWin.attachEvent("onHide", function(win){
			    clearForm();
			});
			
			var oilcanWinToolbar = oilcanWin.attachToolbar();
			oilcanWinToolbar.setIconsPath('<%=basePath%>images/icon/');
			oilcanWinToolbar.loadStruct('<%=basePath%>page/xml/oilcanWinToolbar.xml', function(){
				oilcanWinToolbar.setItemText("oilcanWinSave", "<div style='font-size:12px;'>保存</div>");
				oilcanWinToolbar.setItemText("oilcanWinCancel", "<div style='font-size:12px;'>取消</div>");
			});
			
			var oilcanTab = oilcanWin.attachTabbar();
			oilcanTab.addTab("base_tab", "<div style='color:blue;font-size:12px'>罐车基本情况查检报告</div>", null, 0, true);
			oilcanTab.addTab("oilcan_tab", "<div style='color:blue;font-size:12px'>罐体及承压件查检报告</div>", null, -1, false);
			oilcanTab.addTab("attachment_tab", "<div style='color:blue;font-size:12px'>安全附件查检报告</div>", null, -1, false);
			oilcanTab.addTab("device_tab", "<div style='color:blue;font-size:12px'>油气回收设备检查报告</div>", null, -1, false);
			oilcanTab.addTab("hermetic_tab", "<div style='color:blue;font-size:12px'>密闭性检测报告</div>", null, -1, false);
			oilcanTab.addTab("view_tab", "<div style='color:blue;font-size:12px'>罐体壁厚测定与外观检查报告</div>", null, -1, false);
			oilcanTab.addTab("report_tab", "<div style='color:blue;font-size:12px'>报告首页</div>", null, -1, false);
			
			//1)罐车基本情况检查报告
			var baseLayout = oilcanTab.tabs("base_tab").attachLayout({
				pattern: "3E",
				cells: [
					{id: "a", header: false, height: 250},
					{id: "b", header: false},
					{id: "c", header: false, height: 115}
				]
			});
			
			var baseFormData = [
				{type: "block", list: [
					{type: "input", label: "车牌照号", name: "carNo", inputWidth: 140, offsetLeft: 10},
					{type: "input", name: "id", hidden: true},
					{type: "newcolumn"},
					{type: "input", label: "汽车品牌", name: "oilcanBrand", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "汽车型号", name: "oilcanModel", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "制造厂名", name: "produce1", inputWidth: 270, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "input", label: "出厂日期", name: "outDate1", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "首检日期", name: "firstCheckDate", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "罐体型号", name: "carModel", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "制造厂名", name: "produce2", inputWidth: 270, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "input", label: "出厂日期", name: "outDate2", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "select", label: "准运介质", name: "medium", inputWidth: 140, offsetLeft: 10, options:[
	               		{text: "", value: ""},
			            <%
			            	int i = 0;
			            	for(String keyCode : mediumDicts.keySet()){
			            		if(i != mediumDicts.keySet().size()-1){
			            %>
			                		{text: "<%=mediumDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=mediumDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		i++;
			            	}
			            %>
	                ]},
					{type: "newcolumn"},
					{type: "input", label: "介质编号", name: "mediumCode", inputWidth: 60, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "密度", name: "density", inputWidth: 46, offsetLeft: 5},
					{type: "newcolumn"},
					{type: "input", label: "登记日期", name: "regDate", inputWidth: 100, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "长", name: "length", inputWidth: 32, offsetLeft: 15},
					{type: "newcolumn"},
					{type: "input", label: "宽", name: "width", inputWidth: 32, offsetLeft: 5},
					{type: "newcolumn"},
					{type: "input", label: "高", name: "height", inputWidth: 32, offsetLeft: 5}
				]},
				{type: "block", list: [
					{type: "input", label: "汽车核定载质量(吨)", name: "weight", inputWidth: 83, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "汽车轴数", name: "axisNum", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "出厂标注容积(立方米)", name: "outCapacity", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "允许装载容积", name: "allowCapacity", inputWidth: 80, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "允许装载质量", name: "allowWeight", inputWidth: 80, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "select", label: "罐体材质", name: "oilcanMaterial", inputWidth: 70, offsetLeft: 10, options:[
	               		{text: "", value: ""},
			            <%
			            	int j = 0;
			            	for(String keyCode : materialDicts.keySet()){
			            		if(j != materialDicts.keySet().size()-1){
			            %>
			                		{text: "<%=materialDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=materialDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		j++;
			            	}
			            %>
	                ]},
					{type: "newcolumn"},
					{type: "input", label: "仓数", name: "warehouseNum", inputWidth: 42, offsetLeft: 0},
					{type: "newcolumn"},
					{type: "input", label: "车门标注单位名称", name: "unitName", inputWidth: 625, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "input", label: "罐车出厂编号", name: "outCode", inputWidth: 116, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "罐车合格证号", name: "licensedCode", inputWidth: 116, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "车辆识别代码", name: "spotCode", inputWidth: 116, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "罐体质量监检证号", name: "checkCode", inputWidth: 221, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "input", label: "质检机构名称", name: "organizationName", inputWidth: 317, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "变更记载说明", name: "convertNote", inputWidth: 448, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "calendar", label: "查检日期", name: "checkDate", inputWidth: 140, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "下次查检日期", name: "nextCheckDate", inputWidth: 115, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "结&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;论", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "conclusion", value: "罐体符合要求", position: "label-right", label: "罐体符合要求", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "conclusion", value: "罐体不符合要求", position: "label-right", label: "罐体不符合要求", offsetLeft: 10}
				]}
			]
			baseForm = baseLayout.cells("a").attachForm(baseFormData);
			//baseForm.getInput("outDate1").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			//baseForm.getInput("outDate1").style.backgroundPosition = "center right";
			//baseForm.getInput("outDate1").style.backgroundRepeat = "no-repeat";
			///baseForm.getInput("firstCheckDate").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			//baseForm.getInput("firstCheckDate").style.backgroundPosition = "center right";
			//baseForm.getInput("firstCheckDate").style.backgroundRepeat = "no-repeat";
			//baseForm.getInput("outDate2").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			//baseForm.getInput("outDate2").style.backgroundPosition = "center right";
			//baseForm.getInput("outDate2").style.backgroundRepeat = "no-repeat";
			//baseForm.getInput("regDate").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			//baseForm.getInput("regDate").style.backgroundPosition = "center right";
			//baseForm.getInput("regDate").style.backgroundRepeat = "no-repeat";
			baseForm.getInput("checkDate").style.backgroundImage = "url(<%=basePath%>images/icon/calendar.gif)";
			baseForm.getInput("checkDate").style.backgroundPosition = "center right";
			baseForm.getInput("checkDate").style.backgroundRepeat = "no-repeat";
			
			
			var checkToolbar = baseLayout.cells("b").attachToolbar();
			checkToolbar.setIconsPath('<%=basePath%>images/icon/');
			checkToolbar.loadStruct('<%=basePath%>page/xml/checkToolbar.xml', function(){
				checkToolbar.setItemText("checkText", "<div style='font-size:12px;font-weight:bold'>查检记录：</div>");
				checkToolbar.setItemText("checkAdd", "<div style='font-size:12px;'>新增</div>");
				checkToolbar.setItemText("checkDelete", "<div style='font-size:12px;'>删除</div>");
			});
			
			checkGrid = baseLayout.cells("b").attachGrid();
			checkGrid.setHeader("查检记录",null,["text-align:center;"]);
			checkGrid.setInitWidths("*")
			checkGrid.setColAlign("left")
			checkGrid.setColTypes("ed");
			checkGrid.setColSorting("str")
			checkGrid.setSkin("dhx_skyblue")
			checkGrid.setNoHeader(true);
			checkGrid.init();
			
			var baseToolbar = baseLayout.cells("c").attachToolbar();
			baseToolbar.setIconsPath('<%=basePath%>images/icon/');
			baseToolbar.loadStruct('<%=basePath%>page/xml/baseToolbar.xml', function(){
				baseToolbar.setItemText("baseText", "<div style='font-size:12px;font-weight:bold'>问题记载：</div>");
				baseToolbar.setItemText("baseAdd", "<div style='font-size:12px;'>新增</div>");
				baseToolbar.setItemText("baseDelete", "<div style='font-size:12px;'>删除</div>");
			});
			
			baseGrid = baseLayout.cells("c").attachGrid();
			baseGrid.setHeader("问&nbsp;&nbsp;&nbsp;题&nbsp;&nbsp;&nbsp;记&nbsp;&nbsp;&nbsp;载",null,["text-align:center;"]);
			baseGrid.setInitWidths("*")
			baseGrid.setColAlign("left")
			baseGrid.setColTypes("ed");
			baseGrid.setColSorting("str")
			baseGrid.setSkin("dhx_skyblue")
			baseGrid.setNoHeader(true);
			baseGrid.init();
			
			
			//2)承压件
			var shoulderLayout = oilcanTab.tabs("oilcan_tab").attachLayout({
				pattern: "3W",
				cells: [
					{id: "a", header: false, height: 330},
					{id: "b", header: false, height: 330},
					{id: "c", header: false}
				]
			});
			var shoulderAFormData = [
				{type: "label", label: "<font size=2>1.罐内防波板</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "input", name: "os_pid", hidden: true},
					{type: "input", label: "内置(块)", name: "os_bulwarkNum", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_bulwarkState", value: "完好", position: "label-right", label: "完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_bulwarkState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>2.人孔与人孔盖个数与紧固严密情况</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "input", label: "个&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数", name: "os_holeNum", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_holeState", value: "完好", position: "label-right", label: "完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_holeState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>3.注入口个数及紧固情况</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "input", label: "个&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数", name: "os_affluxNum", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_affluxState", value: "完好", position: "label-right", label: "完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_affluxState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>4.罐体与底盘连接紧固情况</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "select", name: "os_detroitType", inputWidth: 112, offsetLeft: 10, options:[
	               		{text: "", value: ""},
	               		{text: "螺丝连接", value: "螺丝连接"},
	               		{text: "整体焊接", value: "整体焊接"}
	                ]},
					{type: "newcolumn"},
					{type: "radio", name: "os_detroitState", value: "完好", position: "label-right", label: "完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_detroitState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>5.罐体与支座有无发现裂纹</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_hasCrack", value: "无裂纹", position: "label-right", label: "无裂纹", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_hasCrack", value: "有裂纹", position: "label-right", label: "有裂纹", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>6.罐体外观检查</font>", offsetLeft: 10},
				{type: "block", list: [
					<%
		            	int n = 0;
		            	for(String keyCode : showDicts.keySet()){
		            		if(n != showDicts.keySet().size()-1){
		            %>
		                		{type: "checkbox", name: "os_oilcanShow<%=n%>", position: "label-right", label: "<%=showDicts.get(keyCode)%>", offsetLeft: 10},
								{type: "newcolumn"},
		            <%
		            		}else{
		            %>
		                		{type: "checkbox", name: "os_oilcanShow<%=n%>", position: "label-right", label: "<%=showDicts.get(keyCode)%>", offsetLeft: 10}
		            <%
		            		}
		            		n++;
		            	}
		            %>
				]},
				{type: "input", label: "缺<br/><br/><br/>陷", name: "os_oilcanDefect", inputWidth: 210, rows:4, offsetLeft: 30}
			]
			shoulderAForm = shoulderLayout.cells("a").attachForm(shoulderAFormData);
			
			
			var shoulderBFormData = [
				{type: "label", label: "<font size=2>7.装卸阀直径和个数</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "input", name: "shoulderPid", hidden: true},
					{type: "input", label: "DN直径", name: "os_diameter", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "DN(个)", name: "os_diameterNum", inputWidth: 70, offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>8.阀门类别</font>", offsetLeft: 10},
				{type: "block", list: [
					<%
		            	int k = 0;
		            	for(String keyCode : valveTypeDicts.keySet()){
		            		if(k != valveTypeDicts.keySet().size()-1){
		            %>
		                		{type: "input", label: "<%=valveTypeDicts.get(keyCode)%>", name: "os_valveType<%=k%>", inputWidth: 50, offsetLeft: 10},
								{type: "newcolumn"},
		            <%
		            		}else{
		            %>
		                		{type: "input", label: "<%=valveTypeDicts.get(keyCode)%>", name: "os_valveType<%=k%>", inputWidth: 50, offsetLeft: 10}
		            <%
		            		}
		            		k++;
		            	}
		            %>
				]},
				{type: "label", label: "<font size=2>9.阀门材质</font>", offsetLeft: 10},
				{type: "block", list: [
					<%
		            	int l = 0;
		            	for(String keyCode : valveMaterialDicts.keySet()){
		            		if(l != valveMaterialDicts.keySet().size()-1){
		            %>
		                		{type: "checkbox", name: "os_valveMaterial<%=l%>", position: "label-right", label: "<%=valveMaterialDicts.get(keyCode)%>", offsetLeft: 10},
								{type: "newcolumn"},
		            <%
		            		}else{
		            %>
		                		{type: "checkbox", name: "os_valveMaterial<%=l%>", position: "label-right", label: "<%=valveMaterialDicts.get(keyCode)%>", offsetLeft: 10}
		            <%
		            		}
		            		l++;
		            	}
		            %>
				]},
				{type: "label", label: "<font size=2>10.阀门及连接脚垫应完好无外渗漏</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "select", name: "os_seepage", inputWidth: 112, offsetLeft: 10, options:[
			            <%
			            	int m = 0;
			            	for(String keyCode : seepageDicts.keySet()){
			            		if(m != seepageDicts.keySet().size()-1){
			            %>
			                		{text: "<%=seepageDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=seepageDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		m++;
			            	}
			            %>
	                ]}
				]},
				{type: "label", label: "<font size=2>11.装卸软管(输送易燃、易爆液体的软管应有导电铜丝其电阻值＜5Ω)</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_hose", value: "符合要求", position: "label-right", label: "符合要求", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_hose", value: "不符合要求", position: "label-right", label: "不符合要求", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>11.加油管应有导静电线且连接完好</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_refuel", value: "连接完好", position: "label-right", label: "连接完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_refuel", value: "连接不完好", position: "label-right", label: "连接不完好", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_refuel", value: "无", position: "label-right", label: "无", offsetLeft: 10}
				]}
				
			]
			shoulderBForm = shoulderLayout.cells("b").attachForm(shoulderBFormData);
			
			
			
			var shoulderCFormData = [
				{type: "label", label: "<font size=2>12.有无油气回收装置</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_recoverSystem", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_recoverSystem", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_recoverState", value: "符合要求", position: "label-right", label: "符合要求", offsetLeft: 20, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_recoverState", value: "基本符合", position: "label-right", label: "基本符合", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>13. 有无泵送装置，应完好无外渗漏</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_bengSystem", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_bengSystem", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_bengSystem", value: "机头有", position: "label-right", label: "机头有", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_bengState", value: "完好", position: "label-right", label: "完好", offsetLeft: 20, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_bengState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>14.卸料计量装置</font>", offsetLeft: 10},
				{type: "block", list: [
					<%
		            	int o = 0;
		            	for(String keyCode : measureSystemDicts.keySet()){
		            		if(o != measureSystemDicts.keySet().size()-1){
		            %>
		                		{type: "checkbox", name: "os_measureSystem<%=o%>", position: "label-right", label: "<%=measureSystemDicts.get(keyCode)%>", offsetLeft: 10},
								{type: "newcolumn"},
		            <%
		            		}else{
		            %>
		                		{type: "checkbox", name: "os_measureSystem<%=o%>", position: "label-right", label: "<%=measureSystemDicts.get(keyCode)%>", offsetLeft: 10}
		            <%
		            		}
		            		o++;
		            	}
		            %>
				]},
				{type: "label", label: "<font size=2>15.罐体有无自行开孔与改装部件</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_refitPlace", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_refitPlace", value: "无", position: "label-right", label: "无", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>16.罐体保温及罐内加热管</font>", offsetLeft: 10},
				{type: "block", list: [
					{type: "radio", name: "os_oilcanHeat", value: "无", position: "label-right", label: "无", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "os_oilcanHeat", value: "有保温层", position: "label-right", label: "有保温层", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "os_oilcanHeat", value: "罐内加热管", position: "label-right", label: "罐内加热管", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "select", name: "os_checkPerson", label: "查检人", inputWidth: 112, offsetLeft: 10, options:[
						{text: "", value: ""},
			            <%
			            	for(int r=0; r<persons.size(); r++){
			            		if(r != persons.size()-1){
			            %>
			                		{text: "<%=(String)persons.get(r).get("name")%>", value: "<%=(String)persons.get(r).get("pid")%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=(String)persons.get(r).get("name")%>", value: "<%=(String)persons.get(r).get("pid")%>"}
			            <%
			            		}
			            	}
			            %>
	                ]}
				]}
			]
			shoulderCForm = shoulderLayout.cells("c").attachForm(shoulderCFormData);
			
			
			
			//********************************************安全附件*************************************************
			
			var attachmentLayout = oilcanTab.tabs("attachment_tab").attachLayout({
				pattern: "2U",
				cells: [
					{id: "a", header: false, height: 495},
					{id: "b", header: false}
				]
			});
			var attachmentAFormData = [
				{type: "block", list: [
					{type: "label", label: "<font size=2>1.灭火器数量：不少于2个</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", name: "sa_pid", hidden: true},
					{type: "radio", name: "sa_fireDevice", value: "齐全", position: "label-right", label: "齐全", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_fireDevice", value: "不齐全", position: "label-right", label: "不齐全", offsetLeft: 10}
				]},
				
				{type: "block", list: [
					{type: "label", label: "<font size=2>2.危险品标志灯：1个</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerLamp", value: "齐全", position: "label-right", label: "齐全", offsetLeft: 37, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerLamp", value: "新车待配", position: "label-right", label: "新车待配", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerLamp", value: "不齐全", position: "label-right", label: "不齐全", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>3.危险品标志牌：1个</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerPlate", value: "齐全", position: "label-right", label: "齐全", offsetLeft: 37, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerPlate", value: "新车待配", position: "label-right", label: "新车待配", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dangerPlate", value: "不齐全", position: "label-right", label: "不齐全", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>4.罐体表面有运输危险货物标志及字样：罐体两侧及罐后</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_surfaceMark", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_surfaceMark", value: "基本符合", position: "label-right", label: "基本符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_surfaceMark", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>5.罐体表面油漆和色带：油漆应色泽鲜明、分界整齐，色带宽度应不小于150mm</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_paintColor", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_paintColor", value: "基本符合", position: "label-right", label: "基本符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_paintColor", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>6.运输易燃、易爆液体，发动机排气管有火花熄灭器、距罐体与泵送系统位置：车身前方＞1.5m</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_systemPosition", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_systemPosition", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_systemPosition", value: "改至车身前方", position: "label-right", label: "改至车身前方", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_systemPosition", value: "加装火花熄灭器", position: "label-right", label: "加装火花熄灭器", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>7.金属罐体与非金属衬里的罐体，有导静电措施：导静电橡胶拖地带 电阻值＜5Ω</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_rubber", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_rubber", value: "错装", position: "label-right", label: "错装", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_rubber", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_rubber", value: "阻值大", position: "label-right", label: "阻值大", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_rubber", value: "坏", position: "label-right", label: "坏", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "radio", name: "sa_transmitType", value: "导电杆", position: "label-right", label: "导电杆", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_transmitType", value: "导电夹", position: "label-right", label: "导电夹", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>，电阻值＜5Ω</font>", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "radio", name: "sa_transmitValue", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_transmitValue", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_transmitValue", value: "阻值大", position: "label-right", label: "阻值大", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_transmitValue", value: "坏", position: "label-right", label: "坏", offsetLeft: 10}
				]}
			]
			attachmentAForm = attachmentLayout.cells("a").attachForm(attachmentAFormData);
			
			var attachmentBFormData = [
				{type: "label", label: "<font size=2>8.罐体护栏：当罐体顶部距地面大于2m时，平台周围应加装护栏</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_attendance", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_attendance", value: "无", position: "label-right", label: "无", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>9.上下罐梯子：应便于攀登、连接牢固，宽度不＜350mm步距不＞350mm</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_ladder", value: "符合要求", position: "label-right", label: "符合要求", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_ladder", value: "不符合要求", position: "label-right", label: "不符合要求", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_ladder", value: "无", position: "label-right", label: "无", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>10.阀门箱：关闭严密，箱内无杂物</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_valveContainer", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_valveContainer", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_valveState", value: "完好", position: "label-right", label: "完好", offsetLeft: 20, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_valveState", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_valveState", value: "损坏", position: "label-right", label: "损坏", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_valveState", value: "有杂物", position: "label-right", label: "有杂物", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>11.蓄电池箱：封闭完好</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_garnerContainer", value: "完好", position: "label-right", label: "完好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_garnerContainer", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>12.电源总开关及其控制装置：电源总开关应更换为电磁开关，尽量靠近蓄电池，其控制装置应装在驾驶室内</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_switchSystem", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_switchSystem", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>13.有无压力表、真空表：外观完好</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "radio", name: "sa_pressure1", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_pressure1", value: "无", position: "label-right", label: "无", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_pressure2", value: "完好", position: "label-right", label: "完好", offsetLeft: 20, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_pressure2", value: "不完好", position: "label-right", label: "不完好", offsetLeft: 10}
				]},
				{type: "label", label: "<font size=2>14.呼吸阀、排空阀个数及完好情况：应确保开启灵活</font>", offsetLeft: 15},
				{type: "block", list: [
					{type: "input", label: "DN(mm)", name: "sa_dnLength", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "个数", name: "sa_dnNum", inputWidth: 70, offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dnState", value: "符合", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_dnState", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>15.紧急切断阀：应装置在罐内或紧靠罐体的根部</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "sa_breakSystem", value: "有", position: "label-right", label: "有", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "sa_breakSystem", value: "无", position: "label-right", label: "无", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "select", name: "sa_checkPerson", label: "查检人", inputWidth: 112, offsetLeft: 10, options:[
						{text: "", value: ""},
			            <%
			            	for(int s=0; s<persons.size(); s++){
			            		if(s != persons.size()-1){
			            %>
			                		{text: "<%=(String)persons.get(s).get("name")%>", value: "<%=(String)persons.get(s).get("pid")%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=(String)persons.get(s).get("name")%>", value: "<%=(String)persons.get(s).get("pid")%>"}
			            <%
			            		}
			            	}
			            %>
	                ]}
				]}
			]
			attachmentBForm = attachmentLayout.cells("b").attachForm(attachmentBFormData);
			
			
			
			
			//4)油气回收设备
			var deviceFormData = [
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：密封式快速接头 DN 80 mm</font>", offsetLeft: 10},
					{type: "input", name: "de_pid", hidden: true},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_kissNum", inputWidth: 70, offsetLeft: 50},
					{type: "newcolumn"},
					{type: "radio", name: "de_kissState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_kissState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_kissState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_kissNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：帽盖</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_hatNum", inputWidth: 70, offsetLeft: 193},
					{type: "newcolumn"},
					{type: "radio", name: "de_hatState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_hatState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_hatState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_hatNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：油气管线气动阀门</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_valveNum", inputWidth: 70, offsetLeft: 111},
					{type: "newcolumn"},
					{type: "radio", name: "de_valveState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_valveState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_valveState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_valveNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：连接胶管</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_gluingNum", inputWidth: 70, offsetLeft: 166},
					{type: "newcolumn"},
					{type: "radio", name: "de_gluingState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_gluingState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_gluingState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_gluingNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：多仓油气管路并联</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_oilcanPipeNum", inputWidth: 70, offsetLeft: 111},
					{type: "newcolumn"},
					{type: "radio", name: "de_oilcanPipeState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_oilcanPipeState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_oilcanPipeState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_oilcanPipeNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：油气管线尾阀</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_lineValveNum", inputWidth: 70, offsetLeft: 139},
					{type: "newcolumn"},
					{type: "radio", name: "de_lineValveState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_lineValveState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_lineValveState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_lineValveNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：固定支架</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_standNum", inputWidth: 70, offsetLeft: 166},
					{type: "newcolumn"},
					{type: "radio", name: "de_standState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_standState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_standState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_standNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>油气回收：压力/真空阀(呼吸阀、通气阀)</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_pressureNum", inputWidth: 70, offsetLeft: 37},
					{type: "newcolumn"},
					{type: "radio", name: "de_pressureState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_pressureState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_pressureState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_pressureNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：DN100mm密封式快速接头</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_bottomKissNum", inputWidth: 70, offsetLeft: 54},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomKissState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomKissState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomKissState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_bottomKissNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：帽盖</font>", offsetLeft: 10},
					{type: "input", name: "de_pid", hidden: true},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_bottomHatNum", inputWidth: 70, offsetLeft: 193},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomHatState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomHatState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomHatState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_bottomHatNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：气动底阀</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_bottomValveNum", inputWidth: 70, offsetLeft: 166},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomValveState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomValveState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_bottomValveState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_bottomValveNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：气动底阀与快速接头之间中间阀</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_centerValveNum", inputWidth: 70, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "radio", name: "de_centerValveState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_centerValveState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_centerValveState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_centerValveNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：防溢流探测头和插座</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "数量", name: "de_outletNum", inputWidth: 70, offsetLeft: 97},
					{type: "newcolumn"},
					{type: "radio", name: "de_outletState", value: "良好", position: "label-right", label: "良好", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "de_outletState", value: "破损", position: "label-right", label: "破损", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "de_outletState", value: "缺失", position: "label-right", label: "缺失", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "备注", name: "de_outletNote", inputWidth: 250, offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>底部装油：防溢流探测头安装高度</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "高度", name: "de_fixHeightNum", inputWidth: 70, offsetLeft: 83},
					{type: "newcolumn"},
					{type: "input", label: "灵敏度", name: "de_fixHeightNote", inputWidth: 150, offsetLeft: 10}
				]}
			]
			deviceForm = oilcanTab.tabs("device_tab").attachForm(deviceFormData);
			
			//4)密闭性
			var hermeticFormData = [
				{type: "block", list: [
					{type: "label", label: "<font size=2>1号油仓</font>", offsetLeft: 10},
					{type: "input", name: "hc_pid", hidden: true},
					{type: "newcolumn"},
					{type: "input", label: "油仓容积(m<sup>3</sup>)", name: "hc_firstOilcan1", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "油气回收系统密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_firstOilcan2", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_firstOilcan2", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "油气回收管线气动阀门密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_firstOilcan3", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_firstOilcan3", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>2号油仓</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "油仓容积(m<sup>3</sup>)", name: "hc_secondOilcan1", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "油气回收系统密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_secondOilcan2", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_secondOilcan2", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "油气回收管线气动阀门密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_secondOilcan3", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_secondOilcan3", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>3号油仓</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "油仓容积(m<sup>3</sup>)", name: "hc_thirdOilcan1", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "油气回收系统密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_thirdOilcan2", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_thirdOilcan2", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "油气回收管线气动阀门密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_thirdOilcan3", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_thirdOilcan3", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>4号油仓</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "油仓容积(m<sup>3</sup>)", name: "hc_forthOilcan1", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "油气回收系统密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_forthOilcan2", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_forthOilcan2", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "油气回收管线气动阀门密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_forthOilcan3", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_forthOilcan3", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>5号油仓</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", label: "油仓容积(m<sup>3</sup>)", name: "hc_fifthOilcan1", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "油气回收系统密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_fifthOilcan2", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_fifthOilcan2", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "label", label: "油气回收管线气动阀门密闭性检测结果", offsetLeft: 20},
					{type: "newcolumn"},
					{type: "radio", name: "hc_fifthOilcan3", value: "符合要求", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_fifthOilcan3", value: "不符合", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>呼吸阀开启及吸入压力检测</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", name: "hc_pressureStart", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "KPa", offsetLeft: 2},
					{type: "newcolumn"},
					{type: "input", name: "hc_pressureEnd", inputWidth: 70, offsetLeft: 20},
					{type: "newcolumn"},
					{type: "label", label: "KPa", offsetLeft: 2}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>呼吸阀开启及吸入压力</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "hc_pressureState", value: "符合标准", position: "label-right", label: "符合", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_pressureState", value: "不符合标准", position: "label-right", label: "不符合", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>问题记载</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "input", name: "hc_question", inputWidth: 700, offsetLeft: 20, rows: 4}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>结&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;论</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "hc_conclusion", value: "符合要求", position: "label-right", label: "符合要求", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "hc_conclusion", value: "不符合要求", position: "label-right", label: "不符合要求", offsetLeft: 10}
				]},
				{type: "block", list: [
					{type: "select", name: "hc_checkPerson", label: "查检人", inputWidth: 112, offsetLeft: 10, options:[
						{text: "", value: ""},
			            <%
			            	for(int d=0; d<persons.size(); d++){
			            		if(d != persons.size()-1){
			            %>
			                		{text: "<%=(String)persons.get(d).get("name")%>", value: "<%=(String)persons.get(d).get("pid")%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=(String)persons.get(d).get("name")%>", value: "<%=(String)persons.get(d).get("pid")%>"}
			            <%
			            		}
			            	}
			            %>
	                ]}
				]}
			]
			hermeticForm = oilcanTab.tabs("hermetic_tab").attachForm(hermeticFormData);
			
			
			//5)罐体壁厚测定与外观检查报告
			var determineShowFormData = [
				{type: "block", list: [
					{type: "input", label: "测量仪器型号", name: "ds_deviceModel", inputWidth: 200, offsetLeft: 20},
					{type: "input", name: "ds_pid", hidden: true},
					{type: "newcolumn"},
					{type: "input", label: "罐 体 材 质", name: "ds_oilcanMaterial", inputWidth: 200, offsetLeft: 25},
					{type: "newcolumn"},
					{type: "input", label: "测量仪器精度", name: "ds_deviceCrack", inputWidth: 200, offsetLeft: 25}
				]},
				{type: "block", list: [
					{type: "input", label: "公&nbsp;&nbsp;称&nbsp;&nbsp;厚&nbsp;&nbsp;度", name: "ds_coverHeader", inputWidth: 200, offsetLeft: 21},
					{type: "newcolumn"},
					{type: "input", label: "耦&nbsp;&nbsp;&nbsp;合&nbsp;&nbsp;&nbsp;剂", name: "ds_coupling", inputWidth: 200, offsetLeft: 26},
					{type: "newcolumn"},
					{type: "input", label: "测&nbsp;&nbsp;量&nbsp;&nbsp;点&nbsp;&nbsp;数", name: "ds_gaugeNum", inputWidth: 200, offsetLeft: 26}
				]},
				//{type: "label", label: "<font size=2>实测结果：</font>", offsetLeft: 50},
				{type: "block", list: [
					{type: "label", label: "<font size=2>测厚点编号</font>", offsetLeft: 45},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>A1</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>A2</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>A3</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>A4</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>B1</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>B2</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>B3</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>B4</font>", offsetLeft: 60}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>实测厚度值</font>", offsetLeft: 45},
					{type: "newcolumn"},
					{type: "input", name: "ds_A1", inputWidth: 50, offsetLeft: 40},
					{type: "newcolumn"},
					{type: "input", name: "ds_A2", inputWidth: 50, offsetLeft: 35},
					{type: "newcolumn"},
					{type: "input", name: "ds_A3", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_A4", inputWidth: 50, offsetLeft: 25},
					{type: "newcolumn"},
					{type: "input", name: "ds_B1", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_B2", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_B3", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_B4", inputWidth: 50, offsetLeft: 30}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>测厚点编号</font>", offsetLeft: 45},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>C1</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>C2</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>C3</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>C4</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>D1</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>D2</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>D3</font>", offsetLeft: 60},
					{type: "newcolumn"},
					{type: "label", label: "<font size=2>D4</font>", offsetLeft: 60}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>实测厚度值</font>", offsetLeft: 45},
					{type: "newcolumn"},
					{type: "input", name: "ds_C1", inputWidth: 50, offsetLeft: 40},
					{type: "newcolumn"},
					{type: "input", name: "ds_C2", inputWidth: 50, offsetLeft: 35},
					{type: "newcolumn"},
					{type: "input", name: "ds_C3", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_C4", inputWidth: 50, offsetLeft: 25},
					{type: "newcolumn"},
					{type: "input", name: "ds_D1", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_D2", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_D3", inputWidth: 50, offsetLeft: 30},
					{type: "newcolumn"},
					{type: "input", name: "ds_D4", inputWidth: 50, offsetLeft: 30}
				]},
				{type: "block", list: [
					{type: "radio", name: "ds_image1", value: "3", offsetLeft: 10, checked: true, offsetTop: 50},
					{type: "newcolumn"},
					{type: "template", name: "t_image1", value: "<img width='150px' height='120px' src='d:/image/3.png'/>", inputWidth: 150, inputHeight: 120},
					{type: "newcolumn"},
					{type: "radio", name: "ds_image1", value: "4", offsetLeft: 50, offsetTop: 50},
					{type: "newcolumn"},
					{type: "template", name: "t_image2", value: "<img width='150px' height='120px' src='d:/image/4.png'/>", inputWidth: 150, inputHeight: 120},
					{type: "newcolumn"},
					{type: "radio", name: "ds_image1", value: "5", offsetLeft: 50, offsetTop: 50},
					{type: "newcolumn"},
					{type: "template", name: "t_image3", value: "<img width='150px' height='120px' src='d:/image/5.png'/>", inputWidth: 150, inputHeight: 120},
					{type: "newcolumn"},
					{type: "radio", name: "ds_image1", value: "6", offsetLeft: 50, offsetTop: 50},
					{type: "newcolumn"},
					{type: "template", name: "t_image4", value: "<img width='150px' height='120px' src='d:/image/6.png'/>", inputWidth: 150, inputHeight: 120}
				]},
				{type: "block", list: [
					{type: "radio", name: "ds_image2", value: "1", offsetLeft: 10, checked: true, offsetTop: 40},
					{type: "newcolumn"},
					{type: "template", name: "e_image1", value: "<img width='150px' height='100px' src='d:/image/1.png'/>", inputWidth: 150, inputHeight: 100},
					{type: "newcolumn"},
					{type: "radio", name: "ds_image2", value: "2", offsetLeft: 50, offsetTop: 40},
					{type: "newcolumn"},
					{type: "template", name: "e_image2", value: "<img width='150px' height='100px' src='d:/image/2.png'/>", inputWidth: 150, inputHeight: 100},
					{type: "newcolumn"},
					{type: "input", name: "ds_showCheck", inputWidth: 360, offsetLeft: 50, label: "外观检查", rows: 5, offsetTop: 10}
				]},
				{type: "block", list: [
					{type: "label", label: "<font size=2>检测结论</font>", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "radio", name: "ds_conclusion", value: "符合要求", position: "label-right", label: "符合要求", offsetLeft: 10, checked: true},
					{type: "newcolumn"},
					{type: "radio", name: "ds_conclusion", value: "不符合要求", position: "label-right", label: "不符合要求", offsetLeft: 10},
					{type: "newcolumn"},
					{type: "select", name: "ds_checkPerson", label: "检测人", inputWidth: 112, offsetLeft: 30, options:[
						{text: "", value: ""},
			            <%
			            	for(int f=0; f<persons.size(); f++){
			            		if(f != persons.size()-1){
			            %>
			                		{text: "<%=(String)persons.get(f).get("name")%>", value: "<%=(String)persons.get(f).get("pid")%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=(String)persons.get(f).get("name")%>", value: "<%=(String)persons.get(f).get("pid")%>"}
			            <%
			            		}
			            	}
			            %>
	                ]}
				]}
				
				
			]
			determineShowForm = oilcanTab.tabs("view_tab").attachForm(determineShowFormData);
			
			
			//报告首页
			var reportFormData = [
				{type: "block", list: [
					{type: "input", label: "报&nbsp;&nbsp;告&nbsp;&nbsp;编&nbsp;&nbsp;号", name: "rt_code", inputWidth: 200, offsetLeft: 22},
					{type: "input", name: "rt_pid", hidden: true},
					{type: "newcolumn"},
					{type: "select", label: "罐体材质类别", name: "rt_materialType", inputWidth: 200, offsetLeft: 25, options:[
			            <%
			            	int r = 0;
			            	for(String keyCode : materialTypeDicts.keySet()){
			            		if(r != materialTypeDicts.keySet().size()-1){
			            %>
			                		{text: "<%=materialTypeDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=materialTypeDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		r++;
			            	}
			            %>
	                ]},
					{type: "newcolumn"},
					{type: "select", label: "介质归属类别", name: "rt_mediumType", inputWidth: 80, offsetLeft: 25, options:[
			            <%
			            	int s = 0;
			            	for(String keyCode : mediumTypeDicts.keySet()){
			            		if(s != mediumTypeDicts.keySet().size()-1){
			            %>
			                		{text: "<%=mediumTypeDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=mediumTypeDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		s++;
			            	}
			            %>
	                ]},
	                {type: "newcolumn"},
	                {type: "select", name: "rt_mediumNote", inputWidth: 100, offsetLeft: 10, options:[
			            <%
			            	int t = 0;
			            	for(String keyCode : mediumNoteDicts.keySet()){
			            		if(t != mediumNoteDicts.keySet().size()-1){
			            %>
			                		{text: "<%=mediumNoteDicts.get(keyCode)%>", value: "<%=keyCode%>"},
			            <%
			            		}else{
			            %>
			                		{text: "<%=mediumNoteDicts.get(keyCode)%>", value: "<%=keyCode%>"}
			            <%
			            		}
			            		t++;
			            	}
			            %>
	                ]}
				]},
				{type: "block", list: [
					{type: "input", label: "罐车登记编号", name: "rt_registerCode", inputWidth: 200, offsetLeft: 21},
					{type: "newcolumn"},
					{type: "input", label: "道路运输证号", name: "rt_roadCode", inputWidth: 200, offsetLeft: 26}
				]}
			]
			reportForm = oilcanTab.tabs("report_tab").attachForm(reportFormData);
			
			oilcanWin.hide();
		}
		
		//字典数据维护
		function configOilcan(){
			var dictWins = new dhtmlXWindows();
			var dictWin = dictWins.createWindow("dictWinId", winWidth/2-450, 20, 750, 550);
			dictWin.setText("<font size=2>数据维护</font>");
			dictWin.setModal(true);
			dictWin.attachURL("<%=basePath%>page/dict.jsp");
		}
		
		function bjOilcan(){
			var id = oilcanGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要标记的记录");
				return;
			}
			dhtmlx.confirm("您确定要标记选中的记录吗？", function(result){
				if(result == true){
					oilcansvc.bjOilcan(id, function(data){
						if(data > 0){
							dhtmlx.alert("数据标记成功");
						}else{
							dhtmlx.alert("数据标记失败");
						}
					});
				}
			});
		}
		
		//新增问题
		function addBase(){
			baseGrid.addRow(baseGrid.uid(), [""], -1);
		}
		//删除问题
		function deleteBase(){
			var id = baseGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要删除的记录");
				return;
			}
			if(id.length == 32){
				oilcansvc.deleteBase(id, function(data){
					if(data == 0){
						dhtmlx.alert("数据删除失败");
					}
				})
			}
			baseGrid.deleteRow(id);
		}
		//新增查检记录
		function addCheck(){
			checkGrid.addRow(checkGrid.uid(), [""], -1);
		}
		
		//删除查检记录
		function deleteCheck(){
			var id = checkGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要删除的记录");
				return;
			}
			if(id.length == 32){
				oilcansvc.deleteCheck(id, function(data){
					if(data == 0){
						dhtmlx.alert("数据删除失败");
					}
				})
			}
			checkGrid.deleteRow(id);
		}
		
		//新增罐车信息
		function addOilcan(){
			oilcanWin.show();
		}
		
		//修改罐车信息
		function updateOilcan(){
			var id = oilcanGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要修改的记录");
				return;
			}
			oilcansvc.findByHql("from BaseInformation where id='" + id + "'", function(data){
				if(data != null && data.length != 0){
					var oilcan = data[0];
					baseForm.setItemValue("id", oilcan.id);
					baseForm.setItemValue("oilcanBrand", oilcan.oilcanBrand);
					baseForm.setItemValue("oilcanModel", oilcan.oilcanModel);
					baseForm.setItemValue("carNo", oilcan.carNo);
					baseForm.setItemValue("produce1", oilcan.produce1);
					baseForm.setItemValue("carModel", oilcan.carModel);
					baseForm.setItemValue("outDate1", oilcan.outDate1);
					baseForm.setItemValue("produce2", oilcan.produce2);
					baseForm.setItemValue("firstCheckDate", oilcan.firstCheckDate);
					baseForm.setItemValue("outDate2", oilcan.outDate2);
					baseForm.setItemValue("medium", oilcan.medium);
					baseForm.setItemValue("mediumCode", oilcan.mediumCode);
					baseForm.setItemValue("density", oilcan.density);
					baseForm.setItemValue("regDate", oilcan.regDate);
					baseForm.setItemValue("length", oilcan.length);
					baseForm.setItemValue("width", oilcan.width);
					baseForm.setItemValue("height", oilcan.height);
					baseForm.setItemValue("weight", oilcan.weight);
					baseForm.setItemValue("axisNum", oilcan.axisNum);
					baseForm.setItemValue("outCapacity", oilcan.outCapacity);
					baseForm.setItemValue("allowCapacity", oilcan.allowCapacity);
					baseForm.setItemValue("allowWeight", oilcan.allowWeight);
					baseForm.setItemValue("oilcanMaterial", oilcan.oilcanMaterial);
					baseForm.setItemValue("warehouseNum", oilcan.warehouseNum);
					baseForm.setItemValue("unitName", oilcan.unitName);
					baseForm.setItemValue("outCode", oilcan.outCode);
					baseForm.setItemValue("licensedCode", oilcan.licensedCode);
					baseForm.setItemValue("organizationName", oilcan.organizationName);
					baseForm.setItemValue("checkCode", oilcan.checkCode);
					baseForm.setItemValue("spotCode", oilcan.spotCode);
					baseForm.setItemValue("conclusion", oilcan.conclusion);
					baseForm.setItemValue("nextCheckDate", oilcan.nextCheckDate);
					baseForm.setItemValue("checkDate", oilcan.checkDate);
					baseForm.setItemValue("convertNote", oilcan.convertNote);
				}
			});
			
			oilcansvc.findPropertiesBySql("select pid,description from CheckRecord where baseId='" + id + "'",false, function(data){
				checkGrid.clearAll();
				checkGrid.parse(data, "json");
			});
			
			oilcansvc.findPropertiesBySql("select pid,description from Problem where baseId='" + id + "'",false, function(data){
				baseGrid.clearAll();
				baseGrid.parse(data, "json");
			});
			
			
			oilcansvc.findByHql("from OilcanShoulder where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					shoulderAForm.setItemValue("os_pid", data[0].pid);
					shoulderAForm.setItemValue("os_bulwarkNum", data[0].bulwarkNum);
					shoulderAForm.setItemValue("os_bulwarkState", data[0].bulwarkState);
					shoulderAForm.setItemValue("os_holeNum", data[0].holeNum);
					shoulderAForm.setItemValue("os_holeState", data[0].holeState);
					shoulderAForm.setItemValue("os_affluxNum", data[0].affluxNum);
					shoulderAForm.setItemValue("os_affluxState", data[0].affluxState);
					shoulderAForm.setItemValue("os_detroitType", data[0].detroitType);
					shoulderAForm.setItemValue("os_detroitState", data[0].detroitState);
					shoulderAForm.setItemValue("os_hasCrack", data[0].hasCrack);
					
					var oilcanShow = data[0].oilcanShow;
					for(var i=0; i<oilcanShow.split(",").length; i++){
						shoulderAForm.setItemValue("os_oilcanShow" + i, oilcanShow.split(",")[i]);
					}
					
					shoulderAForm.setItemValue("os_oilcanDefect", data[0].oilcanDefect);
					shoulderBForm.setItemValue("os_diameter", data[0].diameter);
					shoulderBForm.setItemValue("os_diameterNum", data[0].diameterNum);	
					
					var valveType = data[0].valveType;
					<%
						int h = 0;
		            	for(String keyCode : valveTypeDicts.keySet()){
		            %>
		            		for(var i=0; i<valveType.split(",").length; i++){
								var valveTypeStr = valveType.split(",")[i];
								var valveTypeName = valveTypeStr.substring(0, valveTypeStr.length-2);
								var valveTypeNum = valveTypeStr.substring(valveTypeStr.length-2, valveTypeStr.length-1);
			            		if(valveTypeName == '<%=valveTypeDicts.get(keyCode)%>')
			                		shoulderBForm.setItemValue("os_valveType<%=h%>", valveTypeNum);
			                }
		            <%
		            		h += 1;
		            	}
		            %>
						
					
					var valveMaterial = data[0].valveMaterial;
					for(var i=0; i<valveMaterial.split(",").length; i++){
						shoulderBForm.setItemValue("os_valveMaterial" + i, valveMaterial.split(",")[i]);
					}
					
					shoulderBForm.setItemValue("os_seepage", data[0].seepage);
					shoulderBForm.setItemValue("os_hose", data[0].hose);
					shoulderBForm.setItemValue("os_refuel", data[0].refuel);
					shoulderCForm.setItemValue("os_recoverSystem", data[0].recoverSystem);
					shoulderCForm.setItemValue("os_recoverState", data[0].recoverState);
					shoulderCForm.setItemValue("os_bengSystem", data[0].bengSystem);
					shoulderCForm.setItemValue("os_bengState", data[0].bengState);
					
					var measureSystem = data[0].measureSystem;
					for(var i=0; i<measureSystem.split(",").length; i++){
						shoulderCForm.setItemValue("os_measureSystem" + i, measureSystem.split(",")[i]);
					}
					
					shoulderCForm.setItemValue("os_refitPlace", data[0].refitPlace);
					shoulderCForm.setItemValue("os_oilcanHeat", data[0].oilcanHeat);
					shoulderCForm.setItemValue("os_checkPerson", data[0].checkPerson);
				}
			});
			
			oilcansvc.findByHql("from SafeAttachment where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					attachmentAForm.setItemValue("sa_fireDevice", data[0].fireDevice);
					attachmentAForm.setItemValue("sa_dangerLamp", data[0].dangerLamp);
					attachmentAForm.setItemValue("sa_dangerPlate", data[0].dangerPlate);
					attachmentAForm.setItemValue("sa_surfaceMark", data[0].surfaceMark);
					attachmentAForm.setItemValue("sa_paintColor", data[0].paintColor);
					attachmentAForm.setItemValue("sa_systemPosition", data[0].systemPosition);
					attachmentAForm.setItemValue("sa_rubber", data[0].rubber);
					attachmentAForm.setItemValue("sa_transmitType", data[0].transmitType);
					attachmentAForm.setItemValue("sa_transmitValue", data[0].transmitValue);
					attachmentBForm.setItemValue("sa_attendance", data[0].attendance);
					attachmentBForm.setItemValue("sa_ladder", data[0].ladder);
					attachmentBForm.setItemValue("sa_valveContainer", data[0].valveContainer);
					attachmentBForm.setItemValue("sa_valveState", data[0].valveState);
					attachmentBForm.setItemValue("sa_garnerContainer", data[0].garnerContainer);
					attachmentBForm.setItemValue("sa_switchSystem", data[0].switchSystem);
					if(data[0].pressure.indexOf(";") != -1){
						attachmentBForm.setItemValue("sa_pressure1", data[0].pressure.indexOf(";")[0]);
						attachmentBForm.setItemValue("sa_pressure2", data[0].pressure.indexOf(";")[1]);
					}else
						attachmentBForm.setItemValue("sa_pressure1", data[0].pressure);
					
					attachmentBForm.setItemValue("sa_dnLength", data[0].dnLength);
					attachmentBForm.setItemValue("sa_dnNum", data[0].dnNum);
					attachmentBForm.setItemValue("sa_dnState", data[0].dnState);
					attachmentBForm.setItemValue("sa_breakSystem", data[0].breakSystem);
					attachmentBForm.setItemValue("sa_checkPerson", data[0].checkPerson);
					attachmentAForm.setItemValue("sa_pid", data[0].pid);
				}
			});
			
			oilcansvc.findByHql("from RecoverDevice where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					if(data[0].kiss != "/"){
						deviceForm.setItemValue("de_kissNum", data[0].kiss.split(";")[0]);
						deviceForm.setItemValue("de_kissState", data[0].kiss.split(";")[1]);
						deviceForm.setItemValue("de_kissNote", data[0].kiss.split(";")[2]);
					}
					if(data[0].hat != "/"){
						deviceForm.setItemValue("de_hatNum", data[0].hat.split(";")[0]);
						deviceForm.setItemValue("de_hatState", data[0].hat.split(";")[1]);
						deviceForm.setItemValue("de_hatNote", data[0].hat.split(";")[2]);
					}
					if(data[0].valve != "/"){
						deviceForm.setItemValue("de_valveNum", data[0].valve.split(";")[0]);
						deviceForm.setItemValue("de_valveState", data[0].valve.split(";")[1]);
						deviceForm.setItemValue("de_valveNote", data[0].valve.split(";")[2]);
					}
					if(data[0].gluing != "/"){
						deviceForm.setItemValue("de_gluingNum", data[0].gluing.split(";")[0]);
						deviceForm.setItemValue("de_gluingState", data[0].gluing.split(";")[1]);
						deviceForm.setItemValue("de_gluingNote", data[0].gluing.split(";")[2]);
					}
					if(data[0].oilcanPipe != "/"){
						deviceForm.setItemValue("de_oilcanPipeNum", data[0].oilcanPipe.split(";")[0]);
						deviceForm.setItemValue("de_oilcanPipeState", data[0].oilcanPipe.split(";")[1]);
						deviceForm.setItemValue("de_oilcanPipeNote", data[0].oilcanPipe.split(";")[2]);
					}
					if(data[0].lineValve != "/"){
						deviceForm.setItemValue("de_lineValveNum", data[0].lineValve.split(";")[0]);
						deviceForm.setItemValue("de_lineValveState", data[0].lineValve.split(";")[1]);
						deviceForm.setItemValue("de_lineValveNote", data[0].lineValve.split(";")[2]);
					}
					if(data[0].stand != "/"){
						deviceForm.setItemValue("de_standNum", data[0].stand.split(";")[0]);
						deviceForm.setItemValue("de_standState", data[0].stand.split(";")[1]);
						deviceForm.setItemValue("de_standNote", data[0].stand.split(";")[2]);
					}
					if(data[0].pressure != "/"){
						deviceForm.setItemValue("de_pressureNum", data[0].pressure.split(";")[0]);
						deviceForm.setItemValue("de_pressureState", data[0].pressure.split(";")[1]);
						deviceForm.setItemValue("de_pressureNote", data[0].pressure.split(";")[2]);
					}
					if(data[0].bottomKiss != "/"){
						deviceForm.setItemValue("de_bottomKissNum", data[0].bottomKiss.split(";")[0]);
						deviceForm.setItemValue("de_bottomKissState", data[0].bottomKiss.split(";")[1]);
						deviceForm.setItemValue("de_bottomKissNote", data[0].bottomKiss.split(";")[2]);
					}
					if(data[0].bottomHat != "/"){
						deviceForm.setItemValue("de_bottomHatNum", data[0].bottomHat.split(";")[0]);
						deviceForm.setItemValue("de_bottomHatState", data[0].bottomHat.split(";")[1]);
						deviceForm.setItemValue("de_bottomHatNote", data[0].bottomHat.split(";")[2]);
					}
					if(data[0].bottomValve != "/"){
						deviceForm.setItemValue("de_bottomValveNum", data[0].bottomValve.split(";")[0]);
						deviceForm.setItemValue("de_bottomValveState", data[0].bottomValve.split(";")[1]);
						deviceForm.setItemValue("de_bottomValveNote", data[0].bottomValve.split(";")[2]);
					}
					if(data[0].centerValve != "/"){
						deviceForm.setItemValue("de_centerValveNum", data[0].centerValve.split(";")[0]);
						deviceForm.setItemValue("de_centerValveState", data[0].centerValve.split(";")[1]);
						deviceForm.setItemValue("de_centerValveNote", data[0].centerValve.split(";")[2]);
					}
					if(data[0].outlet != "/"){
						deviceForm.setItemValue("de_outletNum", data[0].outlet.split(";")[0]);
						deviceForm.setItemValue("de_outletState", data[0].outlet.split(";")[1]);
						deviceForm.setItemValue("de_outletNote", data[0].outlet.split(";")[2]);
					}
					if(data[0].fixHeight != "/"){
						deviceForm.setItemValue("de_fixHeightNum", data[0].fixHeight.split(";")[0]);
						deviceForm.setItemValue("de_fixHeightNote", data[0].fixHeight.split(";")[1]);
					}
					
					deviceForm.setItemValue("de_pid", data[0].pid);
				}
			});
			
			oilcansvc.findByHql("from ValveHermetic where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					if(data[0].firstOilcan != "/"){
						hermeticForm.setItemValue("hc_firstOilcan1", data[0].firstOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_firstOilcan2", data[0].firstOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_firstOilcan3", data[0].firstOilcan.split(";")[2]);
					}
					if(data[0].secondOilcan != "/"){
						hermeticForm.setItemValue("hc_secondOilcan1", data[0].secondOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_secondOilcan2", data[0].secondOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_secondOilcan3", data[0].secondOilcan.split(";")[2]);
					}
					if(data[0].thirdOilcan != "/"){
						hermeticForm.setItemValue("hc_thirdOilcan1", data[0].thirdOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_thirdOilcan2", data[0].thirdOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_thirdOilcan3", data[0].thirdOilcan.split(";")[2]);
					}
					if(data[0].forthOilcan != "/"){
						hermeticForm.setItemValue("hc_forthOilcan1", data[0].forthOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_forthOilcan2", data[0].forthOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_forthOilcan3", data[0].forthOilcan.split(";")[2]);
					}
					if(data[0].fifthOilcan != "/"){
						hermeticForm.setItemValue("hc_fifthOilcan1", data[0].fifthOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_fifthOilcan2", data[0].fifthOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_fifthOilcan3", data[0].fifthOilcan.split(";")[2]);
					}
				
					hermeticForm.setItemValue("hc_pressureStart", data[0].pressureStart);
					hermeticForm.setItemValue("hc_pressureEnd", data[0].pressureEnd);
					hermeticForm.setItemValue("hc_pressureState", data[0].pressureState);
					hermeticForm.setItemValue("hc_question", data[0].question);
					hermeticForm.setItemValue("hc_conclusion", data[0].conclusion);
					hermeticForm.setItemValue("hc_checkPerson", data[0].checkPerson);
					hermeticForm.setItemValue("hc_pid", data[0].pid);
				}
			});
			
			
			oilcansvc.findByHql("from DetermineShow where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					determineShowForm.setItemValue("ds_deviceModel", data[0].deviceModel);
					determineShowForm.setItemValue("ds_oilcanMaterial", data[0].oilcanMaterial);
					determineShowForm.setItemValue("ds_deviceCrack", data[0].deviceCrack);
					determineShowForm.setItemValue("ds_coverHeader", data[0].coverHeader);
					determineShowForm.setItemValue("ds_coupling", data[0].coupling);
					determineShowForm.setItemValue("ds_gaugeNum", data[0].gaugeNum);
					
					determineShowForm.setItemValue("ds_A1", data[0].thickness.split(",")[0]);
					determineShowForm.setItemValue("ds_A2", data[0].thickness.split(",")[1]);
					determineShowForm.setItemValue("ds_A3", data[0].thickness.split(",")[2]);
					determineShowForm.setItemValue("ds_A4", data[0].thickness.split(",")[3]);
					determineShowForm.setItemValue("ds_B1", data[0].thickness.split(",")[4]);
					determineShowForm.setItemValue("ds_B2", data[0].thickness.split(",")[5]);
					determineShowForm.setItemValue("ds_B3", data[0].thickness.split(",")[6]);
					determineShowForm.setItemValue("ds_B4", data[0].thickness.split(",")[7]);
					determineShowForm.setItemValue("ds_C1", data[0].thickness.split(",")[8]);
					determineShowForm.setItemValue("ds_C2", data[0].thickness.split(",")[9]);
					determineShowForm.setItemValue("ds_C3", data[0].thickness.split(",")[10]);
					determineShowForm.setItemValue("ds_C4", data[0].thickness.split(",")[11]);
					determineShowForm.setItemValue("ds_D1", data[0].thickness.split(",")[12]);
					determineShowForm.setItemValue("ds_D2", data[0].thickness.split(",")[13]);
					determineShowForm.setItemValue("ds_D3", data[0].thickness.split(",")[14]);
					determineShowForm.setItemValue("ds_D4", data[0].thickness.split(",")[15]);
					
					determineShowForm.setItemValue("ds_image1", data[0].image1);
					determineShowForm.setItemValue("ds_image2", data[0].image2);
					determineShowForm.setItemValue("ds_showCheck", data[0].showCheck);
					determineShowForm.setItemValue("ds_conclusion", data[0].conclusion);
					determineShowForm.setItemValue("ds_checkPerson", data[0].checkPerson);
					determineShowForm.setItemValue("ds_pid", data[0].pid);
				}
			});
			
			oilcansvc.findByHql("from ReportPage where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					reportForm.setItemValue("rt_code", data[0].code);	
					reportForm.setItemValue("rt_materialType", data[0].materialType);	
					reportForm.setItemValue("rt_mediumType", data[0].mediumType);	
					reportForm.setItemValue("rt_mediumNote", data[0].mediumNote);	
					reportForm.setItemValue("rt_registerCode", data[0].registerCode);	
					reportForm.setItemValue("rt_roadCode", data[0].roadCode);	
					reportForm.setItemValue("rt_pid", data[0].pid);	
				}
			});
			
			oilcanWin.show();
		}
		
		//复用罐车信息
		function repeatOilcan(){
			var id = oilcanGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要修改的记录");
				return;
			}
			oilcansvc.findByHql("from BaseInformation where id='" + id + "'", function(data){
				if(data != null && data.length != 0){
					var oilcan = data[0];
					baseForm.setItemValue("oilcanBrand", oilcan.oilcanBrand);
					baseForm.setItemValue("oilcanModel", oilcan.oilcanModel);
					baseForm.setItemValue("carNo", oilcan.carNo);
					baseForm.setItemValue("produce1", oilcan.produce1);
					baseForm.setItemValue("carModel", oilcan.carModel);
					baseForm.setItemValue("outDate1", oilcan.outDate1);
					baseForm.setItemValue("produce2", oilcan.produce2);
					baseForm.setItemValue("firstCheckDate", oilcan.firstCheckDate);
					baseForm.setItemValue("outDate2", oilcan.outDate2);
					baseForm.setItemValue("medium", oilcan.medium);
					baseForm.setItemValue("mediumCode", oilcan.mediumCode);
					baseForm.setItemValue("density", oilcan.density);
					baseForm.setItemValue("regDate", oilcan.regDate);
					baseForm.setItemValue("length", oilcan.length);
					baseForm.setItemValue("width", oilcan.width);
					baseForm.setItemValue("height", oilcan.height);
					baseForm.setItemValue("weight", oilcan.weight);
					baseForm.setItemValue("axisNum", oilcan.axisNum);
					baseForm.setItemValue("outCapacity", oilcan.outCapacity);
					baseForm.setItemValue("allowCapacity", oilcan.allowCapacity);
					baseForm.setItemValue("allowWeight", oilcan.allowWeight);
					baseForm.setItemValue("oilcanMaterial", oilcan.oilcanMaterial);
					baseForm.setItemValue("warehouseNum", oilcan.warehouseNum);
					baseForm.setItemValue("unitName", oilcan.unitName);
					baseForm.setItemValue("outCode", oilcan.outCode);
					baseForm.setItemValue("licensedCode", oilcan.licensedCode);
					baseForm.setItemValue("organizationName", oilcan.organizationName);
					baseForm.setItemValue("checkCode", oilcan.checkCode);
					baseForm.setItemValue("spotCode", oilcan.spotCode);
					baseForm.setItemValue("conclusion", oilcan.conclusion);
					baseForm.setItemValue("nextCheckDate", oilcan.nextCheckDate);
					baseForm.setItemValue("checkDate", oilcan.checkDate);
					baseForm.setItemValue("convertNote", oilcan.convertNote);
				}
			});
			
			oilcansvc.findPropertiesBySql("select SUBSTRING(pid,2,31),description from CheckRecord where baseId='" + id + "'",false, function(data){
				checkGrid.clearAll();
				checkGrid.parse(data, "json");
			});
			
			oilcansvc.findPropertiesBySql("select SUBSTRING(pid,2,31),description from Problem where baseId='" + id + "'",false, function(data){
				baseGrid.clearAll();
				baseGrid.parse(data, "json");
			});
			
			oilcansvc.findByHql("from OilcanShoulder where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					shoulderAForm.setItemValue("os_bulwarkNum", data[0].bulwarkNum);
					shoulderAForm.setItemValue("os_bulwarkState", data[0].bulwarkState);
					shoulderAForm.setItemValue("os_holeNum", data[0].holeNum);
					shoulderAForm.setItemValue("os_holeState", data[0].holeState);
					shoulderAForm.setItemValue("os_affluxNum", data[0].affluxNum);
					shoulderAForm.setItemValue("os_affluxState", data[0].affluxState);
					shoulderAForm.setItemValue("os_detroitType", data[0].detroitType);
					shoulderAForm.setItemValue("os_detroitState", data[0].detroitState);
					shoulderAForm.setItemValue("os_hasCrack", data[0].hasCrack);
					
					var oilcanShow = data[0].oilcanShow;
					for(var i=0; i<oilcanShow.split(",").length; i++){
						shoulderAForm.setItemValue("os_oilcanShow" + i, oilcanShow.split(",")[i]);
					}
					
					shoulderAForm.setItemValue("os_oilcanDefect", data[0].oilcanDefect);
					shoulderBForm.setItemValue("os_diameter", data[0].diameter);
					shoulderBForm.setItemValue("os_diameterNum", data[0].diameterNum);	
					
					var valveType = data[0].valveType;
					<%
						int w = 0;
		            	for(String keyCode : valveTypeDicts.keySet()){
		            %>
		            		for(var i=0; i<valveType.split(",").length; i++){
								var valveTypeStr = valveType.split(",")[i];
								var valveTypeName = valveTypeStr.substring(0, valveTypeStr.length-2);
								var valveTypeNum = valveTypeStr.substring(valveTypeStr.length-2, valveTypeStr.length-1);
			            		if(valveTypeName == '<%=valveTypeDicts.get(keyCode)%>')
			                		shoulderBForm.setItemValue("os_valveType<%=w%>", valveTypeNum);
			                }
		            <%
		            		w += 1;
		            	}
		            %>
						
					
					var valveMaterial = data[0].valveMaterial;
					for(var i=0; i<valveMaterial.split(",").length; i++){
						shoulderBForm.setItemValue("os_valveMaterial" + i, valveMaterial.split(",")[i]);
					}
					
					shoulderBForm.setItemValue("os_seepage", data[0].seepage);
					shoulderBForm.setItemValue("os_hose", data[0].hose);
					shoulderBForm.setItemValue("os_refuel", data[0].refuel);
					shoulderCForm.setItemValue("os_recoverSystem", data[0].recoverSystem);
					shoulderCForm.setItemValue("os_recoverState", data[0].recoverState);
					shoulderCForm.setItemValue("os_bengSystem", data[0].bengSystem);
					shoulderCForm.setItemValue("os_bengState", data[0].bengState);
					
					var measureSystem = data[0].measureSystem;
					for(var i=0; i<measureSystem.split(",").length; i++){
						shoulderCForm.setItemValue("os_measureSystem" + i, measureSystem.split(",")[i]);
					}
					
					shoulderCForm.setItemValue("os_refitPlace", data[0].refitPlace);
					shoulderCForm.setItemValue("os_oilcanHeat", data[0].oilcanHeat);
					shoulderCForm.setItemValue("os_checkPerson", data[0].checkPerson);
				}
			});
			
			oilcansvc.findByHql("from SafeAttachment where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					attachmentAForm.setItemValue("sa_fireDevice", data[0].fireDevice);
					attachmentAForm.setItemValue("sa_dangerLamp", data[0].dangerLamp);
					attachmentAForm.setItemValue("sa_dangerPlate", data[0].dangerPlate);
					attachmentAForm.setItemValue("sa_surfaceMark", data[0].surfaceMark);
					attachmentAForm.setItemValue("sa_paintColor", data[0].paintColor);
					attachmentAForm.setItemValue("sa_systemPosition", data[0].systemPosition);
					attachmentAForm.setItemValue("sa_rubber", data[0].rubber);
					attachmentAForm.setItemValue("sa_transmitType", data[0].transmitType);
					attachmentAForm.setItemValue("sa_transmitValue", data[0].transmitValue);
					attachmentBForm.setItemValue("sa_attendance", data[0].attendance);
					attachmentBForm.setItemValue("sa_ladder", data[0].ladder);
					attachmentBForm.setItemValue("sa_valveContainer", data[0].valveContainer);
					attachmentBForm.setItemValue("sa_valveState", data[0].valveState);
					attachmentBForm.setItemValue("sa_garnerContainer", data[0].garnerContainer);
					attachmentBForm.setItemValue("sa_switchSystem", data[0].switchSystem);
					if(data[0].pressure.indexOf(";") != -1){
						attachmentBForm.setItemValue("sa_pressure1", data[0].pressure.indexOf(";")[0]);
						attachmentBForm.setItemValue("sa_pressure2", data[0].pressure.indexOf(";")[1]);
					}else
						attachmentBForm.setItemValue("sa_pressure1", data[0].pressure);
					
					attachmentBForm.setItemValue("sa_dnLength", data[0].dnLength);
					attachmentBForm.setItemValue("sa_dnNum", data[0].dnNum);
					attachmentBForm.setItemValue("sa_dnState", data[0].dnState);
					attachmentBForm.setItemValue("sa_breakSystem", data[0].breakSystem);
					attachmentBForm.setItemValue("sa_checkPerson", data[0].checkPerson);
				}
			});
			
			oilcansvc.findByHql("from RecoverDevice where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					if(data[0].kiss != "/"){
						deviceForm.setItemValue("de_kissNum", data[0].kiss.split(";")[0]);
						deviceForm.setItemValue("de_kissState", data[0].kiss.split(";")[1]);
						deviceForm.setItemValue("de_kissNote", data[0].kiss.split(";")[2]);
					}
					if(data[0].hat != "/"){
						deviceForm.setItemValue("de_hatNum", data[0].hat.split(";")[0]);
						deviceForm.setItemValue("de_hatState", data[0].hat.split(";")[1]);
						deviceForm.setItemValue("de_hatNote", data[0].hat.split(";")[2]);
					}
					if(data[0].valve != "/"){
						deviceForm.setItemValue("de_valveNum", data[0].valve.split(";")[0]);
						deviceForm.setItemValue("de_valveState", data[0].valve.split(";")[1]);
						deviceForm.setItemValue("de_valveNote", data[0].valve.split(";")[2]);
					}
					if(data[0].gluing != "/"){
						deviceForm.setItemValue("de_gluingNum", data[0].gluing.split(";")[0]);
						deviceForm.setItemValue("de_gluingState", data[0].gluing.split(";")[1]);
						deviceForm.setItemValue("de_gluingNote", data[0].gluing.split(";")[2]);
					}
					if(data[0].oilcanPipe != "/"){
						deviceForm.setItemValue("de_oilcanPipeNum", data[0].oilcanPipe.split(";")[0]);
						deviceForm.setItemValue("de_oilcanPipeState", data[0].oilcanPipe.split(";")[1]);
						deviceForm.setItemValue("de_oilcanPipeNote", data[0].oilcanPipe.split(";")[2]);
					}
					if(data[0].lineValve != "/"){
						deviceForm.setItemValue("de_lineValveNum", data[0].lineValve.split(";")[0]);
						deviceForm.setItemValue("de_lineValveState", data[0].lineValve.split(";")[1]);
						deviceForm.setItemValue("de_lineValveNote", data[0].lineValve.split(";")[2]);
					}
					if(data[0].stand != "/"){
						deviceForm.setItemValue("de_standNum", data[0].stand.split(";")[0]);
						deviceForm.setItemValue("de_standState", data[0].stand.split(";")[1]);
						deviceForm.setItemValue("de_standNote", data[0].stand.split(";")[2]);
					}
					if(data[0].pressure != "/"){
						deviceForm.setItemValue("de_pressureNum", data[0].pressure.split(";")[0]);
						deviceForm.setItemValue("de_pressureState", data[0].pressure.split(";")[1]);
						deviceForm.setItemValue("de_pressureNote", data[0].pressure.split(";")[2]);
					}
					if(data[0].bottomKiss != "/"){
						deviceForm.setItemValue("de_bottomKissNum", data[0].bottomKiss.split(";")[0]);
						deviceForm.setItemValue("de_bottomKissState", data[0].bottomKiss.split(";")[1]);
						deviceForm.setItemValue("de_bottomKissNote", data[0].bottomKiss.split(";")[2]);
					}
					if(data[0].bottomHat != "/"){
						deviceForm.setItemValue("de_bottomHatNum", data[0].bottomHat.split(";")[0]);
						deviceForm.setItemValue("de_bottomHatState", data[0].bottomHat.split(";")[1]);
						deviceForm.setItemValue("de_bottomHatNote", data[0].bottomHat.split(";")[2]);
					}
					if(data[0].bottomValve != "/"){
						deviceForm.setItemValue("de_bottomValveNum", data[0].bottomValve.split(";")[0]);
						deviceForm.setItemValue("de_bottomValveState", data[0].bottomValve.split(";")[1]);
						deviceForm.setItemValue("de_bottomValveNote", data[0].bottomValve.split(";")[2]);
					}
					if(data[0].centerValve != "/"){
						deviceForm.setItemValue("de_centerValveNum", data[0].centerValve.split(";")[0]);
						deviceForm.setItemValue("de_centerValveState", data[0].centerValve.split(";")[1]);
						deviceForm.setItemValue("de_centerValveNote", data[0].centerValve.split(";")[2]);
					}
					if(data[0].outlet != "/"){
						deviceForm.setItemValue("de_outletNum", data[0].outlet.split(";")[0]);
						deviceForm.setItemValue("de_outletState", data[0].outlet.split(";")[1]);
						deviceForm.setItemValue("de_outletNote", data[0].outlet.split(";")[2]);
					}
					if(data[0].fixHeight != "/"){
						deviceForm.setItemValue("de_fixHeightNum", data[0].fixHeight.split(";")[0]);
						deviceForm.setItemValue("de_fixHeightNote", data[0].fixHeight.split(";")[1]);
					}
					
				}
			});
			
			oilcansvc.findByHql("from ValveHermetic where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					if(data[0].firstOilcan != "/"){
						hermeticForm.setItemValue("hc_firstOilcan1", data[0].firstOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_firstOilcan2", data[0].firstOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_firstOilcan3", data[0].firstOilcan.split(";")[2]);
					}
					if(data[0].secondOilcan != "/"){
						hermeticForm.setItemValue("hc_secondOilcan1", data[0].secondOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_secondOilcan2", data[0].secondOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_secondOilcan3", data[0].secondOilcan.split(";")[2]);
					}
					if(data[0].thirdOilcan != "/"){
						hermeticForm.setItemValue("hc_thirdOilcan1", data[0].thirdOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_thirdOilcan2", data[0].thirdOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_thirdOilcan3", data[0].thirdOilcan.split(";")[2]);
					}
					if(data[0].forthOilcan != "/"){
						hermeticForm.setItemValue("hc_forthOilcan1", data[0].forthOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_forthOilcan2", data[0].forthOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_forthOilcan3", data[0].forthOilcan.split(";")[2]);
					}
					if(data[0].fifthOilcan != "/"){
						hermeticForm.setItemValue("hc_fifthOilcan1", data[0].fifthOilcan.split(";")[0]);
						hermeticForm.setItemValue("hc_fifthOilcan2", data[0].fifthOilcan.split(";")[1]);
						hermeticForm.setItemValue("hc_fifthOilcan3", data[0].fifthOilcan.split(";")[2]);
					}
				
					hermeticForm.setItemValue("hc_pressureStart", data[0].pressureStart);
					hermeticForm.setItemValue("hc_pressureEnd", data[0].pressureEnd);
					hermeticForm.setItemValue("hc_pressureState", data[0].pressureState);
					hermeticForm.setItemValue("hc_question", data[0].question);
					hermeticForm.setItemValue("hc_conclusion", data[0].conclusion);
					hermeticForm.setItemValue("hc_checkPerson", data[0].checkPerson);
				}
			});
			
			oilcansvc.findByHql("from DetermineShow where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					determineShowForm.setItemValue("ds_deviceModel", data[0].deviceModel);
					determineShowForm.setItemValue("ds_oilcanMaterial", data[0].oilcanMaterial);
					determineShowForm.setItemValue("ds_deviceCrack", data[0].deviceCrack);
					determineShowForm.setItemValue("ds_coverHeader", data[0].coverHeader);
					determineShowForm.setItemValue("ds_coupling", data[0].coupling);
					determineShowForm.setItemValue("ds_gaugeNum", data[0].gaugeNum);
					
					determineShowForm.setItemValue("ds_A1", data[0].thickness.split(",")[0]);
					determineShowForm.setItemValue("ds_A2", data[0].thickness.split(",")[1]);
					determineShowForm.setItemValue("ds_A3", data[0].thickness.split(",")[2]);
					determineShowForm.setItemValue("ds_A4", data[0].thickness.split(",")[3]);
					determineShowForm.setItemValue("ds_B1", data[0].thickness.split(",")[4]);
					determineShowForm.setItemValue("ds_B2", data[0].thickness.split(",")[5]);
					determineShowForm.setItemValue("ds_B3", data[0].thickness.split(",")[6]);
					determineShowForm.setItemValue("ds_B4", data[0].thickness.split(",")[7]);
					determineShowForm.setItemValue("ds_C1", data[0].thickness.split(",")[8]);
					determineShowForm.setItemValue("ds_C2", data[0].thickness.split(",")[9]);
					determineShowForm.setItemValue("ds_C3", data[0].thickness.split(",")[10]);
					determineShowForm.setItemValue("ds_C4", data[0].thickness.split(",")[11]);
					determineShowForm.setItemValue("ds_D1", data[0].thickness.split(",")[12]);
					determineShowForm.setItemValue("ds_D2", data[0].thickness.split(",")[13]);
					determineShowForm.setItemValue("ds_D3", data[0].thickness.split(",")[14]);
					determineShowForm.setItemValue("ds_D4", data[0].thickness.split(",")[15]);
					
					determineShowForm.setItemValue("ds_image1", data[0].image1);
					determineShowForm.setItemValue("ds_image2", data[0].image2);
					determineShowForm.setItemValue("ds_showCheck", data[0].showCheck);
					determineShowForm.setItemValue("ds_conclusion", data[0].conclusion);
					determineShowForm.setItemValue("ds_checkPerson", data[0].checkPerson);
				}
			});
			
			oilcansvc.findByHql("from ReportPage where baseId='" + id + "'", function(data){
				if(data != null && data.length != 0){
					reportForm.setItemValue("rt_code", data[0].code);	
					reportForm.setItemValue("rt_materialType", data[0].materialType);	
					reportForm.setItemValue("rt_mediumType", data[0].mediumType);	
					reportForm.setItemValue("rt_mediumNote", data[0].mediumNote);	
					reportForm.setItemValue("rt_registerCode", data[0].registerCode);	
					reportForm.setItemValue("rt_roadCode", data[0].roadCode);	
				}
			});
			
			oilcanWin.show();
		}
		
		//保存罐车信息
		function saveOilcanWin(){
			var id = baseForm.getItemValue("id");
			var oilcanBrand = baseForm.getItemValue("oilcanBrand");
			var oilcanModel = baseForm.getItemValue("oilcanModel");
			var carNo = baseForm.getItemValue("carNo");
			var produce1 = baseForm.getItemValue("produce1");
			var carModel = baseForm.getItemValue("carModel");
			var outDate1 = baseForm.getItemValue("outDate1");
			var produce2 = baseForm.getItemValue("produce2");
			var firstCheckDate = baseForm.getItemValue("firstCheckDate");
			var outDate2 = baseForm.getItemValue("outDate2");
			var medium = baseForm.getItemValue("medium");
			var mediumCode = baseForm.getItemValue("mediumCode");
			var density = baseForm.getItemValue("density");
			var regDate = baseForm.getItemValue("regDate");
			var length = baseForm.getItemValue("length");
			var width = baseForm.getItemValue("width");
			var height = baseForm.getItemValue("height");
			var weight = baseForm.getItemValue("weight");
			var axisNum = baseForm.getItemValue("axisNum");
			var outCapacity = baseForm.getItemValue("outCapacity");
			var allowCapacity = baseForm.getItemValue("allowCapacity");
			var allowWeight = baseForm.getItemValue("allowWeight");
			var oilcanMaterial = baseForm.getItemValue("oilcanMaterial");
			var warehouseNum = baseForm.getItemValue("warehouseNum");
			var unitName = baseForm.getItemValue("unitName");
			var outCode = baseForm.getItemValue("outCode");
			var licensedCode = baseForm.getItemValue("licensedCode");
			var organizationName = baseForm.getItemValue("organizationName");
			var checkCode = baseForm.getItemValue("checkCode");
			var spotCode = baseForm.getItemValue("spotCode");
			var conclusion = baseForm.getItemValue("conclusion");
			var checkDate = baseForm.getItemValue("checkDate");
			var nextCheckDate = baseForm.getItemValue("nextCheckDate");
			var convertNote = baseForm.getItemValue("convertNote");
	
			if(isEmpty(carNo)){
				dhtmlx.alert("请将信息填写完整");
				return;
			}
			
			var baseInformation = {
				'oilcanBrand' : oilcanBrand,
				'oilcanModel' : oilcanModel,
				'carNo' : carNo,
				'produce1' : produce1,
				'carModel' : carModel,
				'outDate1' : outDate1,
				'produce2' : produce2,
				'firstCheckDate' : firstCheckDate,
				'outDate2' : outDate2,
				'medium' : medium,
				'mediumCode' : mediumCode,
				'density' : density,
				'regDate' : regDate,
				'length' : length,
				'width' : width,
				'height' : height,
				'weight' : weight,
				'axisNum' : axisNum,
				'outCapacity' : outCapacity,
				'allowCapacity' : allowCapacity,
				'allowWeight' : allowWeight,
				'oilcanMaterial' : oilcanMaterial,
				'warehouseNum' : warehouseNum,
				'unitName' : unitName,
				'outCode' : outCode,
				'licensedCode' : licensedCode,
				'organizationName' : organizationName,
				'checkCode' : checkCode,
				'spotCode' : spotCode,
				'conclusion' : conclusion,
				'checkDate' : (isEmpty(checkDate) ? "" : checkDate.Format('yyyy-MM-dd')),
				'nextCheckDate' : nextCheckDate,
				'convertNote' : convertNote,
				'$dwrClassName' : 'BaseInformation'
			}
			
			if(!isEmpty(id))
				baseInformation.id = id;
				
			var checkIds = checkGrid.getAllRowIds();
			var checkRecords = [];
			if(!isEmpty(checkIds)){
				for(var i=0; i<checkIds.split(',').length; i++){
					var checkId = checkIds.split(',')[i];
					var checkDescription = checkGrid.cells(checkId, 0).getValue();
					if(!isEmpty(checkDescription)){
						var checkRecord = {
							'description' : checkDescription,
							'$dwrClassName' : "CheckRecord"
						}
						if(checkId.length == 32)
							checkRecord.pid = checkId;
						checkRecords.push(checkRecord);
					}
				}
			}
			
			var baseIds = baseGrid.getAllRowIds();
			var problems = [];
			if(!isEmpty(baseIds)){
				for(var i=0; i<baseIds.split(',').length; i++){
					var baseId = baseIds.split(',')[i];
					var problem = {
						'description' : baseGrid.cells(baseId, 0).getValue(),
						'$dwrClassName' : "Problem"
					}
					if(baseId.length == 32)
						problem.pid = baseId;
					problems.push(problem);
				}
			}
				
				
			var os_pid = shoulderAForm.getItemValue("os_pid");	
			var os_bulwarkNum = shoulderAForm.getItemValue("os_bulwarkNum");	
			var os_bulwarkState = shoulderAForm.getItemValue("os_bulwarkState");	
			var os_holeNum = shoulderAForm.getItemValue("os_holeNum");	
			var os_holeState = shoulderAForm.getItemValue("os_holeState");	
			var os_affluxNum = shoulderAForm.getItemValue("os_affluxNum");	
			var os_affluxState = shoulderAForm.getItemValue("os_affluxState");	
			var os_detroitType = shoulderAForm.getItemValue("os_detroitType");	
			var os_detroitState = shoulderAForm.getItemValue("os_detroitState");	
			var os_hasCrack = shoulderAForm.getItemValue("os_hasCrack");	
			
			var os_oilcanShow = "";
			var oilcanShowNum = <%=showDicts.size()%>;
			for(var i=0; i<oilcanShowNum; i++){
				var showNum = shoulderAForm.getItemValue("os_oilcanShow" + i);
				os_oilcanShow += "," + showNum;
			}
			if(!isEmpty(os_oilcanShow))
				os_oilcanShow = os_oilcanShow.substring(1);
			
			var os_oilcanDefect = shoulderAForm.getItemValue("os_oilcanDefect");	
			var os_diameter = shoulderBForm.getItemValue("os_diameter");	
			var os_diameterNum = shoulderBForm.getItemValue("os_diameterNum");	
			
			var os_valveType = "";
			var valveTypeNum = <%=valveTypeDicts.size()%>;
			for(var i=0; i<valveTypeNum; i++){
				var typeNum = shoulderBForm.getItemValue("os_valveType" + i);
				if(!isEmpty(typeNum))
					os_valveType += "," + shoulderBForm.getItemLabel("os_valveType" + i) + typeNum + "个";
			}
			if(!isEmpty(os_valveType))
				os_valveType = os_valveType.substring(1);
			
			var os_valveMaterial = "";
			var valveMaterialNum = <%=valveMaterialDicts.size()%>;
			for(var i=0; i<valveMaterialNum; i++){
				var materialNum = shoulderBForm.getItemValue("os_valveMaterial" + i);
				os_valveMaterial += "," + materialNum;
			}
			if(!isEmpty(os_valveMaterial))
				os_valveMaterial = os_valveMaterial.substring(1);
			
			var os_seepage = shoulderBForm.getItemValue("os_seepage");
			var os_hose = shoulderBForm.getItemValue("os_hose");
			var os_refuel = shoulderBForm.getItemValue("os_refuel");
			var os_recoverSystem = shoulderCForm.getItemValue("os_recoverSystem");
			var os_recoverState = shoulderCForm.getItemValue("os_recoverState");
			var os_bengSystem = shoulderCForm.getItemValue("os_bengSystem");
			var os_bengState = shoulderCForm.getItemValue("os_bengState");
			
			var os_measureSystem = "";
			var measureSystemNum = <%=measureSystemDicts.size()%>;
			for(var i=0; i<measureSystemNum; i++){
				var measurelNum = shoulderCForm.getItemValue("os_measureSystem" + i);
				os_measureSystem += "," + measurelNum;
			}
			if(!isEmpty(os_measureSystem))
				os_measureSystem = os_measureSystem.substring(1);
			
			var os_refitPlace = shoulderCForm.getItemValue("os_refitPlace");
			var os_oilcanHeat = shoulderCForm.getItemValue("os_oilcanHeat");
			var os_checkPerson = shoulderCForm.getItemValue("os_checkPerson");
			
			var oilcanShoulder = {
				'bulwarkNum' : os_bulwarkNum,
				'bulwarkState' : os_bulwarkState,
				'holeNum' : os_holeNum,
				'holeState' : os_holeState,
				'affluxNum' : os_affluxNum,
				'affluxState' : os_affluxState,
				'detroitType' : os_detroitType,
				'detroitState' : os_detroitState,
				'hasCrack' : os_hasCrack,
				'oilcanShow' : os_oilcanShow,
				'oilcanDefect' : os_oilcanDefect,
				'diameter' : os_diameter,
				'diameterNum' : os_diameterNum,
				'valveType' : os_valveType,
				'valveMaterial' : os_valveMaterial,
				'seepage' : os_seepage,
				'refuel' : os_refuel,
				'hose' : os_hose,
				'recoverSystem' : os_recoverSystem,
				'recoverState' : os_recoverState,
				'bengSystem' : os_bengSystem,
				'bengState' : os_bengState,
				'measureSystem' : os_measureSystem,
				'refitPlace' : os_refitPlace,
				'oilcanHeat' : os_oilcanHeat,
				'checkPerson' : os_checkPerson,
				'$dwrClassName' : "OilcanShoulder"
			}
			
			if(!isEmpty(os_pid))
				oilcanShoulder.pid = os_pid;
		
			var sa_fireDevice = attachmentAForm.getItemValue("sa_fireDevice");
			var sa_dangerLamp = attachmentAForm.getItemValue("sa_dangerLamp");
			var sa_dangerPlate = attachmentAForm.getItemValue("sa_dangerPlate");
			var sa_surfaceMark = attachmentAForm.getItemValue("sa_surfaceMark");
			var sa_paintColor = attachmentAForm.getItemValue("sa_paintColor");
			var sa_systemPosition = attachmentAForm.getItemValue("sa_systemPosition");
			var sa_rubber = attachmentAForm.getItemValue("sa_rubber");
			var sa_transmitType = attachmentAForm.getItemValue("sa_transmitType");
			var sa_transmitValue = attachmentAForm.getItemValue("sa_transmitValue");
			var sa_attendance = attachmentBForm.getItemValue("sa_attendance");
			var sa_ladder = attachmentBForm.getItemValue("sa_ladder");
			var sa_valveContainer = attachmentBForm.getItemValue("sa_valveContainer");
			var sa_valveState = attachmentBForm.getItemValue("sa_valveState");
			var sa_garnerContainer = attachmentBForm.getItemValue("sa_garnerContainer");
			var sa_switchSystem = attachmentBForm.getItemValue("sa_switchSystem");
			var sa_pressure1 = attachmentBForm.getItemValue("sa_pressure1");
			var sa_pressure2 = attachmentBForm.getItemValue("sa_pressure2");
			var sa_dnLength = attachmentBForm.getItemValue("sa_dnLength");
			var sa_dnNum = attachmentBForm.getItemValue("sa_dnNum");
			var sa_dnState = attachmentBForm.getItemValue("sa_dnState");
			var sa_breakSystem = attachmentBForm.getItemValue("sa_breakSystem"); 
			var sa_checkPerson = attachmentBForm.getItemValue("sa_checkPerson"); 
			var sa_pid = attachmentAForm.getItemValue("sa_pid");
			
			var safeAttachment = {
				"fireDevice" : sa_fireDevice,
				"dangerLamp" : sa_dangerLamp,
				"dangerPlate" : sa_dangerPlate,
				"surfaceMark" : sa_surfaceMark,
				"paintColor" : sa_paintColor,
				"systemPosition" : sa_systemPosition,
				"rubber" : sa_rubber,
				"transmitType" : sa_transmitType,
				"transmitValue" : sa_transmitValue,
				"attendance" : sa_attendance,
				"ladder" : sa_ladder,
				"valveContainer" : sa_valveContainer,
				"valveState" : sa_valveState,
				"garnerContainer" : sa_garnerContainer,
				"switchSystem" : sa_switchSystem,
				"dnLength" : sa_dnLength,
				"dnNum" : sa_dnNum,
				"dnState" : sa_dnState,
				"breakSystem" : sa_breakSystem,
				"checkPerson" : sa_checkPerson,
				"$dwrClassName" : "SafeAttachment"
			}
			
			if(sa_pressure1 == "有")
				safeAttachment.pressure = sa_pressure1 + ";" + sa_pressure2;
			else
				safeAttachment.pressure = sa_pressure1;
			
			if(!isEmpty(sa_pid))
				safeAttachment.pid = sa_pid;
				
				
			var kissNum = deviceForm.getItemValue("de_kissNum");
			var kissState = deviceForm.getItemValue("de_kissState");
			var kissNote = deviceForm.getItemValue("de_kissNote");
			var hatNum = deviceForm.getItemValue("de_hatNum");
			var hatState = deviceForm.getItemValue("de_hatState");
			var hatNote = deviceForm.getItemValue("de_hatNote");
			var valveNum = deviceForm.getItemValue("de_valveNum");
			var valveState = deviceForm.getItemValue("de_valveState");
			var valveNote = deviceForm.getItemValue("de_valveNote");
			var gluingNum = deviceForm.getItemValue("de_gluingNum");
			var gluingState = deviceForm.getItemValue("de_gluingState");
			var gluingNote = deviceForm.getItemValue("de_gluingNote");
			var oilcanPipeNum = deviceForm.getItemValue("de_oilcanPipeNum");
			var oilcanPipeState = deviceForm.getItemValue("de_oilcanPipeState");
			var oilcanPipeNote = deviceForm.getItemValue("de_oilcanPipeNote");
			var lineValveNum = deviceForm.getItemValue("de_lineValveNum");
			var lineValveState = deviceForm.getItemValue("de_lineValveState");
			var lineValveNote = deviceForm.getItemValue("de_lineValveNote");
			var standNum = deviceForm.getItemValue("de_standNum");
			var standState = deviceForm.getItemValue("de_standState");
			var standNote = deviceForm.getItemValue("de_standNote");
			var pressureNum = deviceForm.getItemValue("de_pressureNum");
			var pressureState = deviceForm.getItemValue("de_pressureState");
			var pressureNote = deviceForm.getItemValue("de_pressureNote");
			var bottomKissNum = deviceForm.getItemValue("de_bottomKissNum");
			var bottomKissState = deviceForm.getItemValue("de_bottomKissState");
			var bottomKissNote = deviceForm.getItemValue("de_bottomKissNote");
			var bottomHatNum = deviceForm.getItemValue("de_bottomHatNum");
			var bottomHatState = deviceForm.getItemValue("de_bottomHatState");
			var bottomHatNote = deviceForm.getItemValue("de_bottomHatNote");
			var bottomValveNum = deviceForm.getItemValue("de_bottomValveNum");
			var bottomValveState = deviceForm.getItemValue("de_bottomValveState");
			var bottomValveNote = deviceForm.getItemValue("de_bottomValveNote");
			var centerValveNum = deviceForm.getItemValue("de_centerValveNum");
			var centerValveState = deviceForm.getItemValue("de_centerValveState");
			var centerValveNote = deviceForm.getItemValue("de_centerValveNote");
			var outletNum = deviceForm.getItemValue("de_outletNum");
			var outletState = deviceForm.getItemValue("de_outletState");
			var outletNote = deviceForm.getItemValue("de_outletNote");
			var fixHeightNum = deviceForm.getItemValue("de_fixHeightNum");
			var fixHeightNote = deviceForm.getItemValue("de_fixHeightNote");
			var de_pid = deviceForm.getItemValue("de_pid");
			
			var recoverDevice = {};
			if(!isEmpty(kissNum))
				recoverDevice.kiss = kissNum + ";" + kissState + ";" + kissNote;
			else
				recoverDevice.kiss = "/";
				
			if(!isEmpty(hatNum))
				recoverDevice.hat = hatNum + ";" + hatState + ";" + hatNote;
			else
				recoverDevice.hat = "/";
				
			if(!isEmpty(valveNum))
				recoverDevice.valve = valveNum + ";" + valveState + ";" + valveNote;
			else
				recoverDevice.valve = "/";
				
			if(!isEmpty(gluingNum))
				recoverDevice.gluing = gluingNum + ";" + gluingState + ";" + gluingNote;
			else
				recoverDevice.gluing = "/";
				
			if(!isEmpty(oilcanPipeNum))
				recoverDevice.oilcanPipe = oilcanPipeNum + ";" + oilcanPipeState + ";" + oilcanPipeNote;
			else
				recoverDevice.oilcanPipe = "/";
				
			if(!isEmpty(lineValveNum))
				recoverDevice.lineValve = lineValveNum + ";" + lineValveState + ";" + lineValveNote;
			else
				recoverDevice.lineValve = "/";
				
			if(!isEmpty(standNum))
				recoverDevice.stand = standNum + ";" + standState + ";" + standNote;
			else
				recoverDevice.stand = "/";
				
			if(!isEmpty(pressureNum))
				recoverDevice.pressure = pressureNum + ";" + pressureState + ";" + pressureNote;
			else
				recoverDevice.pressure = "/";
				
			if(!isEmpty(bottomKissNum))
				recoverDevice.bottomKiss = bottomKissNum + ";" + bottomKissState + ";" + bottomKissNote;
			else
				recoverDevice.bottomKiss = "/";
				
			if(!isEmpty(bottomHatNum))
				recoverDevice.bottomHat = bottomHatNum + ";" + bottomHatState + ";" + bottomHatNote;
			else
				recoverDevice.bottomHat = "/";
				
			if(!isEmpty(bottomValveNum))
				recoverDevice.bottomValve = bottomValveNum + ";" + bottomValveState + ";" + bottomValveNote;
			else
				recoverDevice.bottomValve = "/";
				
			if(!isEmpty(centerValveNum))
				recoverDevice.centerValve = centerValveNum + ";" + centerValveState + ";" + centerValveNote;
			else
				recoverDevice.centerValve = "/";
				
			if(!isEmpty(outletNum))
				recoverDevice.outlet = outletNum + ";" + outletState + ";" + outletNote;
			else
				recoverDevice.outlet = "/";
				
			if(!isEmpty(fixHeightNum))
				recoverDevice.fixHeight = fixHeightNum + ";" + fixHeightNote;
			else
				recoverDevice.fixHeight = "/";
				
			if(!isEmpty(de_pid))
				recoverDevice.pid = de_pid;
		
			
			var hc_firstOilcan1 = hermeticForm.getItemValue("hc_firstOilcan1");
			var hc_firstOilcan2 = hermeticForm.getItemValue("hc_firstOilcan2");
			var hc_firstOilcan3 = hermeticForm.getItemValue("hc_firstOilcan3");
			var hc_secondOilcan1 = hermeticForm.getItemValue("hc_secondOilcan1");
			var hc_secondOilcan2 = hermeticForm.getItemValue("hc_secondOilcan2");
			var hc_secondOilcan3 = hermeticForm.getItemValue("hc_secondOilcan3");
			var hc_thirdOilcan1 = hermeticForm.getItemValue("hc_thirdOilcan1");
			var hc_thirdOilcan2 = hermeticForm.getItemValue("hc_thirdOilcan2");
			var hc_thirdOilcan3 = hermeticForm.getItemValue("hc_thirdOilcan3");
			var hc_forthOilcan1 = hermeticForm.getItemValue("hc_forthOilcan1");
			var hc_forthOilcan2 = hermeticForm.getItemValue("hc_forthOilcan2");
			var hc_forthOilcan3 = hermeticForm.getItemValue("hc_forthOilcan3");
			var hc_fifthOilcan1 = hermeticForm.getItemValue("hc_fifthOilcan1");
			var hc_fifthOilcan2 = hermeticForm.getItemValue("hc_fifthOilcan2");
			var hc_fifthOilcan3 = hermeticForm.getItemValue("hc_fifthOilcan3");
			var hc_pressureStart = hermeticForm.getItemValue("hc_pressureStart");
			var hc_pressureEnd = hermeticForm.getItemValue("hc_pressureEnd");
			var hc_pressureState = hermeticForm.getItemValue("hc_pressureState");
			var hc_question = hermeticForm.getItemValue("hc_question");
			var hc_conclusion = hermeticForm.getItemValue("hc_conclusion");
			var hc_checkPerson = hermeticForm.getItemValue("hc_checkPerson");
			var hc_pid = hermeticForm.getItemValue("hc_pid");
			
			var valveHermetic = {};
			if(!isEmpty(hc_firstOilcan1))
				valveHermetic.firstOilcan = hc_firstOilcan1 + ";" + hc_firstOilcan2 + ";" + hc_firstOilcan3;
			else
				valveHermetic.firstOilcan = "/";
			if(!isEmpty(hc_secondOilcan1))
				valveHermetic.secondOilcan = hc_secondOilcan1 + ";" + hc_secondOilcan2 + ";" + hc_secondOilcan3;
			else
				valveHermetic.secondOilcan = "/";
			if(!isEmpty(hc_thirdOilcan1))
				valveHermetic.thirdOilcan = hc_thirdOilcan1 + ";" + hc_thirdOilcan2 + ";" + hc_thirdOilcan3;
			else
				valveHermetic.thirdOilcan = "/";
			if(!isEmpty(hc_forthOilcan1))
				valveHermetic.forthOilcan = hc_forthOilcan1 + ";" + hc_forthOilcan2 + ";" + hc_forthOilcan3;
			else
				valveHermetic.forthOilcan = "/";
			if(!isEmpty(hc_fifthOilcan1))
				valveHermetic.fifthOilcan = hc_fifthOilcan1 + ";" + hc_fifthOilcan2 + ";" + hc_fifthOilcan3;
			else
				valveHermetic.fifthOilcan = "/";
			if(!isEmpty(hc_pressureStart))
				valveHermetic.pressureStart = hc_pressureStart;
			if(!isEmpty(hc_pressureEnd))
				valveHermetic.pressureEnd = hc_pressureEnd;
			if(!isEmpty(hc_pressureState))
				valveHermetic.pressureState = hc_pressureState;
			if(!isEmpty(hc_question))
				valveHermetic.question = hc_question;
			if(!isEmpty(hc_conclusion))
				valveHermetic.conclusion = hc_conclusion;
			if(!isEmpty(hc_checkPerson))
				valveHermetic.checkPerson = hc_checkPerson;
			if(!isEmpty(hc_pid))
				valveHermetic.pid = hc_pid;
				
				
			var ds_deviceModel = determineShowForm.getItemValue("ds_deviceModel");
			var ds_oilcanMaterial = determineShowForm.getItemValue("ds_oilcanMaterial");
			var ds_deviceCrack = determineShowForm.getItemValue("ds_deviceCrack");
			var ds_coverHeader = determineShowForm.getItemValue("ds_coverHeader");
			var ds_coupling = determineShowForm.getItemValue("ds_coupling");
			var ds_gaugeNum = determineShowForm.getItemValue("ds_gaugeNum");
			
			var ds_A1 = determineShowForm.getItemValue("ds_A1");
			var ds_A2 = determineShowForm.getItemValue("ds_A2");
			var ds_A3 = determineShowForm.getItemValue("ds_A3");
			var ds_A4 = determineShowForm.getItemValue("ds_A4");
			var ds_B1 = determineShowForm.getItemValue("ds_B1");
			var ds_B2 = determineShowForm.getItemValue("ds_B2");
			var ds_B3 = determineShowForm.getItemValue("ds_B3");
			var ds_B4 = determineShowForm.getItemValue("ds_B4");
			var ds_C1 = determineShowForm.getItemValue("ds_C1");
			var ds_C2 = determineShowForm.getItemValue("ds_C2");
			var ds_C3 = determineShowForm.getItemValue("ds_C3");
			var ds_C4 = determineShowForm.getItemValue("ds_C4");
			var ds_D1 = determineShowForm.getItemValue("ds_D1");
			var ds_D2 = determineShowForm.getItemValue("ds_D2");
			var ds_D3 = determineShowForm.getItemValue("ds_D3");
			var ds_D4 = determineShowForm.getItemValue("ds_D4");
			
			
			var thickness = ds_A1 + "," + ds_A2 + "," + ds_A3 + "," + ds_A4 + "," + 
							ds_B1 + "," + ds_B2 + "," + ds_B3 + "," + ds_B4 + "," + 
							ds_C1 + "," + ds_C2 + "," + ds_C3 + "," + ds_C4 + "," + 
							ds_D1 + "," + ds_D2 + "," + ds_D3 + "," + ds_D4;
			var ds_image1 = determineShowForm.getItemValue("ds_image1");
			var ds_image2 = determineShowForm.getItemValue("ds_image2");
			var ds_showCheck = determineShowForm.getItemValue("ds_showCheck");
			var ds_conclusion = determineShowForm.getItemValue("ds_conclusion");
			var ds_checkPerson = determineShowForm.getItemValue("ds_checkPerson");
			var ds_pid = determineShowForm.getItemValue("ds_pid");
			
			var determineShow = {
				"deviceModel" : ds_deviceModel,
				"oilcanMaterial" : ds_oilcanMaterial,
				"deviceCrack" : ds_deviceCrack,
				"coverHeader" : ds_coverHeader,
				"coupling" : ds_coupling,
				"gaugeNum" : ds_gaugeNum,
				"thickness" : thickness,
				"image1" : ds_image1,
				"image2" : ds_image2,
				"showCheck" : ds_showCheck,
				"conclusion" : ds_conclusion,
				"checkPerson" : ds_checkPerson,
				"$dwrClassName" : "DetermineShow"
			}
			
			if(!isEmpty(ds_pid))
				determineShow.pid = ds_pid;
				
			var rt_code = reportForm.getItemValue("rt_code");	
			var rt_materialType = reportForm.getItemValue("rt_materialType");	
			var rt_mediumType = reportForm.getItemValue("rt_mediumType");	
			var rt_mediumNote = reportForm.getItemValue("rt_mediumNote");	
			var rt_registerCode = reportForm.getItemValue("rt_registerCode");	
			var rt_roadCode = reportForm.getItemValue("rt_roadCode");	
			var rt_pid = reportForm.getItemValue("rt_pid");	
			
			var reportPage = {
				'code' : rt_code,
				'materialType' : rt_materialType,
				'mediumType' : rt_mediumType,
				'mediumNote' : rt_mediumNote,
				'registerCode' : rt_registerCode,
				'roadCode' : rt_roadCode,
				'$dwrClassName' : "ReportPage"
			}
			
			if(!isEmpty(rt_pid))
				reportPage.pid = rt_pid;
			
			
			oilcansvc.saveOilcan(baseInformation, checkRecords, problems, oilcanShoulder, safeAttachment, recoverDevice, valveHermetic, determineShow, reportPage, function(data){
				if(data > 0){
					oilcanWin.hide();
					dhtmlx.alert("数据保存成功");
				}else{
					dhtmlx.alert("数据保存失败");
				}
			});
		}
		
		
		//删除罐车信息
		function deleteOilcan(){
			var id = oilcanGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要删除的记录");
				return;
			}
			dhtmlx.confirm("您确定要删除选中的记录吗？", function(result){
				if(result == true){
					oilcansvc.deleteOilcan(id, function(data){
						if(data > 0){
							dhtmlx.alert("数据删除成功");
						}else{
							dhtmlx.alert("数据删除失败");
						}
					});
				}
			});
		}
		
		//打印
		function printOilcan(){
			var id = oilcanGrid.getSelectedRowId();
			if(isEmpty(id)){
				dhtmlx.alert("请选择要打印的记录");
				return;
			}
			var arg = {
				"reportName" : "oilcanReport", 
				"id" : id
			};
			oilcansvc.report(arg, function(result) {
				reportFrame.document.open();
				reportFrame.document.write(result);
				reportFrame.document.close();
			});
		}
		
		//导出
		function exportOilcan(){
			var ids = oilcanGrid.getSelectedRowId();
			if(isEmpty(ids)){
				dhtmlx.alert("请选择要导出的记录");
				return;
			}
			oilcansvc.exportOilcan(ids, function(data){
				dhtmlx.alert("数据已导出，请去D:/SQL文件夹下查找");
			});
		}
		
		//导入
		function importOilcan(){
			window.showModalDialog('<%=path%>/page/importFile.jsp','罐车信息导入','dialogHeight=200px,dialogWidth=550px,dialogTop=0,dialogLeft=0');
		}
		
		
		//清空窗体
		function clearForm(){
			baseForm.clear();
			baseGrid.clearAll();
			checkGrid.clearAll();
			shoulderAForm.clear();
			shoulderBForm.clear();
			shoulderCForm.clear();
			attachmentAForm.clear();
			attachmentBForm.clear();
			deviceForm.clear();
			hermeticForm.clear();
			determineShowForm.clear();
			reportForm.clear();
		}
	</script>
</head>
<body onload="loadView();">
	<div style="width:0px;height:0px;overflow: hidden;margin:0;">
	 	<iframe name="reportFrame" height="0" width="0"/>
	</div>
</body>
</html>