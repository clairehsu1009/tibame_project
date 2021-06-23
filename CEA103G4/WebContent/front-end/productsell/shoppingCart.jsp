<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.* , com.product.model.*" %>

<%


    Vector<ProductVO> buylist2 = (Vector<ProductVO>) session.getAttribute("shoppingcart");
    
    if(buylist2 != null){
    	
	Map<String, Vector<ProductVO>> mBuylist = new HashMap<String, Vector<ProductVO>>();
	for(ProductVO vo:buylist2) {
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
<html lang="zxx">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content="Fashi Template" />
    <meta name="keywords" content="Fashi, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>ShoppingCart - Mode Femme</title>
	<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
      rel="stylesheet"
    />

    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/themify-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/nice-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/style.css" type="text/css" />
  <style>
  .shopping-cart {
    padding-top: 0px;
}
.cart-table table tr td.qua-col .productCounts {
  width: 123px;
  height: 46px;
  border: 2px solid #ebebeb;
  padding: 0 15px;
  float: left;
}

.cart-table table tr td.qua-col .productCounts .qtybtn {
  font-size: 24px;
  color: #b2b2b2;
  float: left;
  line-height: 38px;
  cursor: pointer;
  width: 18px;
}

.cart-table table tr td.qua-col .productCounts .qtybtn.dec {
  font-size: 30px;
}

.cart-table table tr td.qua-col .productCounts input {
  text-align: center;
  width: 52px;
  font-size: 14px;
  font-weight: 700;
  border: none;
  color: #4c4c4c;
  line-height: 40px;
  float: left;
}

.btn-info {
    color: #fff;
    background-color: #17a2b8;
    border-color: #17a2b8;
    font-weight: 500;
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
              <a href="${pageContext.request.contextPath}/front-end/index.jsp"><i class="fa fa-home"></i> 首頁</a>
              <a href="${pageContext.request.contextPath}/front-end/productsell/shop.jsp">商品頁</a>
              <span>購物車清單</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad" id="shopping_cart">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
<%if (buylist != null && (buylist.size() > 0)) {%>   
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
                    <th>小計</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody>
                	<tr><td style="padding-bottom:5px;"><a href="<%=request.getContextPath()%>/SellerProducts?user_id=${entry.key}" target="_blank"><button class="btn btn-outline-warning" type="button"><i class="fa fa-diamond" style="display:inline-block;"></i>&nbsp;${entry.key}</button></a></td></tr>
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
                      
                      
                     <div id="PC${order.product_no}" class="productCounts" >
                     <span id="dec${order.product_no}" class="dec qtybtn dec${order.product_no}" >-</span>
                      <input name="${order.product_no}" id="PN${order.product_no}" type="text" value="${order.product_quantity}" />
                      <span id="Add${order.product_no}" class="inc qtybtn Add${order.product_no}" style="none">+</span>
                    </div>
                      </div>
                      <span id="max${order.product_no}" value="${order.product_remaining}">在庫數量：${order.product_remaining}</span>
                    </td>
                    <td>
                    <div id="TP${order.product_no}" class="cartProductItemSumPrice" style="margin-top: 30px;color: #e7ab3c;">${order.product_price*order.product_quantity}</div>
					</td>
					<td class="close-td first-row">
                    <form action="<%=request.getContextPath()%>/ShoppingServlet" method="POST">
		              <input type="hidden" name="action"  value="DELETE">
		              <input type="hidden" name="delProductNo" value="${order.product_no}">
		              <input type="submit" class="btn btn-info" value="刪 除">
		          	</form>
		          	</td>
                  </tr>
                  <c:set var="sum" value="${sum + order.product_price*order.product_quantity}"> </c:set>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            </c:forEach>
            
            <div class="row">
              <div class="col-lg-2 col-6">
                <div class="cart-buttons">
                  <a href="<%=request.getContextPath()%>/front-end/productsell/shop.jsp" class="btn btn-info"
                    >繼續購物</a>
                </div>
              </div>
              <div class="col-lg-2 offset-lg-8 col-6">
              <form action="<%=request.getContextPath()%>/ShoppingServlet" method="POST">
                    <input type="hidden" name="action"  value="DELETEALL">
                    <input class="btn btn-info" style="margin-left: 45px;" type="submit" value="清空購物車"
                    ></input></form>
              </div>
              <div class="col-lg-4 offset-lg-8">
                <div class="proceed-checkout">
                  <ul>
                    <li class="cart-total">合計 <span id="Sum">${sum}</span></li>
                  </ul>
                  <a href="<%=request.getContextPath()%>/front-end/protected/check-out.jsp" class="proceed-btn" id="checkOut">結帳</a>
                </div>
              </div>
            </div>
<%}%>
         <%if (buylist == null) {%>   
                	<div style="text-align: center;color:#e7ab3c;font-weight: 700;font-size: x-large;margin-top: 10px;margin-bottom: 10px;">您的購物車空空如也...</div>
                	<div style="text-align: center;"><a href="<%=request.getContextPath()%>/front-end/productsell/shop.jsp" class="btn btn-info">去購物吧！</a></div>
          <%}%>
          </div>
        </div>
      </div>
    </section>

    <!-- Shopping Cart Section End -->



    <!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/products-search.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>


<script>
<c:forEach var="order" items="${buylist}" varStatus="cartstatus">  
// 各商品小計
    	// 直接修改數量
    	$("#PC${order.product_no}").change(function(){

			var newValue = $('#PC${order.product_no}').parent().find('input').val();
			var maxRemaining = $("#max${order.product_no}").attr("value");

			if(parseInt(newValue) >= parseInt(maxRemaining)){
				$('input[name="${order.product_no}"]').val(maxRemaining);
				let totalPrice = ($(".PP${order.product_no}").attr("value"))*($("#PN${order.product_no}").val());
				$("#TP${order.product_no}").text(totalPrice);
				sum();
			}else if(parseInt(newValue) <= 0){
				$('input[name="${order.product_no}"]').val(1);
				let totalPrice = ($(".PP${order.product_no}").attr("value"))*($("#PN${order.product_no}").val());
				$("#TP${order.product_no}").text(totalPrice);
				sum();
			}else if(parseInt(newValue) < parseInt(maxRemaining)){
				$('input[name="${order.product_no}"]').val(newValue);
				let totalPrice = ($(".PP${order.product_no}").attr("value"))*($("#PN${order.product_no}").val());
				$("#TP${order.product_no}").text(totalPrice);
				sum();
			}
    	});
    	// 直接修改數量並刷新後，商品數量不變
    	shopping_cart.addEventListener('change', event => {
    			$.ajax({ 
   	 		  type:"POST",
    				  url:"<%=request.getContextPath()%>/ShoppingServlet",
   	 		  data:{
   	 			  "product_no": "${order.product_no}",
   	 			  "product_name": "${order.product_name}",
   	 			  "product_price": "${order.product_price}",
   	 			  "proqty": $('input[name="${order.product_no}"]').val(),
   	 			  "product_remaining": "${order.product_remaining}",
   	 			  "user_id": "${order.user_id}",
   	 			  "action": "updateCount"
   	 		  },
   	 		  success: function(res) {
				  const cartproducts=cartProduct(res, "<%=request.getContextPath()%>"); 
				  $("#carts").html(cartproducts); 
				  
				  var carRes  = JSON.parse(res)
				  var ibaCount = carRes["results"].length;
				  $("#iba").html(ibaCount);

				  var titlePrice = 0
					carRes["results"].forEach(function (item,index) {
						titlePrice += (item.product_price * item.product_quantity)
					});
				  $(".cart-price").html("$" + titlePrice);
				  $("#cartHoverTotal").html("$" + titlePrice);
   	 			  }
   	 		  });
    	});
		
    	 </c:forEach> 
    	</script>
    <script>		
    const shopping_cart = document.getElementById('shopping_cart')
// 各商品小計
     <c:forEach var="order" items="${buylist}" varStatus="cartstatus">  
     	// 點擊+-
    	$("#PC${order.product_no}").click(function(e){
			let totalPrice = ($(".PP${order.product_no}").attr("value"))*($("#PN${order.product_no}").val());
			$("#TP${order.product_no}").text(totalPrice);
			sum();
		});
   		// 點擊+-並刷新後，商品數量不變
    	shopping_cart.addEventListener('click', event => {
    		if (event.target.matches('.dec${order.product_no}')) {
    			
    			$.ajax({ 
   	 		  type:"POST",
    				  url:"<%=request.getContextPath()%>/ShoppingServlet",
   	 		  data:{
   	 			  "product_no": "${order.product_no}",
   	 			  "product_name": "${order.product_name}",
   	 			  "product_price": "${order.product_price}",
   	 			  "proqty": $('input[name="${order.product_no}"]').val(),
   	 			  "product_remaining": "${order.product_remaining}",
   	 			  "user_id": "${order.user_id}",
   	 			  "action": "updateCount"
   	 		  },
   	 		  success: function(res) {
				  const cartproducts=cartProduct(res, "<%=request.getContextPath()%>"); 
				  $("#carts").html(cartproducts); 
				  
				  var carRes  = JSON.parse(res)
				  var ibaCount = carRes["results"].length;
				  $("#iba").html(ibaCount);

				  var titlePrice = 0
					carRes["results"].forEach(function (item,index) {
						titlePrice += (item.product_price * item.product_quantity)
					});
				  $(".cart-price").html("$" + titlePrice);
				  $("#cartHoverTotal").html("$" + titlePrice);
   	 			  }
   	 		  });
    		}else if (event.target.matches('.Add${order.product_no}')){

    			$.ajax({ 
   	 		  type:"POST",
    				  url:"<%=request.getContextPath()%>/ShoppingServlet",
   	 		  data:{
   	 			  "product_no": "${order.product_no}",
   	 			  "product_name": "${order.product_name}",
   	 			  "product_price": "${order.product_price}",
   	 			  "proqty": $('input[name="${order.product_no}"]').val(),
   	 			  "product_remaining": "${order.product_remaining}",
   	 			  "user_id": "${order.user_id}",
   	 			  "action": "updateCount"
   	 		  },
   	 		  success: function(res) {
				  const cartproducts=cartProduct(res, "<%=request.getContextPath()%>"); 
				  $("#carts").html(cartproducts); 
				  
				  var carRes  = JSON.parse(res)
				  var ibaCount = carRes["results"].length;
				  $("#iba").html(ibaCount);

				  var titlePrice = 0
					carRes["results"].forEach(function (item,index) {
						titlePrice += (item.product_price * item.product_quantity)
					});
				  $(".cart-price").html("$" + titlePrice);
				  $("#cartHoverTotal").html("$" + titlePrice);
   	 			  }
   	 		  });	
        	}
    	});
    	
    	
//     </c:forEach>
	
//     <c:forEach var="order" items="${buylist}" varStatus="cartstatus">
    
    var proQty = $('#PC${order.product_no}');
	proQty.on('click', '.qtybtn', function () {
		var $button = $(this);
		var oldValue = $button.parent().find('input').val();
		if ($button.hasClass('inc')) {
			var newVal = parseFloat(oldValue) + 1;
		} else {
			// Don't allow decrementing below zero
			if (oldValue > 1) {
				var newVal = parseFloat(oldValue) - 1;
			} else {
				newVal = 1;
			}
		}
		$button.parent().find('input').val(newVal);
	});
    
	//數量按鈕前端控制不可大於商品數量
	$('#Add${order.product_no}').on('click', function () {
    	var Count = $('input[name="${order.product_no}"]').val();
    	var maxRemaining = $("#max${order.product_no}").attr("value"); 	
			
	    	if (Count == maxRemaining) {
	    		$("#Add${order.product_no}").prop('disabled',true);
	    		Swal.fire("商品數量只剩下"+ maxRemaining +"個");
	    	} 
	    	if (Count < maxRemaining) {
	    		$("#Add${order.product_no}").prop('disabled',false);
	    	}

	});
	

	
// 	$("#PC${order.product_no}").change(function() {	
// 		var newValue = $('#PC${order.product_no}').parent().find('input').val();
// 		var maxRemaining = $("#max${order.product_no}").attr("value");
// 		if(newValue > maxRemaining){
// 			$('input[name="${order.product_no}"]').val(maxRemaining);
// 		}
// 		if(newValue < maxRemaining){
// 			$('input[name="${order.product_no}"]').val(newValue);
// 		}
// 	});

	
	 
		//計算合計方法
		function sum(){
			//計算總價，編寫總價方法
	             var zong = 0;
	             $(".cartProductItemSumPrice").each(function () {
	                 var all = parseInt($(this).text());
	                 zong += all;
	             })
	             $("#Sum").text(zong);
		}
						  
		 </c:forEach>  
    </script>
  
  </body>
</html>
