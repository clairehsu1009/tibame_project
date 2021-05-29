<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.emp.model.*"%>

<%
	EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%> 

<html>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta charset="UTF-8">
<title>修改密碼</title>
<!-- BOOSTRAP CSS-->
<link href="<%=request.getContextPath()%>/back-template/docs/css/main.css"
	rel="stylesheet">
<style type="text/css">
body {
	background-color: #000000;
	padding: 0px;
	margin: 0px;
}

#gradient {
	width: 100%;
	height: 800px;
	padding: 0px;
	margin: 0px;
}

#confirm {
	color: #fff;
	background-color: #8dc9cc;
	border-color: #8dc9cc;
}

#login:hover {
	color: #fff;
	background-color: #2ab1b8;
	border-color: #22c1c9;
}

.
#login:focus, #login.focus {
	color: #fff;
	background-color: #2ab1b8;
	border-color: #22c1c9;
	box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
}

#login.disabled, #login:disabled {
	color: #fff;
	background-color: #8dc9cc;
	border-color: #8dc9cc;
}

#login:not (:disabled ):not (.disabled ):active, #login:not (:disabled 
	):not 
	 (.disabled ).active, .show>#login.dropdown-toggle {
	color: #fff;
	background-color: #2ab1b8;
	border-color: #22c1c9;
}

#login:not (:disabled ):not (.disabled ):active:focus, #login:not (:disabled
	 ):not (.disabled ).active:focus, .show>#login.dropdown-toggle:focus {
	box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
}

.container {
	padding-top: 150px;
}
</style>
</head>

<body id="gradient">
<div class="shadow p-3 mb-1 bg-white rounded" style="font-size:40px">
			<span class="badge badge-secondary">
				修改密碼
			</span>
			
		</div>	
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">
			<div class="col-xl-10 col-lg-12 col-md-9">
				<div class="card  border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6">
								<div class="p-5">

									<form method="post"
										action="<%=request.getContextPath()%>/loginhandler"
										class="user">
<h1>${empVO.ename}</h1>
										<span id="word"></span>
<!-- 										<div class="form-group"> -->
<!-- 											<input type="text" name="empno" -->
<!-- 												class="form-control form-control-user" -->
<!-- 												id="exampleInputEmpno"  -->
<%-- 												placeholder="請輸入員編..." required><font color=red><b>${errorMsgs.empno}</b></font> --%>
<!-- 										</div> -->
										<div class="form-group">
											<input type="text" name="pswd"
												class="form-control form-control-user"
												id="exampleInputAccount" aria-describedby="accountHelp"
												placeholder="請輸入新密碼..." required><font color=red><b>${errorMsgs.pswd}</b></font>
										</div>
										<div class="form-group">
											<input type="password" name="pswd_again"
												class="form-control form-control-user"
												id="exampleInputPassword" placeholder="確認密碼" required><font color=red><b>${errorMsgs.pswd_again}</b></font>
										</div>
										<input type="hidden" name="action" value="update_pswd">
										<input type="hidden" name="empno" value="${empVO.empno}">
										<input type="submit" value="確認" class="btn btn-user btn-block"
											id="confirm" />
									</form>
									<hr>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- js-->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
	<script type="text/javascript">
		var confirm = document.getElementById("confirm");
// 		var exampleInputAccount = document
// 				.getElementById("exampleInputEmpno");
		var exampleInputAccount = document
				.getElementById("exampleInputAccount");
		var exampleInputPassword = document
				.getElementById("exampleInputPassword");

		confirm.addEventListener(
						"click",
						function(e) {

							if (exampleInputAccount.value !== ""
									&& exampleInputPassword.value !== ""
									&& exampleInputAccount.value === exampleInputPassword.value) {
							} else {
								swal({
									title : "修改失敗！",
									icon : "warning",
									text: '兩次輸入的密碼不一樣',
									timer : 1500,
									showConfirmButton : false
								})
								e.preventDefault();
							}
						});
	</script>
	<script>
    var colors = new Array(
    		  [208,193,198],
    		  [214,214,214],
    		  [188,169,162],
    		  [146,172,209],
    		  [155,144,138],
    		  [177,122,125],
    		  [128,42,42],
    		  [255,249,238]);

var step = 0;
//color table indices for: 
// current color left
// next color left
// current color right
// next color right
var colorIndices = [0,1,2,3];

//transition speed
var gradientSpeed = 0.002;

function updateGradient()
{
  
  if ( $===undefined ) return;
  
var c0_0 = colors[colorIndices[0]];
var c0_1 = colors[colorIndices[1]];
var c1_0 = colors[colorIndices[2]];
var c1_1 = colors[colorIndices[3]];

var istep = 1 - step;
var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
var color1 = "rgb("+r1+","+g1+","+b1+")";

var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
var color2 = "rgb("+r2+","+g2+","+b2+")";

 $('#gradient').css({
   background: "-webkit-gradient(linear, left top, right top, from("+color1+"), to("+color2+"))"}).css({
    background: "-moz-linear-gradient(left, "+color1+" 0%, "+color2+" 100%)"});
  
  step += gradientSpeed;
  if ( step >= 1 )
  {
    step %= 1;
    colorIndices[0] = colorIndices[1];
    colorIndices[2] = colorIndices[3];
    
    //pick two new target color indices
    //do not pick the same as the current one
    colorIndices[1] = ( colorIndices[1] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    colorIndices[3] = ( colorIndices[3] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    
  }
}

setInterval(updateGradient,10);
</script>
</body>

</html>