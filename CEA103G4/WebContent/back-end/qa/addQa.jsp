<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.qa.model.*"%>

<%
	QaVO qaVO = (QaVO) request.getAttribute("qaVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>新增Q&A</title>
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
<style>
td {
padding: 15px 20px 5px 0px;
}
.app-title {
margin: -30px -30px 0px;
}
</style>

</head>
<body bgcolor='white' class="app sidebar-mini rtl">
<jsp:include page="/back-end/backendMenu.jsp" />
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-file-text"></i> 新增Q&A
			</h1>
			
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item"><a
				href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/QaServlet" name="form1">
		<table>
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
			<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
			<tr>
				<td>管理員編號：</td>
				<td><select size="1" name="empno">
					<c:forEach var="empVO" items="${empSvc.all}">
						<option value="${empVO.empno}" ${(qaVO.empno==empVO.empno)? 'selected':'' } >${empVO.empno}</option>
					</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>日期:</td>
				<td><input name="qa_date" class="form-control" size="45" id="f_date1" type="text" ></td>
			</tr>
			<tr>
				<td>問題：</td>
				<td><input name="question" class="form-control" size="45" type="text" value="<%=(qaVO == null) ? "" : qaVO.getQuestion()%>"  >
				</td>
			</tr>
			<tr>
				<td>解答：</td>
				<td>
				<textarea class="form-control" id="answer" style="resize:none; white-space:pre-wrap;" maxlength="300" rows="6" name="answer"><%=(qaVO == null) ? "" : qaVO.getAnswer()%></textarea>
				</td>
			</tr>

		</table>
		<br> 
		<input type="hidden" name="action" value="insert"> 
<%-- 		<input type="hidden" name="empno" value="${empVO.empno }">  --%>
		<input type="submit" class="btn btn-primary" value="送出新增">
	</FORM>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<% 
  java.sql.Date qa_date = null;
  try {
	  qa_date = qaVO.getQa_date();
   } catch (Exception e) {
	   qa_date = new java.sql.Date(System.currentTimeMillis());
   }
%>
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
 		   value: '<%=qa_date%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
     
</script>
</html>