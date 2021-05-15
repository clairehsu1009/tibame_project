<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fun.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	FunVO funVO = (FunVO) request.getAttribute("funVO"); //EmpServlet.java(Concroller), 存入req的funVO物件
%>

<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

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

table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
	max-width: 89px;
	min-width: 89px;
}

table th .AutoNewline {
	width: 500px;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>網站功能資料 - ListOneFun.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/fun/selectFun.jsp"><img
						src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>功能編號</th>
			<th>功能名稱</th>
			<th>功能狀態</th>
	
		</tr>
		<tr>
			<td>${funVO.funno}</td>
			<td>${funVO.funName}</td>
			<c:choose>
					<c:when test="${funVO.state==0}">
						<td>關閉</td>
					</c:when>
					<c:when test="${funVO.state==1}">
						<td>開啟</td>
					</c:when>
				</c:choose>
			
		</tr>
	</table>

</body>
</html>