<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.user.model.*"%>

<%
  UserVO userVO = (UserVO) request.getAttribute("userVO"); //UserServlet.java (Controller) 存入req的userVO物件 (包括幫忙取出的userVO, 也包括輸入資料錯誤時的userVO物件)
  request.setAttribute("userVO", userVO);
%>
<html>
<head>
<title>會員資料修改</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

 <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
  <!-- Twitter meta-->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:site" content="@pratikborsadiya">
  <meta property="twitter:creator" content="@pratikborsadiya">
  <!-- Open Graph Meta-->
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Vali Admin">
  <meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
  <meta property="og:url" content="http://pratikborsadiya.in/blog/vali-admin">
  <meta property="og:image" content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
  <meta property="og:description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-template/css/usermain.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
td {
padding: 15px 20px 5px 0px;
}
.app-title {
margin: -30px -30px 0px;
}
.address .form-control {
    display:inline-block;
    width: 117.5%;
}
.form-control {
	width: 70.5%;
}
</style>

</head>
<body bgcolor='white' class="app sidebar-mini rtl">
<jsp:include page="/front-end/user/userSidebar.jsp" />
<main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-edit"></i> 修改我的資料</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i class="fa fa-home fa-lg"></i></a></li>
                    <li class="breadcrumb-item">修改我的資料</li>
                  </ul>
                </div>
<%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if>          --%>
         
<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" name="form1" enctype = "multipart/form-data">
<table>
	<tr>
		<td>帳號:<font color=red><b>*</b></font></td>
		<td>${param.user_id}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>密碼:</td> -->
<%-- 		<td><input type="TEXT" name="user_pwd" size="45" value="<%=userVO.getUser_pwd()%>" /></td> --%>
<!-- 	</tr> -->
	<tr>
		<td>姓名:</td>
		<td><input type="TEXT" class="form-control" name="user_name" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_name()%>" />
			 <font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_name }</b></td>
	</tr>
	<tr>
		<td>身分証字號:</td>
		<td><%=userVO.getId_card()%></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>性別:</td> -->
<!-- 		<td><select name="user_gender"> -->
<%-- 					<option value="0" ${(userVO.user_gender==0)? 'selected':'' }>女</option> --%>
<%-- 					<option value="1" ${(userVO.user_gender==1)? 'selected':'' }>男</option> --%>
<!-- 			</select></td>  -->
<%-- 	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_gender}</b></td></tr> --%>
	<tr>
	<td>性別:</td>
	<td><input type="radio" id="user_gender" name="user_gender" value="1" ${(userVO.user_gender==1)? 'checked':'' }>
	<label for="male">男</label>
	<input type="radio" id="user_gender" name="user_gender" value="0" ${(userVO.user_gender==0)? 'checked':'' }>
	<label for="female">女</label><font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_gender }</b></td> 
	</tr>
	
	<tr>
		<td>生日:</td>
		<td><input name="user_dob" class="form-control" size="45" id="f_date1" type="text" >
		<font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_dob}</b></td>
	</tr>
	<tr>
		<td>Email:</td>
		<td><input type="TEXT" class="form-control" name="user_mail" size="45"	value="<%=userVO.getUser_mail()%>" />
		<font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_mail }</b></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input type="TEXT" class="form-control" name="user_phone" size="45"	value="<%=userVO.getUser_phone()%>" />
		<font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_phone }</b></td>
	</tr>
	<tr>
		<td>手機號碼:</td>
		<td style="padding-bottom: 15px;">
		<input type="TEXT" class="form-control" name="user_mobile" size="45" value="<%=userVO.getUser_mobile()%>" />
		<font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_mobile }</b></td>
	</tr>
	<tr>
		<td>地址:</td>
		<th><div class="row address">
			<div id="twzipcode" class="form-group col-md-10" style="margin-bottom: 0px;">
			</div>
			<div class="form-group col-md-10" style="margin-bottom: 0px;"><font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.city }</b></div>
			<div class="form-group col-md-12">
			<input type="TEXT" class="form-control" name="user_addr" size="45"
			value="<%=userVO.getUser_addr()%>"> <font color=red><b>${(empty errorMsgs) ? "" : errorMsgs.user_addr }</b>
			</div>
			</div>
		</th>
	</tr>
	<tr>
		<td>選擇圖片:</td>
		<td><input type="file" name="user_pic" id="myFile" />
		<img width="100px" height="100px" id="oldimg" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${userVO.user_id}">
		<div id="preview"></div></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>註冊日期:</td> -->
<!-- 		<td><input name="regdate" id="f_date2" type="text" ></td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>點數:</td> -->
<%-- 		<td><input type="TEXT" name="user_point" size="45" value="<%=userVO.getUser_point()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>違約次數:</td> -->
<%-- 		<td><input type="TEXT" name="violation" size="45" value="<%=userVO.getViolation()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>狀態:</td> -->
<%-- 		<td><input type="TEXT" name="user_state" size="45" value="<%=userVO.getUser_state()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>賣家評價:</td> -->
<%-- 		<td><input type="TEXT" name="user_comment" size="45" value="<%=userVO.getUser_comment()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>評價人數:</td> -->
<%-- 		<td><input type="TEXT" name="comment_total" size="45" value="<%=userVO.getComment_total()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>錢包:</td> -->
<%-- 		<td><input type="TEXT" name="cash" size="45" value="<%=userVO.getCash()%>" /></td> --%>
<!-- 	</tr> -->

