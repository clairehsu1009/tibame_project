<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.product.controller.*"%>
<%@ page import="com.user.model.*"%>
<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />

<%
	
	ProductDAO dao = new ProductDAO();
	List<ProductVO> products = dao.getAllShop();
	pageContext.setAttribute("products",products);
		
 %>
 <jsp:useBean id="liveSvc" scope="page" class="com.live.model.LiveService" />
 
 
<!DOCTYPE html>
<html>
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

    <!-- Hero Section Begin -->
    <section class="hero-section">
      <div class="hero-items owl-carousel">
        <div class="single-hero-items set-bg" data-setbg="${pageContext.request.contextPath}/front-template/images/index/hero-1.jpg">
          <div class="container">
            <div class="row">
              <div class="col-lg-5 indexwords">
                <span>Second hand</span>
                <h1>Mode femme</h1>
                <h5>不追隨昂貴的品牌，尋找符合個人風格的穿搭</h5><br>
                <p> 高價商品已不再是時尚的代名詞，二手服飾讓所有人以平價的方式打造出自我風格的穿搭Style。
					來Mode Femme出售您的服飾、配件，或是尋找屬於你的風格搭配！
                </p>
                <a href="${pageContext.request.contextPath}/front-end/productsell/shop.jsp" class="primary-btn">Shop Now</a>
              </div>
            </div>
            <div class="off-card">
              <h2>Mode <span>femme</span></h2>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Hero Section End -->

    <!-- Women Banner Section Begin -->
    <section class="women-banner spad">
      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-3">
            <div
              class="product-large set-bg"
              data-setbg="${pageContext.request.contextPath}/front-template/images/products/women-large.jpg"
            >
              <h2>Women’s</h2>
            </div>
          </div>
          <div class="col-lg-8 offset-lg-1" id="product_slider">
          <div class="product-slider-pdtype"><a class="cative" href="<%=request.getContextPath()%>/product_type/product_type.do?action=getProductsByPdtype&pdtype_no=4001">Clothes</a></div>
            <div class="product-slider owl-carousel">
            <c:forEach var="productVO" items="${products}" begin="0" end="${products.size()}">
            <c:if test="${productVO.pdtype_no == 4001}">
       <div class="productBox">
          <div class="productcard"> 
            <div class="product-item" >
                <div class="pi-pic">
                <div class="pi-img">
                <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}">
                    <img class="card-img-top"  src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" alt="${productVO.product_name}">           
                    </a>      	
                  </div>
                    <ul>
                        <li class="w-icon">
                            <i class="icon_bag_alt" data-id="${productVO.product_no}"></i>
                        </li>   
                        <li class="w-heart" >
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
            </c:if>
            </c:forEach>
            </div>
            <div class="product-slider-pdtype"><a class="cative" href="<%=request.getContextPath()%>/product_type/product_type.do?action=getProductsByPdtype&pdtype_no=4004">Shoes</a></div>
           <div class="product-slider owl-carousel">  
            <c:forEach var="productVO" items="${products}" begin="0" end="${products.size()}">
            <c:if test="${productVO.pdtype_no == 4004}"> 
         <div class="productBox">
          <div class="productcard"> 
            <div class="product-item" >
                <div class="pi-pic">
                <div class="pi-img">
                <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}">
                    <img class="card-img-top"  src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" alt="${productVO.product_name}">           
                    </a>      	
                  </div>
                    <ul>
                        <li class="w-icon">
                            <i class="icon_bag_alt" data-id="${productVO.product_no}"></i>
                        </li>   
                        <li class="w-heart" >
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
            </c:if>
            </c:forEach>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Women Banner Section End -->

    <!-- Deal Of The Week Section Begin-->
