<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.bid.model.*"%>

<%
	BidVO bidVO = (BidVO) request.getAttribute("bidVO");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>得標資料新增 - addBid.jsp</title>
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
		<tr>
			<td>
				<h3>得標新增 - addBid.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/bid/select_page.jsp"><img src="${pageContext.request.contextPath}/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>得標新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bid/bid.do" name="form1">
		<table>
			

			<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
			<tr>
				<td>得標會員帳號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="user_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(bidVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
				</select></td>
			</tr>

			<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
			<tr>
				<td>得標商品編號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="product_no">
					<c:forEach var="productVO" items="${productSvc.all}">
						<option value="${productVO.product_no}" ${(bidVO.product_no==productVO.product_no)? 'selected':'' } >${productVO.product_no}
					</c:forEach>
				</select></td>
			</tr>


			<tr>
				<td>得標價格:<font color=red><b>*</b></font></td>
				<td>
					<input type="TEXT" name="bid_price" size="45" value="<%= (bidVO==null)? "0" : bidVO.getBid_price()%>" />
				</td>
			</tr>
			
			
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

</html>