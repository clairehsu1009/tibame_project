<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>

<%
	UserVO userVO = (UserVO) request.getAttribute("userVO");
	request.setAttribute("userVO", userVO);
%>

<!DOCTYPE html>
<html lang="zh-Hant">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Modefemme</title>
    <link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

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
    <style type="text/css">
  	.register-login-section {
    padding-top: 0px;
	}
	.register-form h2 {
    margin-bottom: 10px;
	}
	td {
    padding-right: 5px;
    padding-bottom: 5px;
}
  	</style>
  </head>

  <body>
	<!-- Header Section Begin -->
    <%@include file="/front-end/header.jsp"%>
	<!-- Header End -->
	
    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="breadcrumb-text">
              <a href="<%=request.getContextPath()%>/front-end/index.jsp"><i class="fa fa-home"></i> Home</a>
              <span>註冊</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->

    <!-- Register Section Begin -->
    <div class="register-login-section spad">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 offset-lg-3">
            <div class="register-form">
              <h2>會員註冊</h2>
              <FORM form METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" name="form1">
<!--                 <div class="group-input"> -->
<!--                   <label for="user_id">帳號 *</label> -->
<%--                   <input type="text" name="user_id" value="<%= (userVO==null)? "" : userVO.getUser_id()%>"/> --%>
<!--                 </div> -->
<table>
	<tr>
		<td>帳號 </td>
		<td><input type="TEXT" class="form-control" name="user_id" size="45" 
			 value="<%= (userVO==null)? "abcd01" : userVO.getUser_id()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_id}</b></td></tr>
	<tr>
		<td>密碼 </td>
		<td><input type="password" class="form-control" name="user_pwd" size="45" 
			 value="<%= (userVO==null)? "abcd01" : userVO.getUser_pwd()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_pwd}</b></td></tr>
	<tr>
		<td>姓名 </td>
		<td><input type="TEXT" class="form-control" name="user_name" size="45" 
			 value="<%= (userVO==null)? "漢斯" : userVO.getUser_name()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_name}</b></td></tr>
	<tr>
		<td>身分證字號 </td>
		<td><input type="TEXT" class="form-control" name="id_card" size="45"
			 value="<%= (userVO==null)? "A123456789" : userVO.getId_card()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.id_card}</b></td></tr>
	<tr>
	<td>性別 </td>
	<td><input type="radio" name="user_gender" value="1" ${(userVO.user_gender==1)? 'checked':'' }>
	<label for="male">男</label>
	<input type="radio" name="user_gender" value="0" ${(userVO.user_gender==0)? 'checked':'' }>
	<label for="female">女</label><font color=red><b>${errorMsgs.user_gender}</b></td>
	</tr>
	
	<tr>
		<td>生日 </td>
		<td><input name="user_dob" class="form-control" size="45" id="f_date1" type="text"></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_dob}</b></td></tr>
	<tr>
		<td>Email</td>
		<td><input type="TEXT" class="form-control" name="user_mail" size="45"
			 value="<%= (userVO==null)? "joy15132000@hotmail.com" : userVO.getUser_mail()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_mail}</b></td></tr>
	<tr>
		<td>電話</td>
		<td><input type="TEXT" class="form-control" name="user_phone" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_phone()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_phone}</b></td></tr>
	<tr>
		<td>手機號碼</td>
		<td><input type="TEXT" class="form-control" name="user_mobile" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_mobile()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_mobile}</b></td></tr>
	<tr>
		<td>地址</td>
		<td>
		<div id="twzipcode"></div><font color=red><b>${errorMsgs.city}</b>
		<input type="TEXT" class="form-control" name="user_addr" size="45" value="<%= (userVO==null)? "" : userVO.getUser_addr()%>"></td>
		</td><tr><td></td><td><font color=red><b>${errorMsgs.user_addr}</b></td></tr>
	</tr>
<%-- 	<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" /> --%>
</table>
				<input type="hidden" name="action" value="insert">
                <button type="submit" class="site-btn register-btn">
                  	加入會員
                </button>
              </FORM>
            <div _ngcontent-sc209="" class="card-body px-5 py-4">
				<div _ngcontent-sc209="" class="small text-center">
					已經有帳號了嗎?&nbsp; <a style="color:pink; font-weight:700;" href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">請直接登入 !</a>
				</div>
			</div>
<!--               <div class="switch-login"> -->
<%--                 <a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp" class="or-login">已經有帳號了嗎?請直接登入</a> --%>
<!--               </div> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Register Form Section End -->

    <!-- Partner Logo Section Begin -->
    <div class="partner-logo">
      <div class="container">
        <div class="logo-carousel owl-carousel">
          <div class="logo-item">
            <div class="tablecell-inner">
              <img src="img/logo-carousel/logo-1.png" alt="" />
            </div>
          </div>
          <div class="logo-item">
            <div class="tablecell-inner">
              <img src="img/logo-carousel/logo-2.png" alt="" />
            </div>
          </div>
          <div class="logo-item">
            <div class="tablecell-inner">
              <img src="img/logo-carousel/logo-3.png" alt="" />
            </div>
          </div>
          <div class="logo-item">
            <div class="tablecell-inner">
              <img src="img/logo-carousel/logo-4.png" alt="" />
            </div>
          </div>
          <div class="logo-item">
            <div class="tablecell-inner">
              <img src="img/logo-carousel/logo-5.png" alt="" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Partner Logo Section End -->

	<!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
<%--     <script src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script> --%>
    <script src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
  </body>
<script>
$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town", // 自訂區別 select 標籤的 name 值
	countySel: "<%=(userVO==null)? "" :userVO.getCity()%>",
	districtSel: "<%=(userVO==null)? "" :userVO.getTown()%>",
	zipcodeSel: "<%=(userVO==null)? "" :userVO.getZipcode()%>"
	});

</script>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date user_dob = null;
  try {
	  user_dob = userVO.getUser_dob();
   } catch (Exception e) {
	   user_dob = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=user_dob%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>
</html>
