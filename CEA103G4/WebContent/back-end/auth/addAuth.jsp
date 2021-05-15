<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.fun.model.*"%>
<%
	AuthVO authVO = (AuthVO) request.getAttribute("authVO");
%>
<%
	EmpVO empVO = (EmpVO) request.getAttribute("empVO");
%>


<% 
	EmpService empSvc = new EmpService(); 
 	List<EmpVO> list = empSvc.getAll(); 
	
 	AuthService authSvc = new AuthService(); 
 	List<AuthVO> list1 = authSvc.getAll(); 
	
 	for(int i = 0; i < list.size(); i++){ 
 		for(int j = 0; j < list1.size(); j++){ 
			if((list.get(i).getEmpno().intValue()==list1.get(j).getEmpno().intValue())){ 	
				list.remove(i);
				i--;
				break;
			} 
		} 
 		
	} 
 	
 	request.setAttribute("list", list);
 %> 
 
 <%=list.size() %>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>權限資料新增 - addAuth.jsp</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
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

<%-- <jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" /> --%>
<jsp:useBean id="funSvc" scope="page" class="com.fun.model.FunService" />


</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>權限資料新增 - addAuth.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/auth/selectAuth.jsp"><img
						src="<%=request.getContextPath()%>/images/tomcat.png" width="100"
						height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do"
		name="form1">
		<table>
			<tr>
				<td>選擇員工姓名:<font color=red><b>*</b></font>
				</td>
				<td><select size="1" name="empno">
						<c:forEach var="empVO" items="${list}">
							<option value="${empVO.empno}">${empVO.ename}</option>
						</c:forEach>
				</select></td>
			</tr>
		
			<tr>
				<td>選擇功能名稱:<font color=red><b>*</b></font></td>
				<td>
					<ul>
					<c:forEach var="funVO" items="${funSvc.all}">
							<li><input name = "funno" value="${funVO.funno}" type="hidden"></input>${funVO.funName}
							<select size="1" name="auth_no">
										<option value="1" ${(authVO.auth_no==1)? 'selected':''}>開</option>
										<option value="0" ${(authVO.auth_no==0)? 'selected':''}>關</option>
									</select></li>
						</c:forEach>
					
				</td>
			</tr>
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>



</html>