<c:forEach var="live" items="${liveSvc.getAll()}" begin="0" end="0">
    <c:if test="${live.live_state == 2}">
    <section class="deal-of-week set-bg spad" data-setbg="${pageContext.request.contextPath}/front-template/images/index/time-live.jpg">
      <div class="row container">
        <div class="col-lg-6 text-center">
          <div class="section-title">
            <h2>目前直播中</h2>
			<h4>直播間名稱&nbsp;${live.live_name}</h4>			
            <div class="product-price">
              <span>直播類別&nbsp;「${live.live_type}」</span>
            </div>
          </div>
          <div class="liveTime">
          <h4>直播開始時間</h4>
          </div>
          <div class="countdown-timer"> 
            <div class="cd-item">
              <span>
            <fmt:formatDate value="${live.live_time}" pattern="MM"/>
              </span>
              <p>月</p>
            </div>
            <div class="cd-item">
              <span>
            <fmt:formatDate value="${live.live_time}" pattern="dd"/>
              </span>
              <p>日</p>
            </div>        	
            <div class="cd-item">
              <span>
            <fmt:formatDate value="${live.live_time}" pattern="HH"/>
              </span>
              <p>點</p>
            </div>
            <div class="cd-item">
              <span>
              <fmt:formatDate value="${live.live_time}" pattern="mm"/>
              </span>
              <p>分</p>
            </div>
          </div>
          
<!--           <div class="countdown-timer" id="countdown"> -->
<!--             <div class="cd-item"> -->
<!--               <span></span> -->
<!--               <p>Days</p> -->
<!--             </div> -->
<!--             <div class="cd-item"> -->
<!--               <span></span> -->
<!--               <p>Hrs</p> -->
<!--             </div> -->
<!--             <div class="cd-item"> -->
<!--               <span></span> -->
<!--               <p>Mins</p> -->
<!--             </div> -->
<!--             <div class="cd-item"> -->
<!--               <span></span> -->
<!--               <p>Secs</p> -->
<!--             </div> -->
<!--           </div> -->										
          <a href="<%=request.getContextPath()%>/live/live.do?live_no=${live.live_no}" class="primary-btn" style="border-radius: 10px; background:pink;">前往觀看</a>
        </div>
        <div class="col-lg-6 text-center">
        <div>
      <a href="<%=request.getContextPath()%>/live/live.do?live_no=${live.live_no}">
        <img width="350px" height="350px" src="${pageContext.request.contextPath}/live/LiveGifReader.do?live_no=${live.live_no}" class="rounded mx-auto d-block" alt="${live.live_name}">
       </a> 
        </div>
        </div>
      </div>
    </section>
    </c:if>
  </c:forEach>


        <div class="benefit-items">
          <div class="row">
            <div class="col-lg-4">
              <div class="single-benefit">
                <div class="sb-icon">
                  <img src="${pageContext.request.contextPath}/front-template/images/index/icon-1.png" alt="" />
                </div>
                <div class="sb-text">
                  <h6>Free Shipping</h6>
                  <p>For all order over 99$</p>
                </div>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="single-benefit">
                <div class="sb-icon">
                  <img src="${pageContext.request.contextPath}/front-template/images/index/icon-2.png" alt="" />
                </div>
                <div class="sb-text">
                  <h6>Delivery On Time</h6>
                  <p>If good have prolems</p>
                </div>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="single-benefit">
                <div class="sb-icon">
                  <img src="${pageContext.request.contextPath}/front-template/images/index/icon-1.png" alt="" />
                </div>
                <div class="sb-text">
                  <h6>Secure Payment</h6>
                  <p>100% secure payment</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Latest Blog Section End -->

   
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
    <script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/products-search.js" ></script>
    
	<script>
	const product_slider = document.getElementById('product_slider');
	product_slider.addEventListener('click', event => {
		if (event.target.matches('.icon_bag_alt')) {
	    	addCart(event.target.dataset.id);	
		}else if (event.target.matches('.icon_heart_alt')){
			addFavorite(event.target.dataset.id);
    	}
});
	
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
    
    
  </body>
</html>