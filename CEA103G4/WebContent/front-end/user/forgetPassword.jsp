<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>

<%
	UserVO userVO = (UserVO) request.getAttribute("userVO");
%>

<!DOCTYPE html>
<html lang="zxx">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content="Fashi Template" />
    <meta name="keywords" content="Fashi, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>ForgetPassword - Mode Femme</title>
    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
      rel="stylesheet"
    />
    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/themify-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/nice-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/style.css" type="text/css" />
  <style>
  label.text-gray-600.small {
    color: black;
}
.small.text-center {
    color: black;
}
  </style>
  </head>

  <body>
	<!-- Header Section Begin -->
    <%@include file="/front-end/header.jsp"%>
	<!-- Header End -->

	<main _ngcontent-sc163="">
		<div class="breacrumb-section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="breadcrumb-text">
							<a href="<%=request.getContextPath()%>/front-end/index.jsp"><i
								class="fa fa-home"></i> 回首頁</a> <span>忘記密碼</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr _ngcontent-sc209="" class="my-0">
		<div _ngcontent-sc209="" class="card-body p-5">
			<div _ngcontent-sc209="" class="row justify-content-center">
				<div _ngcontent-sc209="" class="col-xl-8 col-lg-9">
					<form _ngcontent-sc209="" novalidate=""
						class="ng-untouched ng-pristine ng-invalid" METHOD="post" action="<%=request.getContextPath()%>/front-end/user/user.do">
						<div _ngcontent-sc209="" class="form-group">
							<p>請輸入註冊時的UserID及GMAIL信箱</p>
							<label _ngcontent-sc209="" for=""
								class="text-gray-600 small">UserID *</label><input
								_ngcontent-sc209="" id="user_id" data-cy="emailInput"
								type="text" aria-describedby="emailHelp" name="user_id"
								formcontrolname=""
								class="form-control form-control-solid ng-untouched ng-pristine ng-invalid"
								value="<%= (userVO==null)? "" : userVO.getUser_id()%>" placeholder="UserID" autofocus><td><font color=red><b>${errorMsgs.user_id}</b><br>
							<label _ngcontent-sc209="" for="emailInput"
								class="text-gray-600 small">Email address *</label><input
								_ngcontent-sc209="" id="emailInput" data-cy="emailInput"
								type="email" aria-describedby="emailHelp" name="user_mail"
								formcontrolname="email"
								class="form-control form-control-solid ng-untouched ng-pristine ng-invalid"
								value="<%= (userVO==null)? "" : userVO.getUser_mail()%>" placeholder="XXXX@gmail.com"><td><font color=red><b>${errorMsgs.user_mail}</b>
						</div>
						<div _ngcontent-sc209="" class="text-right">
						 	<input type="hidden" name="action" value="getPassword">
							<button _ngcontent-sc209="" data-cy="requestPasswordResetButton"
								type="submit" class="btn btn-primary">寄送密碼修改信
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<hr _ngcontent-sc209="" class="my-0">
		<div _ngcontent-sc209="" class="card-body px-5 py-4">
			<div _ngcontent-sc209="" class="small text-center">
				新朋友嗎? <a _ngcontent-sc209="" routerlink="../register"
					href="<%=request.getContextPath()%>/front-end/user/register.jsp">來註冊吧 !</a>
			</div>
		</div>
	</main>
	
	<!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->
    
    <!-- Js Plugins -->
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
  </body>
</html>
