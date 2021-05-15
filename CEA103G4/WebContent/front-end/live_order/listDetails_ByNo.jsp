<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.emp.model.*"%>

<%-- <jsp:useBean id="listDetails_ByNo" scope="request" type="java.util.Set<Live_order_detailVO>" /> <!-- 於EL此行可省略 --> --%>
<jsp:useBean id="live_orderSvc" scope="page" class="com.live_order.model.Live_orderService" />


<html>
<head><title>訂單明細 - listDetails_ByNo.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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
<table id="table-2">
	<tr><td>
		 <h3>訂單明細 - listDetails_ByNo.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/live_order_detail/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>訂單編號</th>
		<th>商品編號</th>
		<th>價格</th>
		<th>數量</th>

	</tr>
	
	<c:forEach var="live_order_detailVO" items="${listDetails_ByNo}" >
		<tr${(live_order_detailVO.live_order_no==param.live_order_no)&&((live_order_detailVO.product_no==param.product_no)) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色-->
			<td>${live_order_detailVO.live_order_no}</td>
			<td>${live_order_detailVO.product_no}</td>
			<td>${live_order_detailVO.price}</td>
			<td>${live_order_detailVO.product_num}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order_detail/live_order_detail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="live_order_no"      value="${live_order_detailVO.live_order_no}">
			    <input type="hidden" name="product_no"      value="${live_order_detailVO.product_no}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order_detail/live_order_detail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
   			    <input type="hidden" name="live_order_no"      value="${live_order_detailVO.live_order_no}">
			    <input type="hidden" name="product_no"      value="${live_order_detailVO.product_no}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>