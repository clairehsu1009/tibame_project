<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.emp.model.*"%>
<%@	page import="com.fun.model.*"%>
<%@	page import="com.auth.model.*"%>

<%
	EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
	AuthVO authVO = (AuthVO) request.getAttribute("authVO");
%>

<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
<jsp:useBean id="funSvc" scope="page" class="com.fun.model.FunService" />
<jsp:useBean id="authSvc" scope="page" class="com.auth.model.AuthService" />
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>員工資料修改</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />

</head>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}

.address .form-control {
    display:inline-block;
    margin-right: 30px;
}

.form-group.authselect ul li {
    display:inline-block;
    margin-right: 15px;
}
.row {
justify-content: center;

}


</style>
</head>

<body bgcolor='white' class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-edit"></i> 員工資料修改
				</h1>

			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>
		<div class="main-container">
			<div class="pd-ltr-20 xs-pd-20-10">
				<div class="min-height-200px">
					<div class="pd-20 card-box mb-30">
						<div class="row">
							<div class="col-md-12">
								<div class="tile">
									<div class="tile-body">
										<%-- 錯誤表列 --%>
										<c:if test="${not empty errorMsgs}">
											<font style="color: red">請修正以下錯誤:</font>
											<ul>
												<c:forEach var="message" items="${errorMsgs}">
													<li style="color: red">${message}</li>
												</c:forEach>
											</ul>
										</c:if>

										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/emp/emp.do"
											name="form1">

											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label style="padding-left: 160px;"><i class="fas fa-user-alt"></i>員工編號:<font
															color=red style="font-size: 120%"><%=empVO.getEmpno()%></font></label>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>員工姓名:</label> <input
															class="form-control" type="TEXT" name="ename" size="45"
															value="<%=(empVO == null) ? "" : empVO.getEname()%>" />
													</div>
												</div>
											<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>職位:</label>
															<select
															class="form-control" size="1" name="job">
															<option value="一般管理員" ${(empVO.job==empVO.job)? 'selected':''}>一般管理員</option>
															<option value="高級管理員" ${(empVO.job==empVO.job)? 'selected':''}>高級管理員</option>
														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>身份證字號:</label> <input
															class="form-control" type="TEXT" name="id" size="45"
															value="<%=(empVO == null) ? "" : empVO.getId()%>" />
													</div>
												</div>
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>性別:</label> <select
															class="form-control" size="1" name="gender">
															<option value="1" ${(empVO.gender==1)? 'selected':''}>男</option>
															<option value="2" ${(empVO.gender==2)? 'selected':''}>女</option>
														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>生日:</label> <input
															class="form-control" name="dob" id="f_date2" type="text">
													</div>
												</div>
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>email:</label> <input
															class="form-control" type="email" name="email" size="45"
															value="<%=(empVO == null) ? "" : empVO.getEmail()%>" />
													</div>
												</div>

											</div>
											<div class="row">
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>薪水:</label> <input
															class="form-control" type="TEXT" name="sal" size="45"
															value="<%=(empVO == null) ? "" : empVO.getSal()%>" />
													</div>
												</div>
												<div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>狀態:</label> <select
															class="form-control" size="1" name="state">
															<option value="1" ${(empVO.state==1)? 'selected':''}>在職</option>
															<option value="0" ${(empVO.state==0)? 'selected':''}>離職</option>
														</select>
													</div>
												</div>
											</div>
											
											<div class="row address">
													<div class="form-group col-md-10">
														<label><i class="fas fa-user-alt"></i>地址:</label>
														<div id="twzipcode"></div>
													</div>	
														<div class="form-group col-md-10">
														<input class="form-control" type="TEXT" name="addr"
															size="45" value="<%=empVO.getAddr()%>" />
														</div>	
													
											</div>
											<div class="row">
												
											  <div class="col-md-5">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>到職日期:</label> <input
															class="form-control" name="hiredate" id="f_date1"
															type="text">
													</div>
												</div>
												<div class="col-md-5">
													<div class="form-group">
														
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-10">
													<div class="form-group">
														<label><i class="fas fa-user-alt"></i>權限:</label>
														<div class="form-group authselect">
															<ul>
																<c:forEach var="authVO" items="<%=authSvc.getAuthNOs(empVO.getEmpno())%>">
																	<li><input class="col-md-3" name="funno" value="${authVO.funno}" type="hidden">${funSvc.getOneFun(authVO.funno).funName}&emsp;
																		<label> <select class="form-control" size="1" name="auth_no">
																				<option value="1"
																					${(authVO.auth_no==1)? 'selected':''}>開</option>
																				<option value="0"
																					${(authVO.auth_no==0)? 'selected':''}>關</option>
																		</select>
																	</label></li>
																</c:forEach>
															</ul>
														</div>
													</div>
												</div>
											</div>


											<br>
											<div class="row">
											
												<input type="hidden" name="action" value="update"> <input
													type="hidden" name="empno" value="<%=empVO.getEmpno()%>">
												<input type="hidden" name="requestURL"
													value="<%=request.getParameter("requestURL")%>">
												<!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
												<input type="hidden" name="whichPage"
													value="<%=request.getParameter("whichPage")%>">
												<!--只用於:istAllEmp.jsp-->
												<input class="btn btn-primary" type="submit" value="送出修改">
											</div>
										</FORM>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control col-md-5", "town form-control col-md-5"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "dist", // 自訂區別 select 標籤的 name 值
	countySel: "<%=empVO.getCity()%>",
	districtSel: "<%=empVO.getDist()%>"
	});
</script>

		<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

		<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
		<script
			src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

		<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 	       value: '<%=empVO.getHiredate()%>', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 	       value: '<%=empVO.getDob()%> ', // value:  new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			//startDate:	            '2017/07/10',  // 起始日
			//minDate:               '-1970-01-01', // 去除今日(不含)之前
			//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
			});
			// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

			//      1.以下為某一天之前的日期無法選擇
			//      var somedate1 = new Date('2017-06-15');
			//      $('#f_date1').datetimepicker({
			//          beforeShowDay: function(date) {
			//        	  if (  date.getYear() <  somedate1.getYear() || 
			//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
			//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
			//              ) {
			//                   return [false, ""]
			//              }
			//              return [true, ""];
			//      }});

			//      2.以下為某一天之後的日期無法選擇
			//      var somedate2 = new Date('2017-06-15');
			//      $('#f_date1').datetimepicker({
			//          beforeShowDay: function(date) {
			//        	  if (  date.getYear() >  somedate2.getYear() || 
			//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
			//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
			//              ) {
			//                   return [false, ""]
			//              }
			//              return [true, ""];
			//      }});

			//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
			//      var somedate1 = new Date('2017-06-15');
			//      var somedate2 = new Date('2017-06-25');
			//      $('#f_date1').datetimepicker({
			//          beforeShowDay: function(date) {
			//        	  if (  date.getYear() <  somedate1.getYear() || 
			//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
			//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
			//		             ||
			//		            date.getYear() >  somedate2.getYear() || 
			//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
			//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
			//              ) {
			//                   return [false, ""]
			//              }
			//              return [true, ""];
			//      }});
		</script>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />

</body>
</html>