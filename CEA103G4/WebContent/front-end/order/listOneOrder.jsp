<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.order.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	OrderVO orderVO = (OrderVO) request.getAttribute("orderVO"); //OrderServlet.java(Concroller), 存入req的OrderVO物件
%>

<html>
<head>
<title>訂單資料 - listOneOrder.jsp</title>

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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>訂單資料 - ListOneOrder.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>訂單編號</th>
		<th>訂單日期</th>
		<th>付款截止時間</th>
		<th>訂單狀態</th>
		<th>訂單運費</th>
		<th>訂單價格</th>
		<th>付款方式</th>
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
	<tr>
		<td>${orderVO.order_no}</td>
		<td>${orderVO.order_date}</td>
		<td>${orderVO.pay_deadline}</td>
		<td>${(orderVO.order_state==0)? "未付款":"已付款"}</td>
		<td>${orderVO.order_shipping}</td>
		<td>${orderVO.order_price}</td>
		<td>${(orderVO.pay_method==0)? "信用卡":"轉帳"}</td>
		<td>${orderVO.rec_name}</td>
		<td>${orderVO.zipcode}${orderVO.city}${orderVO.town}${orderVO.rec_addr}</td>
		<td>${orderVO.rec_phone}</td>
		<td>${orderVO.rec_cellphone}</td>
		<td>${(orderVO.logistics==0)? "超商":"宅配"}</td>
		<td>
		${(orderVO.logisticsstate==0)? "未出貨":""}
		${(orderVO.logisticsstate==1)? "已出貨":""}
		${(orderVO.logisticsstate==2)? "已取貨":""}
		</td>
		<td>${orderVO.discount}</td>
		<td>${orderVO.user_id}</td>
		<td>${orderVO.seller_id}</td>
		<td>${orderVO.srating}</td>
		<td>${orderVO.srating_content}</td>
		<td>${orderVO.point}</td>
	</tr>
</table>

</body>
</html>