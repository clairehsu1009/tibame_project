<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<jsp:useBean id="authSvc" scope="page"
	class="com.auth.model.AuthService" />
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
<title>員工${empVO.empno} :${empVO.ename}</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.table {
	overflow-x: auto;
}
</style>
</head>


<body class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-dashboard"></i> 員工基本資料
				</h1>

			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="tile">
					<div class="tile-body">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>員工編號:
										${empVO.empno}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>員工姓名:
										${empVO.ename}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>職位: ${empVO.job}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>身分證字號:
										${empVO.id}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>性別: <c:choose>
											<c:when test="${empVO.gender==0}">
												<td>女</td>
											</c:when>
											<c:when test="${empVO.gender==1}">
												<td>男</td>
											</c:when>
										</c:choose> </label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>生日: ${empVO.dob}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>地址:
										${empVO.city}${empVO.dist}${empVO.addr}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>E-mail:
										${empVO.email}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>薪水: ${empVO.sal}</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>狀態: <c:choose>
											<c:when test="${empVO.state==0}">
												<td class="table-danger">離職</td>
											</c:when>
											<c:when test="${empVO.state==1}">
												<td class="table-danger">在職</td>
											</c:when>
										</c:choose></label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label><i class="fas fa-user-alt"></i>到職日期:
										${empVO.hiredate}</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label><i class="fas fa-user-alt"></i>權限:</label>
										<div class="form-group">
											<ul>
												<c:forEach var="authVO"
													items="<%=authSvc.getAuthNOs(empVO.getEmpno())%>">
													<li><input class="col-md-6" name="funno"
														value="${authVO.funno}" type="hidden">${funSvc.getOneFun(authVO.funno).funName}&emsp;：
														<label> <c:choose>
																<c:when test="${authVO.auth_no==0}">
																	<td class="table-danger">無權限</td>
																</c:when>
																<c:when test="${authVO.auth_no==1}">
																	<td class="table-danger">正常</td>
																</c:when>
															</c:choose>

													</label></li>
												</c:forEach>
											</ul>
										</div>
									</div>
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