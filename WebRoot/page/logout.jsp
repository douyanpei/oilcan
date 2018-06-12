<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="common.jsp"%>
<%
	request.getSession().invalidate();
	response.sendRedirect("page/login.jsp");
%>