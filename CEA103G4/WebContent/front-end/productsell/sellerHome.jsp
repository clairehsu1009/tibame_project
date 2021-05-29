<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.user.model.*"%>

<%
		Object SellerProducts = request.getAttribute("SellerProducts");
		ProductVO productVO = (ProductVO) request.getAttribute("productVO");
%>
<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
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
    
    <style>
    
.card-body {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    min-height: 1px;
    padding: 0rem;
    padding-top: 25px;
}

.seller-star i{
  font-size: 16px;
  display: inline-block;
  color: #fac451;
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
            <div class="breadcrumb-text">
              <a href="${pageContext.request.contextPath}/front-end/index.jsp"><i class="fa fa-home"></i> Home</a>
              <span>SellerHome</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Section finish -->
<!-- seller Info Begin -->
          
		<section>
           <div class="sellerHome" id="sellerHome">
         <div class="row sellerInfo">
         <c:if test="${SellerProducts.size() == 0}">
			<div class="card mb-3" id="sellerPic">
  			<div class="row g-0">
   			 <div class="col-md-6" id="sellerImg">
      			<img  width="200px" height="200px" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${seller.user_id}" class="rounded mx-auto d-block" alt="">
   			 </div>
    			<div class="col-md-6">
     		 <div class="card-body">
       		 <h5 class="card-title"></h5>
       			<p class="card-text"><small class="text-muted"></small></p>

       			<div class="seller-btn">
       			<div><a href="#" id="chat-seller"><i class="fa fa-commenting-o"></i>&nbsp;<p style="display:inline-block; color:pink;">私訊賣家</p></a></div>
       			</div>
     		 </div>
    		</div>
 		 </div>
       </div>
         </c:if>
         <c:forEach var="seller" items="${SellerProducts}" begin="0" end="0">	
			<div class="card mb-3">
  			<div class="row g-0">
   			 <div class="col-md-6">
      			<img width="200px" height="200px" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${seller.user_id}" class="rounded mx-auto d-block" alt="">
   			 </div>
    			<div class="col-md-6">
     		 <div class="card-body">
       		 <h5 class="card-title"></h5>
       			<p class="card-text"><small class="text-muted"></small></p>
       			<c:if test="${userSvc.getOneUser(seller.user_id).user_comment == 0}">
       			<div class="seller-star">
       			<p class="card-text">
       			              <i class="fa fa-star-o" ></i>
							  <i class="fa fa-star-o" ></i>
							  <i class="fa fa-star-o" ></i>
							  <i class="fa fa-star-o" ></i>
							  <i class="fa fa-star-o" ></i>
       			</p>
       			</div>
       			</c:if>					
       			<c:if test="${userSvc.getOneUser(seller.user_id).user_comment != 0}">
				  <div class="seller-star">
				  <p class="card-text">
                     <input type="hidden" name="srating" value="<fmt:formatNumber type="number" value="${userSvc.getOneUser(seller.user_id).user_comment/userSvc.getOneUser(seller.user_id).comment_total}" maxFractionDigits="0"/>" id="con"/>
                        <i class="fa fa-star-o" id="s1"></i>
						<i class="fa fa-star-o" id="s2"></i>
						<i class="fa fa-star-o" id="s3"></i>
						<i class="fa fa-star-o" id="s4"></i>
						<i class="fa fa-star-o" id="s5"></i>
						<span>(${userSvc.getOneUser(seller.user_id).comment_total})</span>
					</p>	
					</div>
               </c:if>
       			<div class="seller-btn">
       			<div><a href="#" id="chat-seller"><i class="fa fa-commenting-o"></i>&nbsp;<p style="display:inline-block; color:pink;">私訊賣家</p></a></div>
       			</div>
     		 </div>
    		</div>
 		 </div>
       </div>
       </c:forEach>
      </div>
         <div class="row">  
            <c:forEach var="productVO" items="${SellerProducts}" begin="0" end="${SellerProducts.size()}">
          <div class="col-lg-3 col-sm-6 productBox">
        <div class="card mb-2 productcard">
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
                            <i class="icon_heart_alt"  data-id="${productVO.product_no}"></i>
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
    <c:set var="seller" value="${productVO.user_id}"></c:set>
    <input class="user_id" type="hidden" value="${productVO.user_id}">
    <input class="user_regdate" type="hidden" value="${userSvc.getOneUser(productVO.user_id).regdate}">
          </c:forEach>
          </div>
       </div>
   </section>
    <!-- Product Shop Section End -->


    <!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->

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
	var chatSeller = document.getElementById("chat-seller");
//	 var miniChat = document.querySelector(".mini-chat");
	 chatSeller.addEventListener("click",function(){
		closelist.style.visibility="hidden";
		if("${userVO.user_id}" == ""){
			login();
		}else if("${userVO.user_id}" == "${seller}"){
			Swal.fire({
	  			  icon: 'error',
	  			  title: '很抱歉,無法私訊自己',
	  			  showConfirmButton: false,
	  			  timer: 1500
	  			});
		}else{
		miniChat.style.visibility="visible";
		var friend = "${seller}";
		addListener2(friend);
			
		}
	});
	
	
	var url = window.location.search;
	var str = url.split('?')[1];
	var sellerID = str.split('=')[1];
	$(".card-title").text("賣家帳號"+ sellerID);
	$("#sellerImg").html('<img src="${pageContext.request.contextPath}/UserShowPhoto?user_id='+sellerID+ '" class="rounded mx-auto d-block" >');
	var user_regdate = $(".user_regdate").attr("value");
	if (user_regdate !== undefined){
		$(".text-muted").html("加入時間"+ user_regdate);
	}
	
	const sellerHome = document.getElementById('sellerHome');
	sellerHome.addEventListener('click', event => {
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
//				  console.log(carRes["results"].length);
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
	
    $(document).ready(function(){
		switch($("#con").val()){
		case "1":
			$("#s1").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "2":
			$("#s1,#s2").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "3":
			$("#s1,#s2,#s3").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "4":
			$("#s1,#s2,#s3,#s4").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "5":
			$("#s1,#s2,#s3,#s4,#s5").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		default:

		}
	})
	
	</script>

  </body>
</html>
