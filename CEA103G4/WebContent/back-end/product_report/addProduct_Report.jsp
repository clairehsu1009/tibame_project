<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product_report.model.*"%>

<%
  Product_ReportVO product_reportVO = (Product_ReportVO) request.getAttribute("product_reportVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>商品資料新增 - addProduct.jsp</title>

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
		 <h3>商品檢舉資料新增 </h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product_report/select_page.jsp">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" name="form1">
<table>
	
	<tr>
		<td>商品檢舉內容:</td>
		<td><input type="TEXT" name="pro_report_content" size="45" value="<%= (product_reportVO==null)? "" : product_reportVO.getPro_report_content()%>" /></td>
	</tr>
	<tr>
		<td>商品編號:</td>
		<td><input type="TEXT" name="product_no" size="45" value="<%= (product_reportVO==null)? "" : product_reportVO.getProduct_no()%>" /></td>
	</tr>
	<tr>
		<td>檢舉者帳號:</td>
		<td><input type="TEXT" name="user_id" size="45" value="<%= (product_reportVO==null)? "" : product_reportVO.getUser_id()%>"  /></td>
	</tr>
	<tr>
		<td>處理員工編號:</td>
		<td><input type="TEXT" name="empno" size="45" value="<%= (product_reportVO==null)? "14002" : product_reportVO.getEmpno()%>" /></td>
	</tr>
	
	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>

</html>