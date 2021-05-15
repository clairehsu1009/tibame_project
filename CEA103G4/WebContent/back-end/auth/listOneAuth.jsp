<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="com.emp.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	AuthVO authVO = (AuthVO) request.getAttribute("authVO");
%>
<%
	EmpVO empVO = (EmpVO)session.getAttribute("account");
	session.setAttribute("empVO", empVO);
%>
<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
<jsp:useBean id="funSvc2" scope="page" class="com.fun.model.FunService" />

<html>
<head>
<title>權限資料 - listOneAuth .jsp</title>

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
				<h3>網站權限資料 - ListOneAuth.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/auth/selectAuth.jsp"><img
						src="<%=request.getContextPath()%>/images/back1.gif" width="100"
						height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<table  class="layui-table layui-form">
		<tr>
			<th>功能編號</th>
<!-- 			<th>功能名稱</th> -->
			<th>員工編號</th>
<!-- 			<th>員工姓名</th> -->
			<th>狀態</th>
		</tr>
		<tr>
			<td>${authVO.empno}</td>
			<td>${authVO.funno}</td>
			<td>${authVO.auth_no}</td>
		</tr>
	
	</table>


</body>
</html>