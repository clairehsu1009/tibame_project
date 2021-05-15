<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>

<%
  UserVO userVO = (UserVO) request.getAttribute("userVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>會員資料新增 - addUser.jsp</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>會員資料新增 - addUser.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" name="form1">
<table>
	<tr>
		<td>帳號:</td>
		<td><input type="TEXT" name="user_id" size="45" 
			 value="<%= (userVO==null)? "abcd00" : userVO.getUser_id()%>" /></td>
	</tr>
	<tr>
		<td>密碼:</td>
		<td><input type="TEXT" name="user_pwd" size="45" 
			 value="<%= (userVO==null)? "abcd00" : userVO.getUser_pwd()%>" /></td>
	</tr>
	<tr>
		<td>姓名:</td>
		<td><input type="TEXT" name="user_name" size="45" 
			 value="<%= (userVO==null)? "董月花" : userVO.getUser_name()%>" /></td>
	</tr>
	<tr>
		<td>身分証字號:</td>
		<td><input type="TEXT" name="id_card" size="45"
			 value="<%= (userVO==null)? "A234567899" : userVO.getId_card()%>" /></td>
	</tr>
	<tr>
		<td>性別:</td>
		<td><input type="TEXT" name="user_gender" size="45"
			 value="<%= (userVO==null)? "F" : userVO.getUser_gender()%>" /></td>
	</tr>
	<tr>
		<td>生日:</td>
		<td><input name="user_dob" id="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>Email:</td>
		<td><input type="TEXT" name="user_mail" size="45"
			 value="<%= (userVO==null)? "abcd15@hotmail.com" : userVO.getUser_mail()%>" /></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input type="TEXT" name="user_phone" size="45"
			 value="<%= (userVO==null)? "32506999" : userVO.getUser_phone()%>" /></td>
	</tr>
	<tr>
		<td>手機號碼:</td>
		<td><input type="TEXT" name="user_mobile" size="45"
			 value="<%= (userVO==null)? "0988888888" : userVO.getUser_mobile()%>" /></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td>
		<div id="twzipcode"></div>
		<input type="TEXT" name="user_addr" size="45">
		</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>地址:</td> -->
<!-- 		<td><input type="TEXT" name="user_addr" size="45" -->
<%-- 			 value="<%= (userVO==null)? "新竹市東區龍山東路15巷30號" : userVO.getUser_addr()%>" /></td> --%>
<!-- 	</tr> -->
	<tr>
		<td>註冊日期:</td>
		<td><input name="regdate" id="f_date2" type="text"></td>
	</tr>
	<tr>
		<td>點數:</td>
		<td><input type="TEXT" name="user_point" size="45"
			 value="<%= (userVO==null)? "100" : userVO.getUser_point()%>" /></td>
	</tr>
	<tr>
		<td>違約次數:</td>
		<td><input type="TEXT" name="violation" size="45"
			 value="<%= (userVO==null)? "0" : userVO.getViolation()%>" /></td>
	</tr>
	<tr>
		<td>狀態:</td>
		<td><input type="TEXT" name="user_state" size="45"
			 value="<%= (userVO==null)? "1" : userVO.getUser_state()%>" /></td>
	</tr>
	<tr>
		<td>賣家評價:</td>
		<td><input type="TEXT" name="user_comment" size="45"
			 value="<%= (userVO==null)? "0" : userVO.getUser_comment()%>" /></td>
	</tr>
	<tr>
		<td>評價人數:</td>
		<td><input type="TEXT" name="comment_total" size="45"
			 value="<%= (userVO==null)? "0" : userVO.getComment_total()%>" /></td>
	</tr>
	<tr>
		<td>錢包:</td>
		<td><input type="TEXT" name="cash" size="45"
			 value="<%= (userVO==null)? "0" : userVO.getCash()%>" /></td>
	</tr>

<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="deptno"> -->
<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 				<option value="${deptVO.deptno}" ${(userVO.deptno==deptVO.deptno)? 'selected':'' } >${deptVO.dname} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>

<script>
    $("#twzipcode").twzipcode({
    	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
    	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
    	countyName: "city", // 自訂城市 select 標籤的 name 值
    	districtName: "town" // 自訂區別 select 標籤的 name 值
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
        
        $('#f_date2').datetimepicker({
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
</html>