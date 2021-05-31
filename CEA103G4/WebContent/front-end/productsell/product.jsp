<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.product_report.model.*"%>
<%@ page import="com.user.model.*"%>
<%@ page import="com.seller_follow.model.*"%>

<%
	ProductVO productVO = (ProductVO) request.getAttribute("productVO");

	UserVO userVO = (UserVO) session.getAttribute("account");
	session.setAttribute("userVO", userVO);

%>
<jsp:useBean id="product_typeSvc" scope="page"
	class="com.product_type.model.Product_TypeService" />
<jsp:useBean id="productSvc" scope="page"
	class="com.product.model.ProductService" />
<jsp:useBean id="product_reportSvc" scope="page"
	class="com.product_report.model.Product_ReportService" />
<jsp:useBean id="userSvc" scope="page"
	class="com.user.model.UserService" />
<jsp:useBean id="seller_followSvc" scope="page"
	class="com.seller_follow.model.Seller_FollowService" />
<jsp:useBean id="orderSvc" scope="page"
	class="com.order.model.OrderService" />

<!DOCTYPE html>
<html>
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
	.red_heart {
		color:red;
	
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
						<a href="${pageContext.request.contextPath}/front-end/index.jsp"><i
							class="fa fa-home"></i> Home</a> <a
							href="${pageContext.request.contextPath}/front-end/productsell/shop.jsp">Shop</a>
						<span>商品詳情</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb Section Begin -->

	<!-- Product Shop Section Begin -->
	<section class="product-shop spad page-details">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 productLeft">
					<div class="filter-widget col-md-12 col-4" id="RWDpd">
						<h4 class="fw-title">商品分類</h4>
						<ul class="filter-catagories">
							<c:forEach var="product_typeVO" items="${list2}" begin="0"
								end="${list2.size()}">
								<li><div class="catagoriesQuery"
										value="${product_typeVO.pdtype_no}">${product_typeVO.pdtype_name}</div></li>
							</c:forEach>
						</ul>
					</div>
					<div class="filter-widget col-md-12 col-7" id="RWDsm">
						<h4 class="fw-title">Price</h4>
						<div class="filter-range-wrap">
							<div class="range-slider">
								<div class="price-input">
									<input type="text" id="minamount" /> <input type="text"
										id="maxamount" />
								</div>
							</div>
							<div
								class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
								data-min="0" data-max="2000">
								<div class="ui-slider-range ui-corner-all ui-widget-header"></div>
								<span tabindex="0"
									class="ui-slider-handle ui-corner-all ui-state-default"></span>
								<span tabindex="0"
									class="ui-slider-handle ui-corner-all ui-state-default"></span>
							</div>
						</div>
						<div id="moneyRange" class="filter-btn">價格篩選</div>

					</div>
					<div class="filter-widget">
						<h4 class="fw-title">進階查詢</h4>
						<div class="fw-all-choose" id="fw-all-choose">
							<div class="fw-cs col-md-6 col-4" id="fw-cs">
								<c:forEach var="product_typeVO" items="${list2}" begin="0"
									end="${list2.size()}">
									<div class="cs-item">
										<label for="${product_typeVO.pdtype_name}">
											${product_typeVO.pdtype_name} <input type="checkbox"
											id="${product_typeVO.pdtype_name}" name="pdtypeNo"
											value="${product_typeVO.pdtype_no}" /> <span
											class="checkmark"></span>
										</label>
									</div>
								</c:forEach>
							</div>
							<div class="fw-price col-md-6 col-6">
								<div class="sc-item">
									<input type="radio" id="a-price" name="productPrice" value="A" />
									<label for="a-price">$300<i
										class="fa fa-arrow-circle-down"></i></label>
								</div>
								<div class="sc-item">
									<input type="radio" id="b-price" name="productPrice" value="B" />
									<label for="b-price">$301~$500</label>
								</div>
								<div class="sc-item">
									<input type="radio" id="c-price" name="productPrice" value="C" />
									<label for="c-price">$501~$1000</label>
								</div>
								<div class="sc-item">
									<input type="radio" id="d-price" name="productPrice" value="D" />
									<label for="d-price">$1001<i
										class="fa fa-arrow-circle-up"></i></label>
								</div>
							</div>
							<div class="fw-all-btn">
								<div class="filter-btn" id="fw-all-btn">送出查詢</div>
								<div class="filter-btn" id="clearallbtn">清除全部</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 左邊功能列結束 -->

				<!-- 右邊商品區塊 -->
				<div class="col-lg-9 productRight">
					<div class="row">
						<div class="col-lg-6">
							<div class="product-pic-zoom">
								<img class="product-big-img"
									src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}"
									alt="${productVO.product_name}" />
							</div>
						</div>
						<div class="col-lg-6">
							<div class="product-details">
								<div class="pd-title">
									<!-- 動態串商品名 -->
									<h3>${productVO.product_name}</h3>
									<a href="javascript:void(0)" class="heart-icon"><i
										class="icon_heart_alt" data-id="${productVO.product_no}"></i></a>
								</div>
								<div class="pd-desc">

									<h4>
										<span>$</span> ${productVO.product_price}
									</h4>
								</div>
								<c:if test="${productVO.product_state == 1}">
									<div class="quantity">
										<div class="pro-qty">
											<span id="decProduct" class="dec qtybtn">-</span> <input
												name="proqty" id="proqty" type="text" value="1" /> <span
												id="addProduct" class="inc qtybtn" style="">+</span>
										</div>
										<button class="primary-btn pd-cart" id="cartBtn">加入購物車</button>
									</div>
									</form>
									<ul class="pd-tags">
										<li><span id="maxRemaining"
											value="${productVO.product_remaining}">剩餘數量：${productVO.product_remaining}</span>
										</li>
										<li><span 
											>已售出：${productVO.product_sold}</span>
										</li>
									</ul>
								</c:if>
								<c:if test="${productVO.product_state != 1}">
									<div class="quantity">
										<button type="button" class="btn btn-danger">此商品已下架</button>
									</div>
								</c:if>
