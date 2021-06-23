<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.product.controller.*"%>

<%
	ProductDAO dao = new ProductDAO();
	Object prouducts = request.getAttribute("products")==null? dao.getAllShop():request.getAttribute("products");
	pageContext.setAttribute("products",prouducts);
	
%>
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />


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
              <span>Shop</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Section Begin -->


<!-- Product Shop Section Begin -->
    <section class="product-shop spad">
      <div class="container">
        <div class="row">
          <div
            class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1 produts-sidebar-filter"
          >
            <div class="filter-widget col-md-12 col-4" id="RWDpd">
              <h4 class="fw-title">商品分類</h4>
              <ul class="filter-catagories">
              <c:forEach var="product_typeVO" items="${list2}" begin="0" end="${list2.size()}">
              <li><div class="catagoriesQuery" value="${product_typeVO.pdtype_no}">${product_typeVO.pdtype_name}</div></li>
                </c:forEach>
              </ul>
            </div>
            <div class="filter-widget col-md-12 col-7" id="RWDsm">
              <h4 class="fw-title">Price</h4>
              <div class="filter-range-wrap">
                <div class="range-slider">
                  <div class="price-input">
                    <input type="text" id="minamount" />
                    <input type="text" id="maxamount" />
                  </div>
                </div>
                <div
                  class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                  data-min="0"
                  data-max="2000"
                >
                  <div
                    class="ui-slider-range ui-corner-all ui-widget-header"
                  ></div>
                  <span
                    tabindex="0"
                    class="ui-slider-handle ui-corner-all ui-state-default"
                  ></span>
                  <span
                    tabindex="0"
                    class="ui-slider-handle ui-corner-all ui-state-default"
                  ></span>
                </div>
              </div>
              <div id="moneyRange" class="filter-btn">價格篩選</div>

            </div>
            <div class="filter-widget">
              <h4 class="fw-title">進階查詢</h4>
              <div class="fw-all-choose" id="fw-all-choose">
              <div class="fw-cs col-md-6 col-4" id="fw-cs">
               <c:forEach var="product_typeVO" items="${list2}" begin="0" end="${list2.size()}">
                <div class="cs-item">
                 <label for="${product_typeVO.pdtype_name}">
                    ${product_typeVO.pdtype_name}
                   <input type="checkbox"  id="${product_typeVO.pdtype_name}" name="pdtypeNo" value="${product_typeVO.pdtype_no}" />
                   <span class="checkmark"></span>
                  </label>
                 </div>
                </c:forEach>
                </div>
                <div class="fw-price col-md-6 col-6">
                <div class="sc-item">
                  <input type="radio" id="a-price" name="productPrice" value="A"/>
                  <label for="a-price">$300<i class="fa fa-arrow-circle-down"></i></label>
                </div>
                <div class="sc-item">
                  <input type="radio" id="b-price"name="productPrice" value="B"/>
                  <label for="b-price">$301~$500</label>
                </div>
                <div class="sc-item">
                  <input type="radio" id="c-price" name="productPrice" value="C"/>
                  <label for="c-price">$501~$1000</label>
                </div>
                <div class="sc-item">
                  <input type="radio" id="d-price" name="productPrice" value="D"/>
                  <label for="d-price">$1001<i class="fa fa-arrow-circle-up"></i></label>
                </div>
                </div>
                <div class="fw-all-btn">
                <div class="filter-btn" id="fw-all-btn">送出查詢</div>
                <div  class="filter-btn" id="clearallbtn">清除全部</div>
                </div>
             </div>
          </div>
          </div>
          <!-- 左邊功能列結束 -->
          
          
          <div class="col-lg-9 order-1 order-lg-2">
            <div class="product-show-option">
              <div class="row">
                <div class="col-lg-7 col-md-7">
                  <div class="select-option">
 					<div  id="allProductsQuery" class="allproduct-btn">全部商品</div>
 					<div  id="newProductsQuery" class="newproduct-btn">最新商品</div>
                    <select class="p-show"  id="p-show">
                      <option value="0">價格</option>
                      <option value="1" >價格：低到高</option>
                      <option value="2">價格：高到低</option>
                    </select>
                  </div>
                </div>
                <div class="col-lg-5 col-md-5 text-right" id="productheart">
                  <a href="${pageContext.request.contextPath}/front-end/productsell/productFavorite.jsp">
                  <span><i class="icon_heart_alt"></i>收藏商品清單</span>
                  </a>
                </div>
              </div>
            </div>
           <div class="product-list">
            <div class="row" id="products">            
            <c:forEach var="productVO" items="${products}" begin="0" end="${products.size()}">
          <div class="col-lg-4 col-sm-6 productBox">
        <div class="card mb-2 productcard">
            <div class="product-item" >
                <div class="pi-pic">
                <div class="pi-img">
                <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}">
                    <img class="card-img-top"  src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" alt="${productVO.product_name}">           
                    </a>      	
                  </div>
                    <ul>
                        <li class="w-icon" id="SC${productVO.product_no}">
                            <i class="icon_bag_alt" data-id="${productVO.product_no}"></i>
                        </li>   
                        <li class="w-heart">
                            <i class="icon_heart_alt" data-id="${productVO.product_no}"></i>
                        </li>
                    </ul>
                </div>
                <div class="pi-text">
                  <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}">                  
                        <h5>${productVO.product_name}</h5>    
                    	 <div class="product-price"><span>$</span>
                          ${productVO.product_price}
                    	</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
          </c:forEach>
          </div>
       </div>
     </div>
     </div>
     </div>
   </section>
    <!-- Product Shop Section End -->

