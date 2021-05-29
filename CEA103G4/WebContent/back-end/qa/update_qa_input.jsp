<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.qa.model.*"%>

<%
  QaVO qaVO = (QaVO) request.getAttribute("qaVO");
  request.setAttribute("qaVO", qaVO);
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
<title>修改Q&A資料</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
td {
padding: 15px 20px 5px 0px;
}
</style>
</head>
<body class="app sidebar-mini rtl">
<jsp:include page="/back-end/backendMenu.jsp" />
<main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-file-text"></i> 修改Q&A</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i class="fa fa-home fa-lg"></i></a></li>
                    <li class="breadcrumb-item">修改Q&A</li>
                  </ul>
                </div>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>         
         
<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/QaServlet" name="form1">
<table>
	<tr>
		<td>Q&A編號：</td>
		<td>${param.qa_no}</td>
	</tr>
	<tr>
		<td>Q&A類型：</td>
		<td>
		<select name="qa_type">
			<option value="1" ${(qaVO.qa_type==1)? 'selected':''}>帳務相關</option>
			<option value="2" ${(qaVO.qa_type==2)? 'selected':''}>商品相關</option>
			<option value="3" ${(qaVO.qa_type==3)? 'selected':''}>訂單相關</option>
			<option value="4" ${(qaVO.qa_type==4)? 'selected':''}>會員相關</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>員工編號：</td>
		<td>${qaVO.empno }</td>
	</tr>
	<tr>
		<td>日期：</td>
		<td><input name="qa_date" class="form-control" size="45" id="f_date1" type="text" >
		</td>
	</tr>
	<tr>
		<td>問題：</td>
		<td><input name="question" class="form-control" size="45" type="text" value="${qaVO.question }"  >
		</td>
	</tr>
	<tr>
		<td>解答：</td>
		<td>
		<textarea class="form-control" id="answer" style="resize:none; white-space:pre-wrap;" maxlength="300" rows="6" name="answer">${qaVO.answer }</textarea>
		</td>
	</tr>

</table>

<input type="hidden" name="action" value="update">
<input type="hidden" name="qa_no" value="${qaVO.qa_no }">
<input type="hidden" name="empno" value="${qaVO.empno }">
<button type="submit" class="btn btn-info">送出修改</button>
</FORM>

</main>
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
           <jsp:include page="/back-end/backendfooter.jsp" />
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=qaVO.getQa_date()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
     
</script>
</html>