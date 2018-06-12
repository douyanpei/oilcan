<%@page contentType="text/html; charset=UTF-8" import="java.lang.*" %>
<%@ page import="oilcan.model.User"%>
<%@ page import="util.Constants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires",0);
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)(request.getSession().getAttribute(Constants.SessionBundleName.user));
%>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type='text/javascript' src="dhx/dhtmlx.js"></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='js/common.js'></script>
<link rel="stylesheet" type="text/css" href="dhx/dhtmlx.css" />
