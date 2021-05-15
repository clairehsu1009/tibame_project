<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product_report.model.*"%>

<%
	Product_ReportVO product_reportVO = (Product_ReportVO) request.getAttribute("product_reportVO"); //EmpServlet.java(Concroller), 存入req的product_reportVO物件
%>

<html>
<head>
<title>商品檢舉資料 </title>

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
}
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>所有商品檢舉</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product_report/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>商品檢舉編號</th>
		<th>商品檢舉內容</th>
		<th>商品編號</th>
		<th>檢舉者帳號</th>
		<th>檢舉時間</th>
		<th>處理員工編號</th>
		<th>檢舉處理狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>

		<tr>
			<td>${product_reportVO.pro_report_no}</td>
			<td>${product_reportVO.pro_report_content}</td>
			<td>${product_reportVO.product_no}</td>
			<td>${product_reportVO.user_id}</td>
			<td><fmt:formatDate value="${product_reportVO.report_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${product_reportVO.empno}</td>
			<td>
			<c:choose>
    		<c:when test="${product_reportVO.proreport_state == 0}">
       			未處理
   			 </c:when>
   			 <c:when test="${product_reportVO.proreport_state == 1}">
       			審核通過
    		</c:when>
    		<c:when test="${product_reportVO.proreport_state == 2}">
       			審核不通過
    		</c:when>
			</c:choose>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="pro_report_no"  value="${product_reportVO.pro_report_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="pro_report_no"  value="${product_reportVO.pro_report_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>

	</table>

</body>
</html>