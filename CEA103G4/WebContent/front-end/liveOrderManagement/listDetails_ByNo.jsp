<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%-- <jsp:useBean id="listDetails_ByNo" scope="request" type="java.util.Set<Live_order_detailVO>" /> <!-- 於EL此行可省略 --> --%>
<jsp:useBean id="live_orderSvc" scope="page"
	class="com.live_order.model.Live_orderService" />


<html>
<head>
<title>訂單明細 - listDetails_ByNo.jsp</title>



</head>
<body bgcolor='white'>


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>


	<div class="row">
		<div class="col-xl-12">
			<div class="tile">
				<h3 class="tile-title">訂單明細</h3>
				<table class="table table-hover">
				<thead>
					<tr>
						<th>訂單編號</th>
						<th>商品編號</th>
						<th>價格</th>
						<th>數量</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
					<c:forEach var="live_order_detailVO" items="${listDetails_ByNo}">
						<tr
							${(live_order_detailVO.live_order_no==param.live_order_no)&&((live_order_detailVO.product_no==param.product_no)) ? 'bgcolor=#CCCCFF':''}>
							<!--將修改的那一筆加入對比色-->
							<td>${live_order_detailVO.live_order_no}</td>
							<td>${live_order_detailVO.product_no}</td>
							<td>${live_order_detailVO.price}</td>
							<td>${live_order_detailVO.product_num}</td>
<!-- 							<td> -->
<!-- 								<FORM METHOD="post" -->
<%-- 									ACTION="<%=request.getContextPath()%>/live_order_detail/live_order_detail.do" --%>
<!-- 									style="margin-bottom: 0px;"> -->
<!-- 									<input type="submit" value="修改" class="btn btn-info"> <input type="hidden" -->
<!-- 										name="live_order_no" -->
<%-- 										value="${live_order_detailVO.live_order_no}"> <input --%>
<!-- 										type="hidden" name="product_no" -->
<%-- 										value="${live_order_detailVO.product_no}"> <input --%>
<!-- 										type="hidden" name="requestURL" -->
<%-- 										value="<%=request.getServletPath()%>"> --%>
<!-- 									送出本網頁的路徑給Controller -->
<!-- 									目前尚未用到  -->
<!-- 									<input type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 								</FORM> -->
<!-- 							</td> -->
<!-- 							<td> -->
<!-- 								<FORM METHOD="post" -->
<%-- 									ACTION="<%=request.getContextPath()%>/live_order_detail/live_order_detail.do" --%>
<!-- 									style="margin-bottom: 0px;"> -->
<!-- 									<input type="submit" value="刪除" class="btn btn-danger"> <input type="hidden" -->
<!-- 										name="live_order_no" -->
<%-- 										value="${live_order_detailVO.live_order_no}"> <input --%>
<!-- 										type="hidden" name="product_no" -->
<%-- 										value="${live_order_detailVO.product_no}"> <input --%>
<!-- 										type="hidden" name="requestURL" -->
<%-- 										value="<%=request.getServletPath()%>"> --%>
<!-- 									送出本網頁的路徑給Controller -->
<!-- 									<input type="hidden" name="action" value="delete"> -->
<!-- 								</FORM> -->
<!-- 							</td> -->
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>

</body>
</html>