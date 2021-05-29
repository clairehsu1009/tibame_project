<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.user.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<%
	UserVO userVO = (UserVO) session.getAttribute("account");
	session.setAttribute("userVO", userVO);
%>
<html>
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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>更改密碼</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<link
	href="https://fonts.googleapis.com/css?family=Raleway|Rock+Salt|Source+Code+Pro:300,400,600"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/creditcard/style.css">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-template/css/usermain.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
label.col-sm-2.col-form-label {
	color: black;
}

button.btn.btn-info {
	margin-left: 15px;
}

.app-title {
	margin: -30px -30px 0px;
}
</style>

</head>
<body class="app sidebar-mini rtl">
<body bgcolor='white' class="app sidebar-mini rtl">
	<jsp:include page="/front-end/user/userSidebar.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-dollar"></i>&nbsp;我的錢包
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i
						class="fa fa-home fa-lg"></i></a></li>
				<li class="breadcrumb-item">我的錢包</li>
			</ul>
		</div>

		<div class="row">
			<div class="col-md-12 productsAdd">
				<div class="form-group">
					<sql:query var="rs" dataSource="${xxx}" startRow="0">
    						 SELECT CASH FROM cea103_g4.USER WHERE USER_ID='${userVO.user_id}'
 						 </sql:query>
					<c:forEach var="row" items="${rs.rows}">

						<label for="user_pwd" class="col-sm-3 col-form-label">目前錢包餘額
							&nbsp;: &nbsp;<b>${row.cash}元</b>
						</label>
					</c:forEach>
					<button class="btn btn-info" id="clickCredit">信用卡儲值</button>
				</div>

			</div>
		</div>
		<div id="showUp" style="display: none">
			<div class="container preload">
				<div class="creditcard">
					<div class="front">
						<div id="ccsingle"></div>
						<svg version="1.1" id="cardfront"
							xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
							viewBox="0 0 750 471" style="enable-background: new 0 0 750 471;"
							xml:space="preserve">
                    <g id="Front">
                        <g id="CardBackground">
                            <g id="Page-1_1_">
                                <g id="amex_1_">
                                    <path id="Rectangle-1_1_"
								class="lightcolor grey"
								d="M40,0h670c22.1,0,40,17.9,40,40v391c0,22.1-17.9,40-40,40H40c-22.1,0-40-17.9-40-40V40
                            C0,17.9,17.9,0,40,0z" />
                                </g>
                            </g>
                            <path class="darkcolor greydark"
								d="M750,431V193.2c-217.6-57.5-556.4-13.5-750,24.9V431c0,22.1,17.9,40,40,40h670C732.1,471,750,453.1,750,431z" />
                        </g>
                        <text
								transform="matrix(1 0 0 1 60.106 295.0121)" id="svgnumber"
								class="st2 st3 st4">0123 4567 8910 1112</text>
                        <text
								transform="matrix(1 0 0 1 54.1064 428.1723)" id="svgname"
								class="st2 st5 st6">JOHN DOE</text>
                        <text
								transform="matrix(1 0 0 1 54.1074 389.8793)" class="st7 st5 st8">cardholder name</text>
                        <text
								transform="matrix(1 0 0 1 479.7754 388.8793)"
								class="st7 st5 st8">expiration</text>
                        <text transform="matrix(1 0 0 1 65.1054 241.5)"
								class="st7 st5 st8">card number</text>
                        <g>
                            <text
								transform="matrix(1 0 0 1 574.4219 433.8095)" id="svgexpire"
								class="st2 st5 st9">01/23</text>
                            <text
								transform="matrix(1 0 0 1 479.3848 417.0097)"
								class="st2 st10 st11">VALID</text>
                            <text
								transform="matrix(1 0 0 1 479.3848 435.6762)"
								class="st2 st10 st11">THRU</text>
                            <polygon class="st2"
								points="554.5,421 540.4,414.2 540.4,427.9 		" />
                        </g>
                        <g id="cchip">
                            <g>
                                <path class="st2"
								d="M168.1,143.6H82.9c-10.2,0-18.5-8.3-18.5-18.5V74.9c0-10.2,8.3-18.5,18.5-18.5h85.3
                        c10.2,0,18.5,8.3,18.5,18.5v50.2C186.6,135.3,178.3,143.6,168.1,143.6z" />
                            </g>
                            <g>
                                <g>
                                    <rect x="82" y="70" class="st12"
								width="1.5" height="60" />
                                </g>
                                <g>
                                    <rect x="167.4" y="70" class="st12"
								width="1.5" height="60" />
                                </g>
                                <g>
                                    <path class="st12"
								d="M125.5,130.8c-10.2,0-18.5-8.3-18.5-18.5c0-4.6,1.7-8.9,4.7-12.3c-3-3.4-4.7-7.7-4.7-12.3
                            c0-10.2,8.3-18.5,18.5-18.5s18.5,8.3,18.5,18.5c0,4.6-1.7,8.9-4.7,12.3c3,3.4,4.7,7.7,4.7,12.3
                            C143.9,122.5,135.7,130.8,125.5,130.8z M125.5,70.8c-9.3,0-16.9,7.6-16.9,16.9c0,4.4,1.7,8.6,4.8,11.8l0.5,0.5l-0.5,0.5
                            c-3.1,3.2-4.8,7.4-4.8,11.8c0,9.3,7.6,16.9,16.9,16.9s16.9-7.6,16.9-16.9c0-4.4-1.7-8.6-4.8-11.8l-0.5-0.5l0.5-0.5
                            c3.1-3.2,4.8-7.4,4.8-11.8C142.4,78.4,134.8,70.8,125.5,70.8z" />
                                </g>
                                <g>
                                    <rect x="82.8" y="82.1" class="st12"
								width="25.8" height="1.5" />
                                </g>
                                <g>
                                    <rect x="82.8" y="117.9"
								class="st12" width="26.1" height="1.5" />
                                </g>
                                <g>
                                    <rect x="142.4" y="82.1"
								class="st12" width="25.8" height="1.5" />
                                </g>
                                <g>
                                    <rect x="142" y="117.9" class="st12"
								width="26.2" height="1.5" />
                                </g>
                            </g>
                        </g>
                    </g>
                    <g id="Back">
                    </g>
                </svg>
					</div>
					<div class="back">
						<svg version="1.1" id="cardback"
							xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
							viewBox="0 0 750 471" style="enable-background: new 0 0 750 471;"
							xml:space="preserve">
                    <g id="Front">
                        <line class="st0" x1="35.3" y1="10.4" x2="36.7"
								y2="11" />
                    </g>
                    <g id="Back">
                        <g id="Page-1_2_">
                            <g id="amex_2_">
                                <path id="Rectangle-1_2_"
								class="darkcolor greydark"
								d="M40,0h670c22.1,0,40,17.9,40,40v391c0,22.1-17.9,40-40,40H40c-22.1,0-40-17.9-40-40V40
                        C0,17.9,17.9,0,40,0z" />
                            </g>
                        </g>
                        <rect y="61.6" class="st2" width="750"
								height="78" />
                        <g>
                            <path class="st3"
								d="M701.1,249.1H48.9c-3.3,0-6-2.7-6-6v-52.5c0-3.3,2.7-6,6-6h652.1c3.3,0,6,2.7,6,6v52.5
                    C707.1,246.4,704.4,249.1,701.1,249.1z" />
                            <rect x="42.9" y="198.6" class="st4"
								width="664.1" height="10.5" />
                            <rect x="42.9" y="224.5" class="st4"
								width="664.1" height="10.5" />
                            <path class="st5"
								d="M701.1,184.6H618h-8h-10v64.5h10h8h83.1c3.3,0,6-2.7,6-6v-52.5C707.1,187.3,704.4,184.6,701.1,184.6z" />
                        </g>
                        <text
								transform="matrix(1 0 0 1 621.999 227.2734)" id="svgsecurity"
								class="st6 st7">985</text>
                        <g class="st8">
                            <text
								transform="matrix(1 0 0 1 518.083 280.0879)"
								class="st9 st6 st10">security code</text>
                        </g>
                        <rect x="58.1" y="378.6" class="st11"
								width="375.5" height="13.5" />
                        <rect x="58.1" y="405.6" class="st11"
								width="421.7" height="13.5" />
                        <text
								transform="matrix(1 0 0 1 59.5073 228.6099)" id="svgnameback"
								class="st12 st13">John Doe</text>
                    </g>
                </svg>
					</div>
				</div>
			</div>
			<div class="form-container">
				<div class="field-container">
					<label for="name">Name</label> <input id="name" maxlength="20"
						type="text">
				</div>
				<div class="field-container">
					<label for="cardnumber">Card Number</label><span id="generatecard">generate
						random</span> <input id="cardnumber" type="text" pattern="[0-9]*"
						inputmode="numeric">
					<svg id="ccicon" class="ccicon" width="750" height="471"
						viewBox="0 0 750 471" version="1.1"
						xmlns="http://www.w3.org/2000/svg"
						xmlns:xlink="http://www.w3.org/1999/xlink">

            </svg>
				</div>
				<div class="field-container">
					<label for="expirationdate">Expiration (mm/yy)</label> <input
						id="expirationdate" type="text" pattern="[0-9]*"
						inputmode="numeric">
				</div>
				<div class="field-container">
					<label for="securitycode">Security Code</label> <input
						id="securitycode" type="text" pattern="[0-9]*" inputmode="numeric">
				</div>
			</div>
			<div>

				<div class="form-group">
					<label for="cash" class="col-sm-6 col-form-label">儲值金額</label>
					<div class="col-sm-10">
						<input type="text" id="cash">
					</div>
				</div>
				<button class="btn btn-info" id="addMoney">確認儲值</button>
			</div>
		</div>

		<!-- partial -->
		<script
			src='https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js'></script>
		<script
			src="<%=request.getContextPath()%>/front-template/creditcard/script.js"></script>

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
		<script src="js/plugins/pace.min.js"></script>
		<!-- Page specific javascripts-->
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/back-template/docs/js/plugins/bootstrap-notify.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/back-template/docs/js/plugins/sweetalert.min.js"></script>
		<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<!-- Google analytics script-->
		<script type="text/javascript">
			if (document.location.hostname == 'pratikborsadiya.in') {
				(function(i, s, o, g, r, a, m) {
					i['GoogleAnalyticsObject'] = r;
					i[r] = i[r] || function() {
						(i[r].q = i[r].q || []).push(arguments)
					}, i[r].l = 1 * new Date();
					a = s.createElement(o), m = s.getElementsByTagName(o)[0];
					a.async = 1;
					a.src = g;
					m.parentNode.insertBefore(a, m)
				})(window, document, 'script',
						'//www.google-analytics.com/analytics.js', 'ga');
				ga('create', 'UA-72504830-1', 'auto');
				ga('send', 'pageview');
			}
		</script>
		<script>
			$("#clickCredit").click(function(){
				$("#showUp").css("display","inline");
			});
			
			$("#addMoney").click(function(){
				$.ajax({ 
					  type:"POST",
					  url:"<%=request.getContextPath()%>/front-end/user/user.do",
					 	 data:{
					 		 "cash":$("#cash").val(),
							 "user_id": "${userVO.user_id}",
							 "action": "addUserCash"
					  },
					  success: function(res) {
						  Swal.fire({
							  title: "儲值金額:"+$("#cash").val()+"元成功",
							  width: 600,
							  padding: '3em',
							  background: '#fff',
							  backdrop: `
							    rgba(0,0,123,0.4)
							    url(${pageContext.request.contextPath}/images/money.gif)
							    left top
							    no-repeat
							  `
							}).then(function(){
								
						           location.reload(); 
							});

				      }, 	  
				
				 });
			});
		</script>
</body>
</html>