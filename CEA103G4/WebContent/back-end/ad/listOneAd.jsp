<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.ad.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	AdVO adVO = (AdVO) request.getAttribute("adVO"); //AdServlet.java(Concroller), 存入req的adVO物件
%>

<html>
<head>
<title>廣告資料 - listOneAd.jsp</title>

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
		<tr>
			<td>
				<h3>廣告資料 - ListOneAd.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ad/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>廣告編號</th>
			<th>員工編號</th>
			<th>廣告內容</th>
			<th>廣告圖片</th>
			<th>廣告狀態</th>
			<th>開始日期</th>
			<th>結束日期</th>
			<th>賣場網址</th>

		</tr>

		<tr>
			<td>${adVO.ad_no}</td>
			<td>${adVO.empno}</td>
			<td>${adVO.ad_content}</td>
			<td><img width="100px" height="100px" src="${pageContext.request.contextPath}/AdShowPhoto?ad_no=${adVO.ad_no}"></td>
			<td>
			${(adVO.ad_state)==0? '待上架':''}
			${(adVO.ad_state)==1? '已上架':''}
			</td>
			<td><fmt:formatDate value="${adVO.ad_start_date}"
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><fmt:formatDate value="${adVO.ad_end_date}"
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${adVO.ad_url}</td>

		</tr>
	</table>

</body>
</html>