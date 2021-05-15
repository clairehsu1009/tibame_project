<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.fun.model.*"%>

<%
	AuthVO authVO = (AuthVO) request.getAttribute("authVO");
%>


<jsp:useBean id="funSvc" scope="page" class="com.fun.model.FunService" />


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>員工權限資料修改</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />

</head>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
</head>
<body bgcolor='white' class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-wrench"></i> 權限管理
				</h1>

			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>
		<div class="main-container">
			<div class="pd-ltr-20 xs-pd-20-10">
				<div class="min-height-200px">
					<div class="pd-20 card-box mb-30">
						<div class="clearfix">
							<h2 class="text-dark h2">更改權限資料</h2>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="tile">
									<h3 class="tile-title">資料修改:</h3>
									<div class="tile-body">
										<%-- 錯誤表列 --%>
										<c:if test="${not empty errorMsgs}">
											<font style="color: red">請修正以下錯誤:</font>
											<ul>
												<c:forEach var="message" items="${errorMsgs}">
													<li style="color: red">${message}</li>
												</c:forEach>
											</ul>
										</c:if>

										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/auth/auth.do"
											name="form1">
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>員工編號:<font
															color=red style="font-size: 120%"><%=authVO.getEmpno()%></font></label>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>功能名稱 : &emsp; <input name="funno"
																value="<%=authVO.getFunno()%>" type="hidden"> ${funSvc.getOneFun(authVO.funno).funName}<font
															color=red><b>*</b></font></label>
														
															
																<select class="form-control" size="1" name="auth_no">
																	<option value="1" ${(authVO.auth_no==1)? 'selected':''}>開</option>
																	<option value="0" ${(authVO.auth_no==0)? 'selected':''}>關</option>
															</select>
														
													</div>
												</div>
											</div>

											<br> <input type="hidden" name="action" value="update">
											<input type="hidden" name="empno" value="${authVO.empno}">
											<input type="hidden" name="funno" value="${authVO.funno}">
											<input type="hidden" name="auth_no" value="${authVO.auth_no}">
											<input type="hidden" name="requestURL"
												value="<%=request.getParameter("requestURL")%>"> <input
												type="hidden" name="whichPage"
												value="<%=request.getParameter("whichPage")%>"> <input
												class="btn btn-primary" type="submit" id="submit" value="送出新增">
										</FORM>
																								
									</div>
								</div>
						     </div>
						 </div>
					</div>
				</div>
			   </div>
			</div>
	

<script>
	/* 	let sub = document.getElementById("submit");
	 sub.addEventListener(type, callback, capture)

	 sub.addEventListener("onclick", function(){
	 let chx = document.getElementsByName("auth_no");
	 for(let i = 0; i < chx.length; i++){
	 let checkbox = chx[i];
	 checkbox.checked = true;
	 }
	 },false); */
</script>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>
</html>