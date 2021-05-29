<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.user.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<jsp:useBean id="orderSvc" scope="page"
	class="com.order.model.OrderService" />

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
<title>Mode Femme 直售賣家訂單</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-template/css/usermain.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
table td, table tr, table th {
	white-space: nowrap;
}

h3 {
	display: inline;
}

#change {
	diplay: inline;
	float: right;
}
</style>
</head>
<body class="app sidebar-mini rtl">

	<!-- Navbar_siderbar start-->
	<%@include file="/front-end/user/userSidebar.jsp"%>
	<!-- Navbar_siderbar finish-->

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-archive"></i>直售訂單管理
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">直售訂單管理</a></li>
			</ul>
		</div>

		<div class="col-xl-12">
			<div class="bs-component">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active show"
						data-toggle="tab" href="#unshipped">待出貨商品</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#shipped">已出貨商品</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#picked">已取貨商品</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade active show" id="unshipped">
						<div class="row">
							<div class="col-xl-12">
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/front-end/order/order.do"
									style="margin-bottom: 0px;">
									<div class="tile">
										<h3 class="tile-title">我的待出貨商品</h3>
										<div id="change">
											<input type="submit" class="btn btn-info" value="批次出貨">
											<input type="hidden" name="action" value="shipped">
										</div>
										<table class="table table-hover">
											<thead>
												<tr id="tr">
													<th scope="col"><input type="checkbox" id="AllCheck"></th>
													<th scope="col">#</th>
													<th scope="col">訂單日期</th>
													<th scope="col">訂單金額</th>
													<th scope="col">收件人姓名</th>
													<th scope="col">收件人地址</th>
													
													<th></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="orderVO"
													items="${orderSvc.getAllByID2(userVO.user_id)}">
													<c:if test="${orderVO.logisticsstate==0}">
														<tr>
															<td><input type="checkbox" name="order_no" value="${orderVO.order_no}"></td>
															<td><a href="${pageContext.request.contextPath}/front-end/order/order.do?action=listDetails_ByNo_B&order_no=${orderVO.order_no}">${orderVO.order_no}</a></td>
															<td><fmt:formatDate value="${orderVO.order_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>${orderVO.order_price}</td>
															<td>${orderVO.rec_name}</td>
															<td>${orderVO.zipcode}${orderVO.city}${orderVO.town}${orderVO.rec_addr}</td>
															<td></td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</FORM>
								<% if (request.getAttribute("listDetails_ByNo") != null) { %>
								<jsp:include page="listDetails_ByNo.jsp" />
								<% 	}  %>
							</div>
						</div>
					</div>


					<div class="tab-pane fade" id="shipped">
						<div class="row">
							<div class="col-xl-12">
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/front-end/order/order.do"
									style="margin-bottom: 0px;">
									<div class="tile">
										<h3 class="tile-title">我的已出貨商品</h3>
										<div id="change">
<!-- 											<input type="submit" class="btn btn-info" value="取消出貨"> -->
<!-- 											<input type="hidden" name="action" value="unshipped"> -->
										</div>
										<table class="table table-hover">
											<thead>
												<tr>
<!-- 													<th scope="col"><input type="checkbox" id="AllCheck"></th> -->
													<th scope="col">#</th>
													<th scope="col">訂單時間</th>
													<th scope="col">訂單金額</th>
													<th scope="col">物流方式</th>
													<th></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="orderVO"
													items="${orderSvc.getAllByID2(userVO.user_id)}">
													<c:if test="${orderVO.logisticsstate==1}">
														<tr>
