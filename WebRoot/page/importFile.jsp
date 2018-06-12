<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3. org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires",0);
	String contextPath = request.getContextPath();
	String returnText = (String)request.getAttribute("returnText");
%>
<base target="_self"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预约名单导入</title> 
	<style>
		.cnt{
		    border:1px solid #7AA5DE;
		    width:400px;
		    margin-top:10px;
		    padding:10px 50px;
			background-color: #ddecff;
			MARGIN-RIGHT: auto;
			MARGIN-LEFT: auto; 
			font-size : 14px;
			display: inline-block;
		}
	</style>    
	<script type="text/javascript">

	//判断上传的文件是否是sql文件
	function isSql(name){
		var sArray = new Array();
		sArray = name.split(".");
		if(sArray[sArray.length-1] != "sql"){
			alert("选择的不是sql文档，请重新选择文件。");
			return false;
		} else {	
			return true;
		}
	}
	
	function verify(){
		var filePath = document.getElementById("file").value;
		if(filePath.length > 0){
			fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
			if(isSql(fileName))
				return true;
		}else
			alert("请选择上传文件");	
		return false;
	}
	
	function _submit(){
		var form1 = document.getElementById("form1");
		if(verify()) 
			form1.submit(); 
		else
			return false;
	}
	</script>
</head>
<body style="text-align:center">  
<h4>预约名单导入</h4>
<hr/>  
<form id="form1" action="<%=contextPath %>/servlet/UploadSqlServlet" method="post" enctype="multipart/form-data">   
	<input type="hidden" name="returnPath" value="/page/importFile.jsp"/>
	<div align="center" class="cnt">
		<table width="440px" style="margin-top:10px" align="center" cellpadding="0" cellspacing="0">
			<tr align="left">
				<td colspan="2" style="color: red"><%if(returnText !=null ){out.print(returnText);} %></td>
			</tr>
			<tr align="left" height="10">
				<td width="35%" style="text-align: left">选择要导入的预约名单：</td>
				<td width="65%" style="text-align: left"><input type="file" id="file" name="file" style="width: 250px"></td>
			</tr>
		</table>
		<br>
		<table width="350px" border="0" align="center" cellpadding="0" cellspacing="0">
	  		<tr>
	    		<td align="right">
	      			<a href="#" onclick="_submit()"><span class="icon-upload" >开始上传</span></a>
	      		</td>
	  		</tr>
		</table>
	</div>
</form>  
</body>  
</html>