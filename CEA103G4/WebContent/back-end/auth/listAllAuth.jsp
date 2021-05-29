<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.auth.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	AuthService authSvc = new AuthService();
	List<AuthVO> list = authSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<%
	AuthVO authVO = (AuthVO) request.getAttribute("authVO");
%>
<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
<jsp:useBean id="funSvc" scope="page" class="com.fun.model.FunService" />
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
<title>所有權限資料</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
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
					<i class="fa fa-server"></i> 所有權限
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

						<table class="col-md-12" id="sampleTable" style="font-size: 120%">
							<thead>
								<tr  role="row" class="table-info" ${(authVO.empno==param.auth_no) ? 'bgcolor=#CCCCFF':''}>
									<th>員工編號</th>
									<th>員工姓名</th>
<!-- 									<th>功能編號</th> -->
									<th class="sorting_asc">功能名稱</th>
									<th>狀態</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
<%-- 								<%@ include file="page1.file"%> --%>
<%-- 								<c:forEach var="authVO" items="${list}" begin="<%=pageIndex%>" --%>
<%-- 									end="<%=pageIndex+rowsPerPage-1%>"> --%>
									<tr ${(authVO.empno==param.empno) ? 'bgcolor=#CCCCFF':''}>
										<td>${authVO.empno}</td>
										<td>${empSvc.getOneEmp(authVO.empno).ename}</td>
<%-- 										<td>${authVO.funno}</td> --%>
										<td>${funSvc.getOneFun(authVO.funno).funName}</td>
										<!-- 											<td><select class="form-control" size="1" name="auth_no"> -->
										<%-- 													<option value="1" ${(authVO.auth_no==1)? 'selected':''}>正常</option> --%>
										<%-- 													<option value="0" ${(authVO.auth_no==0)? 'selected':''}>無權限</option> --%>
										<!-- 											</select></td> -->
									
										<c:choose>
											<c:when test="${authVO.auth_no==0}">
												<td>無權限</td>
											</c:when>
											<c:when test="${authVO.auth_no==1}">
												<td>正常</td>
											</c:when>
										</c:choose>

<!-- 										<td> -->
<!-- 											<FORM METHOD="post" -->
<%-- 												ACTION="<%=request.getContextPath()%>/auth/auth.do" --%>
<!-- 												style="margin-bottom: 0px;"> -->
<!-- 												<input class="btn btn-primary" type="submit" value="修改"> -->
<%-- 												<input type="hidden" name="empno" value="${authVO.empno}"> --%>
<%-- 												<input type="hidden" name="funno" value="${authVO.funno}"> --%>
<%-- 												<input type="hidden" name="auth_no" value="${authVO.auth_no}">  --%>
<%-- 												<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<!-- 												送出本網頁的路徑給Controller -->
<%-- 												<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 												<input type="hidden" name="action" value="getOne_For_Update"> -->

<!-- 											</FORM> -->
<!-- 										</td> -->
<!-- 										<td> -->
<!-- 											<FORM METHOD="post" -->
<%-- 												ACTION="<%=request.getContextPath()%>/auth/auth.do" --%>
<!-- 												style="margin-bottom: 0px;"> -->
<!-- 												<input class="btn btn-warning" type="submit" value="刪除"> -->
<!-- 												<input type="hidden" name="requestURL" -->
<%-- 													value="<%=request.getServletPath()%>"> --%>
<!-- 												送出本網頁的路徑給Controller -->
<%-- 												<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<%-- 												<input type="hidden" name="funno" value="${authVO.funno}"> --%>
<%-- 												<input type="hidden" name="empno" value="${authVO.empno}"> --%>
<!-- 												<input type="hidden" name="action" value="delete"> -->
<!-- 											</FORM> -->
<!-- 										</td> -->
									</tr>
<%-- 								</c:forEach> --%>
							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
<%-- 		<%@ include file="page2.file"%> --%>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>

</html>