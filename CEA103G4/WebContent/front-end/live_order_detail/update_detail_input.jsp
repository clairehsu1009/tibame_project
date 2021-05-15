<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.live_order_detail.model.*"%>
<%
  Live_order_detailVO live_order_detailVO = (Live_order_detailVO) request.getAttribute("live_order_detailVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>直播訂單明細修改 - update_detail_input.jsp</title>

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
		 <h3>直播訂單明細資料修改 - update_detail_input.jsp</h3>
		  <h4><a href="<%=request.getContextPath()%>/front-end/live_order_detail/select_page.jsp"><img src="${pageContext.request.contextPath}/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order_detail/live_order_detail.do" name="form1">
<table>

		<jsp:useBean id="live_orderSvc" scope="page" class="com.live_order.model.Live_orderService" />
		<tr>
			<td>直播訂單編號:<font color=red><b>*</b></font></td>
			<td><%=live_order_detailVO.getLive_order_no()%></td>
		</tr>
		
		<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
		<tr>
			<td>商品編號:<font color=red><b>*</b></font></td>
			<td><select size="1" name="product_no" id="product_no">
				<option value=""  >
				<c:forEach var="productVO" items="${productSvc.all}">
					<option value="${productVO.product_no}" ${(live_order_detailVO.product_no==productVO.product_no)? 'selected':'' } >${productVO.product_no}
				</c:forEach>
			</select></td>
		</tr>
		
		<tr>
			<td>價格:</td>
			<td><input type="TEXT" name="price" size="45" value="<%= (live_order_detailVO==null)? "300" : live_order_detailVO.getPrice()%>"/></td>
		</tr>
		
		<tr>
			<td>數量:</td>
			<td><input type="TEXT" name="product_num" size="45" value="<%= (live_order_detailVO==null)? "1" : live_order_detailVO.getProduct_num()%>"/></td>
		</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="live_order_no"  value="<%=live_order_detailVO.getLive_order_no()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
<input type="submit" value="送出修改"></FORM>

<br>送出修改的來源網頁路徑:<br><b>
   <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
   <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (此範例目前只用於:istAllEmp.jsp))</b>
</body>

</html>