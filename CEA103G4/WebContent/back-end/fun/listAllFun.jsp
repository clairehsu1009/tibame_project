<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.fun.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>
<%
	FunVO funVO = (FunVO) request.getAttribute("funVO"); 
%>
<%
	FunService funSvc = new FunService();
	List<FunVO> list = funSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes">
<html>
<head>
<title>後台權限管理</title>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body bgcolor='white' class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-dashboard"></i> 權限管理
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
						<table class="col-md-12" id="sampleTable">
							<thead>
								<tr role="row" class="table-info">
									<th>網站功能編號</th>
									<th>功能名稱</th>
									<th>權限查詢</th>
									<!-- 								<th>修改</th> -->
									<!-- 			<th>刪除</th> -->
								</tr>
							</thead>
							<tbody>
								<%-- 		<%@ include file="page1.file"%> --%>
								<c:forEach var="funVO" items="${list}">

									<tr>
										<td>${funVO.funno}</td>
										<td>${funVO.funName}</td>
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${funVO.state==0}"> --%>
<!-- 												<td>關閉</td> -->
<%-- 											</c:when> --%>
<%-- 											<c:when test="${funVO.state==1}"> --%>
<!-- 												<td>正常</td> -->
<%-- 											</c:when> --%>
<%-- 										</c:choose> --%>
										<!-- 				<td><select size="1" name="state"> -->
										<%-- 						<option value="1" ${(funVO.state==0)? 'selected':''}>開啟</option> --%>
										<%-- 						<option value="0" ${(funVO.state==0)? 'selected':''}>關閉</option> --%>
										<!-- 				</select></td> -->

										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/fun/fun.do"
												style="margin-bottom: 0px;">
												<input class="btn btn-primary" type="submit" value="查詢"> <input
													type="hidden" name="funno" value="${funVO.funno}">
												<input type="hidden" name="action" value="getOne_For_Update">
										</FORM>
										</td>

									</tr>
								</c:forEach>
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