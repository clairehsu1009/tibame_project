<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>
<%
	UserVO userVO = (UserVO) request.getAttribute("userVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員檢舉</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
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
</head>
<body bgcolor='white' class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-wrench"></i> 會員檢舉管理
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
							<h2 class="text-dark h2">更改會員狀態</h2>
						</div>
						<div class="row">
							<div class="col-md-12">
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
										ACTION="<%=request.getContextPath()%>/front-end/user/user.do"
										name="form1">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label><i class="fas fa-user-alt"></i>會員帳號:<font
														color=red style="font-size: 120%">${userVO.user_id}</font></label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label><i class="fas fa-user-alt"></i>會員姓名:<font
														 style="font-size: 120%">${userVO.user_name}</font></label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label><i class="fas fa-user-alt"></i>會員狀態: &emsp;
														<font color=red><b>*</b></font></label> 
														<select class="form-control" size="1" name="user_state">
														<option value="1" ${(userVO.user_state==1)? 'selected':''}>正常</option>
														<option value="0" ${(userVO.user_state==0)? 'selected':''}>停權</option>
													</select>
												</div>
											</div>
										</div>
											<br> <input type="hidden" name="action" value="update_user_report">
											<input type="hidden" name="user_id" value="${userVO.user_id}">
											<input class="btn btn-primary" type="submit" id="submit" value="送出新增">
										</FORM>													
									</div>
								</div>
						     </div>
						 </div>
					</div>
				</div>
			   </div>
			</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>
</html>
	
										