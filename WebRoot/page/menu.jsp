<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
	div {font-size:13px;font-weight:bold;font-family:'宋体'}
</style>

<div id="menuData" style="display: none;">
	<div id="flow" text="业务流程">
		<div id="new" text="企业基本信息"></div>
		<div id="open" text="职业性健康查体委托书" img="open.gif"></div>
		<div id="save" text="分类汇总"></div>
		<div id="file_sep_1" type="separator"></div>
		<div id="saveAs" text="新登记"></div>
		<div id="print" text="体检登记"></div>
		<div id="print1" text="体检问诊"></div>
		<div id="file_sep_2" type="separator"></div>
		<div id="print2" text="样品采集记录"></div>
		<div id="file_sep_3" type="separator"></div>
		<div id="print3" text="体检记录">
			<div id="print4" text="一般查体结果"></div>
			<div id="print5" text="听力结果"></div>
			<div id="print6" text="结果集中录入"></div>
			<div id="print7" text="显示体检项目"></div>
			<div id="print8" text="外检结果导入"></div>
			<div id="print9" text="结果综合编辑"></div>
			<div id="file_sep_4" type="separator"></div>
			<div id="printa" text="结果复核"></div>
			<div id="file_sep_5" type="separator"></div>
			<div id="printb" text="实验室结果（血）"></div>
			<div id="printc" text="实验室结果（尿）"></div>
		</div>
		<div id="pageSetup1" text="职业健康结果审核"></div>
		<div id="pageSetup2" text="从业主检医师结论"></div>
		<div id="close" text="退出"></div>
	</div>
	<div id="sep_top_1" type="separator"></div>
	<div id="search" text="查询统计">
		<div id="undo1" text="查体情况综合统计" img="undo.gif"></div>
		<div id="redo1" text="工作情况统计"></div>
		<div id="selectAll1" text="不合格通知"></div>
		<div id="selectAll2" text="收费情况"></div>
		<div id="selectAll3" text="图形分析表"></div>
		<div id="selectAll4" text="领导查询"></div>
		<div id="selectAll5" text="血便分析"></div>
	</div>
	<div id="sep_top_2" type="separator"></div>
	<div id="design" text="系统设置">
		<div id="abouta" text="修改密码"></div>
	</div>
	<div id="sep_top_3" type="separator"></div>
	<div id="data" text="数据维护">
		<div id="aboutb" text="数据备份恢复"></div>
		<div id="needhelp1" text="系统初始化"></div>
	</div>
	<div id="sep_top_4" type="separator"></div>
	<div id="out" text="外出数据">
		<div id="aboutc" text="离线外出数据"></div>
	</div>
	<div id="sep_top_5" type="separator"></div>
	<div id="help" text="系统帮助">
		<div id="aboutd" text="平台注册"></div>
		<div id="needhelp2" text="关于"></div>
	</div>
</div>