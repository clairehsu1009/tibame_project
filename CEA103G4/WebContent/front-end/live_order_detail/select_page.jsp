<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Live_order_detail: Home</title>

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
   <tr><td><h3>IBM Live_order_detail: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Live_order_detail: Home</p>

<h3>資料查詢:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/live_order_detail/listAllDetail.jsp'>List</a> all Live_order_details. <br><br></li>
  

   <jsp:useBean id="live_orderSvc" scope="page" class="com.live_order.model.Live_orderService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order/live_order.do" >
       <b><font color=orange>選擇訂單編號:</font></b>
       <select size="1" name="live_order_no">
         <c:forEach var="live_orderVO" items="${live_orderSvc.all}" > 
          <option value="${live_orderVO.live_order_no}">${live_orderVO.live_order_no}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listDetails_ByNo_A">
     </FORM>
  </li>
</ul>


<h3>訂單明細管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/live_order_detail/addDetail.jsp'>Add</a> a new Live_order_detail.</li>
</ul>

<h3><font color=orange>訂單管理</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/live_order/listAllLive_order.jsp'>List</a> all Live_orders. </li>
</ul>

</body>
</html>