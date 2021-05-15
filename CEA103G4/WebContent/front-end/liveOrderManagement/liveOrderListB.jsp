<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live_order.model.*"%>
<%@ page import="com.user.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<jsp:useBean id="live_orderSvc" scope="page"
	class="com.live_order.model.Live_orderService" />

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
<title>Mode Femme 直播賣家訂單</title>
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
					<i class="fa fa-archive"></i>我的販賣訂單
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">直播訂單管理</a></li>
			</ul>
		</div>


		<div class="col-xl-12">
			<div class="bs-component">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active show"
						data-toggle="tab" href="#1">已付款未出貨訂單</a></li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="tab" href="#2">已付款已出貨訂單</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#3">未付款訂單</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade active show" id="1">
						<div class="row">
							<div class="col-xl-12">
								<div class="tile">
									<h3 class="tile-title">已付款未出貨訂單</h3>
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>付款截止時間</th>
												<th>訂單狀態</th>
												<th>訂單金額</th>
												<th>訂單運費</th>
												<th>付款方式</th>
												<th>物流方式</th>
												<th>物流狀態</th>
												<th>選取帶入</th>
												<th></th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="live_orderVO"
												items="${live_orderSvc.getAllByID2(userVO.user_id)}">
												<c:if test="${live_orderVO.order_state ==1 && live_orderVO.logistics_state == 0}">
													<tr id="TR${live_orderVO.live_order_no}">
														<td>
															<FORM id="${live_orderVO.live_order_no}" METHOD="post"
																ACTION="<%=request.getContextPath()%>/live_order/live_order.do"
																style="margin-bottom: 0px;">
																<input type="hidden" name="live_order_no"
																	value="${live_orderVO.live_order_no}"> <input
																	type="hidden" name="action" value="listDetails_ByNo_B">
																<a href="#"
																	onclick="document.getElementById('${live_orderVO.live_order_no}').submit();">${live_orderVO.live_order_no}</a>


															</FORM>

														</td>
														<td><fmt:formatDate
																value="${live_orderVO.pay_deadline}"
																pattern="yyyy-MM-dd HH:mm:ss" /></td>
														<td>${(live_orderVO.order_state==0)? '未付款':''}
															${(live_orderVO.order_state==1)? '已付款':''}
															${(live_orderVO.order_state==2)? '棄單':''}</td>
														<td>${live_orderVO.order_price}</td>
														<td>${live_orderVO.order_shipping}</td>
														<td>${(live_orderVO.pay_method==0)? '錢包':''}
															${(live_orderVO.pay_method==1)? '信用卡':''}
															${(live_orderVO.pay_method==2)? '轉帳':''}</td>
														<td>${(live_orderVO.logistics==0)? '宅配':'超商'}</td>
														<td>${(live_orderVO.logistics_state==0)? '未出貨':''}
															${(live_orderVO.logistics_state==1)? '已出貨':''}
															${(live_orderVO.logistics_state==2)? '已取貨':''}</td>
														<td><input type="checkbox" id="CB${live_orderVO.live_order_no}"></td>
													</tr>
												</c:if>
											</c:forEach>


											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>

												<c:forEach var="live_orderVO"
													items="${live_orderSvc.getAllByID2(userVO.user_id)}">
													<c:if test="${live_orderVO.order_state ==1}">
														<td><FORM METHOD="post"
																ACTION="<%=request.getContextPath()%>/live_order/live_order.do"
																style="margin-bottom: 0px;">
																<input type="submit" class="btn btn-info" value="出貨">
																<input type="hidden" id="HB${live_orderVO.live_order_no}" name="live_order_no"
																	value="${live_orderVO.live_order_no}" disabled> <input
																	type="hidden" name="action" value="updateShipment">
															</FORM></td>
													</c:if>
												</c:forEach>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>
					
					
					
				
					<div class="tab-pane fade2" id="2">

						<div class="row">
							<div class="col-xl-12">
								<div class="tile">
									<h3 class="tile-title">已付款已出貨訂單</h3>
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>付款截止時間</th>
												<th>訂單狀態</th>
												<th>訂單金額</th>
												<th>訂單運費</th>
												<th>付款方式</th>
												<th>物流方式</th>
												<th>物流狀態</th>
												<th></th>
												<th></th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="live_orderVO"
												items="${live_orderSvc.getAllByID2(userVO.user_id)}">
												<c:if test="${live_orderVO.order_state ==1 && live_orderVO.logistics_state == 1}">

													<tr>
														<td>
															<FORM id="${live_orderVO.live_order_no}" METHOD="post"
																ACTION="<%=request.getContextPath()%>/live_order/live_order.do"
																style="margin-bottom: 0px;">
																<input type="hidden" name="live_order_no"
																	value="${live_orderVO.live_order_no}"> <input
																	type="hidden" name="action" value="listDetails_ByNo_B">
																<a href="#"
																	onclick="document.getElementById('${live_orderVO.live_order_no}').submit();">${live_orderVO.live_order_no}</a>
															</FORM>
														</td>
														<td><fmt:formatDate
																value="${live_orderVO.pay_deadline}"
																pattern="yyyy-MM-dd HH:mm:ss" /></td>
														<td>${(live_orderVO.order_state==0)? '未付款':''}
															${(live_orderVO.order_state==1)? '已付款':''}
															${(live_orderVO.order_state==2)? '棄單':''}</td>
														<td>${live_orderVO.order_price}</td>
														<td>${live_orderVO.order_shipping}</td>
														<td>${(live_orderVO.pay_method==0)? '錢包':''}
															${(live_orderVO.pay_method==1)? '信用卡':''}
															${(live_orderVO.pay_method==2)? '轉帳':''}</td>
														<td>${(live_orderVO.logistics==0)? '宅配':'超商'}</td>
														<td>${(live_orderVO.logistics_state==0)? '未出貨':''}
															${(live_orderVO.logistics_state==1)? '已出貨':''}
															${(live_orderVO.logistics_state==2)? '已取貨':''}</td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>

					<div class="tab-pane fade" id="3">

						<div class="row">
							<div class="col-xl-12">
								<div class="tile">
									<h3 class="tile-title">未付款訂單</h3>
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>付款截止時間</th>
												<th>訂單狀態</th>
												<th>訂單金額</th>
												<th>訂單運費</th>
												<th>付款方式</th>
												<th>物流方式</th>
												<th>物流狀態</th>
												<th></th>
												<th></th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="live_orderVO"
												items="${live_orderSvc.getAllByID2(userVO.user_id)}">
												<c:if test="${live_orderVO.order_state ==0}">

													<tr>
														<td>
															<FORM id="${live_orderVO.live_order_no}" METHOD="post"
																ACTION="<%=request.getContextPath()%>/live_order/live_order.do"
																style="margin-bottom: 0px;">
																<input type="hidden" name="live_order_no"
																	value="${live_orderVO.live_order_no}"> <input
																	type="hidden" name="action" value="listDetails_ByNo_B">
																<a href="#"
																	onclick="document.getElementById('${live_orderVO.live_order_no}').submit();">${live_orderVO.live_order_no}</a>
															</FORM>
														</td>
														<td><fmt:formatDate
																value="${live_orderVO.pay_deadline}"
																pattern="yyyy-MM-dd HH:mm:ss" /></td>
														<td>${(live_orderVO.order_state==0)? '未付款':''}
															${(live_orderVO.order_state==1)? '已付款':''}
															${(live_orderVO.order_state==2)? '棄單':''}</td>
														<td>${live_orderVO.order_price}</td>
														<td>${live_orderVO.order_shipping}</td>
														<td>${(live_orderVO.pay_method==0)? '錢包':''}
															${(live_orderVO.pay_method==1)? '信用卡':''}
															${(live_orderVO.pay_method==2)? '轉帳':''}</td>
														<td>${(live_orderVO.logistics==0)? '宅配':'超商'}</td>
														<td>${(live_orderVO.logistics_state==0)? '未出貨':''}
															${(live_orderVO.logistics_state==1)? '已出貨':''}
															${(live_orderVO.logistics_state==2)? '已取貨':''}</td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>

		<%
			if (request.getAttribute("listDetails_ByNo") != null) {
		%>
		<jsp:include page="listDetails_ByNo.jsp" />
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
<c:forEach var="live_orderVO" items="${live_orderSvc.getAllByID2(userVO.user_id)}">
	<c:if test="${live_orderVO.order_state ==1}">
		
		$("#TR${live_orderVO.live_order_no}" ).click(function(e){
			var checkBoxes = $("#CB${live_orderVO.live_order_no}");
			checkBoxes.prop("checked", !checkBoxes.prop("checked"));
			var isChecked = $("#CB${live_orderVO.live_order_no}" ).is(":checked");
			if(isChecked){
				$("#HB${live_orderVO.live_order_no}").prop('disabled', false);
			}else{
				$("#HB${live_orderVO.live_order_no}").prop('disabled', true);
			}
		});
	</c:if>
</c:forEach>
</script>
</body>
</html>