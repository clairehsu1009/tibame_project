<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.user.model.*"%>

<%
		Object SellerProducts = request.getAttribute("SellerProducts");
		pageContext.setAttribute("SellerProducts", SellerProducts);

	
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
           <div class="sellerHome">
         <div class="row sellerInfo">
			<div class="card mb-3" style="width: 400px;height: 200px;">
  			<div class="row g-0">
   			 <div class="col-md-6">
      			<img width="200px" height="200px" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${userVO.user_id}" class="rounded mx-auto d-block" alt="">
   			 </div>
    			<div class="col-md-6">
     		 <div class="card-body">
       		 <h5 class="card-title"></h5>
       			<p class="card-text"><small class="text-muted"></small></p>
       			<div class="seller-btn">
       			<div><a href="#"><i class="fa fa-commenting-o"></i>&nbsp;<p style="display:inline-block; color:pink;">私訊賣家</p></a></div>
       			</div>
     		 </div>
    		</div>
 		 </div>
       </div>
      </div>
         <div class="row">  
            <c:forEach var="productVO" items="${SellerProducts}" begin="0" end="${SellerProducts.size()}">
          <div class="col-lg-3 col-sm-6">
        <div class="card mb-2 productcard">
            <div class="product-item" >
                <div class="pi-pic">
                <div class="pi-img">
                <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}">
                    <img class="card-img-top"  src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" alt="${productVO.product_name}">           
                    </a>      	
                  </div>
                    <ul>
                        <li class="w-icon active">
                            <a href="#"><i class="icon_bag_alt"></i></a>
                        </li>   
                        <li class="w-heart" >
                            <i class="icon_heart_alt"  data-no="${productVO.product_no}"></i>
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
	
	<script>
	var url = window.location.search;
	var str = url.split('?')[1];
	var sellerID = str.split('=')[1];
	$(".card-title").text("賣家帳號"+ sellerID);
	
	var user_regdate = $(".user_regdate").attr("value");
	if (user_regdate !== undefined){
		$(".text-muted").text("加入時間"+ user_regdate);
	}
	
	
	
	
	</script>

  </body>
</html>
