<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.user.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
  UserVO userVO = (UserVO) request.getAttribute("userVO"); //UserServlet.java(Controller), 存入req的userVO物件
%>

<html>
<head>
<title>會員個人資料</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
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
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-template/css/usermain.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
th {
padding: 15px;
}
button.btn.btn-info {
margin-left: 15px;
}
.app-title {
margin: -30px -30px 0px;
}
.table th, .table td {
/* 	border: 1px solid #dee2e6 !important; */
	border:none !important;
	text-align:center;
}
.oneUser  {
    justify-content: center;

}
.oneUser table {
	width:50%;
    box-shadow: 1px 1px 10px rgb(0 0 0 / 10%);
    border-radius: 10px;
}

@media (max-width: 576px) {

.oneUser table {
	width:95%;
}

}

@media (max-width: 480px)
.app-content {
    padding: 15px;
    overflow-x: hidden;
}


</style>

</head>
<body class="app sidebar-mini rtl">
<body bgcolor='white' class="app sidebar-mini rtl">
<jsp:include page="/front-end/user/userSidebar.jsp" />
<main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-user fa-lg"></i> 我的基本資料</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i class="fa fa-home fa-lg"></i></a></li>
                    <li class="breadcrumb-item">我的基本資料</li>
                  </ul>
                </div>
          <div class="row oneUser" style="margin-top:15px;">

<table class="table">
	<tr>
		<th>帳號</th>
		<td><%=userVO.getUser_id()%></td>
<!-- 		<th>密碼</th> -->
	</tr>
	<tr>
		<th>姓名</th>
		<td><%=userVO.getUser_name()%></td>
	</tr>	
	<tr>
		<th>身分證字號</th>
		<td><%=userVO.getId_card()%></td>
	</tr>	
	<tr>
		<th>性別</th>
		<td>${(userVO.user_gender==0)? '女':''}${(userVO.user_gender==1)? '男':''}</td>
	</tr>	
	<tr>
		<th>生日</th>
		<td><%=userVO.getUser_dob()%></td>
	</tr>	
	<tr>
		<th>Email</th>
		<td><%=userVO.getUser_mail()%></td>
	</tr>	
	<tr>
		<th>電話</th>
		<td><%=userVO.getUser_phone()%></td>
	</tr>	
	<tr>
		<th>手機號碼</th>
		<td><%=userVO.getUser_mobile()%></td>
	</tr>	
	<tr>
		<th>地址</th>
		<td>${userVO.city}${userVO.town}${userVO.zipcode}${userVO.user_addr}</td>
	</tr>	
	<tr>
		<th>個人照</th>
		<td><img width="100px" height="100px" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=<%=userVO.getUser_id()%>"></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<th>狀態</th> -->
<%-- 		<td>${(userVO.user_state==0)? '停權':''}${(userVO.user_state==1)? '正常':''}</td> --%>
<!-- 	</tr>	 -->
<!-- 	<tr> -->
<!-- 		<th>評價人數</th> -->
<%-- 		<td><%=userVO.getComment_total()%></td> --%>
<!-- 	</tr>	 -->

<!-- 		<th>縣市</th> -->
<!-- 		<th>鄉鎮</th> -->
<!-- 		<th>郵遞區號</th> -->
<!-- 		<th>註冊日期</th> -->
<!-- 		<th>點數</th> -->
<!-- 		<th>違約次數</th> -->
<!-- 		<th>賣家評價</th> -->
<!-- 		<th>錢包</th> -->
<%-- 		<td><%=userVO.getUser_pwd()%></td> --%>
<%-- 		<td><%=userVO.getUser_gender()%></td> --%>
<%-- 		<td><%=userVO.getCity()%></td> --%>
<%-- 		<td><%=userVO.getTown()%></td> --%>
<%-- 		<td><%=userVO.getZipcode()%></td> --%>
<%-- 		<td><%=userVO.getUser_addr()%></td> --%>
<%-- 		<td><%=userVO.getRegdate()%></td> --%>
<%-- 		<td><%=userVO.getUser_point()%></td> --%>
<%-- 		<td><%=userVO.getViolation()%></td> --%>
<%-- 		<td><%=userVO.getUser_state()%></td> --%>
<%-- 		<td><%=userVO.getUser_comment()%></td> --%>
<%-- 		<td><%=userVO.getCash()%></td> --%>
</table>
</div>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/user/user.do" style="text-align: center;">
	<button type="submit" class="btn btn-info">修改我的資料</button>
	<input type="hidden" name="user_id"  value="${userVO.user_id}">
	<input type="hidden" name="action"	value="getOne_For_Update">       
</FORM>

<jsp:include page="/front-end/protected/userIndex_footer.jsp" />

</body>
</html>