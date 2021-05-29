<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Modefemme</title>
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
            <div class="breadcrumb-text">
              <a href="${pageContext.request.contextPath}/front-end/index.jsp"><i class="fa fa-home"></i> Home</a>
              <a href="${pageContext.request.contextPath}/front-end/productsell/shop.jsp">Shop</a>
              <span>Favorite</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Section Begin -->
    
    <div class="product-Favorite">
            <div class="row" id="favorite">
            </div>
          </div>              


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
    <script src="${pageContext.request.contextPath}/front-template/js/productFavorite.js" ></script>
   	<script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
   	 <script src="${pageContext.request.contextPath}/front-template/js/products-search.js" ></script>
   	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>

 <script>
 

	const data =  JSON.parse(localStorage.getItem("favorite"));
	const favPath = "<%=request.getContextPath()%>";
	if (data !== null) {
		favoriteContent(data,favPath);
	}
	
	
	
 
	function removeSession (index) {

		$.ajax({ 
			  type:"POST",
			  url:"<%=request.getContextPath()%>/Favorite",
			  data:{
				  "index":index,
				  "action": "remove"
			  },
			  success: function() {
				  Swal.fire({
					  icon: 'success',
					  title: '已移除收藏清單',
					  showConfirmButton: false,
					  timer: 1000
					});
				  }	        
	});
}

	function addCart(id){
		$.ajax({ 
			  type:"POST",
			  url:"<%=request.getContextPath()%>/ShoppingServlet",
			  data:{
				  "product_no": id,
				  "action": "ADDFromFav"
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


				  Swal.fire({
					  icon: 'success',
					  title: '商品加入購物車',
					  showConfirmButton: false,
					  timer: 1000
					});
				  
		      }, 	  
			  error:function () {
		  			Swal.fire({
			  			  icon: 'error',
			  			  title: '很抱歉,加入購物車失敗',
			  			  showConfirmButton: false,
			  			  timer: 1000
			  			});
			  },				
			 });
	}
 
 </script>
    
      