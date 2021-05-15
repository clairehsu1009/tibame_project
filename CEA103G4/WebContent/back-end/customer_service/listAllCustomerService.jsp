<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.customer_service.model.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.user.model.*"%>

<%
	CustomerSerService authSvc = new CustomerSerService();
	List<CustomerSerVO> list = authSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<%
	CustomerSerVO customerSerVO = (CustomerSerVO) request.getAttribute("customerSerVO");
	EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	UserVO userVO = (UserVO) request.getAttribute("userVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
<jsp:useBean id="cusSvc" scope="page" class="com.customer_service.model.CustomerSerService" />
<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta name="description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<!-- Twitter meta-->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:site" content="@pratikborsadiya">
<meta property="twitter:creator" content="@pratikborsadiya">
<!-- Open Graph Meta-->
<meta property="og:type" content="website">
<meta property="og:site_name" content="Vali Admin">
<meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
<meta property="og:url"
	content="http://pratikborsadiya.in/blog/vali-admin">
<meta property="og:image"
	content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
<meta property="og:description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<title>所有員工資料</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-group"></i> 所有Cus
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<div class="row">
			<div class="col-md-12">
				<div class="tile">
					<div class="tile-body">
						<table class="table table-hover" id="sampleTable"
							style="font-size: 120%">
							<thead>
								<tr role="row" class="table-info">
									<th class="sorting_asc">客戶訊息編號</th>
									<th>會員帳號</th>
									<th>訊息狀態</th>
									<th>聊天內容</th>
									<th>員工編號</th>
									<th>客服訊息回覆</th>
									<th>訊息時間</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="sorting_1"><%customerSerVO.getCaseno();%></td>
									<td class="table-danger">${userVO.userId}</td>
									<td class="table-warning">${cusVO.case_state}</td>
									<td>${customerSerVO.content}</td>
									<td>${empVO.empno}</td>
									<td>${customerSerVO.emp_response}</td>
									<td>${customerSerVO.case_time}</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>


	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>

</html>