<!-- 								<div class="pd-share"> -->
<!-- 									<div class="pd-social"> -->
<!-- 										<a href="#"><i class="ti-facebook"></i></a> <a href="#"><i -->
<!-- 											class="ti-twitter-alt"></i></a> <a href="#"><i -->
<!-- 											class="ti-linkedin"></i></a> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="pd-fungroup">
									<div class="pd-function">
										<a href="javascript:void(0)" class="primary-btn" id="chat-seller">私訊賣家</a>
<!-- 										<a href="javascript:void(0)" class="primary-btn chat-seller" id="chat_seller">私訊賣家</a> -->
<!-- 										<FORM METHOD="post" -->
<%-- 											ACTION="<%=request.getContextPath()%>/front-end/message/chatMessage.do"> --%>
<%-- 											<input type="hidden" name="user_id" value="${userVO.user_id}"> --%>
<%-- 											<input type="hidden" name="seller_id" value="${productVO.user_id}"> --%>
<!-- 											<input type="submit" class="primary-btn" value="私訊賣家"> -->
<!-- 										</FORM> -->
										<c:if
											test="${seller_followSvc.getTracerNo(userVO.user_id, productVO.user_id) != null}">
											<div class="primary-btn unFollow"
												value="${seller_followSvc.getTracerNo(userVO.user_id,productVO.user_id).tracer_no}">取消關注</div>
										</c:if>
										<c:if
											test="${seller_followSvc.getTracerNo(userVO.user_id, productVO.user_id) == null}">
											<div id="${productVO.user_id}" value="${userVO.user_id}"
												class="primary-btn sellerFollow">關注賣家</div>
										</c:if>
										<a href="javascript:;" id="reportLink"
											class="primary-btn userReport" value="${userVO.user_id}">商品檢舉</a>
									</div>
									<!--                     檢舉燈箱 -->
									<div class="report-bg">
										<div class="report">
											<div class="report-title" value="${productVO.product_no}">
												檢舉商品名稱：${productVO.product_name} <span><a
													href="javascript:;" id="closeBtn">關閉</a></span>
											</div>

											<div class="report-input-content">
												<div class="report-input">
													<label for="">檢舉內容</label> <input type="text"
														placeholder="請輸入檢舉原因" name="pro_report_content" size="50"
														required>
												</div>
											</div>
											<div class="report-button">
												<div id="report-submit">提交檢舉</div>
											</div>
										</div>
									</div>
									<!--遮蓋層-->
									<!--     燈箱結束 -->
									<div class="p-code">
										<span>Pno : </span> ${productVO.product_no}
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="product-tab">
						<div class="tab-item">
							<ul class="nav" role="tablist">
								<li><a class="active" data-toggle="tab" href="#tab-1"
									role="tab">商品詳情</a></li>
								<li><a data-toggle="tab" href="#tab-2" role="tab">關於賣家</a>
								</li>
								<li><a data-toggle="tab" href="#tab-3" role="tab">賣家評價
										(${userSvc.getOneUser(productVO.user_id).comment_total})</a></li>
							</ul>
						</div>
						<div class="tab-item-content">
							<div class="tab-content">
								<div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
									<div class="product-content">
										<div class="row">
											<div class="col-lg-7">
												<h5>商品說明</h5>
												<textarea class="form-control" id="product_info"
													style="resize: none; white-space: pre-wrap;"
													maxlength="300" rows="6" name="product_info" readonly><%=productVO.getProduct_info()%></textarea>
											</div>
											<div class="col-lg-5">
												<img
													src="${pageContext.request.contextPath}/front-template/images/productsell/tab-desc.jpg"
													alt="" />
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="tab-2" role="tabpanel">
									<div class="specification-table">
										<table class="table">
											<tr>
												<td class="p-catagory">賣家帳號</td>
												<td>
													<div class="p-price">${productVO.user_id}</div>
												</td>
											</tr>
											<tr>
												<td class="p-catagory">賣家評價</td>
												<c:if test="${userSvc.getOneUser(productVO.user_id).user_comment == 0}">
												<td><div class="pd-rating"></div></td>
												</c:if>
												<c:if test="${userSvc.getOneUser(productVO.user_id).user_comment != 0}">
												<td>
												<div class="pd-rating">
                        	  <input type="hidden" name="srating" value="<fmt:formatNumber type="number" value="${userSvc.getOneUser(productVO.user_id).user_comment/userSvc.getOneUser(productVO.user_id).comment_total}" maxFractionDigits="0"/>" id="con"/>
                        	  <i class="fa fa-star-o" id="s1"></i>
							  <i class="fa fa-star-o" id="s2"></i>
							  <i class="fa fa-star-o" id="s3"></i>
							  <i class="fa fa-star-o" id="s4"></i>
							  <i class="fa fa-star-o" id="s5"></i>
							  <span>(${userSvc.getOneUser(productVO.user_id).comment_total})</span>
						</div>
						</td>
                        </c:if>

											</tr>
											<tr>
												<td class="p-catagory">加入時間</td>
												<td>
													<div class="cart-add">${userSvc.getOneUser(productVO.user_id).regdate}</div>
												</td>
											</tr>
											<tr>
												<td class="p-catagory">查看賣場</td>
												<td><a
													href="<%=request.getContextPath()%>/SellerProducts?user_id=${productVO.user_id}"
													target="_blank"><div class="primary-btn"
															style="background: pink; border-radius: 5px;">前往賣場</div></a></td>
											</tr>
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="tab-3" role="tabpanel">
									<div class="customer-review-option">
										<h4>${userSvc.getOneUser(productVO.user_id).comment_total} 評價</h4>
										<c:if test="${userSvc.getOneUser(productVO.user_id).user_comment != 0}">
										<div class="comment-option">
										<c:forEach var="seller" items="${orderSvc.getAllByID2(productVO.user_id)}" begin="0" end="${list2.size()}">
										<c:if test="${seller.srating != 0}">
											<div class="co-item">
												<div class="avatar-pic">
													<img src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${seller.user_id}" alt="" />
												</div>
												<div class="avatar-text">
													<div class="at-rating">
													<input type="hidden"  value="${seller.srating}"  id="star${seller.order_no}"/>
                        	 							 <i class="fa fa-star-o" id="s1${seller.order_no}"></i>
							 							 <i class="fa fa-star-o" id="s2${seller.order_no}"></i>
							 							 <i class="fa fa-star-o" id="s3${seller.order_no}"></i>
							 							 <i class="fa fa-star-o" id="s4${seller.order_no}"></i>
							 							 <i class="fa fa-star-o" id="s5${seller.order_no}"></i>
													</div>
													<h5>
														${seller.user_id} <span><fmt:formatDate value="${seller.order_date}" pattern="yyyy-MM-dd" /></span>
													</h5>
													<div class="at-reply">${seller.srating_content}</div>
												</div>
											</div>
											</c:if>
											 </c:forEach>
										</div>
									</c:if>
