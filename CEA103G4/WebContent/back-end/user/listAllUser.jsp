<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.user.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	UserService userSvc = new UserService();
	List<UserVO> list = userSvc.getAll();
	pageContext.setAttribute("list", list);
%>


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
<title>所有會員資料</title>
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
					<i class="fa fa-dashboard"></i> 會員管理
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
									<th class="sorting_asc">帳號</th>
									<!-- 		<th>密碼</th> -->
									<th>姓名</th>
									<!-- 		<th>身分証字號</th> -->
									<!-- 		<th>性別</th> -->
									<!-- 		<th>生日</th> -->
									<!-- 		<th>Email</th> -->
									<!-- 		<th>電話</th> -->
									<!-- 		<th>手機號碼</th> -->
									<!-- 		<th>地址</th> -->
									<th>註冊日期</th>
									<!-- 		<th>點數</th> -->
									<th>違約次數</th>
									<th>狀態</th>
									<!-- 		<th>賣家評價</th> -->
									<!-- 		<th>評價人數</th> -->
									<!-- 		<th>錢包</th> -->
									<th>修改會員狀態</th>
									<!-- 		<th>刪除</th> -->
<!-- 									<th>曾經檢舉過的直播</th> -->
								</tr>
							</thead>
							<tbody>
								<%@ include file="page1.file"%>
								<c:forEach var="userVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">

									<tr>
										<td>${userVO.user_id}</td>
										<%-- 			<td>${userVO.user_pwd}</td> --%>
										<td>${userVO.user_name}</td>
										<%-- 			<td>${userVO.id_card}</td> --%>
										<!-- 			<td>			 -->
										<%-- 			${(userVO.user_gender=='1')? '男':''} --%>
										<%-- 			${(userVO.user_gender=='0')? '女':''} --%>
										<!-- 			</td> -->
										<%-- 			<td><fmt:formatDate value="${userVO.user_dob}" pattern="yyyy-MM-dd"/></td> --%>
										<%-- 		                       <td>${userVO.user_dob}</td> --%>
										<%-- 			<td>${userVO.user_mail}</td> --%>
										<%-- 			<td>${userVO.user_phone}</td> --%>
										<%-- 			<td>${userVO.user_mobile}</td>  --%>
										<%-- 			<td>${userVO.user_addr}</td> --%>
										<%-- 			<td>${userVO.zipcode}${userVO.city}${userVO.town}${userVO.user_addr}</td> --%>
										<td><fmt:formatDate value="${userVO.regdate}"
												pattern="yyyy-MM-dd" /></td>
										<%-- 			<td>${userVO.user_point}</td> --%>
										<td>${userVO.violation}</td>
										<td>${(userVO.user_state==0)? '停權':''}
											${(userVO.user_state==1)? '正常':''}</td>
										<%-- 			<td>${userVO.user_comment}</td> --%>
										<%-- 			<td>${userVO.comment_total}</td> --%>
										<%-- 			<td>${userVO.cash}</td> --%>
										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/front-end/user/user.do"
												style="margin-bottom: 0px;">
												<input class="btn btn-danger" type="submit" value="修改">
												<input type="hidden" name="user_id"
													value="${userVO.user_id}"> <input type="hidden"
													name="action" value="getOne_For_Update2">
											</FORM>
										</td>
										<!-- 			<td> -->
										<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/user/user.do" style="margin-bottom: 0px;"> --%>
										<!-- 			     <input type="submit" value="刪除"> -->
										<%-- 			     <input type="hidden" name="user_id"  value="${userVO.user_id}"> --%>
										<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
										<!-- 			</td> -->
<!-- 										<td> -->
<!-- 											<FORM METHOD="post" -->
<%-- 												ACTION="<%=request.getContextPath()%>/front-end/user/user.do" --%>
<!-- 												style="margin-bottom: 0px;"> -->
<!-- 												<input class="btn btn-warning" type="submit" value="送出查詢"> -->
<%-- 												<input type="hidden" name="user_id" value="${userVO.user_id}">  --%>
<!-- 											</FORM> -->
<!-- 										</td> -->
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="page2.file"%>
		<%
// 			if (request.getAttribute("listLive_report_ByUser_id") != null) {
		%>
<%-- 		<jsp:include page="listLive_report_ByUser_id.jsp" /> --%>
		<%
// 			}
		%>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>
</html>