<!-- 															<td><input type="checkbox" name="order_no" -->
<%-- 																value="${orderVO.order_no}"></td> --%>
															<td><a href="${pageContext.request.contextPath}/front-end/order/order.do?action=listDetails_ByNo_B&order_no=${orderVO.order_no}">${orderVO.order_no}</a></td>
															<td><fmt:formatDate value="${orderVO.order_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>${orderVO.order_price}</td>
															<td>${(orderVO.logistics==0)? '超商':'宅配'}</td>
															<td></td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</FORM>
							</div>
						</div>
					</div>
					
					<div class="tab-pane fade" id="picked">
						<div class="row">
							<div class="col-xl-12">
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/front-end/order/order.do"
									style="margin-bottom: 0px;">
									<div class="tile">
										<h3 class="tile-title">我的已取貨商品</h3>
										<table class="table table-hover">
											<thead>
												<tr>
													<th scope="col">#</th>
													<th scope="col">訂單時間</th>
													<th scope="col">訂單狀態</th>
													<th scope="col">訂單金額</th>
													<th scope="col">買家帳號</th>
													<th scope="col">買家評價</th>
													<th scope="col">評價內容</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="orderVO"
													items="${orderSvc.getAllByID2(userVO.user_id)}">
													<c:if test="${orderVO.logisticsstate==2}">
														<tr>
															<td><a href="${pageContext.request.contextPath}/front-end/order/order.do?action=listDetails_ByNo_B&order_no=${orderVO.order_no}">${orderVO.order_no}</a></td>
															<td><fmt:formatDate value="${orderVO.order_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>${(orderVO.order_state==0)? '未付款':'已付款'}</td>
															<td>${orderVO.order_price}</td>
															<td>${orderVO.user_id}</td>
															<td>
																<c:if test="${orderVO.srating == 1}">
														  <ion-icon name="star" class="star" id="st1" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st2" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st3" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st4" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st5" style="font-size: 15px;"></ion-icon>
														</c:if>
														<c:if test="${orderVO.srating == 2}">
														  <ion-icon name="star" class="star" id="st1" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st2" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st3" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st4" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st5" style="font-size: 15px;"></ion-icon>
														</c:if>
														<c:if test="${orderVO.srating == 3}">
														  <ion-icon name="star" class="star" id="st1" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st2" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st3" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st4" style="font-size: 15px;"></ion-icon>
														  <ion-icon name="star" class="star" id="st5" style="font-size: 15px;"></ion-icon>
														</c:if>
														<c:if test="${orderVO.srating == 4}">
														  <ion-icon name="star" class="star" id="st1" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st2" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st3" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st4" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st5" style="font-size: 15px;"></ion-icon>
														</c:if>
														<c:if test="${orderVO.srating == 5}">
														  <ion-icon name="star" class="star" id="st1" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st2" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st3" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st4" style="font-size: 15px; color:#f6d04d"></ion-icon>
														  <ion-icon name="star" class="star" id="st5" style="font-size: 15px; color:#f6d04d"></ion-icon>
														</c:if>
<%-- 															  <input type="hidden" name="srating" value="${orderVO.srating}" id="con2"/> --%>
<!-- 								                        	  <ion-icon name="star" class="star" id="st1" style="font-size: 15px;"></ion-icon> -->
<!-- 															  <ion-icon name="star" class="star" id="st2" style="font-size: 15px;"></ion-icon> -->
<!-- 															  <ion-icon name="star" class="star" id="st3" style="font-size: 15px;"></ion-icon> -->
<!-- 															  <ion-icon name="star" class="star" id="st4" style="font-size: 15px;"></ion-icon> -->
<!-- 															  <ion-icon name="star" class="star" id="st5" style="font-size: 15px;"></ion-icon> -->
															</td>
															<td>${orderVO.srating_content}</td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</FORM>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>




		<%
		if (request.getAttribute("listDetails_ByNo") != null) {
		%>
		<%
		}
		%>



	</main>
	<!-- Essential javascripts for application to work-->
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/main.js"></script>
	<!-- The javascript plugin to display page loading on top-->
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/plugins/pace.min.js"></script>
	<!-- Page specific javascripts-->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/back-template/docs/js/plugins/chart.js"></script>
	<script>
// 	switch($("#con2").val()){
//         		case "1":
//         			$("#st1").css("color","#f6d04d");
//         			break;
//         		case "2":
//         			$("#st1,#st2").css("color","#f6d04d");
//         			break;
//         		case "3":
//         			$("#st1,#st2,#st3").css("color","#f6d04d");
//         			break;
//         		case "4":
//         			$("#st1,#st2,#st3,#st4").css("color","#f6d04d");
//         			break;
//         		case "5":
//         			$("#st1,#st2,#st3,#st4,#st5").css("color","#f6d04d");
//         			break;
//         		default:
//         			$("#st1,#st2,#st3,#st4,#st5").css("color","black");
//         		}
	$(document).ready(function(){
		$("#AllCheck").change(function() {
			if ($("#AllCheck").is(":checked")) {
				$("input:checkbox").prop("checked", true);
			} else {
				$("input:checkbox").prop("checked", false);
			}
		});
	})
	</script>
	<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
</body>
</html>