<!-- 										<div class="leave-comment"> -->
<!-- 											<h4>Leave A Comment</h4> -->
<!-- 											<form action="#" class="comment-form"> -->
<!-- 												<div class="row"> -->
<!-- 													<div class="col-lg-6"> -->
<!-- 														<input type="text" placeholder="Name" /> -->
<!-- 													</div> -->
<!-- 													<div class="col-lg-6"> -->
<!-- 														<input type="text" placeholder="Email" /> -->
<!-- 													</div> -->
<!-- 													<div class="col-lg-12"> -->
<!-- 														<textarea placeholder="Messages"></textarea> -->
<!-- 														<button type="submit" class="site-btn">Send -->
<!-- 															message</button> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</form> -->
<!-- 										</div> -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Shop Section End -->

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
	 var chatSeller = document.getElementById("chat-seller");
// 	 var miniChat = document.querySelector(".mini-chat");
	 chatSeller.addEventListener("click",function(){
		closelist.style.visibility="hidden";
		if("${userVO.user_id}" == ""){
			login();
		}else if("${userVO.user_id}" == "${productVO.user_id}"){
			Swal.fire({
	  			  icon: 'error',
	  			  title: '很抱歉,無法私訊自己',
	  			  showConfirmButton: false,
	  			  timer: 1500
	  			});
		}else{
		miniChat.style.visibility="visible";
		
		var friend = "${productVO.user_id}";
		addListener2(friend);
		}
	});

	function sendQuery(datas){ 
		
		$.ajax({ 
		  url:"<%=request.getContextPath()%>/ProductSearch",
		  type:"POST", 
		  data:datas,
		  success: function(result) { 
			const obj  = JSON.parse(result);
				if(obj["results"].length == 0){
					Swal.fire('很抱歉,查無此商品');
	            } else {
	            	var data = JSON.stringify(result);
					window.location.href=('<%=request.getContextPath()%>/front-end/productsell/shop.jsp?data='+encodeURI(data));

	            }
		  }, 
		  
		  error:function () {
			  Swal.fire('很抱歉,查無此商品');
		  },
			
		 }) 
	}
	
	
	//檢舉燈箱js 

	 var reportLink = document.querySelector("#reportLink");
	  var closeBtn = document.querySelector("#closeBtn");
	  var report = document.querySelector(".report");
	  var report_bg = document.querySelector(".report-bg");

	  //1,燈箱顯示/隱藏
	  reportLink.addEventListener("click", function () {
		  if ($('#reportLink').attr("value") === "") {
			  login();
			} else {
	    report.style.display = "block";
	    report_bg.style.display = "block";
			}
	  });
	  closeBtn.addEventListener("click", function () {
	    report.style.display = "none";
	    report_bg.style.display = "none";
	    $('input[name="pro_report_content"]').val("");
	  });

	  //2，拖曳
	  var report_title = document.querySelector(".report-title");
	  report_title.addEventListener("mousedown", function (e) {
	    //鼠標按下的時候,得到鼠標在框裡的座標
	    var x = e.pageX - report.offsetLeft;
	    var y = e.pageY - report.offsetTop;
	    document.addEventListener("mousemove", move); //鼠標移動的時候，得到狀態框座標
	    function move(e) {
	      report.style.left = e.pageX - x + "px";
	      report.style.top = e.pageY - y + "px";
	    }
	    document.addEventListener("mouseup", function () {
	      //鼠標彈起,解除移動事件
	      document.removeEventListener("mousemove", move);
	    });
	  });
	  

	  
	  //商品檢舉AJAX  

	  $(".report-button").click(function(){
		  if($('input[name="pro_report_content"]').val().trim().length != 0){
			$.ajax({ 
			  url:"<%=request.getContextPath()%>/product_report/product_report.do",
			  type:"POST", 
			  data:{
				  "pro_report_content": $('input[name="pro_report_content"]').val(),
				  "product_no": $(".report-title").attr("value"),
				  "user_id": $('#reportLink').attr('value'), 
				  "action": "insert"
			  },
			  success: function() { 
				  Swal.fire({
					  position: 'top',
					  icon: 'success',
					  title: '商品檢舉已提交',
					  showConfirmButton: false,
					  timer: 1500
					});
					    report.style.display = "none";
					    report_bg.style.display = "none";
					    $('input[name="pro_report_content"]').val("");
		            }, 	  
			  error:function () {
		  			Swal.fire({
			  			  icon: 'error',
			  			  title: '很抱歉,檢舉提交失敗,請重新提交。',
			  			  showConfirmButton: false,
			  			  timer: 1500
			  			});
				    report.style.display = "none";
				    report_bg.style.display = "none";
				  $('input[name="pro_report_content"]').val("");
			  },				
			 });
		  }  else {
				Swal.fire({
 					 icon: 'error',
 					 title: '檢舉內容請勿空白',
 					 showConfirmButton: false,
 					 timer: 1500
			});
		  };
	  });
	  
	  //關注賣家AJAX
	  	  $(".sellerFollow").click(function(){
	  		  var user = $('.sellerFollow').attr("value");
	  		  var sellerid = $('.sellerFollow').attr("id");
	  		  if (user === "") {
	  				login();
				} else if (user === sellerid){
		  			Swal.fire({
			  			  icon: 'error',
			  			  title: '很抱歉,無法關注自己',
			  			  showConfirmButton: false,
			  			  timer: 1500
			  			});
				}else {
			$.ajax({ 
			  url:"<%=request.getContextPath()%>/seller_follow/seller_follow.do",
			  type:"POST", 
			  data:{
				  "user_id":user,
				  "seller_id":sellerid,
				  "action": "insert"
			  },
			  success: function() {
						window.location.reload();
		            }, 	  
			  error:function () {
				Swal.fire({
		  			icon: 'error',
		  			title: '很抱歉,取消失敗,請重新點選。',
		  			showConfirmButton: false,
		  			timer: 1500
		  	    });  
			  },				
			 });
		  }
	  });
	  
	  	//取消關注賣家AJAX
	  		$(".unFollow").click(function(){

			$.ajax({ 
			  url:"<%=request.getContextPath()%>/seller_follow/seller_follow.do",
			  type:"POST", 
			  data:{
				  "tracer_no":$(".unFollow").attr("value"),
				  "action": "deleteFromProduct"
			  },
			  success: function() { 
						window.location.reload();
		            }, 	  
			  error:function () {
		  		Swal.fire({
			  	   icon: 'error',
			  	   title: '很抱歉,取消失敗,請重新點選。',
			  	   showConfirmButton: false,
			  	   timer: 1500
			  		});
			  },				
			 });
	  });
	  
	  	function login(){

		Swal.fire({
  			title: '請先登入會員',
  			html:
    		"帳號"+'<input id="userID" class="swal2-input">' +
    		"密碼"+'<input id="PWD" class="swal2-input"  type="password">',
    		showCloseButton: true,
    		confirmButtonText: `登入`,
  		});
  		$(".swal2-confirm").click(function(){
  			
			if($("#userID").val().trim().length != 0 && $("#PWD").val().trim().length != 0){				
  			$.ajax({ 
	  			  url:"<%=request.getContextPath()%>/FrondEnd_LoginHandler",
	  			  type:"POST", 
	  			  data:{
	  				  "user_id":$("#userID").val(),
	  				  "user_pwd":$("#PWD").val(),
	  				  "action": "signIn_ajax"
	  			  },
	  			  success: function(result) {
	  				if (result.length === 0 || result === ""){
			  			Swal.fire({
				  			  icon: 'error',
				  			  title: '帳號或密碼有誤,請重新輸入',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  				} else {
	  					window.location.reload();
			  			Swal.fire({
				  			  icon: 'success',
				  			  title: '登入成功',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  				}
	  		            }, 	  
	  			  error:function () {
			  			Swal.fire({
				  			  icon: 'error',
				  			  title: '登入失敗,請重新登入',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  			  },
  			});
			} else {
				Swal.fire({
					 icon: 'error',
					 title: '帳號或密碼請勿空白',
					 showConfirmButton: false,
					 timer: 1500
			});
			}
			});
	  	};
	  	
		  $("#cartBtn").click(function(){
				$.ajax({ 
				  type:"POST",
				  url:"<%=request.getContextPath()%>/ShoppingServlet",
				  data:{
					  "product_no": "${productVO.product_no}",
					  "product_name": "${productVO.product_name}",
					  "product_price": "${productVO.product_price}",
					  "proqty": $('#proqty').val(),
					  "product_remaining": "${productVO.product_remaining}",
					  "user_id": "${productVO.user_id}",
					  "action": "ADD"
				  },
				  success: function(res) {
					  
					  const cartproducts=cartProduct(res, "<%=request.getContextPath()%>"); 
					  $("#carts").html(cartproducts); 
					  
					  var carRes  = JSON.parse(res)
// 					  console.log(carRes["results"].length);
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
		  });
		  
		  $(".icon_heart_alt").click(function(e){
			  addFavorite(e.target.dataset.id)
			  $(this).addClass("red_heart");
		  });
		  
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
								  title: `${productVO.product_name}已加入收藏清單`,
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
						  title: `${productVO.product_name}已在收藏清單`,
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
								  title: `${productVO.product_name}已加入收藏清單`,
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
	
	<c:forEach var="seller" items="${orderSvc.getAllByID2(productVO.user_id)}" begin="0" end="${list2.size()}">
	<script>
    $(document).ready(function(){
		switch($("#star${seller.order_no}").val()){
		case "1":
			$("#s1${seller.order_no}").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "2":
			$("#s1${seller.order_no},#s2${seller.order_no}").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "3":
			$("#s1${seller.order_no},#s2${seller.order_no},#s3${seller.order_no}").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "4":
			$("#s1${seller.order_no},#s2${seller.order_no},#s3${seller.order_no},#s4${seller.order_no}").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		case "5":
			$("#s1${seller.order_no},#s2${seller.order_no},#s3${seller.order_no},#s4${seller.order_no},#s5${seller.order_no}").removeClass("fa fa-star-o").addClass("fa fa-star");
			break;
		default:

		}
	})
	</script>
	</c:forEach>

</body>
</html>
