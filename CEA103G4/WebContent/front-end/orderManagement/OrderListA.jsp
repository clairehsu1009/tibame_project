<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.user.model.*"%>
<%@ page import="com.product.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<jsp:useBean id="orderSvc" scope="page"
	class="com.order.model.OrderService" />
<jsp:useBean id="productSvc" scope="page"
	class="com.product.model.ProductService" />

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
<title>Mode Femme 直售買家訂單</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
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
#sratingbox {
	position: inline-block
}

ion-icon {
	font-size: 64px;
}
.modal-body{
	width:100%;
	display:flex;
	justify-content: center;
	flex-direction:column;
	align-items:center
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

		<div class="row">
			<div class="col-xl-12">
				<div class="tile">
					<h3 class="tile-title">我的購買訂單</h3>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>#</th>
								<th>訂單時間</th>
								<th>訂單狀態</th>
								<th>訂單金額</th>
								<th>付款方式</th>
								<th>物流方式</th>
								<th>物流狀態</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="orderVO"
								items="${orderSvc.getAllByID(userVO.user_id)}">
								<tr>
									<td>${orderVO.order_no}</td>
									<td><fmt:formatDate value="${orderVO.order_date}"
											pattern="yyyy-MM-dd" /></td>
									<td>${(orderVO.order_state==0)? '未付款':'已付款'}</td>
									<td>${orderVO.order_price}</td>
									<td>${(orderVO.pay_method==0)? '錢包':''}
										${(orderVO.pay_method==1)? '信用卡':''}
										${(orderVO.pay_method==2)? '轉帳':''}</td>
									<td>${(orderVO.logistics==0)? '超商':'宅配'}</td>
									<td>${(orderVO.logisticsstate==0)? '未出貨':''}
										${(orderVO.logisticsstate==1)? '已出貨':''}
										${(orderVO.logisticsstate==2)? '已取貨':''}</td>
									<td>
										<!-- Button trigger modal -->
										<input type="hidden" value="${orderVO.seller_id}">
										<button class="btn btn-info" id="srating_btn"
											data-toggle="modal" data-target="#${orderVO.order_no}">評價</button>
										<input type="hidden" value="${orderVO.order_no}">
									</td>
									<td></td>
								</tr>

							</c:forEach>
						</tbody>
					</table>

				</div>
			</div>
		</div>

			<!-- Modal -->
		<FORM METHOD="post" ACTION="order.do">
			<div class="modal fade" id="" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content" id="sratingbox">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLongTitle">
							
							</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div>	<input type="hidden" name="srating" value="0" id="con"/>
							<ion-icon name="star" class="star all-star" id="s1"></ion-icon>
							<ion-icon name="star" class="star all-star" id="s2"></ion-icon>
							<ion-icon name="star" class="star all-star" id="s3"></ion-icon>
							<ion-icon name="star" class="star all-star" id="s4"></ion-icon>
							<ion-icon name="star" class="star all-star" id="s5"></ion-icon>
							</div>
						
							<div>
								<textarea name="srating_content" rows="10" cols="43" style="resize: none"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<!-- <button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button> -->
								
								<input type="hidden" name="seller_id" value="" id="seller_id">
								<input type="hidden" name="order_no" value="" id="order_no">
								<input type="hidden" name="action" value="updateSrating">
								<input type="button" class="btn btn-secondary" data-dismiss="modal" value="取消">
								<input type="submit" class="btn btn-primary" value="送出">
						</div>
					</div>
				</div>
			</div>
		</FORM>



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
	$(document).ready(function(){
		$("button").click(function(){
			let val =$(this).next('input').val();
			let seller =$(this).prev('input').val();
			$(".all-star").css("color","black");
			$("#con").val("0");
			
			$(".fade").attr("id",val);
			$("h5").text(val);
			$("#order_no").val(val);
			$("#seller_id").val(seller);
		})
		
		
		if(${orderVO.state == 1 && orderVO.logisticsstate == 2}){
			$("button#srating_btn").removeAttr('disabled');
		}else{
			/* $("button#srating_btn").prop('disabled',true); */
		};
		
		$("#s1").click(function(){
			$(".all-star").css("color","black");
			$("#s1").css("color","#f6d04d");
			$("#con").val("1");
		})
		$("#s2").click(function(){
			$(".all-star").css("color","black");
			$("#s1,#s2").css("color","#f6d04d");
			$("#con").val("2");
		})
		$("#s3").click(function(){
			$(".all-star").css("color","black");
			$("#s1,#s2,#s3").css("color","#f6d04d");
			$("#con").val("3");
		})
		$("#s4").click(function(){
			$(".all-star").css("color","black");
			$("#s1,#s2,#s3,#s4").css("color","#f6d04d");
			$("#con").val("4");
		})
		$("#s5").click(function(){
			$(".all-star").css("color","black");
			$(".all-star").css("color","#f6d04d");
			$("#con").val("5");
		})
		
		
	})
	</script>
	<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
</body>
</html>