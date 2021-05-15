<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.live_order.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  Live_orderVO live_orderVO = (Live_orderVO) request.getAttribute("live_orderVO"); //EmpServlet.java(Concroller), 存入req的live_orderVO物件
%>

<html>
<head>
<title>直播訂單資料 - listOneLive_order.jsp</title>

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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>直播訂單資料 - ListOneLive.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/live_order/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>直播訂單編號</th>
		<th>訂單時間</th>
		<th>訂單狀態</th>
		<th>訂單運費</th>
		<th>訂單金額</th>
		<th>付款方式</th>
		<th>付款截止時間</th>
		<th>收件人姓名</th>
		<th>收件人地址</th>
		<th>收件人電話</th>
		<th>收件人手機</th>
		<th>物流方式</th>
		<th>物流狀態</th>
		<th>使用點數折抵</th>
		<th>直播編號</th>
		<th>會員帳號</th>
		<th>賣家帳號</th>
		<th>賣家評價分數</th>
		<th>賣家評價內容</th>
		<th>點數回饋</th>
	</tr>
		<tr>
			<td>${live_orderVO.live_order_no}</td>
			<td><fmt:formatDate value="${live_orderVO.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${(live_orderVO.order_state==0)? '收到訂單':'完成訂單'}</td>
			<td>${live_orderVO.order_shipping}</td>
			<td>${live_orderVO.order_price}</td>
			<td>
			${(live_orderVO.pay_method==0)? '錢包':''}
			${(live_orderVO.pay_method==1)? '信用卡':''}
			${(live_orderVO.pay_method==2)? '轉帳':''}
			</td> 
			<td><fmt:formatDate value="${live_orderVO.pay_deadline}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${live_orderVO.rec_name}</td>
			<td>${live_orderVO.zipcode}${live_orderVO.city}${live_orderVO.town}${live_orderVO.rec_addr}</td>
			<td>${live_orderVO.rec_phone}</td>
			<td>${live_orderVO.rec_cellphone}</td>
			<td>
			${(live_orderVO.logistics==0)? '宅配':'超商取貨'}
			</td>
			
			<td>
			${(live_orderVO.logistics_state==0)? '未出貨':''}
			${(live_orderVO.logistics_state==1)? '已出貨':''}
			${(live_orderVO.logistics_state==2)? '買家已取貨':''}
			</td>
			
			<td>${live_orderVO.discount}</td>
			<td>${live_orderVO.live_no}</td>
			<td>${live_orderVO.user_id}</td>
			<td>${live_orderVO.seller_id}</td>
			<td>${live_orderVO.srating}</td>
			<td>${live_orderVO.srating_content}</td>
			<td>${live_orderVO.point}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order/live_order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="live_order_no"  value="${live_orderVO.live_order_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order/live_order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="live_order_no"  value="${live_orderVO.live_order_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		<tr>
</table>

</body>
</html>