<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%@ page import="com.live.model.*"%>

<%
	LiveVO liveVO = (LiveVO) request.getAttribute("liveVO");
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
<title>Mode Femme 新增直播</title>
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
</head>
<body class="app sidebar-mini rtl">

	<!-- Navbar_siderbar start-->
	<%@include file="/front-end/user/userSidebar.jsp"%>
	<!-- Navbar_siderbar finish-->


	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-edit"></i>新增直播
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">直播管理</a></li>
			</ul>
		</div>
		<div class="row">
			<div class="col-md-12 productsAdd">
				<form METHOD="post"
					ACTION="<%=request.getContextPath()%>/live/live.do" name="form1"
					enctype="multipart/form-data">


					<jsp:useBean id="userSvc" scope="page"
						class="com.user.model.UserService" />
					<div class="form-group">
						<label for="user_id" class="col-sm-2 col-form-label">直播主ID</label>
						<div class="col-sm-10">
							<input type="hidden" name="user_id" value="${userVO.user_id}">
							${userVO.user_id}
						</div>
					</div>


					<div class="form-group">
						<label for="live_name" class="col-sm-2 col-form-label">直播名稱</label>
						<div class="col-sm-10">
							<input class="form-control" id="live_name" name="live_name"
								type="text" placeholder="請輸入直播名稱"
								value="<%=(liveVO == null) ? "" : liveVO.getLive_name()%>"
								required>
						</div>
					</div>


					<div class="form-group">
						<label for="live_id" class="col-sm-2 col-form-label">YoutubeID</label>
						<div class="col-sm-10">
							<input class="form-control" id="live_id" name="live_id"
								type="text" placeholder="請輸入YoutubeID"
								value="<%=(liveVO == null) ? "" : liveVO.getLive_id()%>"
								required>
						</div>
					</div>

					<jsp:useBean id="product_typeSvc" scope="page"
						class="com.product_type.model.Product_TypeService" />
					<div class="form-group">
						<label for="live_type" class="col-sm-2 col-form-label">直播分類</label>
						<div class="col-sm-10">
							<select size="1" class="form-control" name="live_type">
								<c:forEach var="product_typeVO" items="${product_typeSvc.all}">
									<option value="${product_typeVO.pdtype_name}"
										${(liveVO.live_type==product_typeVO.pdtype_name)? 'selected':'' }>${product_typeVO.pdtype_name}
								</c:forEach>
							</select>
						</div>
					</div>


					<div class="form-group">
						<label for="live_state" class="col-sm-2 col-form-label">直播狀態</label>
						<div class="col-sm-10">
							<select size="1" class="form-control" name="live_state">
								<%-- 								<option value="0" ${(liveVO.live_state==0)? 'selected':'' }>已結束</option> --%>
								<option value="1" ${(liveVO.live_state==1)? 'selected':'' }>未直播</option>
								<option value="2" ${(liveVO.live_state==2)? 'selected':'' }>直播中</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="product_info" class="col-sm-2 col-form-label">直播時間</label>
						<div class="col-sm-10">
							<input name="live_time" class="form-control" id="f_date1"
								type="text">
						</div>
					</div>

<%-- 					<jsp:useBean id="empSvc" scope="page" --%>
<%-- 						class="com.emp.model.EmpService" /> --%>
<!-- 					<div class="form-group"> -->
<!-- 						<label for="empno" class="col-sm-2 col-form-label">管理員編號</label> -->
<!-- 						<div class="col-sm-10"> -->
<!-- 							<select size="1" class="form-control" name="empno"> -->
<%-- 								<c:forEach var="empVO" items="${empSvc.all}"> --%>
<%-- 									<option value="${empVO.empno}" --%>
<%-- 										${(liveVO.empno==empVO.empno)? 'selected':'' }>${empVO.empno} --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					預設14001 -->
					<input name="empno" type="hidden" value="14001">

					<div class="form-group">
						<label for="live_photo" class="col-sm-2 col-form-label">直播預覽圖</label>
						<div class="col-sm-10">
							<input name="live_photo" class="form-control" type="file"
								id="imgInp" accept="image/gif, image/jpeg, image/png" required>
						</div>
					</div>

					<div class="form-group">
						<img id="preview_img" class="col-md-6 col-form-label" src="#"
							style="display: none;" />

					</div>

					<div class="form-group">
						<br> <input type="hidden" name="action" value="insert">
						<button type="submit" class="btn btn-info">新增直播專案</button>

					</div>
				</form>
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

	<%
		java.sql.Timestamp live_time = null;
		try {
			live_time = liveVO.getLive_time();
		} catch (Exception e) {
			live_time = new java.sql.Timestamp(System.currentTimeMillis());
		}
	%>
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script
		src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
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
	<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

	<script>
		$.datetimepicker.setLocale('zh');
		$('#f_date1').datetimepicker({
			theme : '', //theme: 'dark',
			timepicker : true, //timepicker:true,
			step : 30, //step: 60 (這是timepicker的預設間隔60分鐘)
			format : 'Y-m-d H:i:s', //format:'Y-m-d H:i:s',
			value : new Date(), //value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			//startDate:	            '2017/07/10',  // 起始日
			minDate : '-1970-01-01' // 去除今日(不含)之前
		//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});
	</script>
</body>
</html>