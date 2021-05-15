<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.product.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
  ProductVO productVO = (ProductVO) request.getAttribute("productVO"); //ProductServlet.java(Controller), 存入req的productVO物件
%>
<jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />

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
		 <h3>商品資料 </h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品名稱</th>
		<th>商品說明</th>
		<th>商品價格</th>
		<th>商品原數量</th>
		<th>商品剩餘數量</th>
		<th>商品狀態</th>
		<th>商品照片</th>
		<th>會員帳號</th>
		<th>商品類別編號</th>
		<th>起標價</th>
		<th>直播編號</th>
	</tr>
	<tr>
			<td>${productVO.product_no}</td>
			<td>${productVO.product_name}</td>
			<td>${productVO.product_info}</td>
			<td>${productVO.product_price}</td>
			<td>${productVO.product_quantity}</td>
			<td>${productVO.product_remaining}</td>
						<td>
			<c:choose>
    		<c:when test="${productVO.product_state == 0}">
       			待售
   			 </c:when>
   			 <c:when test="${productVO.product_state == 1}">
       			直售
    		</c:when>
    		<c:when test="${productVO.product_state == 2}">
       			直播
    		</c:when>
    		<c:when test="${productVO.product_state == 3}">
       			已售出
   		 </c:when>
   		 <c:when test="${productVO.product_state == 4}">
       			下架
   		 </c:when>
       	 <c:when test="${productVO.product_state == 5}">
       		檢舉下架
   		 </c:when>
		</c:choose>
			</td>
			<td><img width="100px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}"></td>
			<td>${productVO.user_id}</td>
			<td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
			<td>${productVO.start_price}</td>
			<td>${productVO.live_no}</td>
	</tr>
</table>

</body>
</html>