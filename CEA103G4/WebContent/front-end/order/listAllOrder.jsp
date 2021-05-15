<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    OrderService orderSvc = new OrderService();
    List<OrderVO> list = orderSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有聊天資料 - listAllOrder.jsp</title>

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
	width: auto;
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
		 <h3>所有訂單資料 - listAllOrder.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>訂單日期</th>
		<th>訂單狀態</th>
		<th>訂單運費</th>
		<th>訂單價格</th>
		<th>付款方式</th>
		<th>付款截止期限</th>
		<th>收件人姓名</th>
		<th>收件人地址</th>
		<th>收件人電話</th>
		<th>收件人手機</th>
		<th>物流方式</th>
		<th>物流狀況</th>
		<th>點數折抵</th>
		<th>買家帳號</th>
		<th>賣家帳號</th>
		<th>賣家評價分數</th>
		<th>賣家評價內容</th>
		<th>點數回饋</th>
		
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="orderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${orderVO.order_no}</td>
			<td><fmt:formatDate value="${orderVO.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${(orderVO.order_state==0)? '未付款':'已付款'}</td>
			<td>${orderVO.order_shipping}</td>
			<td>${orderVO.order_price}</td>
			<td>
				${(orderVO.pay_method==0)? '錢包':''}
				${(orderVO.pay_method==1)? '信用卡':''}
				${(orderVO.pay_method==2)? '轉帳':''}
			</td>
			<td><fmt:formatDate value="${orderVO.pay_deadline}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${orderVO.rec_name}</td>
			<td>${orderVO.zipcode}${orderVO.city}${orderVO.town}${orderVO.rec_addr}</td>
			<td>${orderVO.rec_phone}</td>
			<td>${orderVO.rec_cellphone}</td>
			<td>${(orderVO.logistics==0)? '超商':'宅配'}</td>
			<td>
			${(orderVO.logisticsstate==0)? '未出貨':''}
			${(orderVO.logisticsstate==1)? '已出貨':''}
			${(orderVO.logisticsstate==2)? '已取貨':''}
			</td>
			<td>${orderVO.discount}</td>
			<td>${orderVO.user_id}</td>
			<td>${orderVO.seller_id}</td>
			<td>${orderVO.srating}</td>
			<td>${orderVO.srating_content}</td>
			<td>${orderVO.point}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/order/order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="order_no"  value="${orderVO.order_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/order/order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="order_no"  value="${orderVO.order_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>