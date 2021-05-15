<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ProductDAO dao = new ProductDAO();
    List<ProductVO> list = dao.getAll();
    pageContext.setAttribute("list",list);
%>
<jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />

<html>
<head>
<title>所有商品資料 - listAllProduct.jsp</title>

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
	width: 800px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllProduct.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a></h4>
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
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
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
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="product_no"  value="${productVO.product_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="product_no"  value="${productVO.product_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
			
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
</body>
</html>