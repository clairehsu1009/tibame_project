<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.live_report.model.*"%>

<%
	Live_reportVO live_reportVO = (Live_reportVO) request.getAttribute("live_reportVO"); //EmpServlet.java (Concroller) 存入req的live_reportVO物件 (包括幫忙取出的live_reportVO, 也包括輸入資料錯誤時的live_reportVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>直播檢舉修改 - update_live_report_input.jsp</title>

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
		<tr>
			<td>
				<h3>直播檢舉資料修改 - update_live_report_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/live_report/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>直播檢舉編號:<font color=red><b>*</b></font></td>
				<td><%=live_reportVO.getLive_report_no()%></td>
			</tr>
			<tr>
				<td>直播檢舉內容:</td>
				<td><input type="TEXT" name="live_report_content" size="45"
					value="<%=live_reportVO.getLive_report_content()%>" /></td>
			</tr>
						<tr>
				<td>直播編號:</td>
				<td><input type="TEXT" name="live_no" size="45"
					value="<%=live_reportVO.getLive_no()%>" /></td>
			</tr>
						<tr>
				<td>直播檢舉者ID:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="user_id" size="45"
					value="<%=live_reportVO.getUser_id()%>" /></td>
			</tr>
						<tr>
				<td>員工編號:</td>
				<td><input type="TEXT" name="empno" size="45" value="<%=live_reportVO.getEmpno()%>" /></td>
			</tr>
						<tr>
				<td>直播檢舉處理狀態:</td>
				<td><select name="live_report_state">
						<option value="0" ${(live_reportVO.live_report_state==0)? 'selected':''}>未處理</option>
						<option value="1" ${(live_reportVO.live_report_state==1)? 'selected':''}>審核通過</option>
						<option value="2" ${(live_reportVO.live_report_state==2)? 'selected':''}>審核不通過</option>
				</select></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>直播檢舉日期:<font color=red><b>*</b></font></td> -->
<%-- 				<td><%=live_reportVO.getReport_date()%></td> --%>
<!-- 			</tr>		 -->
			<tr>
				<td>檢舉截圖:</td>
				<td><img src="${pageContext.request.contextPath}/live_report/DBGifReader.do?live_report_no=${live_reportVO.live_report_no}" width="250px"></td>
			</tr>
	
	
		</table>
		<br> <input type="hidden" name="action" value="update"> 
		<input type="hidden" name="live_report_no" value="<%=live_reportVO.getLive_report_no()%>">
			 <input type="submit" value="送出修改">
	</FORM>
</body>


</html>