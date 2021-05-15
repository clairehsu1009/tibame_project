<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Order: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Order: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Order: Home</p>

<h3>訂單查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllOrder.jsp'>List</a> all Orders.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="order.do" >
        <b>輸入訂單編號 (如6001):</b>
        <input type="text" name="order_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="orderSvc" scope="page" class="com.order.model.OrderService" />
   
  <li>
     <FORM METHOD="post" ACTION="order.do" >
       <b>選擇訂單編號:</b>
       <select size="1" name="order_no">
         <c:forEach var="orderVO" items="${orderSvc.all}" > 
          <option value="${orderVO.order_no}">${orderVO.order_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  <jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
  <li>
     <FORM METHOD="post" ACTION="order.do" >
       <b>選擇購買商品編號:</b>
       <select size="1" name="product_no">
         <c:forEach var="productVO" items="${productSvc.all}" > 
          <option value="${productVO.product_no}">${productVO.product_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Add">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
</ul>


<h3>訂單管理</h3>

</body>
</html>