<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="deptno"> -->
<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 				<option value="${deptVO.deptno}" ${(userVO.deptno==deptVO.deptno)?'selected':'' } >${deptVO.dname} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->

</table>

<input type="hidden" name="action" value="update">
<input type="hidden" name="user_id" value="<%=userVO.getUser_id()%>">
<input type="hidden" name="id_card" value="<%=userVO.getId_card()%>">
<button type="submit" class="btn btn-info">送出修改</button></FORM>

</main>
              <!-- Essential javascripts for application to work-->
<%--               <script src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script> --%>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/popper.min.js"></script>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/bootstrap.min.js"></script>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/main.js"></script>
              <!-- The javascript plugin to display page loading on top-->
              <script src="<%=request.getContextPath()%>/back-template/docs/js/plugins/pace.min.js"></script>
              <!-- Page specific javascripts-->
              <script type="text/javascript" src="<%=request.getContextPath()%>/back-template/docs/js/plugins/chart.js"></script>
              <script type="text/javascript">
                var data = {
                 labels: ["January", "February", "March", "April", "May"],
                 datasets: [
                 {
                   label: "My First dataset",
                   fillColor: "rgba(220,220,220,0.2)",
                   strokeColor: "rgba(220,220,220,1)",
                   pointColor: "rgba(220,220,220,1)",
                   pointStrokeColor: "#fff",
                   pointHighlightFill: "#fff",
                   pointHighlightStroke: "rgba(220,220,220,1)",
                   data: [65, 59, 80, 81, 56]
                 },
                 {
                   label: "My Second dataset",
                   fillColor: "rgba(151,187,205,0.2)",
                   strokeColor: "rgba(151,187,205,1)",
                   pointColor: "rgba(151,187,205,1)",
                   pointStrokeColor: "#fff",
                   pointHighlightFill: "#fff",
                   pointHighlightStroke: "rgba(151,187,205,1)",
                   data: [28, 48, 40, 19, 86]
                 }
                 ]
               };
               var pdata = [
               {
                value: 300,
                color: "#46BFBD",
                highlight: "#5AD3D1",
                label: "Complete"
              },
              {
                value: 50,
                color:"#F7464A",
                highlight: "#FF5A5E",
                label: "In-Progress"
              }
              ]
              
//               var ctxl = $("#lineChartDemo").get(0).getContext("2d");
//               var lineChart = new Chart(ctxl).Line(data);
              
//               var ctxp = $("#pieChartDemo").get(0).getContext("2d");
//               var pieChart = new Chart(ctxp).Pie(pdata);
            </script>
            <!-- Google analytics script-->
            <script type="text/javascript">
              if(document.location.hostname == 'pratikborsadiya.in') {
               (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
               })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
               ga('create', 'UA-72504830-1', 'auto');
               ga('send', 'pageview');
             }
           </script>
           
           <script>
         //實現上傳圖片可以預覽所上傳的圖片,若重新上傳其他圖片,可以移除舊的圖片預覽,只顯示最新的狀態
let myFile = document.getElementById("myFile");
let preview = document.getElementById('preview');
let oldimg = document.getElementById('oldimg');

function init() {
    myFile.addEventListener('change', function(e) {
    	$("#preview").empty();
        let files = e.target.files;     
        if (files !== null) {          
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
                let reader = new FileReader();
                reader.addEventListener('load', function(e) { 
                    let result = e.target.result;
                    let img = document.createElement('img');
                    img.src = result;
                    preview.append(img);
                    oldimg.remove();
                });
                reader.readAsDataURL(file);
            } else {
            	alert('請上傳圖片！');
            }
        }
    });
}

window.onload = init;

</script>

</body>

<script>
        $("#twzipcode").twzipcode({
        	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
        	css: ["city form-control col-md-5", "town form-control col-md-5"], // 自訂 "城市"、"地別" class 名稱 
        	countyName: "city", // 自訂城市 select 標籤的 name 值
        	districtName: "town", // 自訂區別 select 標籤的 name 值
        	countySel: "<%=userVO.getCity()%>",
        	districtSel: "<%=userVO.getTown()%>",
        	zipcodeSel: "<%=userVO.getZipcode()%>"
        	});
</script>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
 		   value: '<%=userVO.getUser_dob()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
//         $.datetimepicker.setLocale('zh');
//         $('#f_date2').datetimepicker({
//            theme: '',              //theme: 'dark',
//  	       timepicker:false,       //timepicker:true,
//   	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
//  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
<%--  		   value: '<%=userVO.getRegdate()%>', // value:   new Date(), --%>
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//            //startDate:	            '2017/07/10',  // 起始日
//            //minDate:               '-1970-01-01', // 去除今日(不含)之前
//            //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
//         });
        

        
   
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