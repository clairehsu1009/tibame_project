<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live.model.*"%>
<%@ page import="com.user.model.*"%>
<%@ page import="com.product.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
	ProductDAO dao = new ProductDAO();
	List<ProductVO> list = dao.getAll();
	pageContext.setAttribute("list", list);
%>

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
<title>Mode Femme 我的直播專案</title>
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
					<i class="fa fa-archive"></i>我的直播專案
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">直播專案管理</a></li>
			</ul>
		</div>



		<div class="row">
			<div class="col-xl-12">
				<div class="tile">
					<h3 class="tile-title">我的直播專案</h3>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>直播編號</th>
								<th>直播分類</th>
								<th>直播名稱</th>
								<th>直播時間</th>
								<th>直播狀態</th>
								<th>直播預覽圖</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="liveVO"
								items="${liveSvc.getAllByID(userVO.user_id)}">
								<c:if test="${liveVO.live_state >0}">

									<tr>
										<td><a href="<%=request.getContextPath()%>/live/live.do?live_no=${liveVO.live_no}" target="_blank">${liveVO.live_no}</a></td>
										<td>${liveVO.live_type}</td>
										<td>${liveVO.live_name}</td>

										<td><fmt:formatDate value="${liveVO.live_time}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>

										<td>${(liveVO.live_state==0)? '已結束':''}
											${(liveVO.live_state==1)? '未直播':''} ${(liveVO.live_state==2)? '直播中':''}
										</td>
										<td><img
											src="${pageContext.request.contextPath}/live/LiveGifReader.do?live_no=${liveVO.live_no}"
											width="190px"></td>

										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/live/live.do"
												style="margin-bottom: 0px;">
												<input type="submit" value="修改" class="btn btn-info">
												<input type="hidden" name="live_no"
													value="${liveVO.live_no}"> <input type=hidden
													name="action" value="getOne_For_Update">
											</FORM>
										</td>
										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/live/live.do"
												style="margin-bottom: 0px;">
												<input type="submit" value="結束直播" class="btn btn-danger">
												<input type="hidden" name="live_no"
													value="${liveVO.live_no}"> <input type="hidden"
													name="action" value="over">
											</FORM>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>




		<div class="col-xl-12">
			<div class="bs-component">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active show"
						data-toggle="tab" href="#home">待上架商品</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#profile">我的直播商品</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade active show" id="home">
						<div class="row">
							<div class="col-xl-12">
								<div class="tile">
									<h3 class="tile-title">我的待上架商品</h3>
									<table class="table table-hover">
										<thead>
											<tr>
												<!-- 									<th scope="col">直播分類</th> -->
												<th scope="col">商品編號</th>
												<th scope="col">商品圖片</th>
												<th scope="col">商品名稱</th>
												<th scope="col">商品描述</th>
												<th scope="col">起標價</th>
												<th scope="col">數量</th>
												<th scope="col">勾選帶入</th>
												<th></th>
												<th></th>
												<!-- 								<th scope="col">賣家帳號</th> -->
											</tr>
										</thead>

										<tbody>

											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/product/product.do"
												style="margin-bottom: 0px;">

												<c:forEach var="productVO" items="${list}" begin="0"
													end="${list.size()}">
													<c:if
														test="${productVO.product_state == 0 && productVO.user_id == userVO.user_id}">

														<tr id="TR${productVO.product_no}">

															<%-- 											<td>${liveSvc.getOneLive(productVO.live_no).live_type}</td> --%>
															<td scope="row">${productVO.product_no}</td>
															<td><img width="120px" height="100px"
																src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}"
																class="rounded mx-auto d-block" alt=""></td>
															<td>${productVO.product_name}</td>
															<td class="productInfo">${productVO.product_info}</td>
															<td>${productVO.start_price}</td>
															<td>${productVO.product_remaining}</td>
															<%-- 										<td>${productVO.user_id}</td> --%>

															<td><input type="checkbox"
																id="CB${productVO.product_no}"> <input
																type="hidden" name="product_no"
																id="HB${productVO.product_no}"
																value="${productVO.product_no}" disabled></td>

														</tr>


													</c:if>
												</c:forEach>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td>直播編號</td>

													<td colspan="2"><select size="1" name="live_no"
														id="live_no" class="custom-select custom-select-lg mb-3">
															<option value="">
																<c:forEach var="liveVO"
																	items="${liveSvc.getAllByID(userVO.user_id)}">
																	<c:if test="${liveVO.live_state >0}">

																		<option value="${liveVO.live_no}"
																			${(live_orderVO.live_no==liveVO.live_no)? 'selected':'' }>${liveVO.live_no}
																		</option>
																	</c:if>
																</c:forEach>
													</select></td>
													<td><input type="hidden" name="action" value="goLive">
														<input type="submit" value="帶入" class="btn btn-info"></td>
												</tr>
											</FORM>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>
					<div class="tab-pane fade" id="profile">

						<div class="row">
							<div class="col-xl-12">
								<div class="tile">
									<h3 class="tile-title">我的直播商品</h3>
									<table class="table table-hover">
										<thead>
											<tr>
												<th scope="col">直播編號</th>
												<!-- 									<th scope="col">直播分類</th> -->
												<th scope="col">商品編號</th>
												<th scope="col">商品圖片</th>
												<th scope="col">商品名稱</th>
												<th scope="col">商品描述</th>
												<th scope="col">起標價</th>
												<th scope="col">數量</th>
												<th scope="col">選取</th>
												<th scope="col"></th>
												<!-- 								<th scope="col">賣家帳號</th> -->
											</tr>
										</thead>

										<tbody>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/product/product.do"
												style="margin-bottom: 0px;">
												<c:forEach var="productVO" items="${list}" begin="0"
													end="${list.size()}">
													<c:if
														test="${productVO.product_state == 2 && productVO.user_id == userVO.user_id}">
														<tr id="tr${productVO.product_no}">
															<th scope="row">${productVO.live_no == 0 ? '未設定':productVO.live_no}</th>
															<%-- 											<td>${liveSvc.getOneLive(productVO.live_no).live_type}</td> --%>
															<td>${productVO.product_no}</td>
															<td><img width="120px" height="100px"
																src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}"
																class="rounded mx-auto d-block" alt=""></td>
															<td>${productVO.product_name}</td>
															<td class="productInfo">${productVO.product_info}</td>
															<td>${productVO.start_price}</td>
															<td>${productVO.product_remaining}</td>
															<td><input type="checkbox" id="cb${productVO.product_no}"> 
																<input type="hidden" name="product_no" id="hb${productVO.product_no}" value="${productVO.product_no}" disabled></td>
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
													<td><input type="hidden" name="action"
														value="offShelf"> <input type="submit" value="下架"
														class="btn btn-info">
											</FORM>
											</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>

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
<c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}">
	<c:if test="${productVO.product_state == 0 && productVO.user_id == userVO.user_id}">
		$("#TR${productVO.product_no}").click(function(e){
			var checkBoxes = $("#CB${productVO.product_no}");
			checkBoxes.prop("checked", !checkBoxes.prop("checked"));
			var isChecked = $("#CB${productVO.product_no}" ).is(":checked");
			if(isChecked){
				$("#HB${productVO.product_no}").prop('disabled', false);
			}else{
				$("#HB${productVO.product_no}").prop('disabled', true);
			}
		});
	</c:if>
	
	<c:if test="${productVO.product_state == 2 && productVO.user_id == userVO.user_id}">
	
	$("#tr${productVO.product_no}" ).click(function(e){
		var checkBoxes = $("#cb${productVO.product_no}");
		checkBoxes.prop("checked", !checkBoxes.prop("checked"));
		var isChecked = $("#cb${productVO.product_no}" ).is(":checked");
		if(isChecked){
			$("#hb${productVO.product_no}").prop('disabled', false);
		}else{
			$("#hb${productVO.product_no}").prop('disabled', true);
		}
	});
</c:if>
</c:forEach>
</script>

</body>
</html>