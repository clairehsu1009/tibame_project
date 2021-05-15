<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>

<%@ page import="com.live_order.model.*"%>

<%
	Live_orderVO live_orderVO = (Live_orderVO) request.getAttribute("live_orderVO");
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
<title>Mode Femme 會員專區</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-template/css/usermain.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

</head>
<body class="app sidebar-mini rtl">

	<!-- Navbar_siderbar start-->
	<%@include file="/front-end/user/userSidebar.jsp"%>
	<!-- Navbar_siderbar finish-->


	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-edit"></i>修改購買訂單
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">直播訂單管理</a></li>
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
			<div class="col-md-12 productsAdd">
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/live_order/live_order.do"
					name="form1">
					<table>
						<tr>
							<td>直播訂單編號:</td>
							<td><%=live_orderVO.getLive_order_no()%></td>

						</tr>
						<tr>
							<td>直播訂單日期:</td>
							<td><fmt:formatDate value="${live_orderVO.order_date}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>最後付款時間:</td>
							<td><fmt:formatDate value="${live_orderVO.pay_deadline}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>直播訂單價格:</td>
							<td><%=live_orderVO.getOrder_price()%></td>
						</tr>
						<tr>
							<td>回饋點數:</td>
							<td><%=Math.round(live_orderVO.getOrder_price() * 0.01)%> <input
								type="HIDDEN" name="point" size="45"
								value="<%=Math.round(live_orderVO.getOrder_price() * 0.01)%>" /></td>
						</tr>
						<tr>
							<td>物流方式:</td>
							<td><select name="logistics" class="form-control"
								id="logistics">
									<option value="0" ${(live_orderVO.logistics==0)? 'selected':''}>宅配</option>
									<option value="1" ${(live_orderVO.logistics==1)? 'selected':''}>超商</option>
							</select></td>
						</tr>
						<tr>
							<td>運費:</td>
							<td>
								<div id="showOrder_shipping">${live_orderVO.order_shipping}</div>
								<input type="HIDDEN" name="order_shipping" id="order_shipping"
								size="45" value="<%=live_orderVO.getOrder_shipping()%>" />
							</td>
						</tr>
						<tr>
							<td>使用折扣:</td>
							<td><%=live_orderVO.getDiscount()%> <input type="HIDDEN"
								name="discount" size="45" class="form-control"
								value="<%=live_orderVO.getDiscount()%>" /></td>
						</tr>
						<tr>
							<td>訂單狀態:</td>
							<td>${(live_orderVO.order_state==0)? '未付款':''}
								${(live_orderVO.order_state==1)? '已付款':''}
								${(live_orderVO.order_state==2)? '棄單':''} <input type="HIDDEN"
								name="order_state" size="45"
								value="<%=live_orderVO.getOrder_state()%>" />

							</td>
						</tr>
						<tr>
							<td>物流狀態:</td>
							<td>${(live_orderVO.logistics_state==0)? '未出貨':''}
								${(live_orderVO.logistics_state==1)? '已出貨':''}
								${(live_orderVO.logistics_state==2)? '已取貨':''} <input
								type="HIDDEN" name="logistics_state" class="form-control"
								size="45" value="<%=live_orderVO.getLogistics_state()%>" />

							</td>
						</tr>
						<tr>
							<td>付款方式:</td>
							<td><select name="pay_method" class="form-control">
									<option value="0"
										${(live_orderVO.pay_method==0)? 'selected':''}>錢包</option>
									<option value="1"
										${(live_orderVO.pay_method==1)? 'selected':''}>信用卡</option>
									<option value="2"
										${(live_orderVO.pay_method==2)? 'selected':''}>轉帳</option>
							</select></td>
						</tr>

						<tr>
							<td>收件人姓名:</td>
							<td><input type="TEXT" class="form-control" name="rec_name"
								size="45" value="<%=live_orderVO.getRec_name()%>" REQUIRED /></td>
						</tr>

						<tr>
							<td>收件人地址:</td>


							<td>
								<div id="twzipcode"></div> <input type="TEXT"
								class="form-control" name="rec_addr" size="45"
								value="<%=live_orderVO.getRec_addr()%>" />
							</td>

						</tr>

						<tr>
							<td>收件人電話:</td>
							<td><input type="TEXT" name="rec_phone" class="form-control"
								size="45" value="<%=live_orderVO.getRec_phone()%>" /></td>
						</tr>

						<tr>
							<td>收件人手機:</td>
							<td><input type="TEXT" name="rec_cellphone"
								class="form-control" size="45"
								value="<%=live_orderVO.getRec_cellphone()%>" REQUIRED /></td>
						</tr>



						<jsp:useBean id="liveSvc" scope="page"
							class="com.live.model.LiveService" />
						<tr>
							<td>直播編號:</td>
							<td><%=live_orderVO.getLive_no()%> <input type="HIDDEN"
								name="live_no" size="45" class="form-control"
								value="<%=live_orderVO.getLive_no()%>" /></td>
						</tr>

						<jsp:useBean id="userSvc" scope="page"
							class="com.user.model.UserService" />
						<tr>
							<td>賣家帳號:</td>
							<td>
								<div id="showSellerId">${live_orderVO.seller_id}</div> <input
								name="seller_id" id="seller_id"
								value="<%=live_orderVO.getSeller_id()%>" type="HIDDEN" />
							</td>
						</tr>



						<tr>
							<td>評價分數:</td>
							<td><select name="srating" class="form-control">
									<option value="5" ${(live_orderVO.srating==5)? 'selected':''}>5</option>
									<option value="4" ${(live_orderVO.srating==4)? 'selected':''}>4</option>
									<option value="3" ${(live_orderVO.srating==3)? 'selected':''}>3</option>
									<option value="2" ${(live_orderVO.srating==2)? 'selected':''}>2</option>
									<option value="1" ${(live_orderVO.srating==1)? 'selected':''}>1</option>
							</select></td>
						</tr>

						<tr>
							<td>評價內容:</td>
							<td><textarea class="form-control" name="srating_content"
									rows="4" cols="50"><%=live_orderVO.getSrating_content()%></textarea></td>
						</tr>

					</table>

					<br> <input type="hidden" name="action" value="updateA">
					<input type="hidden" name="user_id" value="${userVO.user_id}">
					<input type="hidden" name="live_order_no"
						value="<%=live_orderVO.getLive_order_no()%>"> <input
						type="hidden" name="order_date"
						value="<%=live_orderVO.getOrder_date()%>"> <input
						type="hidden" name="order_price"
						value="<%=live_orderVO.getOrder_price()%>"> <input
						type="hidden" name="pay_deadline"
						value="<%=live_orderVO.getPay_deadline()%>"> <input
						type="submit" class="btn btn-info" value="送出修改">
				</FORM>
	</main>
	<!-- Essential javascripts for application to work-->
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script> --%>
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
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#preview_img").attr('src', e.target.result);
					$("#preview_img").attr('width', "250px");
					$("#preview_img").attr('style', "display:block");
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#imgInp").change(function() {
			readURL(this);
		});
	</script>
	<script>

$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town", // 自訂區別 select 標籤的 name 值
	countySel: "<%=live_orderVO.getCity()%>",
	districtSel: "<%=live_orderVO.getTown()%>",
	zipcodeSel: "<%=live_orderVO.getZipcode()%>"
	});
	
$("#logistics").change(function(e) {
	if($("#logistics").val() == '0'){
		$("#order_shipping").attr('value', '100');
		$("#showOrder_shipping").text("100");
	}else{
		$("#order_shipping").attr('value', '50');
		$("#showOrder_shipping").text("50") ;
	}
	});
$("#live_no").change(function(e) {
	<c:forEach var="liveVO" items="${liveSvc.all}">	
	if($("#live_no").val()==${liveVO.live_no}){		
		$("#seller_id").attr('value', '${liveVO.user_id}');
		$("#showSellerId").text('${liveVO.user_id}');
	}	
	</c:forEach>
	});

$("#user_id").change(function(e){
	<c:forEach var="userVO" items="${userSvc.all}">	
	if($("#user_id").val()=='${userVO.user_id}'){
		$("#showPoint").text('${userVO.user_point}');
	}
	</c:forEach>
});
</script>
</body>
</html>