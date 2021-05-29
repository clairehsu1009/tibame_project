<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.user.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
  UserVO userVO = (UserVO) request.getAttribute("userVO"); //UserServlet.java(Controller), 存入req的userVO物件
%>

<html>
<head>

 <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
  <!-- Twitter meta-->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:site" content="@pratikborsadiya">
  <meta property="twitter:creator" content="@pratikborsadiya">
  <!-- Open Graph Meta-->
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Vali Admin">
  <meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
  <meta property="og:url" content="http://pratikborsadiya.in/blog/vali-admin">
  <meta property="og:image" content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
  <meta property="og:description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>更改密碼</title>
  <link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
  
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-template/css/usermain.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
label.col-sm-2.col-form-label {
    color: black;
}
button.btn.btn-info {
margin-left: 15px;
}
.app-title {
margin: -30px -30px 0px;
}
</style>

</head>
<body class="app sidebar-mini rtl">
<body bgcolor='white' class="app sidebar-mini rtl">
<jsp:include page="/front-end/user/userSidebar.jsp" />
<main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-edit"></i> 更改密碼</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i class="fa fa-home fa-lg"></i></a></li>
                    <li class="breadcrumb-item">更改密碼</li>
                  </ul>
                </div>
<div class="row">
	<div class="col-md-12 productsAdd">
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/UpdateUserPwdServlet">
		<div class="form-group">
			<label for="user_pwd" class="col-sm-2 col-form-label">現在的密碼</label>
			<div class="col-sm-10">
				<input class="form-control" id="user_pwd" name="user_pwd"
					type="password" placeholder="請輸入舊密碼"
					value="<%=(userVO == null) ? "" : userVO.getUser_pwd()%>"
					required><font color=red><b>${errorMsgs.user_pwd}</b>
			</div>
		</div>
		<div class="form-group">
			<label for="user_newName" class="col-sm-2 col-form-label">新密碼</label>
			<div class="col-sm-10">
				<input class="form-control" id="user_newName" name="user_newName"
					type="password" placeholder="請輸入新密碼"
					value="" required><font color=red><b>${errorMsgs.user_newName}</b>
			</div>
		</div>
		<div class="form-group">
			<label for="user_newNameCheck" class="col-sm-2 col-form-label">確認新密碼</label>
			<div class="col-sm-10">
				<input class="form-control" id="user_newNameCheck" name="user_newNameCheck"
					type="password" placeholder="請再次輸入新密碼"
					value="" required><font color=red><b>${errorMsgs.user_newNameCheck}</b>
			</div>
		</div>
	<button type="submit" class="btn btn-info" id="demoSwal">確認更改</button>
	<input type="hidden" name="user_id" value="${userVO.user_id} ">
	<input type="hidden" name="action"	value="updateUserPwd">       
</FORM>
</div>
</div>
 <!-- Essential javascripts for application to work-->
    <script src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/back-template/docs/js/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/back-template/docs/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/back-template/docs/js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
<script type="text/javascript" src="<%=request.getContextPath()%>/back-template/docs/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/back-template/docs/js/plugins/sweetalert.min.js"></script>

<!-- Google analytics script-->
    <script type="text/javascript">
      if(document.location.hostname == 'pratikborsadiya.in') {
      	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      	ga('create', 'UA-72504830-1', 'auto');
      	ga('send', 'pageview');
      }
    </script>
</body>
</html>