<!--     分頁樣式待跟老師的分頁檔案結合 -->
 <!-- pagination -->
    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center" id="pagination">
        <li class="page-item">
          <a class="page-link" href="#">1</a>
        </li>
      </ul>
    </nav>
    <!-- pagination END-->

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
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>
	
	<script>
	
	const productsAdd = document.getElementById('products');		
	productsAdd.addEventListener('click', event => {
		if (event.target.matches('.icon_bag_alt')) {
	    	addCart(event.target.dataset.id);	
		}else if (event.target.matches('.icon_heart_alt')){
			addFavorite(event.target.dataset.id);
    	}
});

	//AJAX
	
	function sendQuery(datas){ 
		
		$.ajax({ 
		  url:"<%=request.getContextPath()%>/ProductSearch",  
		  type:"POST",
		  data:datas, 
		  success: function(result) { 
// 			console.log(result) 
		   	const str=cardContent(result, "<%=request.getContextPath()%>"); 
			$("#products").html(str); 
			
			if(str.length === 0){
	  			Swal.fire({
		  			  icon: 'error',
		  			  title: '很抱歉,查無此商品',
		  			  showConfirmButton: false,
		  			  timer: 1000
		  			});
            }

		  },
		  error:function () {
	  			Swal.fire({
		  			  icon: 'error',
		  			  title: '很抱歉,查無此商品',
		  			  showConfirmButton: false,
		  			  timer: 1000
		  			});
		  },
			
		 }) 
	}	
		

		if(window.location.href){
			var url = decodeURIComponent(window.location.search);
			var str = url.split('?')[1]
			var json = str.split('=')[1]
			var result =JSON.parse(json);
			const fromProduct =cardContent(result, "<%=request.getContextPath()%>"); 
			$("#products").html(fromProduct); 
			
			if(fromProduct.length === 0){
	  			Swal.fire({
		  			  icon: 'error',
		  			  title: '很抱歉,查無此商品',
		  			  showConfirmButton: false,
		  			  timer: 1000
		  			});
            }
		};	


				
		</script>
		
<!-- 		  購物車按鈕   -->
		  <c:forEach var="productVO" items="${products}" begin="0" end="${products.size()}">
		  <script>
		  


		  
			//點選加入購物車呼叫的function
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
//						  console.log(carRes["results"].length);
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
		  
		  
function addFavorite(id){
	const data =  JSON.parse(localStorage.getItem("favorite"));
	if (data == null){
		$.ajax({ 
			  type:"POST",
			  url:"<%=request.getContextPath()%>/Favorite",
			  data:{
				  "product_no":id,
				  "action": "addFavorite"
			  },
			  success: function(res) {
				  localStorage.setItem('favorite', res)
				  Swal.fire({
					  icon: 'success',
					  title: `已加入收藏清單`,
					  showConfirmButton: false,
					  timer: 1500
					});
				  },
	})
	} else {
    const index = data["results"].findIndex(item => item.product_no === Number(id))
    if (index !== -1){
		  Swal.fire({
			  icon: 'error',
			  title: `已在收藏清單`,
			  showConfirmButton: false,
			  timer: 1500
			});
    } else {
		$.ajax({ 
			  type:"POST",
			  url:"<%=request.getContextPath()%>/Favorite",
			  data:{
				  "product_no": id,
				  "action": "addFavorite"
			  },
			  success: function(res) {
				  localStorage.setItem('favorite', res)
				  Swal.fire({
					  icon: 'success',
					  title: `已加入收藏清單`,
					  showConfirmButton: false,
					  timer: 1500
					});
				  },
	})
 }
} 
}
	

		  </script>
		  </c:forEach>

  </body>
</html>
