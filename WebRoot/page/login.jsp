<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html; charset=UTF-8" %>
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link href="../css/login.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../js/common.js'></script>
<script type='text/javascript' src='../dwr/interface/lgnsvc.js'></script>
<script type="text/javascript">
function check() {
	if (Trim(document.loginForm.userName.value) == "") {
		alert("请输入用户名");
		document.loginForm.userName.focus();
		return false;
	}

	if (Trim(document.loginForm.passWord.value) == "") {
		alert("请输入密码");
		document.formLogin.passWord.focus();
		return false;
	}
	return true;
}

function login() {
	if (check()) {
		var userName = document.loginForm.userName.value;
		var passWord = document.loginForm.passWord.value;
		var result;
		var message;
		function callBack(data) {
			result = data.result;
			message = data.message;
			if (result == 1) {
				window.location.href = "<%=contextPath%>/page/main.jsp";
			} else {
				alert(message);
			}
			return true;
		}
		lgnsvc.login(userName, passWord, callBack);
	}
	return false;
}

function enterUserName(){
	var userName = document.loginForm.userName.value;
	if(userName.indexOf("请输入账号")>-1)
		document.loginForm.userName.value=userName.replace("请输入账号","");
}
</script>
</head>
<body>
	<div class="header"></div>
	<div class="banner">
		<div class="login-aside">
	  		<div id="o-box-up"></div>
		  	<div id="o-box-down" >
			   	<form name="loginForm" method="post" onsubmit="return login()">
			   		<div class="fm-item">
				   		<label for="logonId" class="form-label">登陆帐号：</label>
				   		<input type="text" name="userName" value="admin" maxlength="100" class="i-text" onkeydown="enterUserName()"/>    
			       		<div class="ui-form-explain"></div>
			  		</div>
			  
				  	<div class="fm-item">
					   <label for="logonId" class="form-label">登陆密码：</label>
					   <input type="password" name="passWord" value="88888"  maxlength="100" class="i-text" >    
				       <div class="ui-form-explain"></div>
				 	</div>
			  		<div class="fm-item pos-r"><br />
			  		</div>
				  	<div class="fm-item">
				   		<label for="logonId" class="form-label"></label>
				   		<input type="submit" value="" tabindex="4"  class="btn-login" style="cursor: pointer"> 
				      	<div class="ui-form-explain"></div>
				 	</div>
			  </form>
		  </div>
		</div>
		<div class="bd">
			<ul>
				<li style="background:url(../images/login/bg.jpg) #CCE1F3 center 0 no-repeat;"></li>
		  	</ul>
	  	</div>
	  	<div class="hd"><ul></ul></div>
	</div>
	<div class="banner-shadow"></div>
	<div class="footer">
   		<p>Copyright &copy; 2015.Company name All rights reserved.</p>
	</div>
	
</body>
</html>