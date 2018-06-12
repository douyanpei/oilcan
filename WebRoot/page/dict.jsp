<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="common.jsp" %>
<html>
<head>
	 <title>字典管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<script type='text/javascript' src='dwr/interface/dictsvc.js'></script>
</head>
<style>
	html,body {
		width: 100%;
		height: 100%;
		overflow: hidden;
	}
</style>
<script type="text/javascript">
//获取屏幕的宽和高
var winWidth = window.screen.availWidth;
var winHeight = window.screen.availHeight;
//对象定义
	var dictForm, dictGrid;
	function doOnLoad(){
		//************************************************************************//
		//*********************** dictTab start ******************************//
		//************************************************************************//
		/*
		 *   Layout
		 */
		var dictLayout = new dhtmlXLayoutObject({
			parent:  document.body,    
		    pattern: "3E",
		    cells: [
		        {id: "a", header: false, fix_size:[1,1]},
		        {id: "b", header: false, fix_size:[1,1]},
		        {id: "c", header: false}
		    ]
		});
		
		dictLayout.cells("a").setHeight(40);
		dictLayout.cells("b").setHeight(130);
		dictLayout.cells("b").hideHeader();
		
		//*****************************Layout A**************************************//
		var searchFormData = [
			{type: "block", inputWidth: "auto", blockOffset: 10, list: [
			    {type: "input", label: "  字典名:", name: "searchCodeCnName", offsetLeft: 15},
			    {type: "newcolumn"},
			    {type: "input", label: "所属类型:", name: "searchCodeType", offsetLeft: 15},
			    {type: "newcolumn"},
			    {type: "input", label: "类型名称:", name: "searchCodeDesc", offsetLeft: 15},
			    {type: "newcolumn"},
			    {type: "button", value: "查询", name: "searchBtn", offsetLeft: 15}
			]}
		];
		dictSearchForm = dictLayout.cells("a").attachForm(searchFormData);	
		
		//*****************************Layout B**************************************//
		dictToolbar = dictLayout.cells("b").attachToolbar({
		    icons_path: "images/icon/",
		    json: "page/xml/dictToolbar.xml"
		}); 
		
		formData = [
	        {type: "fieldset", label: "功能信息", inputWidth: "auto", offsetLeft: 10, offsetTop: 5, list:[
				{type: "block", inputWidth: "auto", list: [
	                {type: "input", name: "codeCnName", value: "", label: "字典名称:", offsetLeft: 15},
	                {type: "newcolumn"},
	                {type: "input", name: "codeValue", value: "", label: "字典编码:", offsetLeft: 15},
	                {type: "newcolumn"},
	                {type: "input", name: "codeCnDesc", value: "", label: "字典描述:", offsetLeft: 15, width: 150},
	            ]},
			    {type: "block", inputWidth: "auto", list: [
	                {type: "input", name: "codeType", value: "", label: "所属类型:", offsetLeft: 15},
	                {type: "newcolumn"},
	                {type: "input", name: "codeDesc", value: "", label: "类型名称:", offsetLeft: 15},
	                {type: "newcolumn"},
	                {type: "checkbox", label: "是否起用", name: "codeIsUse", offsetLeft: 15, checked: true},
	                {type: "input", name: "id", value: null, label: "", hidden :true}
	            ]}
	        ]}
	    ];
		
		dictForm = dictLayout.cells("b").attachForm(formData);
		
		//*****************************Layout C**************************************//
		dictGrid = dictLayout.cells("c").attachGrid();
		dictGrid.setHeader("所属类型,类型描述,字典名,字典代码,字典描述,是否启用",null,["text-align:center;","text-align:center;","text-align:center;","text-align:center;","text-align:center;","text-align:center;","text-align:center;"]);
		dictGrid.setInitWidths("120,120,*,100,120,80")
		dictGrid.setColAlign("center,center,center,center,center,center")
		dictGrid.setColTypes("ro,ro,ro,ro,ro,ro");
		dictGrid.setColSorting("str,str,str,str,str,str")
		dictGrid.setSkin("dhx_skyblue")
		dictGrid.enableColumnMove(true);
		dictGrid.init();
		
		loadData();
		//***************************** Event **************************************//
		dictSearchForm.attachEvent("onButtonClick", function(id) {
			var codeCnName = dictSearchForm.getItemValue("searchCodeCnName");
			var codeType = dictSearchForm.getItemValue("searchCodeType");
			var codeDesc = dictSearchForm.getItemValue("searchCodeDesc");
			
			var conditionSql = " where 1=1";
			if(!isEmpty(codeCnName))
				conditionSql += " and codeCNName like'%" + codeCnName + "%'";
			if(!isEmpty(codeType))
				conditionSql += " and codeType like'%" + codeType + "%'";
			if(!isEmpty(codeDesc))
				conditionSql += " and codeDesc like'%" + codeDesc + "%'";
			dictsvc.findDict(conditionSql, function(data){
				dictGrid.clearAll();
				dictGrid.parse(data, "json");
			});
		});
		
		
		dictGrid.attachEvent("onRowSelect",function(id,cellIndex){
			dictForm.setItemValue("codeType", dictGrid.cells(id,0).getValue());
			dictForm.setItemValue("codeDesc", dictGrid.cells(id,1).getValue());
			dictForm.setItemValue("codeCnName", dictGrid.cells(id,2).getValue());
			dictForm.setItemValue("codeValue", dictGrid.cells(id,3).getValue());
			dictForm.setItemValue("codeCnDesc", dictGrid.cells(id,4).getValue());
			dictForm.setItemValue("id", id);
			if(dictGrid.cells(id,5).getValue() == '是')
				dictForm.setItemValue("codeIsUse", true);
			else
				dictForm.setItemValue("codeIsUse", false);
		});
		
		//***************************** function **************************************//
			
			
	}
	
	function loadData(){
		dictGrid.clearAll();
		dictsvc.findDict('',function(data){
			dictGrid.clearAll();
			dictGrid.parse(data, "json");
		});
	}
	
	function saveDict(){
		var dict = {
			'codeType' : dictForm.getItemValue("codeType") ,
			'codeDesc' : dictForm.getItemValue("codeDesc") ,
			'codeCnName' : dictForm.getItemValue("codeCnName") ,
			'codeValue' : dictForm.getItemValue("codeValue") ,
			'codeCnDesc' : dictForm.getItemValue("codeCnDesc") ,
			'codeIsUse' : dictForm.getItemValue("codeIsUse") ,
			'$dwrClassName' : 'Dict'
		}
		if(!isEmpty(dictForm.getItemValue("id")))
			dict.id = dictForm.getItemValue("id");
		
		dictsvc.saveDict(dict, function(data){
			if(data == 1){
				dhtmlx.alert("保存成功！");
				loadData();
				dictForm.clear();
			}else{
				dhtmlx.alert("保存失败！");
			}
		});
	}
	
	function deleteDict(id){
		var id = dictGrid.getSelectedRowId();
		if(isEmpty(id)){
			dhtmlx.alert("请选中要删除的记录");
			return;
		}
		dictsvc.deleteDict(id, function(data){
			if(data == 1){
				loadData();
				dictForm.clear();
				dhtmlx.alert("数据删除成功");
			}else{
				dhtmlx.alert("数据删除失败");
			}
		});
	}
</script>
<body onload="doOnLoad();">
</body>
</html>