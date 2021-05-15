<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.live.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>
<%
	ProductDAO dao = new ProductDAO();
	List<ProductVO> list = dao.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="product_typeSvc" scope="page"
	class="com.product_type.model.Product_TypeService" />

<jsp:useBean id="liveSvc" scope="page"
	class="com.live.model.LiveService" />

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
					<i class="fa fa-dashboard"></i> 所有直播商品
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
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">直播間編號</th>
									<th scope="col">直播分類</th>
									<th scope="col">商品編號</th>
									<th scope="col">商品圖片</th>
									<th scope="col">商品名稱</th>
									<th scope="col">商品描述</th>
									<th scope="col">起標價</th>
									<th scope="col">數量</th>
									<th scope="col">賣家帳號</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="productVO" items="${list}" begin="0"
									end="${list.size()-1}">
									<c:if test="${productVO.product_state == 2}">
										<tr>
											<th scope="row">${productVO.live_no}</th>
											<td>${liveSvc.getOneLive(productVO.live_no).live_type}</td>
											<td>${productVO.product_no}</td>
											<td><img width="200px"
												src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}"
												class="rounded mx-auto d-block" alt=""></td>
											<td>${productVO.product_name}</td>
											<td class="productInfo">${productVO.product_info}</td>
											<td>${productVO.start_price}</td>
											<td>${productVO.product_remaining}</td>
											<td>${productVO.user_id}</td>
										</tr>
									</c:if>
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