<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product_type.model.*"%>

<%
  Product_TypeVO product_typeVO = (Product_TypeVO) request.getAttribute("product_typeVO"); //EmpServlet.java (Concroller) 存入req的product_typeVO物件 (包括幫忙取出的product_typeVO, 也包括輸入資料錯誤時的product_typeVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>商品類別新增</title>

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
		 <h3>商品類別新增 </h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product_type/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>商品類別新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" name="form1">
<table>

	<tr>
		<td>商品類別名稱:</td>
		<td><input type="TEXT" name="pdtype_name" size="45" 
			 value="<%= (product_typeVO==null)? "" : product_typeVO.getPdtype_name()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>

</html>