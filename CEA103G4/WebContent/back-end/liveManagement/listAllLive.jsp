<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	LiveService liveSvc = new LiveService();
	List<LiveVO> list = liveSvc.getAll();
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
<title>所有員工資料</title>
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
					<i class="fa fa-dashboard"></i> 所有直播專案
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
			<div class="col-xl-12">
				<div class="tile">
					<div class="tile-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>直播編號</th>
									<th>直播分類</th>
									<th>直播名稱</th>
									<th>直播時間</th>
									<th>直播狀態</th>
									<th>直播使用者ID</th>
									<th>EMPNO</th>
									<th>直播預覽圖</th>
								</tr>

							</thead>

							<tbody>
								<%@ include file="page1.file"%>
								<c:forEach var="liveVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">
									<tr>
										<td>${liveVO.live_no}</td>
										<td>${liveVO.live_type}</td>
										<td>${liveVO.live_name}</td>

										<td><fmt:formatDate value="${liveVO.live_time}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>

										<td>${(liveVO.live_state==0)? '直播結束':''}
											${(liveVO.live_state==1)? '未直播':''} ${(liveVO.live_state==2)? '直播中':''}
										</td>
										<td>${liveVO.user_id}</td>
										<td>${liveVO.empno}</td>
										<td><img
											src="${pageContext.request.contextPath}/live/LiveGifReader.do?live_no=${liveVO.live_no}"
											width="200px"></td>


										<!-- 										<td> -->
										<!-- 											<FORM METHOD="post" -->
										<%-- 												ACTION="<%=request.getContextPath()%>/live/live.do" --%>
										<!-- 												style="margin-bottom: 0px;"> -->
										<!-- 												<input type="submit" value="修改"> <input -->
										<%-- 													type="hidden" name="live_no" value="${liveVO.live_no}"> --%>
										<!-- 												<input type="hidden" name="action" value="getOne_For_Update"> -->
										<!-- 											</FORM> -->
										<!-- 										</td> -->
										<!-- 										<td> -->
										<!-- 											<FORM METHOD="post" -->
										<%-- 												ACTION="<%=request.getContextPath()%>/live/live.do" --%>
										<!-- 												style="margin-bottom: 0px;"> -->
										<!-- 												<input type="submit" value="刪除"> <input -->
										<%-- 													type="hidden" name="live_no" value="${liveVO.live_no}"> --%>
										<!-- 												<input type="hidden" name="action" value="delete"> -->
										<!-- 											</FORM> -->
										<!-- 										</td> -->

									</tr>
								</c:forEach>

							</tbody>

						</table>
						<%@ include file="page2.file"%>
						<jsp:include page="/back-end/backendfooter.jsp" />
					</div>
				</div>
			</div>
		</div>
	</main>
</body>

</html>