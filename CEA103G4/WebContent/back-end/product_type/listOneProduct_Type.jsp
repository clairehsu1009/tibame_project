<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.product_type.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  Product_TypeVO product_typeVO = (Product_TypeVO) request.getAttribute("product_typeVO"); //Product_TypeServlet.java(Controller), 存入req的product_typeVO物件
%>

<html>
<head>
<title>商品類別資料</title>

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
		 <h3>商品類別資料 </h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product_type/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>商品類別編號</th>
		<th>商品類別名稱</th>
	</tr>
	<tr>
		<td><%=product_typeVO.getPdtype_no()%></td>
		<td><%=product_typeVO.getPdtype_name()%></td>
	</tr>
</table>

</body>
</html>