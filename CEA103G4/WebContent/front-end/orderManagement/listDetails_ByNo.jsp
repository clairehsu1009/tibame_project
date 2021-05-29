<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="orderSvc" scope="page"
	class="com.order.model.OrderService" />

<html>
<head>
<title>訂單明細 - listDetails_ByNo.jsp</title>



</head>
<body bgcolor='white'>
<jsp:useBean id="productSvc" scope="page"
	class="com.product.model.ProductService" />

	<div class="row">
		<div class="col-xl-12">
			<div class="tile">
				<h3 class="tile-title">訂單明細</h3>
				<table class="table table-hover">
				<thead>
					<tr>
						<th>訂單編號</th>
						<th>商品編號</th>
						<th>商品圖片</th>
						<th>商品名稱</th>
						<th>價格</th>
						<th>數量</th>
					</tr>
				</thead>
					<c:forEach var="order_detailVO" items="${listDetails_ByNo}">
				<c:if test="${orderSvc.getOneOrder(order_detailVO.order_no).srating == 0}">
						<tr>
							<td>${order_detailVO.order_no}</td>
							<td>${order_detailVO.product_no}</td>
							<td><img width="120px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${order_detailVO.product_no}"
							class="rounded d-block" alt="" style="margin:0px; "></td>
							
							<td>${productSvc.getOneProduct(order_detailVO.product_no).product_name}</td>
							<td>${order_detailVO.order_price}</td>
							<td>${order_detailVO.product_num}</td>
						</tr>
				</c:if>
					</c:forEach>
					<c:forEach var="order_detailVO" items="${listDetails_ByNo}">
				<c:if test="${orderSvc.getOneOrder(order_detailVO.order_no).srating != 0}">
						<tr>
							<td>${order_detailVO.order_no}</td>
							<td>${order_detailVO.product_no}</td>
							<td><img width="120px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${order_detailVO.product_no}"
							class="rounded d-block" alt="" style="margin:0px; "></td>
							
							<td>${productSvc.getOneProduct(order_detailVO.product_no).product_name}</td>
							<td>${order_detailVO.order_price}</td>
							<td>${order_detailVO.product_num}</td>
						</tr>
				</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>

</body>
</html>