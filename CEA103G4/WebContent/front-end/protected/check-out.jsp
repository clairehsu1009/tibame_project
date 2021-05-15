<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.*"%>
<%@ page import="com.product.controller.*"%>
<%@ page import="com.order.model.*"%>
<%

	ProductDAO dao = new ProductDAO();
	List<ProductVO> products = dao.getAllShop();
	pageContext.setAttribute("products", products);

	UserVO userVO = (UserVO) session.getAttribute("account");
	session.setAttribute("userVO", userVO);

    Vector<ProductVO> buylist3 = (Vector<ProductVO>) session.getAttribute("shoppingcart");
    
    if(buylist3 != null){
    	
	Map<String, Vector<ProductVO>> mBuylist = new HashMap<String, Vector<ProductVO>>();
	for(ProductVO vo:buylist3) {
		String user_id = vo.getUser_id();
		Vector<ProductVO> vector = mBuylist.get(user_id);
		if(vector == null) {
			vector = new Vector<ProductVO>();
		}
		vector.add(vo);
		mBuylist.put(user_id, vector);
	}
	pageContext.setAttribute("mBuylist", mBuylist);
    }
	
		
 %>



<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Modefemme</title>

<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
	rel="stylesheet" />

<!-- Css Styles -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/themify-icons.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/nice-select.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/style.css"
	type="text/css" />
<style>
.checkout-section {
	padding-top: 20px;
}

#twzipcode {
	display: inline;
}

.select-option {
	text-align: center;
}
</style>

</head>

<body>



	<!-- Header Section Begin -->
	<%@include file="/front-end/header.jsp"%>
	<!-- Header End -->
	<!-- Breadcrumb Section Begin -->
	<div class="breacrumb-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb-text product-more">
						<a href="./index.html"><i class="fa fa-home"></i> Home</a> <a
							href="./shop.html">Shop</a> <span>Check Out</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb Section Begin -->

	<!-- Shopping Cart Section Begin -->
	<section class="checkout-section spad">
		<div class="container">
			<form action="#" class="checkout-form">
				<div class="row">
					<div class="col-lg-6">
						<h4>付款明細</h4>
						<div class="row">
							<div class="col-lg-12">
								<label for="rec_name">收件人姓名:<span>*</span></label> <input
									type="text" name="rec_name" id="rec_name"
									value="${userVO.user_name}" />
							</div>
							<div class="col-lg-12">
								<label for="rec_addr">收件人地址:<span>*</span></label>
								<div class="" id="twzipcode"></div>
								<input type="text" name="rec_addr" id="rec_addr"
									value="${userVO.user_addr}" />
							</div>
							<div class="col-lg-6">
								<label for="rec_phone">收件人電話:<span>*</span></label> <input
									name="rec_phone" type="text" id="rec_phone"
									value="${userVO.user_phone}" />
							</div>
							<div class="col-lg-6">
								<label for="rec_cellphone">收件人手機:<span>*</span></label> <input
									name="rec_cellphone" type="text" id="rec_cellphone"
									value="${userVO.user_mobile}" />
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="place-order">
							<h4>你的訂單</h4>
							
		  <c:set var="sum" value="0"> </c:set>
			<c:forEach var="entry" items="${mBuylist}">
            <div class="cart-table">
              <table class="table">
                <thead class="thead">
                  <tr>
                    <th>商品圖</th>
                    <th>商品名稱</th>
                    <th>單價</th>
                    <th>數量</th>
                    <th>總計</th>
                  </tr>
                </thead>
                <tbody>
                	<tr><td style="padding-bottom:0px;" colspan="5"><a href="<%=request.getContextPath()%>/SellerProducts?user_id=${entry.key}" target="_blank"><button class="btn btn-outline-warning" type="button"><i class="fa fa-diamond" style="display:inline-block;"></i>&nbsp;${entry.key}</button></a></td></tr>
                  <c:forEach var="order" items="${entry.value}" varStatus="cartstatus">
                  <tr>
                    <td class="cart-pic first-row">
                    <a href="<%=request.getContextPath()%>/product/product.do?product_no=${order.product_no}">
                      <img src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${order.product_no}" alt="${order.product_name}"  />
                    </a>
                    </td>
                    <td class="p-name first-row">
                      <h5>${order.product_name }</h5>
                    </td>
                    <td class="PP${order.product_no} first-row" value="${order.product_price}">$${order.product_price }</td>
                    <td class="qua-col first-row">
                      <div class="quantity" style="margin-top: 30px;">
                      <div>${order.product_quantity}</div>
                      </div>
                    </td>
                    <td>
                    <div id="TP${order.product_no}" class="cartProductItemSumPrice" style="margin-top: 30px;color: #e7ab3c;">${order.product_price*order.product_quantity}</div>
					</td>
                  </tr>
                  <c:set var="sum" value="${sum + order.product_price*order.product_quantity}"> </c:set>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            </c:forEach>
							
<!-- 							<div class="order-total"> -->
<!-- 								<ul class="order-table"> -->
<!-- 									<li>產品 <span>總金額</span></li> -->
<!-- 									<li class="fw-normal">Combination x 1 <span>$60.00</span> -->
<!-- 									</li> -->
<!-- 									<li class="fw-normal">Combination x 1 <span>$60.00</span> -->
<!-- 									</li> -->
<!-- 									<li class="fw-normal">Combination x 1 <span>$120.00</span> -->
<!-- 									</li> -->
<!-- 									<li class="total-price">總金額 <span>$240.00</span></li> -->
<!-- 								</ul> -->
<!-- 								<div class="product-show-option"> -->
<!-- 									<div class="row"> -->
<!-- 										<div class="col-lg-6 col-md-6"> -->
<!-- 											<div class="select-option"> -->
<!-- 												<select name="pay_method" class="p-show" id="pay_method"> -->
<!-- 													<option value="">選擇付款方式</option> -->
<!-- 													<option value="0">錢包</option> -->
<!-- 													<option value="1">信用卡</option> -->
<!-- 													<option value="2">轉帳</option> -->
<!-- 												</select> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										<div class="col-lg-6 col-md-6"> -->
<!-- 											<div class="select-option"> -->
<!-- 												<select name="logistics" class="p-show" id="logistics"> -->
<!-- 													<option value="">選擇物流方式</option> -->
<!-- 													<option value="0">超商</option> -->
<!-- 													<option value="1">宅配</option> -->
<!-- 												</select> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="order-btn"> -->
<!-- 									<button type="submit" class="site-btn place-btn">送出</button> -->
<!-- 									<input type="hidden" value="addOrderList" name="action"> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>
	<!-- Shopping Cart Section End -->


	<!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
	<!-- Footer Section End -->

	<!-- Js Plugins -->

	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
	<script type="text/javascript">
		$("#twzipcode").twzipcode({
			zipcodeIntoDistrict : true, // 郵遞區號自動顯示在區別選單中
			css : [ "city form-control", "town form-control" ], // 自訂 "城市"、"地別" class 名稱 
			countyName : "city", // 自訂城市 select 標籤的 name 值
			districtName : "town", // 自訂區別 select 標籤的 name 值
			countySel : "${userVO.city}",
			districtSel : "${userVO.town}",
			zipcodeSel : "${userVO.zipcode}"
		});
	</script>
</body>
</html>
