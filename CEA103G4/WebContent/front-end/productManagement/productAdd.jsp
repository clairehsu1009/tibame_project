<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.user.model.*"%>

<%
	ProductVO productVO = (ProductVO) request.getAttribute("productVO");
	
	Product_TypeDAO dao2 = new Product_TypeDAO();
	List<Product_TypeVO> list2 = dao2.getAll();
	pageContext.setAttribute("list2",list2);
	
	UserVO userVO = (UserVO) session.getAttribute("userVO"); 
	session.setAttribute("userVO", userVO);
	
%>

<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta name="description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<!-- Twitter meta-->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:site" content="@pratikborsadiya">
<meta property="twitter:creator" content="@pratikborsadiya">
<!-- Open Graph Meta-->
<meta property="og:type" content="website">
<meta property="og:site_name" content="Vali Admin">
<meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
<meta property="og:url"
	content="http://pratikborsadiya.in/blog/vali-admin">
<meta property="og:image"
	content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
<meta property="og:description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<title>Mode Femme 新增商品</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-template/css/usermain.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">

	<!-- Navbar_siderbar start-->
	<%@include file="/front-end/user/userSidebar.jsp"%>
	<!-- Navbar_siderbar finish-->


	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-plus">&nbsp;</i>新增商品
				</h1>
			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a href="#">商品管理</a></li>
			</ul>
		</div>
		<div class="row">
		<div class="col-md-12 productsAdd">
		<form METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data">
			<div class="form-group">
				<label for="product_name" class="col-sm-2 col-form-label">商品名稱</label>
				<div class="col-sm-10">
				  <input class="form-control" id="product_name" name="product_name" type="text" placeholder="請輸入商品名稱" value="<%=(productVO == null) ? "" : productVO.getProduct_name()%>" required>
				</div>
			</div>
			<div class="form-group">
				<label for="product_info" class="col-sm-2 col-form-label">商品描述</label>
				<div class="col-sm-10">
				<textarea class="form-control" id="product_info" style="resize:none; white-space:pre-wrap;" maxlength="300" rows="6" name="product_info" placeholder="請輸入商品說明"   ><%=(productVO == null) ? "" : productVO.getProduct_info()%></textarea>
				<div id="words"><span style="font-weight: bold;">0</span>/300</div>
				</div>
			</div>
			  <div class="form-row productInfoGroup">
    			<div class="col-md-4 mb-3">
      			<label for="product_price">商品價格</label>
     			 <input type="text" class="form-control" id="product_price" name="product_price" placeholder="請輸入商品價格" value="<%=(productVO == null) ? "" : productVO.getProduct_price()%>" required>
   			 </div>
   			 	<div class="col-md-4 mb-3">
  				<label for="product_remaining">商品數量</label>
  				  <input type="text" class="form-control" id="product_remaining" name="product_remaining" placeholder="請輸入商品數量" value="<%=(productVO == null) ? "" : productVO.getProduct_remaining()%>" required>
   		     </div>
   		       <div class="col-md-4 mb-3">
  				<label for="pdtype_no">商品類別</label>
             	<select class="custom-select form-control" id="pdtype_no" name="pdtype_no" required>
               		<option selected value="0">請選擇商品類別</option>
               		<c:forEach var="product_typeVO" items="${list2}" begin="0" end="${list2.size()-1}">
               		<option value="${product_typeVO.pdtype_no}"  ${(productVO.pdtype_no==product_typeVO.pdtype_no)? 'selected': ''}> ${product_typeVO.pdtype_name}</option>
                   </c:forEach>
              </select>
   		     </div>
   		    </div>
   		    <div  class="productAddimg">
   		    <div>請上傳商品圖片</div>
			<div class="row">
			<div class="col-lg-4 col-sm-6">
				<label for="product_photo" id="upload-img" class="card mb-2 productcard">
				<input class="form-control" id="product_photo" type="file" name="product_photo" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"  value="<%= (productVO==null)? "" : productVO.getProduct_photo()%>">
				<i class="fa fa-file-picture-o" id="iconcamera"></i>
				<i class="delAvatar fa fa-times-circle-o" title="移除圖片"></i>
				</label>
			</div>
			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
			<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
			</ul>
			</c:if>
		  </div>
		  </div>
		  <div class="productAddBtn">
			<input type="hidden" name="action" value="insert">
			<input type="hidden" name="user_id" value="<%=userVO.getUser_id()%>">
			<a href="<%=request.getContextPath()%>/front-end/productManagement/productList.jsp"><button type="button" class="btn btn-danger">取消</button></a>
			<button type="submit" class="btn btn-info submitAdd" name="product_state" value="0">儲存商品</button>
			<button type="submit" class="btn btn-warning submitAdd" name="product_state" value="1">儲存並上架</button>
			</div>
		
</form>
	</div>
	</div>

	</main>
	<!-- Essential javascripts for application to work-->
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/main.js"></script>
	<!-- The javascript plugin to display page loading on top-->
	<script
		src="<%=request.getContextPath()%>/back-template/docs/js/plugins/pace.min.js"></script>
	<!-- Page specific javascripts-->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/back-template/docs/js/plugins/chart.js"></script>

	<script type="text/javascript">


		//實現上傳圖片可以預覽所上傳的圖片,若重新上傳其他圖片,可以移除舊的圖片預覽,只顯示最新的狀態

		let product_photo = document.getElementById("product_photo");
		let iconcamera = document.getElementById("iconcamera");
		let uploadimg = document.getElementById("upload-img");

		function init() {
			product_photo.addEventListener("change", function(e) {
				$("#upload-img img").remove();
				iconcamera.style.display = "block";
				let files = e.target.files;
				if (files !== null) {
					let file = files[0];
					if (file.type.indexOf('image') > -1) {
						let reader = new FileReader();
						reader.addEventListener('load', function(e) {
							let result = e.target.result;
							iconcamera.style.display = "none";
							let img = document.createElement('img');
							img.src = result;
							uploadimg.append(img);
						});
						reader.readAsDataURL(file);
					} else {
						alert('請上傳圖片！');
					}
				}
			});
		}
		window.onload = init;
		
		$(".delAvatar").click(function() {
			$("#upload-img img").remove();
			iconcamera.style.display = "block";
		});
		
		//統計textarea字數
	    $('#product_info').on('input focus keyup',
		        function(){
		            var strs = $(this).val();
		            remain = strs.length;
		            var content_msg = remain;
		            $(this).next().html(content_msg);
		        });
// 		$(".submitAdd").click(function() {
// 			if ($("#product_photo").val() == null || $("#product_photo").val().length == 0){
// 				alert('請上傳圖片！');
// 			}
// 		});
		



	</script>
</body>
</html>